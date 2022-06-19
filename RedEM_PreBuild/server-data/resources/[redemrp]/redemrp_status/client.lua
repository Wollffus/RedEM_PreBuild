Citizen.CreateThread(function()
    while true do
        Wait(10)
        if GetCurrentTemperature() < 0 then
            TriggerEvent("redem_roleplay:Tip", "You're getting cold..", 3000)
            Wait(300000)
        elseif GetCurrentTemperature() > 28 then
            TriggerEvent("redem_roleplay:Tip", "You're getting hot..", 3000)
            Wait(300000)
        else
        end
    end
end)

local active = false
Citizen.CreateThread(function()
    while true do
        Wait(150)
        if active == false then
            if IsPedRunning(PlayerPedId()) then
                active = true
                SendNUIMessage({
                    showhud = true
                })
            end
        end
        if active == false then
            if IsPedSprinting(PlayerPedId()) then
                active = true
                SendNUIMessage({
                    showhud = true
                })
            end
        end
        if active == true then
            if IsPedStopped(PlayerPedId()) then
                active = false
                SendNUIMessage({
                    showhud = false
                })
            end
        end
    end
end)

RegisterNetEvent('redemrp_status:UpdateStatus')
AddEventHandler('redemrp_status:UpdateStatus', function(thrist, hunger)
    Wait(1000)
    local shownotifiaction1 = false
    local shownotifiaction2 = false
    if hunger <= 10 and not shownotifiaction2 then
        shownotifiaction1 = true
        TriggerEvent("redem_roleplay:Tip", "You hear your belly rumbling!", 3000)
    end

    if thrist <= 10 and not shownotifiaction1 then
        shownotifiaction2 = true
        TriggerEvent("redem_roleplay:Tip", "You feel dry in your mouth!", 3000)
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
        Citizen.CreateThread(function()
            SendNUIMessage({
                showhud = true
            })
            Citizen.Wait(4000)
            SendNUIMessage({
                showhud = false
            })
        end)
    end
    SendNUIMessage({
        thrist = thrist,
        hunger = hunger,
        temp = GetCurrentTemperature()
    })
end)

function GetCurrentTemperature()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    ShouldUseMetricTemperature()
    return round(GetTemperatureAtCoords(coords.x, coords.y, coords.z), 1)
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function Coffe()
    local object = CreateObject(GetHashKey("P_MUGCOFFEE01X"), GetEntityCoords(PlayerPedId()), true, false, false, false, true)
    Citizen.InvokeNative(0x669655FFB29EF1A9, object, 0, "CTRL_cupFill", 1.0)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), object, GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1082130432)
end

function Shampan()
    TriggerEvent("redemrp_inventory:closeinv")
    local propEntity = CreateObject(GetHashKey('P_GLASS001X'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local amount = 0
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_WHISKEY"), propEntity, GetHashKey('P_GLASS001X_PH_R_HAND'), GetHashKey("DRINK_CHAMPAGNE_HOLD"), 1, 0, -1082130432)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 642357238 then
            amount = amount + 1
            if amount >= 7 then
                ------ DRUNK EFFECT
                ClearPedTasks(PlayerPedId())
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
                ------ DRUNK EFFECT
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
            if amount >= 11 then
                ------ DRUNK EFFECT
                break
            end
        elseif Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == false then
            break
        else
            amount = 0
        end
    end
end

function Wine()
    TriggerEvent("redemrp_inventory:closeinv")
    local propEntity = CreateObject(GetHashKey('P_BOTTLEJD01X'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local amount = 0
    TaskItemInteraction_2(PlayerPedId(), -1679900928, propEntity, GetHashKey('P_BOTTLEJD01X_PH_R_HAND'), -68870885, 1,  0, -1082130432)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1204708816 then
            amount = amount + 1
            if amount >= 11 then
                ------ DRUNK EFFECT
                break
            end
        elseif Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == false then
            break
        else
            amount = 0
        end
    end
end
function Stew()
    TriggerEvent("redemrp_inventory:closeinv")
    local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)
    TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
    TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
    Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
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
            SendNUIMessage({
                showhud = true
            })
            info.ClientAction()
            SendNUIMessage({
                showhud = false
            })
        end)
    end
end)
