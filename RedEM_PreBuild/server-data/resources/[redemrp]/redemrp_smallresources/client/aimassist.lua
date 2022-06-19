-- -- Disable controller aim assist -------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        SetPlayerTargetingMode(3) -- or Citizen Native : Citizen.InvokeNative(0xD66A941F401E7302, 3)
    end
end)