local VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()
local discord = BccUtils.Discord.setup(Config.Webhook, Config.WebhookTitle, Config.WebhookAvatar)

local CooldownData = {}
local SpawnCoordsSet = false
local Location = {}

CreateThread(function()
    if GetResourceState('feather-menu'):match("missing") or GetResourceState('feather-menu'):match("stopped") then
        print('^1Missing/Stopped Feather Menu Resource^7')
    end
end)

local function SetPlayerCooldown(type)
    CooldownData[type] = os.time()
end

VORPcore.Callback.Register('bcc-nazar:CheckPlayerCooldown', function(source, cb, type)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return cb(false) end
    local cooldown = Config.cooldown[type]
    local onList = false

    for id, time in pairs(CooldownData) do
        if id == type then
            onList = true
            if os.difftime(os.time(), time) >= cooldown * 60 then
                cb(false) -- Not on Cooldown
                break
            else
                cb(true)
                break
            end
        end
    end
    if not onList then
        cb(false)
    end
end)

RegisterServerEvent('bcc-nazar:BuyHint', function(chestData)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter

    local cost = nil
    for _, chestCfg in pairs(Chests) do
        if chestCfg.huntname == chestData.huntname then
            cost = tonumber(chestCfg.hintcost)
            break
        end
    end

    if cost == nil then
        print('Invalid cost value received')
        return
    end

    if character.money >= cost then
        character.removeCurrency(0, cost)
        TriggerClientEvent('bcc-nazar:OpenChest', src, chestData)
    else
        VORPcore.NotifyRightTip(src, _U('NoMoney'), 4000)
        return
    end

    SetPlayerCooldown('buyHint')
end)

--------- Nazar Spawn Coords Handler (Done Server Side so its same location for all players) ---------------
RegisterServerEvent('bcc-nazar:LocationSet', function()
    if not SpawnCoordsSet then
        Location = Config.nazar.location[math.random(1, #Config.nazar.location)]
        SpawnCoordsSet = true
    end
    TriggerClientEvent('bcc-nazar:PedSpawn', source, Location)
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
    discord:sendMessage("Name: " .. character.firstname .. " " .. character.lastname .. "\nIdentifier: " .. character.identifier .. '\nChest Opened: ' .. chestData.huntname.. "\nRewards: " .. items)
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
            VORPcore.NotifyLeft(src, _U('Nazar'), _U('StackFull'),"BLIPS_MP","blip_mp_collector_map",4000,"COLOR_RED")
            return
        end
        if currMoney == nil or currMoney < totalAmount then
            if itemData.currencytype == "money" then
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoMoney'),"BLIPS_MP","blip_mp_collector_map",4000,"COLOR_RED")
            elseif itemData.currencytype == "gold" then
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoGold'),"BLIPS_MP","blip_mp_collector_map",4000,"COLOR_RED")
            else
                VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoCurrency'),"BLIPS_MP","blip_mp_collector_map",4000,"COLOR_RED")
            end
            return
        end
        if currMoney >= totalAmount then
            if exports.vorp_inventory:addItem(src, itemData.itemdbname, qty) == true then
                character.removeCurrency(Config.CurrencyTypes[itemData.currencytype], totalAmount)
                VORPcore.NotifyLeft(src, _U('Nazar'), "Bought "..qty..'x '..itemData.displayname, "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_GREEN")
                discord:sendMessage("Name: " .. character.firstname .. " " .. character.lastname .. "\nIdentifier: " .. character.identifier .. '\nItems bought: ' .. itemData.itemdbname .. '\nItem price: ' .. tostring(itemData.price) .. '\nAmount bought: ' .. tostring(qty))
            else
                print('^2bcc-nazar^7 : Failed To Buy [^3'..itemData.itemdbname..']^7')
            end
        end

    elseif action == "sell" then -- Sell To Nazar
        local itemData = GetDataFromItemName(itemName, action, currency)
        if itemData == nil then
            VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoItem'),"BLIPS_MP","blip_mp_collector_map",4000,"COLOR_RED")
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
                VORPcore.NotifyLeft(src, _U('Nazar'), "Sold "..qty..'x '..itemData.displayname, "BLIPS_MP", "blip_mp_collector_map", 4000, "COLOR_GREEN")
                discord:sendMessage("Name: " .. character.firstname .. " " .. character.lastname .. "\nIdentifier: " .. character.identifier .. '\nItems Sold: ' .. itemData.itemdbname .. '\nAmount sold: ' .. qty .. '\nSold for: ' .. tonumber(itemData.price))
            else
                print('^2bcc-nazar^7 : Failed To Sell [^3'..itemData.itemdbname..']^7')
            end
        else
            VORPcore.NotifyLeft(src, _U('Nazar'), _U('NoItem'),"BLIPS_MP","blip_mp_collector_map",4000,"COLOR_RED")
            return false
        end
    end

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
VORPcore.Callback.Register('bcc-nazar:CardCooldown', function(source, cb, cardId)
    if CardCooldown[cardId] then
        if os.difftime(os.time(), CardCooldown[cardId]) >= ConfigCards.CardTime * 60 then
            CardCooldown[cardId] = os.time()
          cb(false)
        else
          cb(true)
        end
    else
        CardCooldown[cardId] = os.time() --Store the current time
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

VORPcore.Callback.Register('bcc-nazar:CardCraft', function(source, cb, setId, itemId)
    local invItems = exports.vorp_inventory:getUserInventoryItems(source)
    local cardsData = GetCardsDataFromSet(setId)

    local ownedCards = {}

    -- Pick 12 cards of requested set and store in a table "ownedCards"
    for key, item in pairs(invItems) do
        if item.name == ConfigCards.Item and next(item.metadata) ~= nil then
            if cardsData[item.metadata.model] ~= nil and not cardsData[item.metadata.model].owned then
                cardsData[item.metadata.model].owned = true
                ownedCards[#ownedCards + 1] = item
            end
        end
    end

    -- Check for empty Card Box
    local hasCardBox = exports.vorp_inventory:getItemContainingMetadata(source, ConfigCards.SetItem, {setId = 0})

    if not hasCardBox then
        -- Add Notification of no empty card box here
        VORPcore.NotifyLeft(source,"Collectable Cards",_U('NoCardBox'),"toast_log_blips","blip_rc_collectable_cigcard",4000,"COLOR_RED")
        return
    end
    if #ownedCards > 0 and #ownedCards == 12 then
        -- Remove selected 12 cards from Inventory
        for key, item in pairs(ownedCards) do
            exports.vorp_inventory:subItemID(source, item.id)
        end

        -- Change Metadata of Card Box with set data
        if exports.vorp_inventory:setItemMetadata(source, hasCardBox.id, {description = ConfigCards.SetsData[setId].name, setId = setId}, 1) then
            VORPcore.NotifyLeft(source,"Collectable Cards",_U('PackedCards')..ConfigCards.SetsData[setId].name,"toast_log_blips","blip_rc_collectable_cigcard",4000,"COLOR_GREEN")
        else
            print('^1 Failed to Change Metadata after Craft Cards ^7 Item :', hasCardBox.id)
        end
    else
        -- Add Notification here of not enough cards of setname to pack
        VORPcore.NotifyLeft(source,"Collectable Cards",_U('NotEnoughCards')..ConfigCards.SetsData[setId].name,"toast_log_blips","blip_rc_collectable_cigcard",4000,"COLOR_RED")
    end

    cb(true)
end)

-- Set metadata for card box as setId = 0
AddEventHandler("vorp_inventory:Server:OnItemCreated",function(data, src)
    if data.name == ConfigCards.SetItem and next(data.metadata) == nil then
        exports.vorp_inventory:setItemMetadata(src, data.id, {description = data.desc.."<br>Empty Box", setId = 0}, 1)      
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
            VORPcore.NotifyLeft(source,"Collectable Cards",_U('StackFull'),"toast_log_blips","blip_rc_collectable_cigcard",4000,"COLOR_RED")
            return
        end

        -- check if item meta is changed
        if exports.vorp_inventory:setItemMetadata(src, item.mainid, {description = item.desc.."<br>Empty Box", setId = 0}, 1) then
            -- Give Cards To Player based on setId
            for _, cards in pairs(ConfigCards.Cards) do
                if cards.setId == setId then
                    exports.vorp_inventory:addItem(src, ConfigCards.Item, 1, { description = cards.name..' '..cards.number, model = cards.model })
                end
            end
            VORPcore.NotifyLeft(src,"Collectable Cards",_U('UnpackedCards')..ConfigCards.SetsData[setId].name,"toast_log_blips","blip_rc_collectable_cigcard",4000,"COLOR_GREEN")
        else
            print('^1 Failed to Change Metadata after Unpack Cards ^7 Item :', item.mainid)
        end
    end
end)
