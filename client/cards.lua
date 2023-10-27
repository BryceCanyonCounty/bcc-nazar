CreateThread(function()
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.Pickup, 0x760A9C6F, 1, 1, true, 'hold',
        { timedeventhash = "MEDIUM_TIMED_EVENT" })
    while true do
        Wait(5)
        local coords, cardcoords = GetEntityCoords(PlayerPedId()), nil
        for k, v in pairs(Config.Cards) do
            if GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < 5 then
                if not cardmade then
                    print('spawning card')
                    propEntity = CreateObject(GetHashKey(v.hash), v.coords.x, v.coords.y, v.coords.z, false, true, false,
                        false, true)
                    Citizen.InvokeNative(0x9587913B9E772D29, propEntity, true)
                    cardmade = true
                    FreezeEntityPosition(propEntity, true)
                end
                cardcoords = GetEntityCoords(propEntity)
                if GetDistanceBetweenCoords(coords, cardcoords, false) < 4.5 then
                    print('near card')
                    PromptGroup:ShowGroup(Config.Language.Pickup)
                    if firstprompt:HasCompleted() then
                        TriggerServerEvent('nate_commands:CardCooldownSV', v)
                        Wait(250)
                        if not CardCheck then
                            TaskPlayAnim(PlayerPedId(), "mech_inspection@cigarette_card@ground", "enter", 5.0, 5.0, 3500,
                                01, 0)
                            VORPcore.NotifyLeft("Card Collected", "You've collected a card", "INVENTORY_ITEMS",
                                "document_cig_card_act", 4000, "Color_white")
                            TriggerServerEvent('nate_commands:GetCard', v.name .. ' ' .. v.number, v.hash)
                        else
                            VORPcore.NotifyRightTip("You can not collect this card again", 4000)
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

RegisterNetEvent('nate_commands:UseCard', function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local propEntity = CreateObject(GetHashKey(hash), coords, false, true, false, false, true)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "GENERIC_DOCUMENT_FLIP_AVAILABLE", true, -1)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey(hash), propEntity, GetHashKey('PrimaryItem'),
        GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_INTRO'), 1, 0, -1.0)
end)

RegisterNetEvent('nate_commands:ClientCardCheck', function(check)
    CardCheck = check
end)
