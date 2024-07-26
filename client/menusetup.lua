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
        local NazarMenuPage = NazarMainMenu:RegisterPage('nazar:menu:page')
        NazarMenuPage:RegisterElement('header', {
            value = _U('Nazar'),
            slot = "header",
            style = {}
        })
        NazarMenuPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })
        NazarMenuPage:RegisterElement('button', {
            label = _U('Menu_SubTitle_Buy'),
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenBuyMenu()
            -- This gets triggered whenever the button is clicked
        end)
        NazarMenuPage:RegisterElement('button', {
            label = _U('Menu_SubTitle_Sell'),
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenSellMenu()
            -- This gets triggered whenever the button is clicked
        end)
        NazarMenuPage:RegisterElement('button', {
            label = _U('Menu_SubTitle_Hint'),
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            OpenHintMenu()
            -- This gets triggered whenever the button is clicked
        end)

        NazarMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        NazarMenuPage:RegisterElement('textdisplay', {
            value = Config.NazarSetup.randomQuotes[RandomQuoteIndex],
            slot = "footer",
            style = {
                ['font-family'] = "rdr",
                ['width'] = "80%",
                ['color'] = "rgb(127, 29, 29)"
            }
        })

        NazarMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        NazarMainMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = NazarMenuPage,
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
        local BuyMenuPage = NazarMainMenu:RegisterPage('buy:menu:page')
        BuyMenuPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })
        BuyMenuPage:RegisterElement('subheader', {
            value = _U('Menu_SubTitle_Buy'),
            slot = "header",
            style = {}
        })
        BuyMenuPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for _, items in pairs(Config.Shop) do
            BuyMenuPage:RegisterElement('button', {
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

        BuyMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        BuyMenuPage:RegisterElement('button', {
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

        BuyMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        NazarMainMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = BuyMenuPage,
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
        local SellMenuPage = NazarMainMenu:RegisterPage('sell:menu:page')
        SellMenuPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })
        SellMenuPage:RegisterElement('subheader', {
            value = _U('Menu_SubTitle_Sell'),
            slot = "header",
            style = {}
        })
        SellMenuPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for _, items in pairs(Config.NazarsSellableItems) do
            SellMenuPage:RegisterElement('button', {
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

        SellMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        SellMenuPage:RegisterElement('button', {
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

        SellMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        NazarMainMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = SellMenuPage,
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
        for _, chestCfg in pairs(Chests) do
            elements[elementindex] = {
                label = chestCfg.huntname,
                value = 'hintbought' .. tostring(elementindex),
                desc = '',
                info = chestCfg
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
                local chestData = data.current.info
                TriggerServerEvent('bcc-nazar:BuyHint', chestData)
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
    function OpenHintMenu()
        local HintMenuPage = NazarMainMenu:RegisterPage('hint:menu:page')
        HintMenuPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })
        HintMenuPage:RegisterElement('subheader', {
            value = _U('Menu_SubTitle_Hint'),
            slot = "header",
            style = {}
        })
        HintMenuPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for _, chestCfg in pairs(Chests) do
            HintMenuPage:RegisterElement('button', {
                label = chestCfg.huntname,
                sound = {
                    action = "SELECT",
                    soundset = "RDRO_Character_Creator_Sounds"
                },
            }, function()
                local chestData = chestCfg

                -- Trigger the server event with cost and additional necessary details
                TriggerServerEvent('bcc-nazar:BuyHint', chestData)

                -- Close menu and perform cleanup actions
                NazarMainMenu:Close({})
                ClearPedTasksImmediately(PlayerPedId())
                DisplayRadar(true)
            end)

        end

        HintMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        HintMenuPage:RegisterElement('button', {
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
        end)

        HintMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        NazarMainMenu:Open({
            startupPage = HintMenuPage,
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
        local HandlerMenuPage = NazarMainMenu:RegisterPage('handler:menu:page')

        HandlerMenuPage:RegisterElement('header', {
            value = 'Madam Nazar',
            slot = "header",
            style = {}
        })

        HandlerMenuPage:RegisterElement('line', {
            slot = "header"
        })

        local qty = 1

        HandlerMenuPage:RegisterElement('slider', {
            label = itemDisplay:upper(),
            start = 1,
            min = 1,
            max = 10,
            steps = 1,
            slot = "header",
        }, function(data)
            qty = data.value
        end)

        HandlerMenuPage:RegisterElement('line', {
            slot = "footer"
        })

        -- Adding debug statement in the button registration callback
        HandlerMenuPage:RegisterElement('button', {
            label = (action == "buy" and "BUY" or "SELL"),
            slot = "footer",
            style = {
                ['color'] = "red"
            },
            sound = {
                action = "SELECT",
                soundset = "RDRO_Character_Creator_Sounds"
            },
        }, function()
            if itemDbName ~= nil and qty > 0 then
                TriggerServerEvent('bcc-nazar:HandleBuySell', action, itemDbName, qty, currencyType)
                NazarMainMenu:Close({})
            else
                print("Either itemDbName is nil or qty is not greater than 0")
            end
        end)

        HandlerMenuPage:RegisterElement('bottomline', {
            slot = "footer"
        })

        NazarMainMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = HandlerMenuPage,
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
        local CraftMenuPage = NazarMainMenu:RegisterPage('craft:menu:page')
        CraftMenuPage:RegisterElement('header', {
            value = _U('CraftCard'),
            slot = "header",
            style = {}
        })
        CraftMenuPage:RegisterElement('line', {
            slot = "header",
            style = {}
        })

        for setId, v in pairs(ConfigCards.SetsData) do
            CraftMenuPage:RegisterElement('button', {
                label = v.name,
                sound = {
                    action = "SELECT",
                    soundset = "RDRO_Character_Creator_Sounds"
                },
            }, function()
                local success = VORPcore.Callback.TriggerAwait('bcc-nazar:CardCraft', setId)
                if success then
                    NazarMainMenu:Close({})
                end
            end)
        end

        CraftMenuPage:RegisterElement('bottomline', {
            slot = "footer"
        })

        NazarMainMenu:Open({
            -- cursorFocus = false,
            -- menuFocus = false,
            startupPage = CraftMenuPage,
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
        -- Remove all chest blips
    TriggerEvent('bcc-nazar:ClearBlips')

    if Config.UseVORPMenu then
        VORPMenu.CloseAll()
    else

        -- Close All Feather Menu here
    end
    ClearPedTasksImmediately(PlayerPedId())
    DisplayRadar(true)
end)
