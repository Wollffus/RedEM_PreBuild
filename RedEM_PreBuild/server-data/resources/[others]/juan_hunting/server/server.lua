data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("hunting:add")
AddEventHandler("hunting:add", function(item)
		local _item = item
		local _source = source
		local randomitem =  math.random(1,3)
		local ItemData = data.getItem(_source, _item)
		ItemData.AddItem(randomitem)
end)
function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
RegisterServerEvent("hunting:xp")
AddEventHandler("hunting:xp", function(item)
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		local emberandrex = math.random(15,60)
		user.addXP(emberandrex)
	end)
end)

RegisterServerEvent("hunting:money")
AddEventHandler("hunting:money", function(item , rzeznik)
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		   	local price = item
			user.addMoney(round(price,2 ))
	end)
end)

RegisterServerEvent("hunting:deleteobj")
AddEventHandler("hunting:deleteobj", function()
local _source = source
TriggerClientEvent('hunting:DeleteClient', -1 , _source)
end)
