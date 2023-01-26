local version = 1.2

Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= "redemrp_smallresources" then
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2redemrp_smallresources^1")
		print("^1=====================================^0")
	end
end)
-----------------------------------------------------------------------------CREDITS--------------------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('^5 '..resourceName..'^2 Successfully Loaded ^7')
    print(version )
	print('^1 Developed by RedEM Contributors ^7')
	print('^1 If you require support join:^5 https://discord.gg/zGVDppYxfk ^7')
end)
--
