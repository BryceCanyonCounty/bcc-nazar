local VorpInv = {} -- Pulls and allows the use of VORP Inventory
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
  VORPcore = core
end)

--this is creating a global catch so only 1 nazar spawns
local shoppedspawn = 0
RegisterServerEvent('hd_nazar:shopped')
AddEventHandler('hd_nazar:shopped', function()
  if shoppedspawn == 0 then
    shoppedspawn = shoppedspawn + 1
    TriggerClientEvent('hd_nazar:pedspawn', source)
  end
end)

--global cooldown system
local cooldown = false
RegisterServerEvent('hd_nazar:menuopen6')
AddEventHandler('hd_nazar:menuopen6', function(cost)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    if cooldown == false then
        TriggerClientEvent('hd_nazar:menuopen4', source, arg)
        Character.removeCurrency(0, cost) -- removes a amount of (cost) money(0) [gold would be 1]
        cooldown = true
        Wait(Config.NazarSetup.hintcooldown)
        cooldown = false
    elseif cooldown == true then
        TriggerClientEvent('hd_nazar:failmenuopen', source)
    end
end)
--end cooldown setups

--SELLING ITEMS TO NAZAR SETUP

--this just catches the qty from the menusetup then triggers a client event to get the itemname price and pass back to the server
RegisterServerEvent('hd_nazar:catchinputforsell')
AddEventHandler('hd_nazar:catchinputforsell', function(qty)
  TriggerClientEvent('hd_nazar:infosenderforsell', source, qty)
end)

RegisterServerEvent('hd_nazar:getplayerdataforsell') --registers a server event
AddEventHandler('hd_nazar:getplayerdataforsell', function(Iitemname, Pprice, qty) --gives the event somethign to do and also pulls variables from the client
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
    TriggerClientEvent('hd_nazar:noitem', source) --if you have no items it triggers the client event
  end
end)

--handles the giving of items whena  chest is opened
local cooldown2 = false
RegisterServerEvent('hd_nazar:chestopen') --registers an event
AddEventHandler('hd_nazar:chestopen', function(V) --tells the event what to do and pulls the reward variable from the client
  local Character = VORPcore.getUser(source).getUsedCharacter --Pulls the character info
  if cooldown2 == false then
    for k, v in pairs(V.Reward) do --opens the table
      VorpInv.addItem(source, v.name, v.count) --adds the items and amounts
    end
    TriggerClientEvent('hd_nazar:ccdown2', source)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ChestWebhook, 'chest Opened ' .. V.huntname)
    cooldown2 = true
    Citizen.Wait(Config.NazarSetup.hintcooldown)
    cooldown2 = false
  end
end)

--This will handle the items nazar wil sell to the player
RegisterServerEvent('hd_nazar:nazarsellinfopass')
AddEventHandler('hd_nazar:nazarsellinfopass', function(qty)
  TriggerClientEvent('hd_nazar:nazarsellableitemscatch', source, qty)
end)

--this will actually sell the items as it is recieving the item name qty and price
RegisterServerEvent('hd_nazar:buyfromnazar')
AddEventHandler('hd_nazar:buyfromnazar', function(qty, Itemnamee, Priceee) --recieves the 3 variables from the client. The order caught is important
  local totalamountmultiplied = 	qty * Priceee --multiplies the qty by the price to get the total amount of cash it should cost
  local Character = VORPcore.getUser(source).getUsedCharacter --Pulls the character info
  local currcash = Character.money
  if currcash >= totalamountmultiplied then
    VorpInv.addItem(source, Itemnamee, qty)
    Character.removeCurrency(0, totalamountmultiplied)
    VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ShopWebhook, 'Items bought ' .. Itemnamee .. ' Item price ' .. tostring(Priceee) .. ' Amount bought ' .. tostring(qty))
  elseif currcash < totalamountmultiplied then
    TriggerClientEvent('hd_nazar:nomon', source)
  end
end)
