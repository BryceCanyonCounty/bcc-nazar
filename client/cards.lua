local CardPrompt
local CardGroup = GetRandomIntInRange(0, 0xffffff)
local CardMade = false

if ConfigCards.Enabled then
    CreateThread(function()
        StartCardPrompt()
        while true do
            Wait(0)
            local sleep = true
            for card, cardCfg in pairs(ConfigCards.Cards) do
                local distance = #(GetEntityCoords(PlayerPedId()) - cardCfg.coords)
                if distance <= 15 then
                    sleep = false
                    if not cardCfg.propEntity then
                        SpawnCard(card)
                    end
                    if distance <= 2 then
                        local promptText = CreateVarString(10, 'LITERAL_STRING', cardCfg.name .. ' ' .. cardCfg.number)
                        PromptSetActiveGroupThisFrame(CardGroup, promptText)
                        if Citizen.InvokeNative(0xE0F65F0640EF0617, CardPrompt) then  -- PromptHasHoldModeCompleted
                            local onCooldown = VORPcore.Callback.TriggerAwait('bcc-nazar:CardCooldown', cardCfg.model)
                            if not onCooldown then
                                TriggerServerEvent('bcc-nazar:GetCard', cardCfg.name .. ' ' .. cardCfg.number, cardCfg.model)
                            else
                                VORPcore.NotifyRightTip(_U('CantCollectCard'), 4000)
                            end
                        end
                    end
                else
                    if cardCfg.propEntity then
                        DeleteEntity(cardCfg.propEntity)
                        cardCfg.propEntity = nil
                    end
                    if CardMade then
                        if IsControlJustPressed(0, 0x308588E6) then -- INPUT_GAME_MENU_CANCEL / ESC - BACKSPACE
                           ClearPedTasks(PlayerPedId())
                           CardMade = false
                        end
                    end
                end
            end
            if sleep then
                Wait(1000)
            end
        end
    end)
end

RegisterNetEvent('bcc-nazar:UseCard', function(model)
    local playerPed = PlayerPedId()
    Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 2, true) -- HidePedWeapons
    local propEntity = CreateObject(joaat(model), GetEntityCoords(playerPed), false, false, false, false, false)
    Citizen.InvokeNative(0xCB9401F918CB0F75, playerPed, 'GENERIC_DOCUMENT_FLIP_AVAILABLE', true, -1) -- SetPedBlackboardBool
    TaskItemInteraction_2(playerPed, joaat(model), propEntity, joaat('PrimaryItem'), joaat('CIGARETTE_CARD_W6-5_H10-7_SINGLE_INTRO'), 1, 0, -1.0)
    CardMade = true
end)

function SpawnCard(card)
    local cardCfg = ConfigCards.Cards[card]
    cardCfg.propEntity = CreateObject(joaat(cardCfg.model), cardCfg.coords, false, false, false, false, false)
    Citizen.InvokeNative(0x9587913B9E772D29, cardCfg.propEntity, true) -- PlaceEntityOnGroundProperly
    Wait(500)
    FreezeEntityPosition(cardCfg.propEntity, true)
end

function StartCardPrompt()
    local str = CreateVarString(10, 'LITERAL_STRING', _U('Pickup'))
    CardPrompt = PromptRegisterBegin()
    PromptSetControlAction(CardPrompt, Config.keys.collect) -- [G]
    PromptSetText(CardPrompt, str)
    PromptSetVisible(CardPrompt, true)
    PromptSetEnabled(CardPrompt, true)
    PromptSetHoldMode(CardPrompt, 2000)
    PromptSetGroup(CardPrompt, CardGroup)
    PromptRegisterEnd(CardPrompt)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    ClearPedTasksImmediately(PlayerPedId())
    for _, cardCfg in pairs(ConfigCards.Cards) do
        if cardCfg.propEntity then
            DeleteEntity(cardCfg.propEntity)
        end
    end
end)
