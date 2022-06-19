local version = 1.0

local label =
[[
    _____                  _ _   _____
   / ____|                | | | |  __ \
   | (___  _ __ ___   __ _| | | | |__) |___  ___  ___  _   _ _ __ ___ ___  ___
    \___ \| '_ ` _ \ / _` | | | |  _  // _ \/ __|/ _ \| | | | '__/ __/ _ \/ __|
    ____) | | | | | | (_| | | | | | \ \  __/\__ \ (_) | |_| | | | (_|  __/\__ \
   |_____/|_| |_| |_|\__,_|_|_| |_|  \_\___||___/\___/ \__,_|_|  \___\___||___/
]]
print( label,version )

Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= "redemrp_smallresources" then
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2redemrp_smallresources^1")
		print("^1=====================================^0")
	end
end)
--
--
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('^6 '..resourceName..'^2 Successfully Loaded ^7')
	print('^1 Developed by RedEM Contributors ^7')
	print('^7 If you require support join:^5 https://discord.gg/zGVDppYxfk ^7')
end)
--
