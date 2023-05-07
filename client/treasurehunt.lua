--Function to spawn the chest after buying hint
RegisterNetEvent('bcc-nazar:menuopen4', function()
    VORPcore.NotifyBottomRight(Config.Language.HintNotify,6000) --text in bottom right
    --Object Creation
    local object = CreateObject('p_chest01x', C.x, C.y, C.z - 1, false, false, false) --creates an object
    RequestModel(object, true) --requests the object model

    --Blip Setup
    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, C.x, C.y, C.z, 100.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.Language.TreasureBlipName)

    --Prompt Setup
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --registers a prompt group
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.TreasurePromptTitle, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --creates a prompt in the prompt group

    --Distance Tracker Setup
    while true do
        Wait(5)
        local pl = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(pl.x, pl.y, pl.z, C.x, C.y, C.z, true)
        if dist < 3 then
            PromptGroup:ShowGroup(Config.Language.TreasurePrompt_search) --Names the prompt search chest
            if firstprompt:HasCompleted() then --if the prmpt has been done then
                RequestAnimDict('mech_ransack@chest@med@open@crouch@b') --Checks to see if its loaded
                while not HasAnimDictLoaded('mech_ransack@chest@med@open@crouch@b') do --makes sure its loaded
                    Wait(0)
                end
                TaskPlayAnim(PlayerPedId(), 'mech_ransack@chest@med@open@crouch@b', 'base', 8.0, 8.0, 1000, 17, 0.2, false, false, false) --plays the animation
                RemoveBlip(blip)
                TriggerServerEvent('bcc-nazar:chestopen', V) break --triggers the server event and passes the variable and breaks loop
            end
        elseif dist > 200 then
            Wait(2000)
        end
    end
end)

------ Card Handler -----
RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    Wait(5000)
    if Config.CardsEnable then
        for k, v in pairs(Config.CollectableCards) do
            local id = v.cardname .. tostring(charid)
            TriggerServerEvent('bcc-nazar:CardCooldownCheck', id, v)
        end
    end
end)

RegisterNetEvent('bcc-nazar:CardCollectorMain', function(v)
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(v.cardname, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
    --

    local object = CreateObject('mp005_s_cardt_3s', v.coords.x, v.coords.y, v.coords.z, false, false, false)
    RequestModel(object, true)
    Citizen.InvokeNative(0x9587913B9E772D29, object, true)
    Citizen.InvokeNative(0x7DFB49BCDB73089A, object, true)

    while true do
        Wait(5)
        local pl = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(v.coords.x, v.coords.y, v.coords.z, pl.x, pl.y, pl.z, true)
        if dist < 3 then
            PromptGroup:ShowGroup(Config.Language.TreasurePrompt_search)
            if firstprompt:HasCompleted() then
                DeleteObject(object)
                TriggerServerEvent('bcc-nazar:CardCollectorAddItems', v.carditem) break
            end
        elseif dist > 200 then
            Wait(2000)
        end
    end
end)