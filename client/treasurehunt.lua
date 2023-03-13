local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

Searchinrange2 = 0

function searchforchest()
    local object = CreateObject('p_chest01x', C.x, C.y, C.z - 1, false, false, false) --creates an object
    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, C.x, C.y, C.z, 100.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.Language.TreasureBlipName)
    RequestModel(object, true) --requests the object model
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --registers a prompt group
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.TreasurePromptTitle, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --creates a prompt in the prompt group
    while true do --starts loop
        Citizen.Wait(0)
        local l = GetEntityCoords(PlayerPedId()) --sets the varible l to the players position
        local dist = GetDistanceBetweenCoords(l.x, l.y, l.z, C.x, C.y, Config.z) --get distance between player and config location
        if dist < 5 then --if dist less than 5 do
            Searchinrange2 = 1 --sets global varible to 1 (acts as a trigger)
        elseif dist > 5 then --makes it so if you go in range but dont open it the prompt doesnt stay there the whole time 
            Searchinrange2 = 2 --sets it too 2
        end
        if Searchinrange2 == 1 then --if the trigger is 1 then
            PromptGroup:ShowGroup(Config.Language.TreasurePrompt_search) --Names the prompt search chest
            if firstprompt:HasCompleted() then --if the prmpt has been done then
                firstprompt:DeletePrompt() --deletes prompt
                Citizen.CreateThread(function() --Starts the play animation setup(This entire thread is needed)
                    RequestAnimDict('mech_ransack@chest@med@open@crouch@b') --Checks to see if its loaded
                    while not HasAnimDictLoaded('mech_ransack@chest@med@open@crouch@b') do --makes sure its loaded
                        Citizen.Wait(0)
                    end
                    TaskPlayAnim(PlayerPedId(), 'mech_ransack@chest@med@open@crouch@b', 'base', 8.0, 8.0, 1000, 17, 0.2, false, false, false) --plays the animation
                end) --end of animation setup
                RemoveBlip(blip)
                TriggerServerEvent('chestopen', V) --triggers the server event and passes the variable
                break
            end
        end
    end
end
