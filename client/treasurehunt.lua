--Function to spawn the chest after buying hint
function searchforchest()
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
        Citizen.Wait(10)
        local pl = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pl.x, pl.y, pl.z, C.x, C.y, C.z, true) < 3 then
            PromptGroup:ShowGroup(Config.Language.TreasurePrompt_search) --Names the prompt search chest
            if firstprompt:HasCompleted() then --if the prmpt has been done then
                RequestAnimDict('mech_ransack@chest@med@open@crouch@b') --Checks to see if its loaded
                while not HasAnimDictLoaded('mech_ransack@chest@med@open@crouch@b') do --makes sure its loaded
                    Citizen.Wait(0)
                end
                TaskPlayAnim(PlayerPedId(), 'mech_ransack@chest@med@open@crouch@b', 'base', 8.0, 8.0, 1000, 17, 0.2, false, false, false) --plays the animation
                RemoveBlip(blip)
                TriggerServerEvent('bcc-nazar:chestopen', V) break --triggers the server event and passes the variable and breaks loop
            end
        end
    end
end