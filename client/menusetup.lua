-------------------- Pulling Essentials ---------------
VORPcore = exports.vorp_core:GetCore()

VORPMenu = {}
FeatherMenu = {}

if Config.UseVORPMenu then
    if GetResourceState('vorp_menu'):match("missing") or GetResourceState('vorp_menu'):match("stopped") then
        print('^1Missing/Stopped VORP Menu Resource^7')
    else
        TriggerEvent('vorp_menu:getData', function(cb)
            VORPMenu = cb
        end)
    end
else
    if GetResourceState('feather-menu'):match("missing") or GetResourceState('feather-menu'):match("stopped") then
        print('^1Missing/Stopped Feather Menu Resource^7')
    else
        FeatherMenu = exports['feather-menu'].initiate()
    end
end

-------- Variables ----------------
local myInput = {
    type = "enableinput", -- dont touch
    inputType = "input", -- or text area for sending messages
    button = _U('input_button'), -- button name
    placeholder = _U('input_placeholder'), --placeholdername
    style = "block", --- dont touch
    attributes = {
        inputHeader = _U('input_header'), -- header 1
        type = "number", -- inputype text, number,date.etc if number comment out the pattern
        pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
        title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
    }
}

---------- Main Menu Setup -------------------
if Config.UseVORPMenu then
    function OpenNazarMenu()
        if next(VORPMenu) == nil then 
            print('^1Missing/Stopped VORP Menu Resource^7')
            return
        end
        VORPMenu.CloseAll()
        local elements = { --sets the main 3 elements up
            { label = _U('Menu_SubTitle_Buy'),  value = 'buyItems',  desc = '' },
            { label = _U('Menu_SubTitle_Sell'), value = 'sellItems', desc = '' },
            { label = _U('Menu_SubTitle_Hint'), value = 'buyHint',   desc = '' }
        }
        VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
            title = _U('Nazar'),
            subtext = '',
            align = 'top-left',
            elements = elements,
            itemHeight = '3.5vh',
            lastmenu = '',
        },function(data, menu)
            if data.current == "backup" then
                return _G[data.trigger]()
            end
            if data.current.value == 'buyItems' then --if option clicked is this then
                BuyMenu()
            elseif data.current.value == 'sellItems' then
                SellMenu()
            elseif data.current.value == 'buyHint' then
                HintMenu()
            end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end)
    end
else
    local MainMenu
    function OpenNazarMenu()
        if next(FeatherMenu) == nil then
            print('^1Missing/Stopped Feather Menu Resource^7')
            return
        end
        MainMenu = FeatherMenu:RegisterMenu('feather:nazar:mainMenu', {
            top = '5%',
            left = '5%',
            ['720width'] = '400px',
            ['1080width'] = '500px',
            ['2kwidth'] = '600px',
            ['4kwidth'] = '700px',
            style = {
                -- ['height'] = '500px'
                -- ['border'] = '5px solid white',
                -- ['background-image'] = 'none',
                -- ['background-color'] = '#515A5A'
            },
            contentslot = {
                style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                    ['height'] = '300px',
                    ['min-height'] = '300px',
                }
            },
            draggable = false,
            --canclose = false
        }, {
            opened = function()
                DisplayRadar(false)
            end,
            closed = function()
                DisplayRadar(true)
            end,
        })

        local MainPage = MainMenu:RegisterPage('first:page')
        MainPage:RegisterElement('header', {
            value = _U('Nazar'),
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('button', {
            label = "Buy Items",
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenBuyMenu()
            -- This gets triggered whenever the button is clicked
        end)
        MainPage:RegisterElement('button', {
            label = "Sell Items",
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenSellMenu()
            -- This gets triggered whenever the button is clicked
        end)
        MainPage:RegisterElement('button', {
            label = "Purchase Hints",
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenHintMenu()
            -- This gets triggered whenever the button is clicked
        end)
        
        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        MainPage:RegisterElement('textdisplay', {
            value = Config.NazarSetup.randomQuotes[RandomQuoteIndex],
            slot = "footer",
            style = {
                ['font-family'] = "rdr",
                ['width'] = "80%",
                ['color'] = "rgb(127, 29, 29)"
            }
        })

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        MainMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = MainPage,
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            }
        })
    end
end

------------ Buying Menu Setup ---------------------
if Config.UseVORPMenu then
    function BuyMenu()
        VORPMenu.CloseAll()
        local elements = {}
        local elementindex = 1
        Wait(100)
        for _, items in pairs(Config.Shop) do
            elements[elementindex] = { --sets the elemnents to this table
                label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                items.itemdbname .. ".png'>" .. items.displayname .. ' - ' .. items.price .. ' ' .. '<span style="color: Yellow;">  ' .. items.currencytype .. '</span>',--sets the label -- added currency color and image added by mrtb
                value = 'sell' .. tostring(elementindex), --sets the value
                desc = '', --empty desc
                info = items --sets info to the table(this will allow you too open the table in the menu setup below)
            }
            elementindex = elementindex + 1 --adds 1 to the var
        end
        VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
            title = _U('Menu_SubTitle_Buy'),
            align = 'top-left',
            elements = elements,
            itemHeight = '3.5vh',
            lastmenu = "OpenNazarMenu"
        },function(data, menu)
            if (data.current == "backup") then
                return _G[data.trigger]()
            end
            if data.current.info then
                local itemName = data.current.info.itemdbname --sets the varible to whatever option is clicked (since we set info to = the table)
                local currencyType = data.current.info.currencytype -- Get the currencytype from config.shop added by mrtb
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local qty = tonumber(result) or 0
                    if qty >= 1 then
                        TriggerServerEvent('bcc-nazar:HandleBuySell', "buy", itemName, qty, currencyType)
                        menu.close()
                        ClearPedTasksImmediately(PlayerPedId())
                        DisplayRadar(true)
                    else
                        VORPcore.NotifyRightTip('insertamount', 3000)
                    end
                end)
            end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end)
    end
else
    local BuyMenu
    function OpenBuyMenu()
        BuyMenu = FeatherMenu:RegisterMenu('feather:nazar:mainMenu', {
            top = '5%',
            left = '5%',
            ['720width'] = '400px',
            ['1080width'] = '500px',
            ['2kwidth'] = '600px',
            ['4kwidth'] = '700px',
            style = {
                -- ['height'] = '500px'
                -- ['border'] = '5px solid white',
                -- ['background-image'] = 'none',
                -- ['background-color'] = '#515A5A'
            },
            contentslot = {
                style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                    ['height'] = '300px',
                    ['min-height'] = '300px'
                }
            },
            draggable = false,
            --canclose = false
        }, {
            opened = function()
                DisplayRadar(false)
            end,
            closed = function()
                DisplayRadar(true)
            end,
        })

        local MainPage = BuyMenu:RegisterPage('first:page')
        MainPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('subheader', {
            value = _U('Menu_SubTitle_Buy'),
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for _, items in pairs(Config.Shop) do
            MainPage:RegisterElement('button', {
                label = items.displayname .. ' - '..items.price..' ('..items.currencytype..')',
                -- style = {
                --     ['color'] = ((items.currencytype == "gold") and "yellow" or "white")
                -- },
                sound = {
                    action = "SELECT",
                    soundset = "RDRO_Character_Creator_Sounds"
                },
            }, function()
                -- This gets triggered whenever the button is clicked
                OpenHandlerMenu(items.displayname, items.itemdbname, items.currencytype ,"buy")
            end)
        end

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        MainPage:RegisterElement('button', {
            label = "BACK",
            slot = "footer",
            style = {
                ['color'] = "red"
            },
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenNazarMenu()
            -- This gets triggered whenever the button is clicked
        end)

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        BuyMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = MainPage,
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            }
        })
    end
end
------------ Selling Items Menu Setup -----------------
if Config.UseVORPMenu then
    function SellMenu()
        VORPMenu.CloseAll()
        local elements = {}
        local elementindex = 1
        Wait(100)
        for _, items in pairs(Config.NazarsSellableItems) do
            elements[elementindex] = {
                label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                items.itemdbname .. ".png'>" .. items.displayname .. ' - ' .. items.price .. ' ' .. '<span style="color: Yellow;">  ' .. items.currencytype .. '</span>', -- edited by mrtb
                value = 'sell' .. tostring(elementindex),
                desc = '',
                info = items
            }
            elementindex = elementindex + 1
        end
        VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
            title = _U('Menu_SubTitle_Sell'),
            align = 'top-left',
            elements = elements,
            itemHeight = '3.5vh',
            lastmenu = "OpenNazarMenu"
        },function(data, menu)
            if (data.current == "backup") then
                _G[data.trigger]()
            end
            if data.current.info then
                local itemName = data.current.info.itemdbname --sets the varible to whatever option is clicked
                local currencyType = data.current.info.currencytype --added by mrtb
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local qty = tonumber(result)
                    if qty >= 1 then
                        TriggerServerEvent('bcc-nazar:HandleBuySell', "sell", itemName, qty, currencyType)
                        menu.close()
                        ClearPedTasksImmediately(PlayerPedId())
                        DisplayRadar(true)
                    else
                        VORPcore.NotifyRightTip('insertamount', 3000)
                    end
                end)
            end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end)
    end
else
    local SellMenu
    function OpenSellMenu()
        SellMenu = FeatherMenu:RegisterMenu('feather:nazar:mainMenu', {
            top = '5%',
            left = '5%',
            ['720width'] = '400px',
            ['1080width'] = '500px',
            ['2kwidth'] = '600px',
            ['4kwidth'] = '700px',
            style = {
                -- ['height'] = '500px'
                -- ['border'] = '5px solid white',
                -- ['background-image'] = 'none',
                -- ['background-color'] = '#515A5A'
            },
            contentslot = {
                style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                    ['height'] = '300px',
                    ['min-height'] = '300px'
                }
            },
            draggable = false,
            --canclose = false
        }, {
            opened = function()
                DisplayRadar(false)
            end,
            closed = function()
                DisplayRadar(true)
            end,
        })

        local MainPage = SellMenu:RegisterPage('first:page')
        MainPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('subheader', {
            value = _U('Menu_SubTitle_Sell'),
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for _, items in pairs(Config.NazarsSellableItems) do
            MainPage:RegisterElement('button', {
                label = items.displayname .. ' - '..items.price..' ('..items.currencytype..')',
                -- style = {
                --     ['color'] = ((items.currencytype == "gold") and "yellow" or "white")
                -- },
                sound = {
                    action = "SELECT",
                    soundset = "RDRO_Character_Creator_Sounds"
                },
            }, function()
                -- This gets triggered whenever the button is clicked
                OpenHandlerMenu(items.displayname, items.itemdbname, items.currencytype ,"sell")
            end)
        end

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        MainPage:RegisterElement('button', {
            label = "BACK",
            slot = "footer",
            style = {
                ['color'] = "red"
            },
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenNazarMenu()
            -- This gets triggered whenever the button is clicked
        end)

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        SellMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = MainPage,
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            }
        })
    end
end

-------------- Hint Menu Setup -----------------
if Config.UseVORPMenu then
    function HintMenu()
        VORPMenu.CloseAll()
        local elements = {}
        local elementindex = 1
        Wait(100)
        for _, v in pairs(Config.TreasureLocations) do
            elements[elementindex] = {
                label = v.huntname,
                value = 'hintbought' .. tostring(elementindex),
                desc = '',
                info = v
            }
            elementindex = elementindex + 1
        end
        VORPMenu.Open('default', GetCurrentResourceName(), 'menuapi', {
            title = _U('Menu_SubTitle_Hint'),
            align = 'top-left',
            elements = elements,
            itemHeight = '3.5vh',
            lastmenu = "OpenNazarMenu"
        },function(data, menu)
            if (data.current == "backup") then
                return _G[data.trigger]()
            end
            if data.current.info then
                local cost = data.current.info.hintcost
                    C = data.current.info.location
                    V = data.current.info
                TriggerServerEvent('bcc-nazar:BuyHint', cost)
                menu.close()
                ClearPedTasksImmediately(PlayerPedId())
                DisplayRadar(true)
            end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end)
    end
else
    local HintMenu
    function OpenHintMenu()
        HintMenu = FeatherMenu:RegisterMenu('feather:nazar:mainMenu', {
            top = '5%',
            left = '5%',
            ['720width'] = '400px',
            ['1080width'] = '500px',
            ['2kwidth'] = '600px',
            ['4kwidth'] = '700px',
            style = {
                -- ['height'] = '500px'
                -- ['border'] = '5px solid white',
                -- ['background-image'] = 'none',
                -- ['background-color'] = '#515A5A'
            },
            contentslot = {
                style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                    ['height'] = '300px',
                    ['min-height'] = '300px'
                }
            },
            draggable = false,
            --canclose = false
        }, {
            opened = function()
                DisplayRadar(false)
            end,
            closed = function()
                DisplayRadar(true)
            end,
        })

        local MainPage = HintMenu:RegisterPage('first:page')
        MainPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('subheader', {
            value = _U('Menu_SubTitle_Hint'),
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for _, v in pairs(Config.TreasureLocations) do
            MainPage:RegisterElement('button', {
                label = v.huntname,
                -- style = {
                --     ['color'] = ((items.currencytype == "gold") and "yellow" or "white")
                -- },
                sound = {
                    action = "SELECT",
                    soundset = "RDRO_Character_Creator_Sounds"
                },
            }, function()
                OpenHandlerMenu()
                -- This gets triggered whenever the button is clicked

            end)
        end

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        MainPage:RegisterElement('button', {
            label = "BACK",
            slot = "footer",
            style = {
                ['color'] = "red"
            },
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenNazarMenu()
            -- This gets triggered whenever the button is clicked
        end)

        MainPage:RegisterElement('line', {
            slot = "footer"
        })

        HintMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = MainPage,
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            }
        })
    end
end

----------------- Quantity and Handler--------
if not Config.UseVORPMenu then
    function OpenHandlerMenu(itemDisplay, itemDbName, currencyType, action)
        HandlerMenu = FeatherMenu:RegisterMenu('feather:nazar:handlerMenu', {
            top = '50%',
            left = '50%',
            ['720width'] = '400px',
            ['1080width'] = '500px',
            ['2kwidth'] = '600px',
            ['4kwidth'] = '700px',
            style = {    
                ['height'] = 'auto'  
            },
            contentslot = {
                style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                    --['height'] = '100px',
                    --['min-height'] = '100px'
                }
            },
            draggable = false,
            --canclose = false
        }, {
            opened = function()
                DisplayRadar(false)
            end,
            closed = function()
                DisplayRadar(true)
            end,
        })

        local MainPage = HandlerMenu:RegisterPage('first:page')

        MainPage:RegisterElement('line', {
            slot = "header"
        })

        local qty = 1

        MainPage:RegisterElement('slider', {
            label = itemDisplay:upper(),
            start = 1,
            min = 1,
            max = 10,
            steps = 1,
            slot = "header",
        }, function(data)
            -- This gets triggered whenever the sliders selected value changes
            qty = data.value
        end)

        MainPage:RegisterElement('line', {
            slot = "header"
        })

        MainPage:RegisterElement('button', {
            label = (action == "buy" and "BUY" or "SELL"),
            slot = "header",
            style = {
                ['color'] = "red"
            },
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            -- This gets triggered whenever the button is clicked
            if itemDbName ~= nil and qty > 0 then
                TriggerServerEvent('bcc-nazar:HandleBuySell', action, itemDbName, qty, currencyType)
                HandlerMenu:Close({})
            end
        end)

        HandlerMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = MainPage,
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            }
        })
    end
end

-----------------CRAFT HANDLER-----------------
if Config.UseVORPMenu then
    function CraftMenuMain()
        if next(VORPMenu) == nil then 
            print('^1Missing/Stopped VORP Menu Resource^7')
            return
        end
        VORPMenu.CloseAll()
        local elements = {}
        local elementindex = 1
        Wait(100)
        for setId, v in pairs(ConfigCards.SetsData) do
            elements[elementindex] = {
                label = v.name,
                value = setId,
                desc = '',
                info = v
            }
            elementindex = elementindex + 1
        end
        VORPMenu.Open('default', GetCurrentResourceName(), 'menuapi', {
            title = _U('CraftCard'),
            align = 'right',
            elements = elements,
            itemHeight = '3.5vh',
            lastmenu = ""
        },function(data, menu)
            if (data.current == "backup") then
                return _G[data.trigger]()
            end
            if data.current.info then
                local success = VORPcore.Callback.TriggerAwait('bcc-nazar:CardCraft', data.current.value)
                menu.close()
                ClearPedTasksImmediately(PlayerPedId())
                DisplayRadar(true)
            end
        end,
        function(data, menu)
            menu.close()
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end)

    end
else
    local CraftMenu
    function CraftMenuMain()
        if next(FeatherMenu) == nil then
            print('^1Missing/Stopped Feather Menu Resource^7')
            return
        end
        CraftMenu = FeatherMenu:RegisterMenu('feather:nazar:craftMenu', {
            top = '15%',
            left = '55%',
            ['720width'] = '400px',
            ['1080width'] = '500px',
            ['2kwidth'] = '600px',
            ['4kwidth'] = '700px',
            style = {
                -- ['height'] = '500px'
                -- ['border'] = '5px solid white',
                -- ['background-image'] = 'none',
                -- ['background-color'] = '#515A5A'
            },
            contentslot = {
                style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                    ['height'] = '300px',
                    ['min-height'] = '300px'
                }
            },
            draggable = false,
            --canclose = false
        }, {
            opened = function()
                DisplayRadar(false)
            end,
            closed = function()
                DisplayRadar(true)
            end,
        })

        local MainPage = CraftMenu:RegisterPage('first:page')
        MainPage:RegisterElement('header', {
            value = _U('CraftCard'),
            slot = "header",
            style = {}
        })
        MainPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for setId, v in pairs(ConfigCards.SetsData) do
            MainPage:RegisterElement('button', {
                label = v.name,
                sound = {
                    action = "SELECT",
                    soundset = "RDRO_Character_Creator_Sounds"
                },
            }, function()
                local success = VORPcore.Callback.TriggerAwait('bcc-nazar:CardCraft', setId)
                if success then
                    CraftMenu:Close({})
                end
            end)
        end

        MainPage:RegisterElement('bottomline', {
            slot = "footer"
        })

        CraftMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = MainPage,
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            }
        })
    end
end

RegisterNetEvent('bcc-nazar:OpenCardMenu', function()
    CraftMenuMain()
end)

----------------- Cleanup --------------------
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    if Config.UseVORPMenu then
        VORPMenu.CloseAll()
    else
        
        -- Close All Feather Menu here
    end
    ClearPedTasksImmediately(PlayerPedId())
    DisplayRadar(true)
end)