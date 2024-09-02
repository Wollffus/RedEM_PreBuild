local inHand = false
local working = false
local axeProp = nil
local StartWorkPrompt
local PutAwayPrompt
local PickaxePrompts = GetRandomIntInRange(0, 0xffffff)
local pcoords = nil
local MiningBlips = {}

local TEXTURES = Config.Textures

function SetupPickAxePrompt()
        local str = Config.Prompts.Work[2]
        StartWorkPrompt = PromptRegisterBegin()
        PromptSetControlAction(StartWorkPrompt, Config.Prompts.Work[1])
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(StartWorkPrompt, str)
        PromptSetEnabled(StartWorkPrompt, 1)
        PromptSetVisible(StartWorkPrompt, 1)
		PromptSetStandardMode(StartWorkPrompt,1)
		PromptSetGroup(StartWorkPrompt, PickaxePrompts)
		Citizen.InvokeNative(0xC5F428EE08FA7F2C,StartWorkPrompt,true)
		PromptRegisterEnd(StartWorkPrompt)

        local str2 = Config.Prompts.Stop[2]
        PutAwayPrompt = PromptRegisterBegin()
        PromptSetControlAction(PutAwayPrompt, Config.Prompts.Stop[1]) 
        str2 = CreateVarString(10, 'LITERAL_STRING', str2)
        PromptSetText(PutAwayPrompt, str2)
        PromptSetEnabled(PutAwayPrompt, 1)
        PromptSetVisible(PutAwayPrompt, 1)
		PromptSetStandardMode(PutAwayPrompt,1)
		PromptSetGroup(PutAwayPrompt, PickaxePrompts)
		Citizen.InvokeNative(0xC5F428EE08FA7F2C,PutAwayPrompt,true)
		PromptRegisterEnd(PutAwayPrompt)
end


Citizen.CreateThread(function()
    SetupPickAxePrompt()

    for i, v in pairs(Config.Blip) do
        if v.enabled then
            MiningBlips[i] = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
            SetBlipSprite(MiningBlips[i], v.sprite, 1)
            SetBlipScale(MiningBlips[i], 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, MiningBlips[i], v.name)
        end
    end  

	while true do
		local t = 4
		if inHand == true and working == false then
            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Prompts.Title)
            PromptSetActiveGroupThisFrame(PickaxePrompts, label)
            if Citizen.InvokeNative(0xC92AC953F0A982AE,PutAwayPrompt) then
				DeletePickAxe()
            end
			if Citizen.InvokeNative(0xC92AC953F0A982AE,StartWorkPrompt) then
                if GetMount(PlayerPedId()) == 0 then
                    local atmine = AtMinePoint()
                    if atmine[1] == true then
                        UsePickAxe(atmine[2])
                    else
                        TriggerEvent("Notification:left_pa", Config.Texts.Pickaxe, Config.Texts.CantMine, TEXTURES.locked[1], TEXTURES.locked[2], 2000)
                    end
                end
            end
            if IsPedSwimming(PlayerPedId()) or IsPedClimbing(PlayerPedId()) or IsPedFalling(PlayerPedId()) or IsPedDeadOrDying(PlayerPedId()) then
                DeletePickAxe()
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        pcoords = GetEntityCoords(PlayerPedId())
    end
end)

Citizen.CreateThread(function()
    while true do
        local t = 5
        if pcoords ~= nil and inHand == true then
            for i,v in pairs(Config.MinePoints) do
                local dist = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, v.x, v.y, v.z,true)
                if dist < 10.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, v.x, v.y, v.z-0.89, 0, 0, 0, 0, 0, 0, Config.Checkpoints.size, Config.Checkpoints.size, Config.Checkpoints.height,Config.Checkpoints.rgba[1], Config.Checkpoints.rgba[2], Config.Checkpoints.rgba[3], Config.Checkpoints.rgba[4], 0, 0, 2, Config.Checkpoints.rotate, 0, 0, 0)
                end
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function()
    while true do
        local t = 5
        if inHand == true then
            DisableControlAction(0, 0xAC4BD4F1, true) -- TAB 
            DisableControlAction(0, 0x4CC0E2FE, true) -- B 
            DisableControlAction(0, 0xCEFD9220, true) -- Mount
            DisableControlAction(0, 0x8FFC75D6, true) -- Sprint
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

function CreatePickAxe()
    if inHand == false then
        inHand = true

        if axeProp ~= nil then
            DeleteObject(axeProp)
            SetEntityAsNoLongerNeeded(axeProp)
            axeProp = nil
        end

        local playerPed = PlayerPedId()
        local pc = GetEntityCoords(playerPed)

        local attach = nil
        if IsPedMale(playerPed) then
            attach = Config.Walk.Male
        else
            attach = Config.Walk.Female
        end

        local model = Config.PickaxeModel
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end

        axeProp = CreateObject(model, pc.x,pc.y,pc.z, true, true, true)
        SetModelAsNoLongerNeeded(model)

        AttachEntityToEntity(axeProp, playerPed, attach.BoneID, attach.PX, attach.PY, attach.PZ, attach.PRX, attach.PRY, attach.PRZ, false, false, true, false, 0, true, false, false)

        RequestAnimDict(Config.Anims.walk[1])
        while not HasAnimDictLoaded(Config.Anims.walk[1]) do
                Citizen.Wait(1)
        end
        TaskPlayAnim(playerPed, Config.Anims.walk[1], Config.Anims.walk[2], 8.0, -8.0, -1, Config.Anims.walk[3], 0, true, 0, false, 0, false)
    end
end

function DeletePickAxe()
    if axeProp ~= nil then
        DeleteObject(axeProp)
        SetEntityAsNoLongerNeeded(axeProp)
        axeProp = nil
        inHand = false
        ClearPedTasksImmediately(PlayerPedId())
    end
end

function AtMinePoint()
    local pc = GetEntityCoords(PlayerPedId())
    for i,v in pairs(Config.MinePoints) do
        local dist = GetDistanceBetweenCoords(pc.x,pc.y,pc.z,v.x,v.y,v.z,true)
        if dist < 1.3 then
            return {[1]=true,[2]=i}
        end
    end
    return {[1]=false,[2]=0}
end

function UsePickAxe(id)
    if working == false then
        working = true
        local playerPed = PlayerPedId()
        SetEntityHeading(playerPed, Config.MinePoints[id].h)
        local playerCo = GetEntityCoords(playerPed)
        DeletePickAxe()
        while axeProp ~= nil do
            Citizen.Wait(1)
        end

        ClearPedTasksImmediately(playerPed)

        local attach = nil
        if IsPedMale(playerPed) then
           attach = Config.Work.Male
        else
            attach = Config.Work.Female
        end

        local model = Config.PickaxeModel
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end
        axeProp = CreateObject(model, playerCo.x,playerCo.y,playerCo.z, true, true, true)
        SetModelAsNoLongerNeeded(model)

        AttachEntityToEntity(axeProp, playerPed, attach.BoneID, attach.PX, attach.PY, attach.PZ, attach.PRX, attach.PRY, attach.PRZ, false, false, true, false, 0, true, false, false)

        RequestAnimDict(Config.Anims.work[1])
        while (not HasAnimDictLoaded(Config.Anims.work[1])) do
                Citizen.Wait(1)
        end
        TaskPlayAnim(playerPed, Config.Anims.work[1], Config.Anims.work[2], 8.0, -8.0, -1, Config.Anims.work[3], 0, true, 0, false, 0, false) 

        local timer = Config.WorkDuration * 1000
        Citizen.Wait(timer)
        ClearPedTasksImmediately(PlayerPedId())
        DeletePickAxe()
        while axeProp ~= nil do
            Citizen.Wait(1)
        end
        working = false

        if not IsEntityDead(PlayerPedId()) then
            CreatePickAxe()
            TriggerServerEvent("Badlands_Mining:reward", id)
        end
    end
end

RegisterNetEvent('Badlands_Mining:usePickaxe')
AddEventHandler('Badlands_Mining:usePickaxe', function()
    local playerp = PlayerPedId()
    if not  IsEntityDead(playerp) and inHand == false then
        local hasw, playerw = GetCurrentPedWeapon(playerp, 1)
        if GetMount(playerp) == 0 and not IsPedSwimming(playerp) and not IsPedClimbing(playerp) and not IsPedFalling(playerp) and playerw == -1569615261 then
            CreatePickAxe()
        else
            TriggerEvent("Notification:left_pa", Config.Texts.Pickaxe, Config.Texts.CantUse, TEXTURES.locked[1], TEXTURES.locked[2], 2000)
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if axeProp then
        DeleteObject(axeProp)
        SetEntityAsNoLongerNeeded(axeProp)
        ClearPedTasksImmediately(PlayerPedId())
        inHand = false
        working = false
        axeProp = nil
    end
    for i,v in pairs(MiningBlips) do
        RemoveBlip(v)
    end
end)

--Basic Notification
RegisterNetEvent('Notification:left_pa')
AddEventHandler('Notification:left_pa', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(1)
        end
    end
    if txtr ~= nil then
        exports.Badlands_Mining.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.Badlands_Mining.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)