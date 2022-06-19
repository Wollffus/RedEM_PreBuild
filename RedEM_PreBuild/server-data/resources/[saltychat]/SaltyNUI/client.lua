local ismuted = false

--- SaltyNUI Events ---
RegisterNetEvent('SaltyNUI:TsNotActive')
AddEventHandler('SaltyNUI:TsNotActive', function() 
	SendNUIMessage({action = "toggleWindow", value = "true"})
	ismuted = true
end)
RegisterNetEvent('SaltyNUI:TsActive')
AddEventHandler('SaltyNUI:TsActive', function() 
	SendNUIMessage({action = "toggleWindow", value = "false"})
	ismuted = false
end)


-- SaltyChat Events --- 
AddEventHandler('SaltyChat_SoundStateChanged', function(muted) 
	if (muted) then
		SendNUIMessage({action = "toggleWindow", value = "true"})
		ismuted = true
	else
		ismuted = false
		SendNUIMessage({action = "toggleWindow", value = "false"})
	end
end)

--- Disable Movement if muted ---
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local playerPed = PlayerPedId()

		if ismuted then
			DisableAllControlActions(0)
		else
			Citizen.Wait(500)			
		end
	end
end)
