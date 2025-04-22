local NazarBlip, NazarPed, WagonObj
local madamNazarPrompt, NazarPromptGroup
local promptThread = nil
local IsNazarMenuOpen = false
local promptEnabled = false
local CurrentNazarCoords = nil

-- Debug helper
if Config.devMode then
    function devPrint(msg) print("^1[DEV MODE] ^4" .. msg) end
else
    function devPrint(message) end
end

RegisterNetEvent("vorp:SelectedCharacter", function(charid)
    devPrint("[Nazar] Character selected: " .. tostring(charid))

    -- Delay slightly before calling RPC
    CreateThread(function()
        Wait(1000)
        BccUtils.RPC:Call("bcc-nazar:GetLocation", {}, function(location)
            if location then
                devPrint("[Nazar] Received location after character select.")
                TriggerEvent("bcc-nazar:PedSpawn", location)
            else
                print("[Nazar] Failed to fetch location from server.")
            end
        end)
    end)
end)

    CreateThread(function()
        Wait(2000)
        local playerLoaded = LocalPlayer.state['isLoggedIn'] or true
        if playerLoaded then
            BccUtils.RPC:Call("bcc-nazar:GetLocation", {}, function(location)
                if location then
                    devPrint("[Nazar] DevMode: received location on resource restart.")
                    TriggerEvent("bcc-nazar:PedSpawn", location)
                end
            end)
        end
    end)

print("[Nazar] Callback executed - location valid? ", location and "YES" or "NO")
RegisterNetEvent("bcc-nazar:PedSpawn", function(location)
    devPrint("PedSpawn received with new location.")
    local playerPed = PlayerPedId()
    if promptThread and promptThread.active then
        promptThread.active = false
        devPrint("Old prompt loop stopped.")
    end

    -- DELETE prompt + group
    if madamNazarPrompt then
        madamNazarPrompt:DeletePrompt()
        devPrint("Old prompt deleted.")
        madamNazarPrompt = nil
    end
    NazarPromptGroup = nil

    -- Close UI if open
    if IsNazarMenuOpen then
        NazarMainMenu:Close({})
        IsNazarMenuOpen = false
        devPrint("Closed old Nazar menu.")
    end

    -- CLEANUP old entities
    if NazarPed then NazarPed:Remove() end
    if NazarBlip then NazarBlip:Remove() end
    if WagonObj then DeleteEntity(WagonObj) end

    -- Store new location
    local nazarCoords = vector3(location.nazarCoords.x, location.nazarCoords.y, location.nazarCoords.z)
    local nazarHeading = location.nazarHeading
    local wagonCoords = location.wagonCoords
    CurrentNazarCoords = nazarCoords         -- store for reuse in loop
    devPrint("New coords set: " .. json.encode(location))
    
    if location.wagon then
        WagonObj = Citizen.InvokeNative(0x509D5878EB39E842, `mp005_p_collectorwagon01`, wagonCoords.x, wagonCoords.y,
            wagonCoords.z - 1, false, false, false, false, false)                                                                                                                   -- CreateObject
        Citizen.InvokeNative(0x58A850EAEE20FAA3, WagonObj, true)                                                                                                                    -- PlaceObjectOnGroundProperly
    end

    -- Blip
    if Config.nazar.blip.show then
        local coords = nazarCoords
        NazarBlip = BccUtils.Blips:SetBlip(Config.nazar.blip.name, Config.nazar.blip.sprite, 0.2, coords.x,
            coords.y, coords.z)
        local blipModifier = BccUtils.Blips:AddBlipModifier(NazarBlip, Config.BlipColors
            [Config.nazar.blip.color])
        blipModifier:ApplyModifier()
    end

    NazarPed = BccUtils.Ped:Create(Config.nazar.model, nazarCoords.x, nazarCoords.y, nazarCoords.z - 1, 0, 'world', false)
    NazarPed:SetHeading(nazarHeading)
    BccUtils.Ped.SetStatic(NazarPed:GetPed())
    TaskStartScenarioInPlace(NazarPed:GetPed(), `WORLD_HUMAN_SMOKE_NAZAR`, -1)
    devPrint("Nazar ped created! Model: " ..
    Config.nazar.model .. " at coords: " .. nazarCoords.x .. ", " .. nazarCoords.y .. ", " .. (nazarCoords.z - 1))

    -- Prompts
    NazarPromptGroup = BccUtils.Prompts:SetupPromptGroup()
    madamNazarPrompt = NazarPromptGroup:RegisterPrompt(_U("TalkToNPCText"), Config.keys.nazar, 1, 1, true, "click", {})

    -- Prompt activation delay
    promptEnabled = false
    CreateThread(function()
        Wait(500)
        promptEnabled = true
        devPrint("Prompt re-enabled.")
    end)
    -- Loop
    promptThread = { active = true }
    CreateThread(function()
        devPrint("Started new prompt loop.")
        local audioPlay = false

        while promptThread and promptThread.active do
            local sleep = 1000
            if not IsEntityDead(playerPed) then
                local coords = GetEntityCoords(playerPed)
                local dist = #(coords - CurrentNazarCoords)

                if dist <= 10 then
                    sleep = 0
                    if Config.nazar.music and not audioPlay then
                        audioPlay = true
                        BccUtils.YtAudioPlayer.PlayAudio('https://www.youtube.com/embed/IgSBKjBz7Qw', 'IgSBKjBz7Qw',
                            Config.nazar.volume, 1)
                    end
                elseif audioPlay then
                    audioPlay = false
                    BccUtils.YtAudioPlayer.StopAudio()
                end

                if dist <= 2 and promptEnabled then
                    NazarPromptGroup:ShowGroup(_U("Nazar"))

                    if madamNazarPrompt and madamNazarPrompt:HasCompleted() then
                        OpenNazarMenu()
                        IsNazarMenuOpen = true
                    end
                end
            end
            Wait(sleep)
        end
        devPrint("Prompt loop terminated.")
    end)
end)

-- Cleanup
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        NazarMainMenu:Close({})
        if NazarPed then NazarPed:Remove() end
        if NazarBlip then NazarBlip:Remove() end
        if WagonObj then DeleteEntity(WagonObj) end
        BccUtils.YtAudioPlayer.StopAudio()
        devPrint("Cleaned up on resource stop.")
    end
end)
