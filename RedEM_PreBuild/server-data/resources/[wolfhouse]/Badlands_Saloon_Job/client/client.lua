-- globals --
local onDuty = false
local current_order ={}
local ClientObjects = {}

MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local elements = (Config.MenuItems)

RegisterNetEvent("Badlands_Saloon_Job:SpawnObject")
AddEventHandler("Badlands_Saloon_Job:SpawnObject", function(object)
    local player = PlayerPedId()
    local playerPos = GetEntityCoords(player)
    local objPos = GetOffsetFromEntityInWorldCoords(player,0.0,1.0,0.0)
    local Hash = GetHashKey(object)
    RequestModel(Hash)

    while not HasModelLoaded(Hash) do
        --print("Waiting for model "..Hash)
        Citizen.Wait(100)
    end
	RequestAnimDict("amb_work@world_human_bartender@serve_player")
    while not HasAnimDictLoaded("amb_work@world_human_bartender@serve_player") do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), "amb_work@world_human_bartender@serve_player", "take_glass_trans_serve_beer", 1.0, 8.0, -1, 1, 0, false, false, false)
    Wait(8000)
    ClearPedTasks(PlayerPedId())
    local obj = CreateObject(Hash,objPos.x,objPos.y,objPos.z,true,false,true)

    if object == "p_bowl04x_stew" then
        Citizen.InvokeNative(0x669655FFB29EF1A9, obj, 0, "Stew_Fill", 1.0)
    end
    PlaceObjectOnGroundProperly(obj,true)
    TriggerServerEvent("Badlands_Saloon_Job:ShareObj" , ObjToNet(obj))
end)

-- events --
RegisterNetEvent("Badlands_Saloon_Job:OpenMenu")
AddEventHandler("Badlands_Saloon_Job:OpenMenu", function()
    MenuSaloon()
end)
RegisterNetEvent("Badlands_Saloon_Job:getObj")
AddEventHandler("Badlands_Saloon_Job:getObj", function(netobjs)
    current_order = netobjs
    ClientObjects = {}
end)
-- threads --
local target = 1
local timer  = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local canwait = true
        if #current_order > 0 then
            for k , v in pairs(current_order) do
                local coords = GetEntityCoords(PlayerPedId())
                if ClientObjects[v] == nil then
                    if NetworkDoesNetworkIdExist(v)  then
                        ClientObjects[v] = NetToObj(v)
                    else
                        ClientObjects[v] = nil
                    end
                end
                local objCooords = GetEntityCoords(ClientObjects[v])
                if Vdist(coords , objCooords) < 10 then
                    canwait = false
                end
				if IsControlJustPressed(1,0xDEB34313) and timer < GetGameTimer() then
					GetNextClostesObject()
					timer = GetGameTimer() + 250
				end
                if (target == k or target == nil) then
                    if Vdist(coords , objCooords) < 1.2  then
                        target = k
                        Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, objCooords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.15, 0.15, 0.1, 227, 48, 48, 180, true, false, 1, true)
                        if IsControlJustPressed(1,(Config.PickupAction)) then
                            if NetworkDoesNetworkIdExist(v)  then
                                NetworkRequestControlOfNetworkId(v)
                                local test = 0
                                while not NetworkHasControlOfNetworkId(v) and test < 50 do Wait (10) test = test + 1 end
                                NetworkRequestControlOfEntity(ClientObjects[v])
                                test = 0
                                while not NetworkHasControlOfEntity(ClientObjects[v]) and test < 50 do Wait (10) test = test + 1 end
                                local item =  GetItemNameFromHash(GetEntityModel(ClientObjects[v]))
                                if ClientObjects[v] ~= nil then
                                    DeleteEntity(ClientObjects[v])
                                    TriggerServerEvent("Badlands_Saloon_Job:AddToInv",item)
                                    TriggerServerEvent("Badlands_Saloon_Job:DeleteObj" , v)
                                    table.remove(current_order , k)
                                end
                                target = nil
							end
							Wait(500)
                        end
                    else
                        target = nil
                    end
                end
            end
            if canwait then
                Wait(500)
            end
        else
            Wait(500)
        end
    end
end)

function GetNextClostesObject()
    if target ~= nil then
        local change = true
        local coords = GetEntityCoords(PlayerPedId())
        for k , v in pairs(current_order) do
            local objCooords = GetEntityCoords(ClientObjects[v])
            if Vdist(coords , objCooords) < 2 and k ~= target and k > target then
                change = false
				target = k
                break
            end
        end
        if change then
            target = nil
        end
    end
end

function MenuSaloon()
    MenuData.CloseAll()

    MenuData.Open(

        'default', GetCurrentResourceName(), 'saloon_menu',

        {

            title    = Config.Title,

            subtext    = Config.SubText,

            align    = 'top-left',

            elements = elements,

        },

        function(data, menu)
             TriggerServerEvent('Badlands_Saloon_Job:Serve' , data.current.value)

        end,

        function(data, menu)

            menu.close()

        end

    )

end

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if IsControlJustPressed(1,(Config.JobMenu)) then -- pressed U
			 TriggerServerEvent("Badlands_Saloon_Job:CheckJob")
			 Wait(1000)
        end
    end
end)