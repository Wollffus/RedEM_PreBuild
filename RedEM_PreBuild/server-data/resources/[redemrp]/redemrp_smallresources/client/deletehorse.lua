-- -- Delete Horse -------------------------------------------------------------------------
RegisterCommand("dv", function()
    local playerPed = PlayerPedId()
    local vehicle   = GetVehiclePedIsIn(playerPed, false)

    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    end

    if DoesEntityExist(vehicle) then
        DeleteVehicle(vehicle)
    end
  end)

  RegisterCommand("dh", function()
    local playerPed = PlayerPedId()
    local mount   = GetMount(PlayerPedId())

    if IsPedOnMount(playerPed) then
        DeleteEntity(mount)
    end

  end)

  Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local vehicle   = GetVehiclePedIsIn(playerPed, false)

        if vehicle == 0 then
            Citizen.Wait(3000)
        else
            if IsPedInAnyVehicle(playerPed, true) then
                vehicle = GetVehiclePedIsIn(playerPed, false)
            end
            SetVehicleDoorsShut(vehicle, true)
            Citizen.Wait(50)
        end
    end
  end)