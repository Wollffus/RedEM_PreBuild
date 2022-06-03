local money = math.random(Config.money['min'], Config.money['max'])
local experiance = math.random(Config.experiance['min'], Config.experiance['max'])
local PrimeraMina = false
local Mina1 = false
local Mina2 = false
local Mina3 = false
local Mina4 = false
local FinMina = false
local Entrega = false
local EntregaFinal = false

Citizen.CreateThread(function()
	Wait(0)
		local blip = N_0x554d9d53f696d002(1664425300, Config.Zones['init'].x, Config.Zones['init'].y, Config.Zones['init'].z)
		SetBlipSprite(blip, 3535996525, 1)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Mining")
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        if (Vdist(pos.x, pos.y, pos.z, Config.Zones['init'].x, Config.Zones['init'].y, Config.Zones['init'].z) < 3.0) then
            if Mina1 == false then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent('poke_minero:comjob')
                end
            end
        end
        if PrimeraMina == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner1'].x, Config.Zones['Miner1'].y, Config.Zones['Miner1'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
					RemoveBlip(blip)
					blip2 = N_0x554d9d53f696d002(203020899, Config.Zones['Miner2'].x, Config.Zones['Miner2'].y, Config.Zones['Miner2'].z)
                    SetBlipSprite(blip2, -570710357, 1)
					PrimeraMina = false
                    Mina2 = true
                end
            end
        elseif Mina2 == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner2'].x, Config.Zones['Miner2'].y, Config.Zones['Miner2'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
                    RemoveBlip(blip2)
                    blip3 = N_0x554d9d53f696d002(203020899, Config.Zones['Miner3'].x, Config.Zones['Miner3'].y, Config.Zones['Miner3'].z)
                    SetBlipSprite(blip3, -570710357, 1)
                    Mina2 = false
                    Mina3 = true
                end
            end
        elseif Mina3 == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner3'].x, Config.Zones['Miner3'].y, Config.Zones['Miner3'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
                    RemoveBlip(blip3)
                    blip4 = N_0x554d9d53f696d002(203020899, Config.Zones['Miner4'].x, Config.Zones['Miner4'].y, Config.Zones['Miner4'].z)
                    SetBlipSprite(blip4, -570710357, 1)
                    Mina3 = false
                    Mina4 = true
                end
            end
        elseif Mina4 == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zones['Miner4'].x, Config.Zones['Miner4'].y, Config.Zones['Miner4'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['load'], 5)
                    RemoveBlip(blip4)
                    blip5 = N_0x554d9d53f696d002(203020899, Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z)
                    SetBlipSprite(blip5, -570710357, 1)
                    TriggerEvent('poke_minero:rutafinal')
                    Mina4 = false
                    FinMina = true
                end
            end
        elseif FinMina == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z) < 3.0) then
                DrawTxt(Language.translate[Config.lang]['pressc'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion2()
                    TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['carry'], 5)
                    RemoveBlip(blip5)
                    blip6 = N_0x554d9d53f696d002(203020899, Config.Zones['Entrega'].x, Config.Zones['Entrega'].y, Config.Zones['Entrega'].z)
                    SetBlipSprite(blip6, -570710357, 1)
                    FinMina = false
                    Entrega = true
                    TriggerEvent('poke_minero:comcrono')
                end
            end
        elseif Entrega == true then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zones['Entrega'].x, Config.Zones['Entrega'].y, Config.Zones['Entrega'].z) < 5.0) then
                DrawTxt(Language.translate[Config.lang]['pressf'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['completejob'] ..money.."$ | "..experiance.."XP", 5)
						RemoveBlip(blip6)
						TriggerServerEvent('poke_minero:cobrar', money, experiance)
                        Entrega = false
                        Mina1 = false
                    else
                        TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['noveh'], 5)
                    end
                end
            end
        end
    end
end)
function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end
RegisterNetEvent('poke_minero:rutafinal')
AddEventHandler('poke_minero:rutafinal', function()
	Citizen.Wait(0)

	local jugador = PlayerPedId()
	local Cart = GetHashKey(Config.Cart)
	RequestModel(Cart)

	 while not HasModelLoaded( Cart ) do
        Wait(500)
        modelrequest( Cart )
    end

	spawncar = CreateVehicle(Cart, Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z, Config.Zones['Vehicle'].heading, true, false)
	SetVehicleOnGroundProperly(spawncar)
	SetModelAsNoLongerNeeded(Cart)
end)

RegisterNetEvent('poke_minero:comienzo')
AddEventHandler('poke_minero:comienzo', function(source)
    blip = N_0x554d9d53f696d002(203020899, Config.Zones['Miner1'].x, Config.Zones['Miner1'].y, Config.Zones['Miner1'].z)
    SetBlipSprite(blip, -570710357, 1)
    PrimeraMina = true
    Mina1 = true
end)

RegisterNetEvent('poke_minero:comcrono')
AddEventHandler('poke_minero:comcrono', function()
	local timer = 600

	Citizen.CreateThread(function()
		while timer > 0 and Entrega do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while Entrega do
			Citizen.Wait(0)
			DrawTxt(Language.translate[Config.lang]['temp']..timer..Language.translate[Config.lang]['seconds'], 0.4, 0.92, 0.4, 0.4, true, 255, 255, 255, 150, false)
            if timer < 1 then
                TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['lose'], 5)
				Mina1, Mina2, Mina3, Mina4, FinMina, Entrega, PrimeraMina = false, false, false, false, false, false, false
				DeleteVehicle(spawncar)
				RemoveBlip(blip6)
                SetEntityCoords(PlayerPedId(), Config.Zones['Vehicle'].x, Config.Zones['Vehicle'].y, Config.Zones['Vehicle'].z)
			end
		end
	end)
end)

function animacion()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 20000, true, false, false, false)
    exports['progressBars']:startUI(20000, Language.translate[Config.lang]['mining'])
    Wait(20000)
    ClearPedTasksImmediately(PlayerPedId())
end

function animacion2()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false)
    exports['progressBars']:startUI(7000, Language.translate[Config.lang]['placing'])
    Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end