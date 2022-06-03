
local test_xd = false

function Sell(current_shop)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
    local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    local model = GetEntityModel(holding)
    local pedtype = GetPedType(holding)
    ----print(quality, model, pedtype)
    if holding ~= false then
        for i, row in pairs(Animal) do
            if model == Animal[i]["model"] then
                entity = holding
                Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, true)
                local endpiece = shops[current_shop]["gain"] * Animal[i]["reward"]
                Wait(500)
                SetEntityAsMissionEntity(entity, true, true)
                Wait(500)
                DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityCoords(entity, -3782.62, -4334.62, 3.2)
                Wait(500)
                DeleteEntity(entity)
                Wait(300)
                if not DoesEntityExist(entity) or GetDistanceBetweenCoords(GetEntityCoords(entity) , GetEntityCoords(ped)) > 10 then
                    TriggerServerEvent("hunting:add", Animal[i]["item"])
                    TriggerServerEvent("hunting:money", endpiece, current_shop)
                    TriggerServerEvent("hunting:xp", endpiece)
                    TriggerEvent("redemrp_notification:start", "You sold "..Animal[i]["name"], 2, "success")
                end
                Wait(500)
                if holding == 0 then
                    --print("sold carcass")
                else
                    --print("Something went wrong")
                end

                break
            elseif quality == Animal[i]["poor"] then
                entity = holding
                Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, true)
                local endpiece = shops[current_shop]["gain"] * Animal[i]["reward"]
                --DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityAsMissionEntity(entity, true, true)
                Wait(500)
                DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityCoords(entity, -3782.62, -4334.62, 3.2)
                Wait(500)
                DeleteEntity(entity)
                Wait(300)
                if not DoesEntityExist(entity) or GetDistanceBetweenCoords(GetEntityCoords(entity) , GetEntityCoords(ped)) > 10 then
                    TriggerServerEvent("hunting:money", endpiece, current_shop)
                    TriggerServerEvent("hunting:xp", endpiece)
                    TriggerEvent("redemrp_notification:start", "You sold the leather "..Animal[i]["name"].." low quality", 2, "success")
                end
                Wait(500)
                if holding == 0 then
                    --print("sold Hide")
                else
                    --print("Something went wrong")
                end
                break
            elseif quality == Animal[i]["good"] then

                entity = holding
                Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, true)
                local endpiece = shops[current_shop]["gain"] * Animal[i]["reward"] * 1.15
                --DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityAsMissionEntity(entity, true, true)
                Wait(500)
                DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityCoords(entity, -3782.62, -4334.62, 3.2)
                Wait(500)
                DeleteEntity(entity)
                Wait(300)
                if not DoesEntityExist(entity) or GetDistanceBetweenCoords(GetEntityCoords(entity) , GetEntityCoords(ped)) > 10 then
                    TriggerServerEvent("hunting:money", endpiece, current_shop)
                    TriggerServerEvent("hunting:xp", endpiece)
                    TriggerEvent("redemrp_notification:start", "You sold the leather "..Animal[i]["name"].." good quality", 2, "success")
                end
                Wait(500)
                if holding == 0 then
                    --print("sold Hide")
                else
                    --print("Something went wrong")
                end
                break
            elseif quality == Animal[i]["perfect"] then

                entity = holding
                Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, true)
                local endpiece = shops[current_shop]["gain"] * Animal[i]["reward"] * 1.25
                --DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityAsMissionEntity(entity, true, true)
                Wait(500)
                DetachEntity(entity, 1, 1)
                Wait(500)
                SetEntityCoords(entity, -3782.62, -4334.62, 3.2)
                Wait(500)
                DeleteEntity(entity)
                Wait(300)
                if not DoesEntityExist(entity) or GetDistanceBetweenCoords(GetEntityCoords(entity) , GetEntityCoords(ped)) > 10 then
                    TriggerServerEvent("hunting:money", endpiece, current_shop)
                    TriggerServerEvent("hunting:xp", endpiece)
                    TriggerEvent("redemrp_notification:start", "You sold the leather "..Animal[i]["name"].." perfect quality", 2, "success")
                end
                Wait(500)
                if holding == 0 then
                    --print("sold Hide")
                else
                    --print("Something went wrong")
                end
                break
            end
        end
    elseif holding == false then
        -------------------
        Wait(500)
    end
end


Citizen.CreateThread(function()
    Wait(500)


    for a = 1, #shops do

        local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
        local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, shopV)
        SetBlipSprite(blip, 1369919445)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Butcher")


    end

end)
math.randomseed(GetGameTimer())
local sellPrompt
local ButcherGroup = GetRandomIntInRange(0, 0xffffff)
--print('BlueBerrygroup: ' .. ButcherGroup)

function ButcherSell()
    Citizen.CreateThread(function()
        local str = 'Sell'
        local wait = 0
        sellPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(sellPrompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(sellPrompt, str)
        PromptSetEnabled(sellPrompt, true)
        PromptSetVisible(sellPrompt, true)
        PromptSetHoldMode(sellPrompt, true)
        PromptSetGroup(sellPrompt, ButcherGroup)
        PromptRegisterEnd(sellPrompt)
    end)
end


local trigger = 1
Citizen.CreateThread(function()
    Wait(500)
    ButcherSell()
    while true do
        Wait(1)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for a = 1, #shops do
            local myV = vector3(coords)
            local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
            local dst = Vdist(shopV, myV)
            if dst < 2  then
                if test_xd == false then
                    local ButcherGroupName  = CreateVarString(10, 'LITERAL_STRING', "Butcher")
                    PromptSetActiveGroupThisFrame(ButcherGroup, ButcherGroupName)
                    if PromptHasHoldModeCompleted(sellPrompt) then
                        test_xd = true
                        trigger = a
                        Sell(a)
                        --print("sell")
                    end
                end
            else
                if trigger == a then
                    test_xd = false
                end
            end
        end
    end
end)

function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

    local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)

    SetTextCentre(centre)

    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end

    Citizen.InvokeNative(0xADA9255D, 10);

    DisplayText(str, x, y)

end


Citizen.CreateThread(function()
    while true do
        Wait(10000)
        local player = PlayerPedId()
        local excludeEntity = player
        local shapeTest = StartShapeTestBox(-1067.55, -1734.73,72.75, 100.0, 100.0, 10.0, 0.0, 0.0, 0.0, true, 8, excludeEntity)
        local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
        excludeEntity = entityHit
        local model_hash = GetEntityModel(entityHit)
        ----print("pumy nie bylo")
        if model_hash == 90264823 then
            --print("usuwam pume")
            DeleteEntity(entityHit)
            if DoesEntityExist(entityHit) then
                DeletePed(entityHit)

            end


        end
    end

end)

