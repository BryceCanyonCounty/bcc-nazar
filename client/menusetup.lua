local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
StopAll = false --dead check variable
TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

--this is used to close the menu while you are on the main menu and hit backspace button
local inmenu = false --var used to see if you are in the main menu or not
RegisterNetEvent('bcc-nazar:MenuClose')
AddEventHandler('bcc-nazar:MenuClose', function()
    while true do --loops will run permantely
        Citizen.Wait(10) --waits 10ms prevents crashing
        if IsControlJustReleased(0, 0x156F7119) then --if backspace is pressed then
            if inmenu then --if var is true then
                inmenu = false --resets var
                MenuData.CloseAll() --closes all menus
            end
        end
    end
end)

function MainMenu() --when triggered will open the main menu
    inmenu = true --changes var to true allowing the press of backspace to close the menu
    TriggerEvent('bcc-nazar:MenuClose') --triggers the event
    MenuData.CloseAll() --closes all menus
    local elements = { --sets the main 3 elements up
        { label = Config.Language.Menu_SubTitle_Buy, value = 'buyitems', desc = '' },
        { label = Config.Language.Menu_SubTitle_Sell, value = 'sellitems', desc = '' },
        { label = Config.Language.Menu_SubTitle_Hint, value = 'buyhint', desc = '' }
    }
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi', --opens the menu
        {
            title = Config.Language.Nazar, --sets the title
            align = 'top-left', --aligns it too left side of screen
            elements = elements, --sets the elemnts
        },
        function(data) --creates a function with data as a var
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == 'buyitems' then --if option clicked is this then
                inmenu = false --resets var
                BuyMenu() --triggers function
            elseif data.current.value == 'sellitems' then
                inmenu = false
                SellMenu()
            elseif data.current.value == 'buyhint' then
                inmenu = false
                HintMenu()
            end
        end)
end

function BuyMenu()
    MenuData.CloseAll()
    local elements = {} --sets the var to a table
    local elementindex = 1 --sets the var too 1
    Citizen.Wait(100) --waits 100ms
    for k, items in pairs(Config.Shop) do --opens a for loop
        elements[elementindex] = { --sets the elemnents to this table
            label = items.displayname .. ' ' .. items.price.. '$', --sets the label
            value = 'sell' .. tostring(elementindex), --sets the value
            desc = '', --empty desc
            info = items --sets info to the table(this will allow you too open the table in the menu setup below)
        }
        elementindex = elementindex + 1 --adds 1 to the var
    end
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi', {
        title = Config.Language.Menu_SubTitle_Buy,
        align = 'top-left',
        elements = elements,
        lastmenu = "MainMenu"
    },
        function(data)
            if (data.current == "backup") then
                _G[data.trigger]()
            else
                Iitemname = data.current.info.itemdbname --sets the varible to whatever option is clicked (since we set info to = the table)
                Pprice = data.current.info.price
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
                    elseif qty > 0 then
                        TriggerServerEvent("bcc-nazar:nazarsellinfopass",  qty) --result
                    else
                        TriggerEvent("vorp:TipRight", "insertamount", 3000)
                    end
                end)
            end
        end)
end

function SellMenu()
    MenuData.CloseAll()
    local elements = {}
    local elementindex = 1
    Citizen.Wait(100)
    for k, items in pairs(Config.Nazarssellableitems) do
        elements[elementindex] = {
            label = items.displayname .. ' ' .. items.price.. '$',
            value = 'sell' .. tostring(elementindex),
            desc = '',
            info = items
        }
        elementindex = elementindex + 1
    end
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi', {
        title = Config.Language.Menu_SubTitle_Buy,
        align = 'top-left',
        elements = elements,
        lastmenu = "MainMenu"
    },
        function(data)
            if (data.current == "backup") then
                _G[data.trigger]()
            else
                Iitemname = data.current.info.itemdbname --sets the varible to whatever option is clicked
                Pprice = data.current.info.price
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
                    elseif qty > 0 then
                        TriggerServerEvent("bcc-nazar:catchinputforsell",  qty) --result
                    else
                        TriggerEvent("vorp:TipRight", "insertamount", 3000)
                    end
                end)
            end
        end)
end

function HintMenu()
    MenuData.CloseAll()
    local elements = {}
    local elementindex = 1
    Citizen.Wait(100)
    for k, v in pairs(Config.TreasureLocations) do
        elements[elementindex] = {
            label = v.huntname,
            value = 'hintbought' .. tostring(elementindex),
            desc = '',
            info = v
        }
        elementindex = elementindex + 1
    end
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi', {
        title = Config.Language.Menu_SubTitle_Hint,
        align = 'top-left',
        elements = elements,
        lastmenu = "MainMenu"
    },
        function(data)
            if (data.current == "backup") then
                _G[data.trigger]()
            else
                local cost = data.current.info.hintcost
                C = data.current.info.location
                V = data.current.info
                TriggerServerEvent('bcc-nazar:menuopen6', cost) --triggers server event which is the cooldown event 
                RegisterNetEvent('bcc-nazar:menuopen4') --creates a net event for the serever to call
                AddEventHandler('bcc-nazar:menuopen4', function() --makes the net event have something to run
                    VORPcore.NotifyBottomRight(Config.Language.HintNotify,6000) --text in bottom right
                    WarMenu.CloseMenu() --closes the menu
                    searchforchest()
                end)
            end
        end)
end

--This closes the menu when you stop or restart the resources.
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    MenuData.CloseAll()
end)

--This recieves the qty when buying from nazar and then passes the qty along with the item name and price to the server to handle giving the items
RegisterNetEvent('bcc-nazar:nazarsellableitemscatch')
AddEventHandler('bcc-nazar:nazarsellableitemscatch', function(qty) --is catching the qty from the server
    TriggerServerEvent('bcc-nazar:buyfromnazar', qty, Iitemname, Pprice) --is passing the 3 variables to the server
end)


--this recieves the qty when selling items to nazar from the server and then passes the itemname and price to the server along with the qty
RegisterNetEvent('bcc-nazar:infosenderforsell')
AddEventHandler('bcc-nazar:infosenderforsell', function(qty)
    TriggerServerEvent('bcc-nazar:getplayerdataforsell', Iitemname, Pprice, qty)
end)