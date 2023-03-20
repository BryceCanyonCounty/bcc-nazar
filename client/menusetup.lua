local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
--end pulling it
StopAll = false

--Main Menu
Citizen.CreateThread(function()
    WarMenu.CreateMenu('bcc-nazar:leg2', 'Madam Nazar') --creates the main menu
    WarMenu.CreateSubMenu('bcc-nazar:shop', 'bcc-nazar:leg2', Config.Language.SubMenu_Head_Sell)
    WarMenu.CreateSubMenu('bcc-nazar:sell', 'bcc-nazar:leg2', Config.Language.SubMenu_Head_Hint)
    WarMenu.CreateSubMenu('bcc-nazar:nazarsshop', 'bcc-nazar:leg2', Config.Language.SubMenu_Head_Buy)
    repeat
        if WarMenu.IsMenuOpened('bcc-nazar:leg2') then --if menu is opened then
            if WarMenu.Button(Config.Language.Menu_Title_Hint .. ' ' .. Config.Language.Menu_SubTitle_Hint, '') then --creates the hint shop option
                WarMenu.OpenMenu('bcc-nazar:sell') --opens the sell menu
            end
            if WarMenu.Button(Config.Language.Menu_Title_Sell, Config.Language.Menu_SubTitle_Sell) then --creates the shop option
                WarMenu.OpenMenu('bcc-nazar:shop') --opens the menu
            end
            if WarMenu.Button(Config.Language.Menu_Title_Buy, Config.Language.Menu_SubTitle_Buy) then
                WarMenu.OpenMenu('bcc-nazar:nazarsshop')
            end
        elseif WarMenu.IsMenuOpened('bcc-nazar:sell') then
            for k, v in pairs(Config.TreasureLocations) do --starts a for loop which creates multiple menus depending on the config
                if WarMenu.Button(v.huntname .. " For " .. tostring(v.hintcost)) then --creates a option for each thing in config lua
                    local cost = v.hintcost
                    C = v.location
                    V = v
                    TriggerServerEvent('bcc-nazar:menuopen6', cost) --triggers server event which is the cooldown event 
                    RegisterNetEvent('bcc-nazar:menuopen4') --creates a net event for the serever to call
                    AddEventHandler('bcc-nazar:menuopen4', function() --makes the net event have something to run
                        VORPcore.NotifyBottomRight(Config.Language.HintNotify,6000) --text in bottom right
                        WarMenu.CloseMenu() --closes the menu
                        searchforchest()
                    end)
                end
            end
        elseif WarMenu.IsMenuOpened('bcc-nazar:shop') then
            for p, u in pairs(Config.Shop) do --opens the shop table
                if WarMenu.Button("" ..Config.Language.Shopmenu_sell.. "" .. u.displayname .. "" ..Config.Language.Shopmenu_for.. "" .. u.price.. " $", '') then --creates a menu per thing in the shop
                    Iitemname = u.itemdbname --sets the varible to whatever option is clicked
                    Pprice = u.price --sets the price variable to the config lua
                    --This is from vorpinputs to get the amount they want to sell
                    local myInput = {
                        type = "enableinput", -- dont touch
                        inputType = "input", -- or text area for sending messages
                        button = Config.Language.input_button, -- button name
                        placeholder = Config.Language.input_placeholder, --placeholdername
                        style = "block", --- dont touch
                        attributes = {
                            inputHeader = Config.Language.input_header, -- header 1
                            type = "number", -- inputype text, number,date.etc if number comment out the pattern
                            pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                            title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
                            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                        }
                    }
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
                        local qty = tonumber(result)
                        if qty == nil then
                            print('nil val')
                        elseif qty > 0 then
                            TriggerServerEvent("bcc-nazar:catchinputforsell",  qty) --result
                        else
                            TriggerEvent("vorp:TipRight", "insertamount", 3000)
                        end
                    end)
                    WarMenu.CloseMenu()
                end
            end
        elseif WarMenu.IsMenuOpened('bcc-nazar:nazarsshop') then
            for k, e in pairs(Config.Nazarssellableitems) do
                if WarMenu.Button("" ..Config.Language.Menu_Title_Buy .. " " .. e.displayname .. "" ..Config.Language.Shopmenu_for.. "" .. e.price .. " $") then
                    Itemnamee = e.itemdbname
                    Priceee = e.price
                    local myInput = {
                        type = "enableinput", -- dont touch
                        inputType = "input", -- or text area for sending messages
                        button = Config.Language.input_button, -- button name
                        placeholder = Config.Language.input_placeholder, --placeholdername
                        style = "block", --- dont touch
                        attributes = {
                            inputHeader = Config.Language.input_header, -- header
                            type = "number", -- inputype text, number,date.etc if number comment out the pattern
                            pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                            title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
                            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                        }
                    }
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
                        local qty = tonumber(result)
                        if qty > 0 then
                            TriggerServerEvent("bcc-nazar:nazarsellinfopass",  qty) --result
                        else
                            TriggerEvent("vorp:TipRight", "insertamount", 3000)
                        end
                    end)
                    WarMenu.CloseMenu() -- closes the menu to stop the loop
                end
            end
        end
        WarMenu.Display() --makes the menu show
        Citizen.Wait(0) --prevents crashing
    until false
end)

--This recieves the qty when buying from nazar and then passes the qty along with the item name and price to the server to handle giving the items
RegisterNetEvent('bcc-nazar:nazarsellableitemscatch')
AddEventHandler('bcc-nazar:nazarsellableitemscatch', function(qty) --is catching the qty from the server
    TriggerServerEvent('bcc-nazar:buyfromnazar', qty, Itemnamee, Priceee) --is passing the 3 variables to the server
end)


--this recieves the qty when selling items to nazar from the server and then passes the itemname and price to the server along with the qty
RegisterNetEvent('bcc-nazar:infosenderforsell')
AddEventHandler('bcc-nazar:infosenderforsell', function(qty)
    TriggerServerEvent('bcc-nazar:getplayerdataforsell', Iitemname, Pprice, qty)
end)