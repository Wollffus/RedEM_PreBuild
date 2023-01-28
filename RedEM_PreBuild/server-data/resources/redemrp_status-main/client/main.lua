RedEM = exports["redem_roleplay"]:RedEM()

local IsDrunk = false
local DrunkTime = nil
local DrunkEffects = false
local cooldown = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if IsDrunk and not DrunkEffects then
            DoScreenFadeOut(500)
            Citizen.Wait(500)
            local walkingStyle = { "default", "very_drunk" }
			Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), walkingStyle[1])
			Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), walkingStyle[2])
            AnimpostfxPlay("PlayerDrunk01")
            --Citizen.InvokeNative(0xCAB4DD2D5B2B7246, 0.5) -- AnimPostfxSetStrength
            DrunkEffects = true
            Citizen.Wait(100)
            DoScreenFadeIn(500)
        end
        if IsDrunk and DrunkEffects and DrunkTime then
            if GetGameTimer() - DrunkTime > 120000 then
                DoScreenFadeOut(500)
                Citizen.Wait(500)
                local walkingStyle = { "default", "normal" }
                Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), walkingStyle[1])
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), walkingStyle[2])
                AnimpostfxStop("PlayerDrunk01")
                IsDrunk = false
                DrunkEffects = false
                DrunkTime = nil
                Citizen.Wait(100)
                DoScreenFadeIn(500)
            end
        end
    end
end)

RegisterNetEvent("redemrp_status:client:PlayConsumableSound", function()
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
end)


Citizen.CreateThread(function()
    while true do
        Wait(10)
        if GetCurrentTemperature() < 0 then
            RedEM.Functions.NotifyRight("You feel cold...", 3000)
            Wait(300000)
        elseif GetCurrentTemperature() > 28 then
            RedEM.Functions.NotifyRight("You feel hot...", 3000)
            Wait(300000)
        else
        end
    end
end)

local active = false
Citizen.CreateThread(function()
    while true do
        Wait(3000)
        SendNUIMessage({
            showhud = true
        })
    end
end)

function HealSelf()
    local amount = 30
    local ped = PlayerPedId()
    if GetAttributeCoreValue(ped, 0) + amount <= 100 then
        local addhp = GetAttributeCoreValue(ped, 0) + amount
        Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, addhp)
    else
        Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, 100)
    end
end

RegisterNetEvent('redemrp_status:UpdateStatus', function(thrist, hunger)
    Wait(1000)
    local shownotifiaction1 = false
    local shownotifiaction2 = false
    if hunger <= 10 and not shownotifiaction2 then
        shownotifiaction1 = true
        RedEM.Functions.NotifyLeft("Hungry", "You are starving! Eat something right away.", "menu_textures", "menu_icon_alert", 4000)
    end

    if thrist <= 10 and not shownotifiaction1 then
        shownotifiaction2 = true
        RedEM.Functions.NotifyLeft("Thirsty", "You are thirsty! Drink something right away.", "menu_textures", "menu_icon_alert", 4000)
    end
    shownotifiaction2 = not shownotifiaction2
    shownotifiaction1 = not shownotifiaction1
    if thrist <= 1 or hunger <= 1 then
        local health = GetEntityHealth(PlayerPedId())
        local remove = health - 25
        if remove < 0 then
            remove = 0
            Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
        end
        SetEntityHealth(PlayerPedId(), remove)
    end
    SendNUIMessage({
        thrist = thrist,
        hunger = hunger,
        temp = GetCurrentTemperature()
    })
end)

local Winter = false
local inInterior = false

exports('SetInInterior', function(isInInterior)
    inInterior = isInInterior
end)

function GetCurrentTemperature()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    ShouldUseMetricTemperature()
    temp = round(GetTemperatureAtCoords(coords.x, coords.y, coords.z), 1)
    if not Winter or inInterior then return temp end
    if Winter then
        if temp > 1 then
            if GetClockHours() > 15 then
                temp = -2
            elseif GetClockHours() > 16 then
                temp = -4
            elseif GetClockHours() > 18 then
                temp = -5
            elseif GetClockHours() > 19 then
                temp = -7
            elseif GetClockHours() < 15 then
                temp = -1
            elseif GetClockHours() < 14 then
                temp = 0
            elseif GetClockHours() < 13 then
                temp = 1
            end
        end
        return temp
    end
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function Coffee()
    local object = CreateObject(GetHashKey("P_MUGCOFFEE01X"), GetEntityCoords(PlayerPedId()), true, false, false, false, true)
    Citizen.InvokeNative(0x669655FFB29EF1A9, object, 0, "CTRL_cupFill", 1.0)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), object, GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1082130432)
end

function Champagne()
    TriggerEvent("redemrp_inventory:closeinv")
    local propEntity = CreateObject(GetHashKey('P_GLASS001X'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local amount = 0
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_WHISKEY"), propEntity, GetHashKey('P_GLASS001X_PH_R_HAND'), GetHashKey("DRINK_CHAMPAGNE_HOLD"), 1, 0, -1082130432)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 642357238 then
            amount = amount + 1
            if amount >= 7 then
                DrunkTime = GetGameTimer()
                IsDrunk = true
                break
            end
        elseif Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == false then
            break
        else
            amount = 0
        end
    end
end

function Drink()
    local dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a"
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local prop = GetHashKey("P_BOTTLE008X")
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    RequestModel(prop)
    while not HasModelLoaded(prop) do
        Wait(10)
    end
    local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.05, -0.07, -0.05, -75.0, 60.0, 0.0, true, true, false, true,  1, true)
    TaskPlayAnim(PlayerPedId(), dict, "idle_a", 1.0, 8.0, -1, 31, 0, false, false, false)
    Citizen.Wait(4000)
    ClearPedTasks(PlayerPedId())
    DeleteObject(tempObj2)
    SetModelAsNoLongerNeeded(prop)
end

function Eat()
    local dict = "mech_inventory@eating@multi_bite@sphere_d8-2_sandwich"
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local prop = GetHashKey("P_BREAD05X")
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    RequestModel(prop)
    while not HasModelLoaded(prop) do
        Wait(10)
    end
    local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.1, -0.01, -0.07, -90.0, 100.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), dict, "quick_right_hand", 1.0, 8.0, -1, 31, 0, false, false, false)
    Citizen.Wait(2000)
    ClearPedTasks(PlayerPedId())
    DeleteObject(tempObj2)
    SetModelAsNoLongerNeeded(prop)
end

function Beer()
    TriggerEvent("redemrp_inventory:closeinv")
    local propEntity = CreateObject(GetHashKey('p_bottleBeer01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local amount = 0
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_SALOON_BEER"), propEntity,GetHashKey('p_bottleBeer01x_PH_R_HAND'), 1587785400, 1, 0, -1082130432)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1183277175 then
            amount = amount + 1
            if amount >= 11 then
                DrunkTime = GetGameTimer()
                IsDrunk = true
                break
            end
        elseif Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == false then
            break
        else
            amount = 0
        end
    end
end

function Whisky()
    TriggerEvent("redemrp_inventory:closeinv")
    local propEntity = CreateObject(GetHashKey('p_bottleJD01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local amount = 0
    TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleJD01x_ph_r_hand'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_CHUG_TRANS'), 1, 0, -1.0)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1204708816 then
            amount = amount + 1
            if amount >= 6 then
                DrunkTime = GetGameTimer()
                IsDrunk = true
                break
            end
        elseif Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == false then
            break
        else
            amount = 0
        end
    end
end

function Bandage()
    local playerPed = PlayerPedId()
    if cooldown == 0 and not usingb then
        usingb = true
        TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
        exports['progressBars']:startUI(10000, 'Bandaging...')
        Wait(10000)
        cooldown = 3000
        startCooldown()
        if GetAttributeCoreValue(playerPed, 0) + 30 <= 100 then
        local addhp = GetAttributeCoreValue(playerPed, 0) + 30
            Citizen.InvokeNative( 0xC6258F41D86676E0 ,playerPed, 0 ,addhp )
		else
            Citizen.InvokeNative( 0xC6258F41D86676E0 , playerPed, 0 ,100)
        end		
        usingb = false
    else
		Wait(1000)
        TriggerEvent("redemrp_notification:start", "You have to wait: " .. cooldown/100 .. "seconds before applying another bandage!", 2, "error")
		 -- TriggerEvent("redemrp_notification:start", "You have to wait: " .. cooldown/100 .. "seconds before applying another bandage!", 2, "error")
    end
end

function BoostStamina(amount)
    if GetAttributeCoreValue(PlayerPedId(), 1) + amount <= 100 then
        local addstamina = GetAttributeCoreValue(PlayerPedId(), 1) + amount
        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, addstamina)
    else
        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, 100)
    end
end

Citizen.CreateThread(function()
    for name, info in pairs(Config.Items) do
        RegisterNetEvent('redemrp_status:Action-' .. name)
        AddEventHandler('redemrp_status:Action-' .. name, function()
            info.ClientAction()
        end)
    end
end)

RegisterNetEvent('redemrp_status:StartBandage', function(name)
    local playerPed = PlayerPedId()
    if cooldown == 0 and not usingb then
        usingb = true
        TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
        exports['progressBars']:startUI(10000, 'Bandaging...')
        Wait(10000)
        cooldown = 3000
        startCooldown()
        if GetAttributeCoreValue(playerPed, 0) + 30 <= 100 then
		    local addhp = GetAttributeCoreValue(playerPed, 0) + 30
			Citizen.InvokeNative( 0xC6258F41D86676E0, playerPed, 0, addhp )
		else
			Citizen.InvokeNative( 0xC6258F41D86676E0, playerPed, 0, 100)
        end		
        usingb = false
    else
		Wait(1000)
        TriggerEvent("redemrp_notification:start", "You have to wait: " .. cooldown/100 .. "seconds before applying another bandage!", 2, "error")
    end
end)

function startCooldown()
    Citizen.CreateThread(function()
        while cooldown > 0 do
            Wait(0)
            cooldown = cooldown - 1
        end
    end)
end