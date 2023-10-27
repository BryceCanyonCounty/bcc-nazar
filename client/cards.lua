local cardmade, CardCheck = false, false

CreateThread(function()
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.Pickup, 0x760A9C6F, 1, 1, true, 'hold',
        { timedeventhash = "MEDIUM_TIMED_EVENT" })
    while true do
        Wait(5)
        local coords, cardcoords = GetEntityCoords(PlayerPedId()), nil
        for k, v in pairs(ConfigCards.Cards) do
            if GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < 15 then
                if not cardmade then
                    propEntity = CreateObject(GetHashKey(v.hash), v.coords.x, v.coords.y, v.coords.z, false, true, false,
                        false, true)
                    Citizen.InvokeNative(0x9587913B9E772D29, propEntity, true)
                    cardmade = true
                    FreezeEntityPosition(propEntity, true)
                end
                cardcoords = GetEntityCoords(propEntity)
                if GetDistanceBetweenCoords(coords, cardcoords, false) < 2.0 then
                    PromptGroup:ShowGroup(Config.Language.Pickup)
                    if firstprompt:HasCompleted() then
                        TriggerServerEvent('bcc-nazar:CardCooldownSV', v)
                        Wait(250)
                        if not CardCheck then
                            TaskPlayAnim(PlayerPedId(), "mech_inspection@cigarette_card@ground", "enter", 5.0, 5.0, 3500,
                                01, 0)
                            VORPcore.NotifyLeft("Config.Language.CardCollected", "Config.Language.CardCollected", "INVENTORY_ITEMS",
                                "document_cig_card_act", 4000, "Color_white")
                            TriggerServerEvent('bcc-nazar:GetCard', v.name .. ' ' .. v.number, v.hash)
                        else
                            VORPcore.NotifyRightTip("Config.Language.CantCollectCard", 4000)
                        end
                    end
                end
            else
                cardmade = false
                DeleteEntity(propEntity)
            end
        end
    end
end)

RegisterNetEvent('bcc-nazar:UseCard', function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local propEntity = CreateObject(GetHashKey(hash), coords, false, true, false, false, true)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "GENERIC_DOCUMENT_FLIP_AVAILABLE", true, -1)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey(hash), propEntity, GetHashKey('PrimaryItem'),
        GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_INTRO'), 1, 0, -1.0)
end)

RegisterNetEvent('bcc-nazar:ClientCardCheck', function(check)
    CardCheck = check
end)
