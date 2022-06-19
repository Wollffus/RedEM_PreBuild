local show = false 
local talking = false
local range = 8

function Update()
	SendNUIMessage({
		show = show,
		talking = talking,
		range = range
	})
end

RegisterNetEvent("darkk_show")
AddEventHandler("darkk_show", function(bool)
	show = bool
	SendNUIMessage({
		show = show,
		talking = talking,
		range = range
	})
end)

AddEventHandler('SaltyChat_TalkStateChanged', function(_talking) 
	talking = _talking
	Update()
end)

RegisterNetEvent("darkk_showrange")
AddEventHandler('darkk_showrange', function(_range)
	range = _range
	print(range)
	Update()
end)

Update()