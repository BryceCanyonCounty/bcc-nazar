-------------------- Pulling Essentials ---------------
VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

-------- Variables ----------------
StopAll = false
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

----------- Closing menu if backspace pressed ----------------------
local inmenu = false
AddEventHandler('bcc-nazar:MenuClose', function()
    while inmenu do
        Wait(10)
        if IsControlJustReleased(0, 0x156F7119) then
            if inmenu then
                inmenu = false
                MenuData.CloseAll()
            end
        end
    end
end)

---------- Main Menu Setup -------------------
function MainMenu()
    inmenu = true
    TriggerEvent('bcc-nazar:MenuClose')
    MenuData.CloseAll()
    local elements = { --sets the main 3 elements up
        { label = Config.Language.Menu_SubTitle_Buy, value = 'buyitems', desc = '' },
        { label = Config.Language.Menu_SubTitle_Sell, value = 'sellitems', desc = '' },
        { label = Config.Language.Menu_SubTitle_Hint, value = 'buyhint', desc = '' }
    }
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi', --opens the menu
        {
            title = Config.Language.Nazar,
            align = 'top-left',
            elements = elements,
        },
        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == 'buyitems' then --if option clicked is this then
                inmenu = false
                BuyMenu()
            elseif data.current.value == 'sellitems' then
                inmenu = false
                SellMenu()
            elseif data.current.value == 'buyhint' then
                inmenu = false
                HintMenu()
            end
        end)
end

------------ Buying Menu Setup ---------------------
function BuyMenu()
    MenuData.CloseAll()
    local elements, elementindex = {}, 1
    Wait(100)
    for k, items in pairs(Config.Shop) do
        elements[elementindex] = { --sets the elemnents to this table
            label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
            items.itemdbname .. ".png'>" .. items.displayname .. ' - ' .. items.price .. ' ' .. '<span style="color: Yellow;">  ' .. items.currencytype .. '</span>',--sets the label -- added currency color and image added by mrtb
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
                Scurrencytype = data.current.info.currencytype -- Get the currencytype from config.shop added by mrtb
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
                    local qty = tonumber(result)
                    if qty > 0 then
                        TriggerServerEvent('bcc-nazar:buyfromnazar', qty, Iitemname, Pprice, Scurrencytype)
                    else
                        TriggerEvent("vorp:TipRight", "insertamount", 3000)
                    end
                end)
            end
        end)
end

------------ Selling Items Menu Setup -----------------
function SellMenu()
    MenuData.CloseAll()
    local elements, elementindex = {}, 1
    Wait(100)
    
    for k, items in pairs(Config.Nazarssellableitems) do    
        elements[elementindex] = {
            label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
            items.itemdbname .. ".png'>" .. items.displayname .. ' - ' .. items.price .. ' ' .. '<span style="color: Yellow;">  ' .. items.currencytype .. '</span>', -- edited by mrtb
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
                Scurrencytype = data.current.info.currencytype --added by mrtb
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
                    local qty = tonumber(result)
                    if qty > 0 then
                        TriggerServerEvent('bcc-nazar:getplayerdataforsell', Iitemname, Pprice, qty, Scurrencytype)
                    else
                        TriggerEvent("vorp:TipRight", "insertamount", 3000)
                    end
                end)
            end
        end)
end

-------------- Hint Menu Setup -----------------
function HintMenu()
    MenuData.CloseAll()
    local elements, elementindex = {}, 1
    Wait(100)
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
            end
        end)
end

----------------- Cleanup --------------------
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    MenuData.CloseAll()
end)