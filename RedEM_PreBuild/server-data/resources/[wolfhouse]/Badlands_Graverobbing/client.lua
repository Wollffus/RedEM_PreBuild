local gravestones = { "p_grave06x", "p_gravedugcover01x", "p_gravefresh01x", "p_gravemarker01x", "p_gravemarker02x", "p_gravestone_srd08x", "p_gravestone01ax", "p_gravestone01x", "p_gravestone03ax", "p_gravestone03x", "p_gravestone04x",                                               -- generic | p_graveyard.rpf
"p_gravestone05x", "p_gravestone06x", "p_gravestone07ax",  "p_gravestone07x",  "p_gravestone08ax", "p_gravestone08x", "p_gravestone09x", "p_gravestone14ax", "p_gravestone14x", "p_gravestone16ax", "p_gravestone16x",                                               -- generic | p_graveyard.rpf
"p_gravestonebroken01x", "p_gravestonebroken02x", "p_gravestonebroken05x", "p_gravestoneclean02ax", "p_gravestoneclean02x", "p_gravestoneclean03x", "p_gravestoneclean04ax",
"p_gravestoneclean04x", "p_gravestoneclean05ax", "p_gravestoneclean05x", "p_gravestoneclean06ax", "p_gravestoneclean06x", "p_gravestonejanedoe02x" }

local hour = GetClockHours()
local minute = GetClockMinutes()
local cooldown = 0
local wollffus = false

RegisterNetEvent('grave:TriggerRobbery')
AddEventHandler('grave:TriggerRobbery', function()

if cooldown == 0 and not wollffus then
    hour = GetClockHours()
    if (hour > (Config.sunset) or hour < (Config.sunrise)) then

	    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

	    for key, value in pairs(gravestones) do
		    local gravestone = DoesObjectOfTypeExistAtCoords(x, y, z, 1.0, GetHashKey(value), true)

		    if gravestone then
                wollffus = true
			    ClearPedTasks(ped)
                TriggerEvent("redemrp_notification:start","Getting a shovel out", 6, "error")
                TriggerEvent('redemrp_witness:CallWitness', "Grave Robbery", (Config.messagetolawman))
                Wait(12000)
			    robgrave()
                exports.redemrp_progressbars:DisplayProgressBar((Config.digtimer), "Digging up grave...")
			    TriggerServerEvent("grave:Complete")
			    ClearPedTasks(ped)
			    DeleteObject(entity)
			    DeleteEntity(entity)
			    ClearPedTasksImmediately(PlayerPedId())
                RunCooldown()
                wollffus = false
		    end
	    end
    else
	    PlaySoundFrontend("Witness", "HUD_Wanted_Sounds", true, 1)
        TriggerEvent("redemrp_notification:start", (Config.timeerror), 5, "error")
    end
    else
        PlaySoundFrontend("Witness", "HUD_Wanted_Sounds", true, 1)
        TriggerEvent("redemrp_notification:start", (Config.toosoon), 5, "error")
    end
end)

function robgrave()
    local dict = "amb_work@world_human_coal_shovel@male_a@walk_exit_withprop"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end

	local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
    local modelHash = GetHashKey("p_shovel03x")
    LoadModel(modelHash)
    entity = CreateObject(modelHash, coords.x+0.3, coords.y,coords.z, true, false, false)
    SetEntityVisible(entity, true)
    SetEntityAlpha(entity, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
    SetModelAsNoLongerNeeded(modelHash)
    AttachEntityToEntity(entity,ped, boneIndex, -0.0, 0.0, 0.0, -170.0, 10.0, 0.0, false, false, false, true, 2, true) -- -0.0, 0.0, 0.2, -170.0, 10.0, 0.0,

    TaskPlayAnim(PlayerPedId(), dict, "exit_back", 1.0, 8.0, -1, 1, 0, false, false, false)
end

function RunCooldown()
	cooldown = 2500
	while cooldown > 0 do
		Wait(0)
		cooldown = cooldown - 1
	end
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end
