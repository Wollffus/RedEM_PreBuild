data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)


RegisterServerEvent('poke_minero:comjob')
AddEventHandler('poke_minero:comjob', function()
        TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        TriggerClientEvent('poke_minero:comienzo', source)
        TriggerClientEvent("redemrp_notification:start", source, Language.translate[Config.lang]['gopos'], 5)
    end)
end)

RegisterServerEvent('poke_minero:cobrar')
AddEventHandler('poke_minero:cobrar', function(money, experiance)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        user.addMoney(money * 1.2)
        user.addXP(experiance)
		local ItemData = data.getItem(source, 'rock')
		local ItemData2 = data.getItem(source, 'metal_ore')
		local ItemData3 = data.getItem(source, 'copper_ore')
		ItemData.AddItem(6)
		ItemData2.AddItem(2)
		ItemData3.AddItem(2)
	end)
end)