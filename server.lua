-- Pulls and allows the use of VORP Inventory

local VorpInv = {}

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

--End of pulling VORP Inventory
--Pulls vorp core

local VORPcore = {}

TriggerEvent("getCore", function(core)
  VORPcore = core
end)

--end pulling it

--this is creating a global catch so only 1 nazar spawns
local shoppedspawn = 0
RegisterServerEvent('shopped')
AddEventHandler('shopped', function()
  if shoppedspawn == 0 then
    shoppedspawn = shoppedspawn + 1
    TriggerClientEvent('pedspawn', source)
  end
end)

--global cooldown system
local cooldown = false
RegisterServerEvent('menuopen6')
AddEventHandler('menuopen6', function()
  if cooldown == false then
    TriggerClientEvent('menuopen4', source, arg)
    cooldown = true
    Wait(Config.NazarSetup.hintcooldown)
    cooldown = false
  elseif cooldown == true then
    TriggerClientEvent('failmenuopen', source)
  end
end)
--end cooldown setups

--SELLING ITEMS TO NAZAR SETUP

--this just catches the qty from the menusetup then triggers a client event to get the itemname price and pass back to the server
RegisterServerEvent('catchinputforsell')
AddEventHandler('catchinputforsell', function(qty)
  TriggerClientEvent('infosenderforsell', source, qty)
end)

RegisterServerEvent('getplayerdataforsell') --registers a server event
AddEventHandler('getplayerdataforsell', function(Iitemname, Pprice, qty) --gives the event somethign to do and also pulls variables from the client
  local amountcatch = 0
  local price2 = tonumber(Pprice) --changes the string to a integer
  local Character = VORPcore.getUser(source).getUsedCharacter --gets the players character
  local itemcount = VorpInv.getItemCount(source, Iitemname) --checks if you have the item
  if itemcount >= 1 then --if you have atleast one item then
    VorpInv.subItem(source, Iitemname, qty) --it removes 1 item
    repeat
      Citizen.Wait(0)
      Character.addCurrency(0, price2) --it gives you the set money
      amountcatch = amountcatch + 1
    until amountcatch >= qty
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items Sold ' .. Iitemname .. ' Amount sold ' .. qty .. ' Sold for ' .. tonumber(Pprice))
  elseif itemcount < 1 then
    TriggerClientEvent('noitem', source) --if you have no items it triggers the client event
  end
end)

--handles the giving of items whena  chest is opened
local cooldown2 = false
RegisterServerEvent('chestopen') --registers an event
AddEventHandler('chestopen', function(V) --tells the event what to do and pulls the reward variable from the client
  local Character = VORPcore.getUser(source).getUsedCharacter --Pulls the character info
  if cooldown2 == false then
    for k, v in pairs(V.Reward) do --opens the table
      VorpInv.addItem(source, v.name, v.count) --adds the items and amounts
    end
    TriggerClientEvent('ccdown2', source)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ChestWebhook, 'chest Opened ' .. V.huntname)
    cooldown2 = true
    Citizen.Wait(7200000)
    cooldown2 = false
  end
end)

--This will handle the items nazar wil sell to the player
RegisterServerEvent('nazarsellinfopass')
AddEventHandler('nazarsellinfopass', function(qty)
  TriggerClientEvent('nazarsellableitemscatch', source, qty)
end)

--this will actually sell the items as it is recieving the item name qty and price
RegisterServerEvent('buyfromnazar')
AddEventHandler('buyfromnazar', function(qty, Itemnamee, Priceee) --recieves the 3 variables from the client. The order caught is important
  local totalamountmultiplied = 	qty * Priceee --multiplies the qty by the price to get the total amount of cash it should cost
  local Character = VORPcore.getUser(source).getUsedCharacter --Pulls the character info
  local currcash = Character.money
  if currcash >= totalamountmultiplied then
    VorpInv.addItem(source, Itemnamee, qty)
    Character.removeCurrency(0, totalamountmultiplied)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items bought ' .. Itemnamee .. ' Item price ' .. tostring(Priceee) .. ' Amount bought ' .. tostring(qty))
  elseif currcash < totalamountmultiplied then
    TriggerClientEvent('nomon', source)
  end
end)