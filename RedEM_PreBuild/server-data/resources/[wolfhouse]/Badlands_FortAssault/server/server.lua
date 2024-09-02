RedEM = exports["redem_roleplay"]:RedEM()

local data = {}

TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterNetEvent("Badlands_FortAssault:startToRob")
AddEventHandler("Badlands_FortAssault:startToRob", function()
    local _source = source
	local ItemData = data.getItem(_source, (Config.ItemChoice))

        if ItemData.ItemAmount >= 1 then
            local Player = RedEM.GetPlayer(_source)
            TriggerClientEvent('Badlands_FortAssault:startTimer', _source)
            TriggerClientEvent('Badlands_FortAssault:startAnimation', _source)
    else
        TriggerClientEvent("redemrp_notification:start",source, (Config.NeedMessage), 5)
    end
end)

RegisterNetEvent("Badlands_FortAssault:payout")
AddEventHandler("Badlands_FortAssault:payout", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
        local _user = user
        TriggerClientEvent("redemrp_notification:start", _source, (Config.FinishMessage), 5)
        local wollffus = math.random(4,8)
        local jessica = math.random(10,30)
            local ItemData = data.getItem(_source, (Config.RewardItem))
            ItemData.AddItem(wollffus)
            local ItemData = data.getItem(_source, (Config.RewardItem2))
            ItemData.AddItem(wollffus)
            local ItemData = data.getItem(_source, (Config.RewardItem3))
            ItemData.AddItem(jessica)
            local ItemData = data.getItem(_source, (Config.RewardItem4))
            ItemData.AddItem(wollffus)
            local ItemData = data.getItem(_source, (Config.RewardItem5))
            ItemData.AddItem(wollffus)
        user.addMoney(Config.RewardMoney)
end)

Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= "Badlands_FortAssault" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2Badlands_FortAssault^1")
		print("^1=====================================^0")
	end
end)
-----------------------------------------------------------------------------CREDITS--------------------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('^5 '..resourceName..'^2 Successfully Loaded ^7')
	print('^3 WolfHouse Studios Dev Team ^7')
end)
--