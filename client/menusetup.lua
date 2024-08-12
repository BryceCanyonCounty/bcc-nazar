-- Pulling Essentials
VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()
FeatherMenu = {}
if GetResourceState('feather-menu'):match("missing") or GetResourceState('feather-menu'):match("stopped") then
    print('^1Missing/Stopped Feather Menu Resource^7')
else
    FeatherMenu = exports['feather-menu'].initiate()
end

-- Register Nazar Menu
NazarMainMenu = FeatherMenu:RegisterMenu('feather:nazar:mainMenu', {
    top = '5%',
    left = '5%',            
	['720width'] = '400px',
    ['1080width'] = '500px',
    ['2kwidth'] = '600px',
    ['4kwidth'] = '700px',
    style = {},
    contentslot = {
      style = {
        ['height'] = '350px',
        ['min-height'] = '250px'
      }
    },
    draggable = true
  }, {
    opened = function()
        DisplayRadar(false)
    end,
    closed = function()
        DisplayRadar(true)
    end,
})

---------- Main Menu Setup -------------------
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
    end)
    NazarMenuPage:RegisterElement('button', {
        label = _U('Menu_SubTitle_Sell'),
        sound = {
            action = "SELECT",
            soundset = "RDRO_Character_Creator_Sounds"
        },
    }, function()
        OpenSellMenu()
    end)
    NazarMenuPage:RegisterElement('button', {
        label = _U('Menu_SubTitle_Hint'),
        sound = {
            action = "SELECT",
            soundset = "RDRO_Character_Creator_Sounds"
        },
    }, function()
        local onCooldown = VORPcore.Callback.TriggerAwait('bcc-nazar:CheckPlayerCooldown', 'buyHint')
        if onCooldown then
            VORPcore.NotifyRightTip(_U('NoHintNotify'), 4000)
        else
            OpenHintMenu()
        end
    end)

    NazarMenuPage:RegisterElement('line', {
        slot = "footer"
    })

    NazarMenuPage:RegisterElement('textdisplay', {
        value = Config.quotes[RandomQuoteIndex],
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

------------ Buying Menu Setup ---------------------
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

    for _, items in pairs(Items.buy) do
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

------------ Selling Items Menu Setup -----------------
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

    for _, items in pairs(Items.sell) do
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

-------------- Hint Menu Setup -----------------
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

----------------- Quantity and Handler--------
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

-----------------CRAFT HANDLER-----------------
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

RegisterNetEvent('bcc-nazar:OpenCardMenu', function()
    CraftMenuMain()
end)

----------------- Cleanup --------------------
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    -- Remove all chest blips
    TriggerEvent('bcc-nazar:ClearBlips')

    -- Close All Feather Menu here

    ClearPedTasksImmediately(PlayerPedId())
    DisplayRadar(true)
end)
