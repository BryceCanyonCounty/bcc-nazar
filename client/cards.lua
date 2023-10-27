local cardmade, CardCheck = false, false

if ConfigCards.Enabled then
       CreateThread(function()
        local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
        local firstprompt = PromptGroup:RegisterPrompt(Config.Language.Pickup, 0x760A9C6F, 1, 1, true, 'hold',
            { timedeventhash = "MEDIUM_TIMED_EVENT" })
        for k, v in pairs(Config.Cards) do
            v.spawned = false
        end
        while true do
            Wait(5)
            local coords, cardcoords = GetEntityCoords(PlayerPedId()), nil
            for k, v in pairs(ConfigCards.Cards) do
                if GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < 15 then
                    if not v.spawned then
                        propEntity = CreateObject(GetHashKey(v.hash), v.coords.x, v.coords.y, v.coords.z, false, true, false,
                            false, true)
                        Citizen.InvokeNative(0x9587913B9E772D29, propEntity, true)
                        v.spawned = true
                        FreezeEntityPosition(propEntity, true)
                    end
                    cardcoords = GetEntityCoords(propEntity)
                    if GetDistanceBetweenCoords(coords, cardcoords, false) < 2.5 then
                        PromptGroup:ShowGroup(Config.Language.Pickup)
                        if firstprompt:HasCompleted() then
                            TriggerServerEvent('bcc-nazar:CardCooldownSV', v)
                            Wait(250)
                            if not CardCheck then
                                TriggerServerEvent('bcc-nazar:GetCard', v.name .. ' ' .. v.number, v.hash)
                            else
                                VORPcore.NotifyRightTip(Config.Language.CantCollectCard, 4000)
                            end
                        end
                    end
                else
                    if v.spawned then
                        DeleteEntity(propEntity)
                        v.spawned = false
                    end
                   if cardmade then
                       if IsControlJustPressed(0, 0x308588E6) then
                           ClearPedTasks(PlayerPedId())
                       end
                   end
                end
            end
        end
    end)
end
RegisterNetEvent('bcc-nazar:UseCard', function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local propEntity = CreateObject(GetHashKey(hash), coords, false, true, false, false, true)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "GENERIC_DOCUMENT_FLIP_AVAILABLE", true, -1)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey(hash), propEntity, GetHashKey('PrimaryItem'),
        GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_INTRO'), 1, 0, -1.0)
                  cardmade = true
end)

RegisterNetEvent('bcc-nazar:ClientCardCheck', function(check)
    CardCheck = check
end)
