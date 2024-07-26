local ChestPrompt
local ChestGroup = GetRandomIntInRange(0, 0xffffff)
local PromptStarted = false
local blips = {}

------------ Main Chest Hunt Setup ----------------
RegisterNetEvent('bcc-nazar:OpenChest', function(chestData)
    if not PromptStarted then
        StartChestPrompt()
    end

    VORPcore.NotifyLeft(_U('Nazar'), _U('HintNotify'), "BLIPS_MP", "blip_special_series_2", 6000, "COLOR_GREEN")

    local chestCoords = chestData.location
    local chest = CreateObject(joaat('p_chest01x'), chestCoords.x, chestCoords.y, chestCoords.z - 1, false, false, false, false, false)

    Citizen.InvokeNative(0x58A850EAEE20FAA3, chest, true) -- PlaceObjectOnGroundProperly
    Wait(500)
    FreezeEntityPosition(chest, true)

    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, chestCoords.x, chestCoords.y, chestCoords.z, 100.0) -- BlipAddForRadius
    table.insert(blips, blip)
    Citizen.InvokeNative(0x9CB1A1623062F402, _U('TreasureBlipName')) -- SetBlipName
    while true do
        local sleep = 1000
        local distance = #(GetEntityCoords(PlayerPedId()) - chestCoords)
        if distance <= 3 then
            sleep = 0
            local promptText = CreateVarString(10, 'LITERAL_STRING', _U('TreasurePromptTitle'))
            PromptSetActiveGroupThisFrame(ChestGroup, promptText)
            if Citizen.InvokeNative(0xE0F65F0640EF0617, ChestPrompt) then  -- PromptHasHoldModeCompleted
                local dict = 'mech_ransack@chest@med@open@crouch@b'
                LoadAnim(dict)
                TaskPlayAnim(PlayerPedId(), dict, 'base', 1.0, 1.0, 5000, 17, 1.0, false, false, false)
                RemoveBlip(blip)
                Wait(5000)
                print("Reward data being sent:", json.encode(chestData.Reward))
                TriggerServerEvent('bcc-nazar:GetRewards', chestData)
                DeleteEntity(chest)
                break
            end
        end
        Wait(sleep)
    end
end)

function LoadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function StartChestPrompt()
    local str = CreateVarString(10, 'LITERAL_STRING', _U('TreasurePrompt_search'))
    ChestPrompt = PromptRegisterBegin()
    PromptSetControlAction(ChestPrompt, Config.keys.chest) -- [G]
    PromptSetText(ChestPrompt, str)
    PromptSetVisible(ChestPrompt, true)
    PromptSetEnabled(ChestPrompt, true)
    PromptSetHoldMode(ChestPrompt, 2000)
    PromptSetGroup(ChestPrompt, ChestGroup)
    PromptRegisterEnd(ChestPrompt)

    PromptStarted = true
end

RegisterNetEvent('bcc-nazar:ClearBlips', function()
    for _, blip in ipairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}
end)