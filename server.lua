local VorpInv = {} -- Pulls and allows the use of VORP Inventory
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
  VORPcore = core
end)

--global cooldown system
local cooldown = false
RegisterServerEvent('bcc-nazar:menuopen6', function(cost)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  if cooldown == false then
    TriggerClientEvent('bcc-nazar:menuopen4', source, arg)
    Character.removeCurrency(0, cost) -- removes a amount of (cost) money(0) [gold would be 1]
    cooldown = true
    Wait(Config.NazarSetup.hintcooldown)
    cooldown = false
  elseif cooldown == true then
    VORPcore.NotifyBottomRight(_source, Config.Language.NoHintNotify, 4000) --prints this in players screen
  end
end)

--Handles nazar spawn(this is used so that it only randomizes the coordinates of nazar once for everyone instead of a different coord for each player)
local randomizedcoords = 0
local nspawn
local d = 0
RegisterServerEvent('bcc-nazar:locationset', function()
  if randomizedcoords == 0 then
    d = math.random(1, #Config.NazarSetup.nazarspawn)
    nspawn = Config.NazarSetup.nazarspawn[d]
    randomizedcoords = randomizedcoords + 1
  end
  TriggerClientEvent('bcc-nazar:pedspawn', source, nspawn)
end)

--SELLING ITEMS TO NAZAR SETUP
--this just catches the qty from the menusetup then triggers a client event to get the itemname price and pass back to the server
RegisterServerEvent('bcc-nazar:catchinputforsell', function(qty)
  TriggerClientEvent('bcc-nazar:infosenderforsell', source, qty)
end)

RegisterServerEvent('bcc-nazar:getplayerdataforsell', function(Iitemname, Pprice, qty, Bcurrency) --registers a server event
  local amountcatch = 0
  local price2 = tonumber(Pprice) --changes the string to a integer
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
      Character.addCurrency(BcurrencyT, price2) --it gives you the set money
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
  if cooldown2 == false then
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

--This will handle the items nazar wil sell to the player
RegisterServerEvent('bcc-nazar:nazarsellinfopass', function(qty)
  TriggerClientEvent('bcc-nazar:nazarsellableitemscatch', source, qty)
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

--This handles the version check
local versioner = exports['bcc-versioner'].initiate()
local repo = 'https://github.com/BryceCanyonCounty/bcc-nazar'
versioner.checkRelease(GetCurrentResourceName(), repo)