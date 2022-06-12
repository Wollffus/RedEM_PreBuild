if Trigger.STAMINA then
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, 5000.0) --outer bar gold  stam
        end
    end)
end
