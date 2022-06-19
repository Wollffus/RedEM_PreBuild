data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

MySQL.ready(function()
    ---data.createLocker("V_Bank_Vault" , -304.95, 775.26 ,118.72,"unemployed") --saint denis
    data.createLocker("V_Sheriff" , 2509.89, -1304.68 ,48.93,"police") ---saint denis
    data.createLocker("V_Doctor" , 2730.32, -1231.81 ,50.35,"doctor") --saint denis
	data.createLocker("V_Saloon" , 2801.82, -1167.66 ,47.91,"bartender") --saint denis
	--data.createLocker("V_Indian" , 419.14, 2237.23 ,254.52,"indian") --wapity
	--data.createLocker("private" , 2696.55, -1186.55 ,56.12) --galery saint denis
end)



---PERSONAL LOCKERS--------

MySQL.ready(function()
    data.createLocker("Banks_storage_Val" , 304.95, 775.26 ,118.72, "Valentine") -- gunna house 1 locker
end)

MySQL.ready(function()
    data.createLocker("leelay_house_1" , -59.27, -391.86, 72.22, "leelay") -- leelay house 1 locker
end)

MySQL.ready(function()
    data.createLocker("stirling_bank_storage" , -308.92, 763.58, 118.7, "stirling") -- stirling bank locker
end)--]]