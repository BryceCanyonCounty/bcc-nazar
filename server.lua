--------------------- Pulling Essentials --------------------
local VorpInv = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = {}
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
local BccUtils = exports['bcc-utils'].initiate()

------------ Cool Down System -----------------
local cooldown = false
RegisterServerEvent('bcc-nazar:menuopen6', function(cost)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  if not cooldown then
    TriggerClientEvent('bcc-nazar:menuopen4', _source)
    Character.removeCurrency(0, cost)
    cooldown = true
    Wait(Config.NazarSetup.hintcooldown)
    cooldown = false
  else
    VORPcore.NotifyBottomRight(_source, Config.Language.NoHintNotify, 4000)
  end
end)

--------- Nazar Spawn Coords Handler (Done Server Side so its same location for all players) ---------------
local randomizedcoords, d = 0, 0
local nspawn
RegisterServerEvent('bcc-nazar:locationset', function()
  if randomizedcoords == 0 then
    d = math.random(1, #Config.NazarSetup.nazarspawn)
    nspawn = Config.NazarSetup.nazarspawn[d]
    randomizedcoords = randomizedcoords + 1
  end
  TriggerClientEvent('bcc-nazar:pedspawn', source, nspawn)
end)


---------------------- Selling Items Setup ----------------------
RegisterServerEvent('bcc-nazar:getplayerdataforsell', function(Iitemname, Pprice, qty, Bcurrency)
  local amountcatch, _source = 0, source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local itemcount = VorpInv.getItemCount(_source, Iitemname)
  if (Bcurrency == 'cash') then --added by mrtb start
    BcurrencyT = 0
  elseif (Bcurrency == 'gold') then
    BcurrencyT = 1
  end -- added by mrtb edited
  if itemcount >= tonumber(qty) then
    VorpInv.subItem(_source, Iitemname, qty)
    repeat
      Wait(0)
      Character.addCurrency(BcurrencyT, tonumber(Pprice))
      amountcatch = amountcatch + 1
    until amountcatch >= qty
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items Sold ' .. Iitemname .. ' Amount sold ' .. qty .. ' Sold for ' .. tonumber(Pprice))
  elseif itemcount < tonumber(qty) then
    VORPcore.NotifyBottomRight(_source, Config.Language.NoItem, 4000)
  end
end)

----------- Handles Giving Items When Chest Is Opened ------------
local cooldown2 = false
RegisterServerEvent('bcc-nazar:chestopen', function(V)
  local _source = source
  local itemsgot = ''
  local Character = VORPcore.getUser(_source).getUsedCharacter
  if not cooldown2 then
    for k, v in pairs(V.Reward) do
      VorpInv.addItem(_source, v.name, v.count)
      itemsgot = itemsgot .. v.displayname .. ','
    end
    VORPcore.NotifyRightTip(_source ,Config.Language.ChestLooted .. itemsgot, 4000)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ChestWebhook, 'chest Opened ' .. V.huntname)
    cooldown2 = true
    Wait(Config.NazarSetup.hintcooldown)
    cooldown2 = false
  end
end)

------------ This will actually sell the items -----------------
RegisterServerEvent('bcc-nazar:buyfromnazar', function(qty, Itemnamee, Priceee, Scurrencyy)
  local _source = source
  local totalamountmultiplied = 	qty * Priceee --multiplies the qty by the price to get the total amount of cash it should cost
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local currmoney
  if (Scurrencyy == 'cash') then -- added by mrtb start
    ScurrencyT = 0
    currmoney = Character.money
  elseif (Scurrencyy == 'gold') then
    ScurrencyT = 1
    currmoney = Character.gold
  end -- added by mrtb end
  if currmoney >= totalamountmultiplied then
    VorpInv.addItem(_source, Itemnamee, qty)
    Character.removeCurrency(ScurrencyT, totalamountmultiplied)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items bought ' .. Itemnamee .. ' Item price ' .. tostring(Priceee) .. ' Amount bought ' .. tostring(qty))
  elseif currmoney < totalamountmultiplied then
    if (Scurrencyy == 'cash') then --- added by mrtb start
      VORPcore.NotifyBottomRight(_source, Config.Language.NoMoney, 4000)
    elseif (Scurrencyy == 'gold') then
      VORPcore.NotifyBottomRight(_source, Config.Language.NoGold, 4000)
    end -- added by mrtb end
  end
end)


RegisterServerEvent("bcc-nazar:GetCard", function(cardname, hash)
  local _source = source
      local canCarry = VORPInv.canCarryItem(_source, ConfigCards.Item, 1)
  if canCarry then
    local space = VORPInv.canCarryItems(_source, ConfigCards.Item)
    if space then
      VORPcore.NotifyLeft(_source,Config.Language.CardCollected, Config.Language.YouCollected, "INVENTORY_ITEMS",
        "document_cig_card_act", 4000, "Color_white")
      VORP_INV.addItem(_source, ConfigCards.Item, 1, { description = cardname, hash = hash })
    else
      VORPcore.NotifyRightTip(_source, Config.Language.InvFull, 4000)
    end
  else
    VORPcore.NotifyRightTip(_source, Config.Language.StackFull, 4000)
  end
end)

local Cooldowns = {} --Card Cooldown
RegisterServerEvent('bcc-nazar:CardCooldownSV', function(card)
    local _source = source
    local shopid = card.hash
    if Cooldowns[shopid] then
        if os.difftime(os.time(), Cooldowns[shopid]) >= 3600 then
          print('we are here')
          Cooldowns[shopid] = os.time()
          VorpCore.NotifyRightTip(_source, "got it", 4000)
          TriggerClientEvent('nate_commands:ClientCardCheck', _source, false)
        else
          VorpCore.NotifyRightTip(_source, "TooSoon", 4000)
          TriggerClientEvent('nate_commands:ClientCardCheck', _source, true)
        end
    else
      Cooldowns[shopid] = os.time()           --Store the current time
      VorpCore.NotifyRightTip(_source, "got it", 4000)
                TriggerClientEvent('nate_commands:ClientCardCheck', _source, false)

    end
end)

--This handles the version check
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-nazar')
