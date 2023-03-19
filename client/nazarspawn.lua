local VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

Citizen.CreateThread(function()
 TriggerServerEvent('hd_nazar:locationset')
end)

RegisterNetEvent('hd_nazar:pedspawn')
AddEventHandler('hd_nazar:pedspawn', function(nspawn)
    Nspawn = nspawn
    local model = GetHashKey('cs_mp_travellingsaleswoman') --sets the npc model
    if Config.NazarSetup.blip == true then
        local blip = VORPutils.Blips:SetBlip("Madam Nazaar", 'blip_mp_collector_map', 0.8, Nspawn.x, Nspawn.y, Nspawn.z)
    end
    RequestModel(model) -- requests the varible model
    if not HasModelLoaded(model) then --checks if its loaded
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Wait(100)
    end
    local createdped = CreatePed(model, Nspawn.x, Nspawn.y, Nspawn.z - 1, Nspawn.h, false, true, true, true) --creates ped the minus one makes it so its standing on the ground not floating
    Citizen.InvokeNative(0x283978A15512B2FE, createdped, true) -- sets ped into random outfit, stops it being invis
    SetEntityAsMissionEntity(createdped, true, true) -- sets ped as mission entity preventing it from despawning
    SetEntityInvincible(createdped, true) --sets ped invincible
    FreezeEntityPosition(createdped, true) --freezes the entity
    SetBlockingOfNonTemporaryEvents(createdped, true) --Npc won't get scared
    --Loop creation to create text, and open menu
    while true do -- creates a loop to keep the text up and the distance constantly checked
        Citizen.Wait(0) --makes it wait a slight amount (avoids crashing is needed)
        local playercoord = GetEntityCoords(PlayerPedId()) --gets the players ped coordinates
        local dist = GetDistanceBetweenCoords(playercoord.x, playercoord.y, playercoord.z, Nspawn.x, Nspawn.y, Nspawn.z, false) --gets the distance between coords
        if dist < 10 then -- if distance is less than 10 do
            DrawText3D(Nspawn.x, Nspawn.y, Nspawn.z, Config.Language.TalkToNPCText) --creates the text
        end
        local player = GetEntityCoords(PlayerPedId()) --gets players coords
        if GetDistanceBetweenCoords(Nspawn.x, Nspawn.y, Nspawn.z, player.x, player.y, player.z, false) < 2 then
            if IsControlJustReleased(0, 0x760A9C6F) then
                WarMenu.OpenMenu('hd_nazar:leg2') --opens the main menu
            end
        end
    end
end)

--Creates the ability to use DrawText3D
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end