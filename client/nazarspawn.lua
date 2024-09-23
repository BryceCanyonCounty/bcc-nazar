local Blip, NazarPed, WagonObj

-- Make it usable and change after every 30mins instead of every prompt press
RandomQuoteIndex = 0

------------- Location Setting ---------------
CreateThread(function()
    TriggerServerEvent('bcc-nazar:LocationSet')
end)

--------------- Nazar Spawn Setup -------------------
RegisterNetEvent('bcc-nazar:PedSpawn', function(location)
    local audioPlay = false
    local nazarCoords = vector3(location.nazarCoords.x, location.nazarCoords.y, location.nazarCoords.z)
    local nazarHeading = location.nazarHeading
    local wagonCoords = location.wagonCoords

    if location.wagon then
        WagonObj = Citizen.InvokeNative(0x509D5878EB39E842, `mp005_p_collectorwagon01`, wagonCoords.x, wagonCoords.y, wagonCoords.z - 1, false, false, false, false, false) -- CreateObject
        Citizen.InvokeNative(0x58A850EAEE20FAA3, WagonObj, true) -- PlaceObjectOnGroundProperly
    end

    if Config.nazar.blip.show == true then
        Blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, nazarCoords.x, nazarCoords.y, nazarCoords.z)
        SetBlipSprite(Blip, Config.nazar.blip.sprite, 1)
        Citizen.InvokeNative(0x662D364ABF16DE2F, Blip, joaat(Config.BlipColors[Config.nazar.blip.color])) -- BlipAddModifier
        Citizen.InvokeNative(0x9CB1A1623062F402, Blip, Config.nazar.blip.name) -- SetBlipName
    end

    local model = joaat(Config.nazar.model)
    RequestModel(model, false)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    NazarPed = CreatePed(model, nazarCoords.x, nazarCoords.y, nazarCoords.z - 1, nazarHeading, false, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, NazarPed, true) -- SetRandomOutfitVariation
    BccUtils.Ped.SetStatic(NazarPed)
    TaskStartScenarioInPlace(NazarPed, `WORLD_HUMAN_SMOKE_NAZAR`, -1)

    -- Prompts
    local NazarPromptGroup = BccUtils.Prompts:SetupPromptGroup()
	local madamNazarPrompt = NazarPromptGroup:RegisterPrompt(_U('TalkToNPCText'), Config.keys.nazar, 1, 1, true, 'click', {})
    local musicEnabled = Config.nazar.music

    while true do
        local sleep = 1000
        local distance = #(GetEntityCoords(PlayerPedId()) - nazarCoords)

        if distance <= 10 then
            sleep = 0
            if musicEnabled and not audioPlay then
                audioPlay = true
                BccUtils.YtAudioPlayer.PlayAudio('https://www.youtube.com/embed/IgSBKjBz7Qw', 'IgSBKjBz7Qw', Config.nazar.volume, 1)
            end
        else
            if musicEnabled and audioPlay then
                audioPlay = false
                BccUtils.YtAudioPlayer.StopAudio()
            end
        end

        if distance <= 2 then
            NazarPromptGroup:ShowGroup(_U('Nazar'))

            if madamNazarPrompt:HasCompleted() then
                RandomQuoteIndex = math.random(1, #Config.quotes)
                OpenNazarMenu()
            end
        end
        Wait(sleep)
    end
end)

------------- Cleanup ----------------
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        DeletePed(NazarPed)
        RemoveBlip(Blip)
        DeleteEntity(WagonObj)
    end
end)
