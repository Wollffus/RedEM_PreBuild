local draw = false
RegisterNUICallback('blocker', function(connected, cb)
	local connectedtots = connected
	if connectedtots == false then
		local ped = PlayerPedId()
		draw = true
		FreezeEntityPosition(ped, true)
	elseif connectedtots == true then
		local ped = PlayerPedId()
		draw = false
		FreezeEntityPosition(ped, false)
	end
	Citizen.CreateThread(function()
		while draw do
			Citizen.Wait(0)
			DrawTxt("Salty Chat:", 0.5, 0.1, 0.02, 0.4, true, 255, 255, 255, 255, true)
			DrawTxt("Download the plugin: https://www.saltmine.de/", 0.5, 0.2, 0.02, 0.4, true, 255, 255, 255, 255, true)
			DrawTxt("The plugin will do everything for you and setup itself once you run it.", 0.5, 0.3, 0.02, 0.4, true, 255, 255, 255, 255, true)
			DrawTxt("If your TeamSpeak was already open you will need to close it before you install saltychat.", 0.5, 0.4, 0.02, 0.4, true, 255, 255, 255, 255, true)
			DrawTxt("If you get a API error (or any other problem) try reinstall teamspeak or update it.", 0.5, 0.5, 0.02, 0.4, true, 255, 255, 255, 255, true)
			DrawTxt("TS SERVER IP: 147.135.9.170", 0.5, 0.6, 0.02, 0.4, true, 255, 255, 255, 255, true)
			DrawTxt("Discord: https://discord.gg/pQnx33n", 0.5, 0.7, 0.02, 0.4, true, 255, 255, 255, 255, true)
		end
	end)
end)
Citizen.CreateThread( function()
  while true do
    Wait(10)
	SetPlayerTalkingOverride(PlayerId(), false)
  end
end)
--=============================================================-- DRAW TEXT SECTION--=============================================================--
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end