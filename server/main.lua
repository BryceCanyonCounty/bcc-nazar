local VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()
local discord = BccUtils.Discord.setup(Config.Webhook, Config.WebhookTitle, Config.WebhookAvatar)
local UserLogAPI = exports['bcc-userlog']:getUserLogAPI()

local CooldownData = {}
local SpawnCoordsSet = false
local Location = {}
LastBroadcastedLocation = nil

-- Helper function for debugging in DevMode
if Config.devMode then
    function devPrint(message)
        print("^1[DEV MODE] ^4" .. message)
    end
else
    function devPrint(message) end -- No-op if DevMode is disabled
end

CreateThread(function()
    if GetResourceState('feather-menu'):match("missing") or GetResourceState('feather-menu'):match("stopped") then
        print('^1Missing/Stopped Feather Menu Resource^7')
    end
end)

local function SetPlayerCooldown(type)
    CooldownData[type] = os.time()
end

BccUtils.RPC:Register("bcc-nazar:CheckPlayerCooldown", function(params, cb, source)
    local cooldownType = params.type
    if not cooldownType or not Config.cooldown[cooldownType] then
        return cb(false)
    end

    local cooldown = Config.cooldown[cooldownType]
    local currentTime = os.time()

    for id, time in pairs(CooldownData) do
        if id == cooldownType then
            local elapsed = os.difftime(currentTime, time)
            if elapsed >= cooldown * 60 then
                return cb(false) -- Not on cooldown
            else
                return cb(true) -- Still on cooldown
            end
        end
    end

    cb(false) -- No entry found, allow action
end)

RegisterServerEvent('bcc-nazar:BuyHint', function(chestData)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then
        devPrint("[BuyHint] User not found for src: " .. tostring(src))
        return
    end

    local character = user.getUsedCharacter
    if not character then
        devPrint("[BuyHint] Character not found for user.")
        return
    end

    -- Locate chest config
    local chestCfg = nil
    for _, chest in pairs(Chests) do
        if chest.huntname == chestData.huntname then
            chestCfg = chest
            break
        end
    end

    if not chestCfg then
        devPrint("[BuyHint] ERROR: Chest config not found for huntname: " .. tostring(chestData.huntname))
        return
    end

    local cost = tonumber(chestCfg.hintcost) or 0
    local requiredMinutes = tonumber(chestCfg.requiredPlaytimeMinutes) or 0
    devPrint("[BuyHint] Found chest config for '" .. chestCfg.huntname .. "' with cost: " .. cost .. " and required playtime: " .. requiredMinutes)

    -- Optional: check playtime with bcc-userlog
    if Config.useBccUserlog then
        local identifier = character.identifier
        devPrint("[BuyHint] Character identifier: " .. tostring(identifier))

        local playerData = UserLogAPI:GetUserBySteamID(identifier)
        local playtime = playerData and playerData.players_playTime or 0

        devPrint("[BuyHint] Total playtime for " .. identifier .. ": " .. tostring(playtime) .. " minutes")

        if playtime < requiredMinutes then
            local requiredHours = math.floor(requiredMinutes / 60)
            VORPcore.NotifyRightTip(src, _U('needAtLeast') .. requiredHours .. _U('needHours') .. requiredMinutes .. _U('playtime'), 4000)
            devPrint("[BuyHint] Player has insufficient playtime (" .. playtime .. " < " .. requiredMinutes .. ")")
            return
        end
    end

    -- Check money and proceed
    if character.money >= cost then
        devPrint("[BuyHint] Player has enough money (" .. character.money .. "), charging: " .. cost)
        character.removeCurrency(0, cost)
        TriggerClientEvent('bcc-nazar:OpenChest', src, chestData)
        SetPlayerCooldown('buyHint')

        -- ✅ Send Discord log using your preferred format
        local logMsg = _U('name') ..
            character.firstname .. " " .. character.lastname ..
            _U('identifier') .. character.identifier ..
            chestData.huntname ..
            "Hint Purchased for $" .. cost

        discord:sendMessage(logMsg)
    else
        devPrint("[BuyHint] Not enough money! Player has: " .. character.money .. ", required: " .. cost)
        VORPcore.NotifyRightTip(src, _U('NoMoney'), 4000)
    end
end)

BccUtils.RPC:Register("bcc-nazar:GetLocation", function(_, cb, source)
    devPrint("[Nazar] RPC requested by source: " .. tostring(source))

    -- Set location once on first call
    if not SpawnCoordsSet then
        Location = Config.nazar.location[math.random(1, #Config.nazar.location)]
        SpawnCoordsSet = true
        devPrint("[Nazar] First location set: " .. json.encode(Location))
    end

    -- Send the current location back
    cb(Location)
end)

-- Respawn logic (conditional via config)
CreateThread(function()
    if not Config.nazar.autoRespawn then
        devPrint("Auto respawn is disabled in Config.")
        return
    end

    devPrint("Auto respawn enabled. Timer: " .. tostring(Config.nazar.timeRespawn) .. "ms")

    while true do
        Wait(Config.nazar.timeRespawn)

        local newLocation = Config.nazar.location[math.random(1, #Config.nazar.location)]

        if not Location
            or not Location.nazarCoords
            or newLocation.nazarCoords.x ~= Location.nazarCoords.x
            or newLocation.nazarCoords.y ~= Location.nazarCoords.y
            or newLocation.nazarCoords.z ~= Location.nazarCoords.z then

            Location = newLocation
            LastBroadcastedLocation = newLocation
            SpawnCoordsSet = true

            devPrint("New location selected: " .. json.encode(Location))

            for _, playerId in ipairs(GetPlayers()) do
                TriggerClientEvent('bcc-nazar:PedSpawn', playerId, Location)
                devPrint("Sent PedSpawn to " .. playerId)
            end
        else
            devPrint("Location unchanged, skipping broadcast.")
        end
    end
end)

----------- Handles Giving Items When Chest Is Opened ------------
RegisterServerEvent('bcc-nazar:GetRewards', function(chestData)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter
    local huntname = chestData.huntname
    local items = ''

    for _, chestCfg in pairs(Chests) do
        if chestCfg.huntname == huntname then
            for _, rewardCfg in pairs(chestCfg.Reward) do
                local canCarry = exports.vorp_inventory:canCarryItem(src, rewardCfg.name, rewardCfg.count)
                if canCarry then
                    exports.vorp_inventory:addItem(src, rewardCfg.name, rewardCfg.count)
                    items = items .. rewardCfg.displayname .. ', '
                else
                    VORPcore.NotifyRightTip(src, _U('StackFull') .. ': ' .. rewardCfg.displayname, 6000)
                end
            end
        end
    end

    if items == '' then
        return print("Invalid or nil reward data received.")
    end

    VORPcore.NotifyRightTip(src, _U('ChestLooted') .. items, 6000)
    discord:sendMessage(_U('name') .. character.firstname .. " " .. character.lastname .. _U('identifier') .. character.identifier .. _U('chestOpened') .. chestData.huntname .. _U('rewards') .. items)
end)

-- Function To Get Item Data Based on Action and ItemName Added Safety for event to only sell/buy mentioned items.
local function GetDataFromItemName(itemName, action, currency)
    if action == "buy" then
        for _, item in ipairs(Items.buy) do
            if item.itemdbname == itemName and item.currencytype == currency then
                return item
            end
        end
    elseif action == "sell" then
        for _, item in ipairs(Items.sell) do
            if item.itemdbname == itemName and item.currencytype == currency then
                return item
            end
        end
    end
    return nil -- Return nil if the item is not found
end

RegisterServerEvent('bcc-nazar:HandleBuySell', function(action, itemName, qty, currency)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter

    if action == "buy" then -- Buy From Nazar
        local itemData = GetDataFromItemName(itemName, action, currency)
        if not itemData then return end
        local currMoney = character[itemData.currencytype]
        local totalAmount = itemData.price * qty
        local canCarry = exports.vorp_inventory:canCarryItem(src, itemData.itemdbname, qty)
        if not canCarry then
            VORPcore.NotifyLeft(src, _U('Nazar'), _U('StackFull'), "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_RED")
            return
        end
        if currMoney == nil or currMoney < totalAmount then
            if itemData.currencytype == "money" then
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoMoney'), "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_RED")
            elseif itemData.currencytype == "gold" then
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoGold'), "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_RED")
            else
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoCurrency'), "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_RED")
            end
            return
        end
        if currMoney >= totalAmount then
            local itemsGiven = exports.vorp_inventory:addItem(src, itemData.itemdbname, qty)
            if itemsGiven then
                character.removeCurrency(Config.CurrencyTypes[itemData.currencytype], totalAmount)
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('bought') .. qty .. 'x ' .. itemData.displayname, "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_GREEN")

                discord:sendMessage(_U('name') ..
                character.firstname ..
                " " ..
                character.lastname ..
                _U('identifier') ..
                character.identifier ..
                _U('itemsBought') ..
                itemData.itemdbname .. _U('itemPrice') .. tostring(itemData.price) .. _U('amountBought') .. tostring(qty))
            else
                print('^2bcc-nazar^7 : Failed To Buy [^3' .. itemData.itemdbname .. ']^7')
            end
        end
    elseif action == "sell" then -- Sell To Nazar
        local itemData = GetDataFromItemName(itemName, action, currency)
        if itemData == nil then
            VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoItem'), "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_RED")
            return
        end
        local itemCount = exports.vorp_inventory:getItemCount(src, nil, itemData.itemdbname) -- check if player do have item to sell ?
        local amountCatch = 0
        if itemCount >= qty then
            if exports.vorp_inventory:subItem(src, itemData.itemdbname, qty) == true then
                repeat
                    Wait(0)
                    character.addCurrency(Config.CurrencyTypes[itemData.currencytype], tonumber(itemData.price))
                    amountCatch = amountCatch + 1
                until amountCatch >= qty
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('sold') .. qty .. 'x ' .. itemData.displayname, "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_GREEN")
                discord:sendMessage("Name: " ..
                character.firstname ..
                " " ..
                character.lastname ..
                "\nIdentifier: " ..
                character.identifier ..
                _U('itemsSold') ..
                itemData.itemdbname .. _U('amountSold') .. qty .. _U('soldFor') .. tonumber(itemData.price))
            else
                print('^2bcc-nazar^7 : Failed To Sell [^3' .. itemData.itemdbname .. ']^7')
            end
        else
            VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoItem'), "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_RED")
            return false
        end
    end
end)

BccUtils.RPC:Register("bcc-nazar:GetInventoryItems", function(_, cb, source)
    local inventoryItems = exports.vorp_inventory:getUserInventoryItems(source)
    local sellableItems = {}

    for _, item in pairs(inventoryItems) do
        for _, sellable in pairs(Items.sell) do
            if item.name == sellable.itemdbname then
                table.insert(sellableItems, item)
                break
            end
        end
    end

    cb(sellableItems)
end)

exports.vorp_inventory:registerUsableItem('collector_card', function(data)
    local src = data.source
    exports.vorp_inventory:closeInventory(src)
    TriggerClientEvent('bcc-nazar:UseCard', src, data.item['metadata'].model)
end)

RegisterServerEvent("bcc-nazar:GetCard", function(cardname, model)
    local src = source
    local canCarry = exports.vorp_inventory:canCarryItem(src, ConfigCards.Item, 1)
    if canCarry then
        if exports.vorp_inventory:addItem(src, ConfigCards.Item, 1, { description = cardname, model = model }) == true then
            VORPcore.NotifyLeft(src, _U('CardCollected'), _U('YouCollected'), "INVENTORY_ITEMS", "document_cig_card_act", 4000, "Color_white")
        end
    else
        VORPcore.NotifyRightTip(src, _U('StackFull'), 4000)
    end
end)

local CardCooldown = {}
BccUtils.RPC:Register("bcc-nazar:CardCooldown", function(params, cb, source)
    local cardId = params.cardId
    if not cardId then return cb(true) end -- Fail safe

    if CardCooldown[cardId] then
        if os.difftime(os.time(), CardCooldown[cardId]) >= ConfigCards.CardTime * 60 then
            CardCooldown[cardId] = os.time()
            cb(false)
        else
            cb(true)
        end
    else
        CardCooldown[cardId] = os.time()
        cb(false)
    end
end)

----------------------------------CARD SET UPDATE-----------------------------------------

local function GetCardsDataFromSet(setId)
    local cards = {}
    for key, cardData in ipairs(ConfigCards.Cards) do
        if cardData.setId == setId then
            cardData.owned = false
            cards[cardData.model] = cardData
        end
    end

    return cards
end

BccUtils.RPC:Register("bcc-nazar:CardCraft", function(params, cb, source)
    local setId = params.setId
    local invItems = exports.vorp_inventory:getUserInventoryItems(source)
    local cardsData = GetCardsDataFromSet(setId)
    local ownedCards = {}

    -- Check what cards the player owns from this set
    for _, item in pairs(invItems) do
        if item.name == ConfigCards.Item and next(item.metadata) ~= nil then
            local model = item.metadata.model
            if cardsData[model] and not cardsData[model].owned then
                cardsData[model].owned = true
                ownedCards[#ownedCards + 1] = item
            end
        end
    end

    -- Check for empty card box
    local hasCardBox = exports.vorp_inventory:getItemContainingMetadata(source, ConfigCards.SetItem, { setId = 0 })
    if not hasCardBox then
        VORPcore.NotifyLeft(source, _U('collectableCards'), _U('NoCardBox'), "toast_log_blips", "blip_rc_collectable_cigcard", 4000, "COLOR_RED")
        return cb(false)
    end

    -- Ensure full set of 12
    if #ownedCards == 12 then
        for _, item in pairs(ownedCards) do
            exports.vorp_inventory:subItemID(source, item.id)
        end

        local metadata = { description = ConfigCards.SetsData[setId].name, setId = setId }
        if exports.vorp_inventory:setItemMetadata(source, hasCardBox.id, metadata, 1) then
            VORPcore.NotifyLeft(source, _U('collectableCards'), _U('PackedCards') .. ConfigCards.SetsData[setId].name, "toast_log_blips", "blip_rc_collectable_cigcard", 4000, "COLOR_GREEN")
            return cb(true)
        else
            print('^1 Failed to Change Metadata after Craft Cards ^7 Item:', hasCardBox.id)
            return cb(false)
        end
    else
        VORPcore.NotifyLeft(source, _U('collectableCards'), _U('NotEnoughCards') .. ConfigCards.SetsData[setId].name, "toast_log_blips", "blip_rc_collectable_cigcard", 4000, "COLOR_RED")
        return cb(false)
    end
end)

-- Set metadata for card box as setId = 0
AddEventHandler("vorp_inventory:Server:OnItemCreated", function(data, src)
    local cardBox = ConfigCards.SetItem
    if data.name == cardBox and next(data.metadata) == nil then
        local userItems = exports.vorp_inventory:getUserInventoryItems(src)
        for _, item in pairs(userItems) do
            if item.name == cardBox and next(item.metadata) == nil then
                exports.vorp_inventory:setItemMetadata(src, item.id,
                    { description = item.desc .. "<br>Empty Box", setId = 0 }, 1)
                break
            end
        end
    end
end)

exports.vorp_inventory:registerUsableItem(ConfigCards.SetItem, function(data)
    local src = data.source
    exports.vorp_inventory:closeInventory(src)

    local item = data.item

    if next(item.metadata) == nil then
        print('Invalid Card Box', item.mainid)
        return
    end

    local metadata = item.metadata
    local setId = metadata.setId
    if setId ~= nil and setId == 0 then
        -- Open Craft Menu
        Wait(500)
        TriggerClientEvent('bcc-nazar:OpenCardMenu', src)
    elseif ConfigCards.SetsData[setId] ~= nil then
        -- check Can Carry 12 cards as each set as 12 cards
        local canCarryCards = exports.vorp_inventory:canCarryItem(src, ConfigCards.Item, 12)
        if not canCarryCards then
            VORPcore.NotifyLeft(source, _U('collectableCards'), _U('StackFull'), "toast_log_blips", "blip_rc_collectable_cigcard", 4000, "COLOR_RED")
            return
        end

        -- check if item meta is changed
        if exports.vorp_inventory:setItemMetadata(src, item.mainid, { description = item.desc .. "<br>Empty Box", setId = 0 }, 1) then
            -- Give Cards To Player based on setId
            for _, cards in pairs(ConfigCards.Cards) do
                if cards.setId == setId then
                    exports.vorp_inventory:addItem(src, ConfigCards.Item, 1,
                        { description = cards.name .. ' ' .. cards.number, model = cards.model })
                end
            end
            VORPcore.NotifyLeft(src, _U('collectableCards'), _U('UnpackedCards') .. ConfigCards.SetsData[setId].name, "toast_log_blips", "blip_rc_collectable_cigcard", 4000, "COLOR_GREEN")
        else
            print('^1 Failed to Change Metadata after Unpack Cards ^7 Item :', item.mainid)
        end
    end
end)
