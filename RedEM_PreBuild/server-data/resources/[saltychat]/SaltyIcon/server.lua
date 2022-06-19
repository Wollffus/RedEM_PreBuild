RegisterServerEvent("SaltyChat_SetVoiceRange")
AddEventHandler('SaltyChat_SetVoiceRange', function(_range) 
	TriggerClientEvent('darkk_showrange', source, _range)
end)