local VorpInv = {} -- Pulls and allows the use of VORP Inventory
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
local BccUtils = exports['bcc-utils'].initiate()

--global cooldown system
local cooldown = false
RegisterServerEvent('bcc-nazar:menuopen6', function(cost)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  if not cooldown then
    TriggerClientEvent('bcc-nazar:menuopen4', _source)
    Character.removeCurrency(0, cost) -- removes a amount of (cost) money(0) [gold would be 1]
    cooldown = true
    Wait(Config.NazarSetup.hintcooldown)
    cooldown = false
  else
    VORPcore.NotifyBottomRight(_source, Config.Language.NoHintNotify, 4000) --prints this in players screen
  end
end)

--Handles nazar spawn(this is used so that it only randomizes the coordinates of nazar once for everyone instead of a different coord for each player)
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


--Selling Items setup
RegisterServerEvent('bcc-nazar:getplayerdataforsell', function(Iitemname, Pprice, qty, Bcurrency) --registers a server event
  local amountcatch = 0
  local Character = VORPcore.getUser(source).getUsedCharacter --gets the players character
  local itemcount = VorpInv.getItemCount(source, Iitemname) --checks if you have the item
  if (Bcurrency == 'cash') then --added by mrtb start
    BcurrencyT = 0
  elseif (Bcurrency == 'gold') then
    BcurrencyT = 1
  end -- added by mrtb edited
  if itemcount >= tonumber(qty) then --if you have atleast one item then
    VorpInv.subItem(source, Iitemname, qty) --it removes 1 item
    repeat
      Citizen.Wait(0)
      Character.addCurrency(BcurrencyT, tonumber(Pprice)) --it gives you the set money
      amountcatch = amountcatch + 1
    until amountcatch >= qty
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items Sold ' .. Iitemname .. ' Amount sold ' .. qty .. ' Sold for ' .. tonumber(Pprice))
  elseif itemcount < tonumber(qty) then
    VORPcore.NotifyBottomRight(source, Config.Language.NoItem, 4000) --prints this in players screen
  end
end)

--handles the giving of items whena  chest is opened
local cooldown2 = false
RegisterServerEvent('bcc-nazar:chestopen', function(V) --registers an event
  local Character = VORPcore.getUser(source).getUsedCharacter --Pulls the character info
  if not cooldown2 then
    for k, v in pairs(V.Reward) do --opens the table
      VorpInv.addItem(source, v.name, v.count) --adds the items and amounts
    end
    TriggerClientEvent('bcc-nazar:ccdown2', source)
    VORPcore.NotifyBottomRight(source, Config.Language.Alreadylooted, 4000) --prints this in players screen
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ChestWebhook, 'chest Opened ' .. V.huntname)
    cooldown2 = true
    Citizen.Wait(Config.NazarSetup.hintcooldown)
    cooldown2 = false
  end
end)

--this will actually sell the items as it is recieving the item name qty and price
RegisterServerEvent('bcc-nazar:buyfromnazar', function(qty, Itemnamee, Priceee, Scurrencyy)
  local totalamountmultiplied = 	qty * Priceee --multiplies the qty by the price to get the total amount of cash it should cost
  local Character = VORPcore.getUser(source).getUsedCharacter --Pulls the character info
  local currmoney
  if (Scurrencyy == 'cash') then -- added by mrtb start
    ScurrencyT = 0
    currmoney = Character.money
  elseif (Scurrencyy == 'gold') then
    ScurrencyT = 1
    currmoney = Character.gold
  end -- added by mrtb end
  if currmoney >= totalamountmultiplied then
    VorpInv.addItem(source, Itemnamee, qty)
    Character.removeCurrency(ScurrencyT, totalamountmultiplied)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items bought ' .. Itemnamee .. ' Item price ' .. tostring(Priceee) .. ' Amount bought ' .. tostring(qty))
  elseif currmoney < totalamountmultiplied then
    if (Scurrencyy == 'cash') then --- added by mrtb start
      VORPcore.NotifyBottomRight(source, Config.Language.NoMoney, 4000) --prints this in players screen
    elseif (Scurrencyy == 'gold') then
      VORPcore.NotifyBottomRight(source, Config.Language.NoGold, 4000) --prints this in players screen
    end -- added by mrtb end
  end
end)

----------- Card Collection Cooldown ---------------------
local cooldowns = {}
RegisterServerEvent('bcc-nazar:CardCooldownCheck', function(shopid, v)
  local _source = source
  print(shopid)
  if cooldowns[shopid] then --Checks if the player has collected the card yet
    local seconds = Config.CardRespawnTime
    if os.difftime(os.time(), cooldowns[shopid]) >= seconds then
      cooldowns[shopid] = os.time() --Update the cooldown with the new enacted time.
      TriggerClientEvent("bcc-nazar:CardCollectorMain", _source, v)
    end
  else
    cooldowns[shopid] = os.time()
    TriggerClientEvent("bcc-nazar:CardCollectorMain", _source, v)
  end
end)

---------- Card Add Items -----------
RegisterServerEvent('bcc-nazar:CardCollectorAddItems', function(item)
  local _source = source
  VorpInv.addItem(_source, item, 1)
end)

--This handles the version check
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-nazar')