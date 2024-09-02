local robtime = Config.TotalTime
local timerCount = robtime
local isRobbing = false
local timers = false

local function getDeadPeds()
    local deadPeds = {}
    local pedPool = GetGamePool('CPed')
    local deadPedDist = Config.DeadPedDist
    local areacoords = Config.DeadPedWipe

    for i = 1, #pedPool do
        local ped = pedPool[i]
        local distance = #(GetEntityCoords(ped) - areacoords)
        if IsPedDeadOrDying(ped, true) and not IsPedAPlayer(ped) and NetworkGetEntityOwner(ped) == PlayerId() and distance <= deadPedDist then
            deadPeds[#deadPeds + 1] = ped
        end
    end

    return deadPeds
end

CreateThread(function()
    while true do
        Wait((Config.WaitTime))
        local deadPeds = getDeadPeds()
        for i = 1, #deadPeds do
            DeleteEntity(deadPeds[i])
        end
        collectgarbage()
    end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	SetTextFontForCurrentCommand(15)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 337.19, 1495.84, 181.16, true)
		if betweencoords < 2.0 then
			DrawTxt(Config.StartMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
			TriggerServerEvent("Badlands_FortAssault:startToRob", function()
			isRobbing = true
			end)
			end
		end
	end
end)

RegisterNetEvent('Badlands_FortAssault:startAnimation')
AddEventHandler('Badlands_FortAssault:startAnimation', function()

    local playerPed = PlayerPedId()
    diguppole()
	exports.redemrp_progressbars:DisplayProgressBar(15000, "Digging up post...")

	ClearPedTasks(ped)
	DeleteObject(entity)
	DeleteEntity(entity)
	ClearPedTasksImmediately(PlayerPedId())
		Wait(500)
    TriggerEvent("Badlands_FortAssault:startTheEvent", function()
    end)
end)

RegisterNetEvent("Badlands_FortAssault:startTimer")
AddEventHandler("Badlands_FortAssault:startTimer",function()
	timers = true
	TriggerEvent("Badlands_FortAssault:startTimers")
		while timers do
		Citizen.Wait(0)
		DrawTxt("Hold the Fort for... "..timerCount.." seconds", 0.15, 0.10, 0.3, 0.3, true, 255, 255, 255, 255, true)
		local playerPed = PlayerPedId()
		local playerdead = IsPlayerDead(PlayerId())
		if playerdead then
			timers = false
		end
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 337.19, 1495.84, 181.16, true)
		if betweencoords > 750.0 then
			timers = false
		end

			if timerCount == Config.Reinforcements then
				local playerPed = PlayerPedId()
				local playerdead = IsPlayerDead(PlayerId())
				if playerdead then
					timers = false
				end
				TriggerEvent("redemrp_notification:start", (Config.BackupMessage), 5)
				Citizen.Wait(100)
				SpawnNPCs()
			end

			if timerCount == Config.Reinforcements2 then
				local playerPed = PlayerPedId()
				local playerdead = IsPlayerDead(PlayerId())
				if playerdead then
					timers = false
				end
				TriggerEvent("redemrp_notification:start", (Config.BackupMessage), 5)
				Citizen.Wait(100)
				SpawnNPCs()
			end

			if timerCount == Config.Reinforcements3 then
				local playerPed = PlayerPedId()
				local playerdead = IsPlayerDead(PlayerId())
				if playerdead then
					timers = false
				end
				TriggerEvent("redemrp_notification:start", (Config.BackupMessage), 5)
				Citizen.Wait(100)
				SpawnNPCs()
			end

			if timerCount == Config.Reinforcements4 then
				local playerPed = PlayerPedId()
				local playerdead = IsPlayerDead(PlayerId())
				if playerdead then
					timers = false
				end
				TriggerEvent("redemrp_notification:start", (Config.BackupMessage), 5)
				Citizen.Wait(100)
				SpawnNPCs()
			end

			if timerCount == Config.Reinforcements5 then
				local playerPed = PlayerPedId()
				local playerdead = IsPlayerDead(PlayerId())
				if playerdead then
					timers = false
				end
				TriggerEvent("redemrp_notification:start", (Config.BackupMessage), 5)
				Citizen.Wait(100)
				SpawnNPCs()
			end

		if timerCount == 0 then
			local playerPed = PlayerPedId()
			local playerdead = IsPlayerDead(PlayerId())
			if playerdead then
				timers = false
			end
			Citizen.Wait(1000)
			TriggerServerEvent("Badlands_FortAssault:payout", function()
		end)
		end
	end
end)

AddEventHandler("Badlands_FortAssault:startTimers",function()
Citizen.CreateThread(function()
    while timers do

	Citizen.Wait(1000)
    if timerCount >= 0 then
        timerCount = timerCount - 1
	else
		timers = false
    end
	end

end)
end)

function DrawText(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)
    SetTextCentre(true)
    SetTextDropshadow(1,0,0,0,200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

RegisterNetEvent("Badlands_FortAssault:startTheEvent")
AddEventHandler("Badlands_FortAssault:startTheEvent",function(num,typey)
    while not HasModelLoaded( GetHashKey("G_M_O_UniExConfeds_01") ) do
        Wait(500)
        RequestModel( GetHashKey("G_M_O_UniExConfeds_01") )
    end
	local playerPed = PlayerPedId()
	AddRelationshipGroup('NPC')
	AddRelationshipGroup('PlayerPed')
	SpawnNPCs()
end)

function SpawnNPCs()
local playerPed = PlayerPedId()
	AddRelationshipGroup('NPC')
	AddRelationshipGroup('PlayerPed')
for k,v in pairs(Config.Armymen) do
		pedy = CreatePed(GetHashKey("G_M_O_UniExConfeds_01"),v.x,v.y,v.z,0, true, false, 0, 0)
		SetPedRelationshipGroupHash(pedy, 'NPC')
        GiveWeaponToPed_2(pedy, 0x64356159, 500, true, 1, false, 0.0)
		Citizen.InvokeNative(0x283978A15512B2FE, pedy, true)
		Citizen.InvokeNative(0xF166E48407BAC484, pedy, PlayerPedId(), 0, 0)
		FreezeEntityPosition(pedy, false)
		TaskCombatPed(pedy,playerped, 0, 16)
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

function diguppole()
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
    AttachEntityToEntity(entity,ped, boneIndex, -0.0, 0.0, 0.0, -170.0, 10.0, 0.0, false, false, false, true, 2, true)

    TaskPlayAnim(PlayerPedId(), dict, "exit_back", 1.0, 8.0, -1, 1, 0, false, false, false)
end

local iLocal_21 = CreateVolumeAggregateWithCustomName("Fort Wallace - m_volThreatVolume Agg");
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 343.4911, 1484.906, 183.6585, 0, 0, 125.4594, 50.44129, 27.58693, 15.20348);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 350.3736, 1501.781, 184.2531, 0, 0, 33.49929, 9.61958, 30.69061, 13.84341);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 357.9312, 1517.985, 184.7034, 0, 0, -16.95034, 4.391377, 5.500231, 12.25786);
    Citizen.InvokeNative(0xBCE668AAF83608BE, iLocal_21, 362.5482, 1516.343, 182.8423, 0, 0, 0, 3.488632, 3.541783, 9.602388);
    Citizen.InvokeNative(0xBCE668AAF83608BE, iLocal_21, 366.5602, 1473.809, 182.5569, 0, 0, 0, 4, 4, 7.516581);
    local iLocal_22 = CreateVolumeAggregateWithCustomName("Fort Wallace - m_volRegistrationVolume Agg");
    Citizen.InvokeNative(0x6E0D3C3F828DA773, iLocal_22, iLocal_21);
    Citizen.InvokeNative(0xBCE668AAF83608BE, iLocal_22, 345.1969, 1487.955, 182.5569, 0, 0, 0, 63.65347, 68.76788, 13.83329);
    local sLocal_23 = "OLD_FORT_WALLACE";
    CreateGuardZone(sLocal_23);
    Citizen.InvokeNative(0x8C598A930F471938, sLocal_23, iLocal_22);
    Citizen.InvokeNative(0xA1B0E6301E2E02A6, sLocal_23, iLocal_21);
    Citizen.InvokeNative(0x35815F372D43E1E5, sLocal_23, iLocal_21);
    Citizen.InvokeNative(0xAD3E07C37A7C1ADC, sLocal_23, iLocal_21);
    SetGuardZonePosition(sLocal_23, 346.9555, 1488.217, 182.0683);
    Citizen.InvokeNative(0xA8A74AA79FB67159, sLocal_23, iLocal_21);