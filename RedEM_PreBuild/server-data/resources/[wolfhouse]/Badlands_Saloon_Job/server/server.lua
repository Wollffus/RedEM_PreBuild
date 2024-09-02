RedEM = exports["redem_roleplay"]:RedEM()

local version = 1.6

-- globals --
data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

local Objects = {}
local PriceTable = (Config.Prices)

-- events --
RegisterServerEvent("Badlands_Saloon_Job:AddToInv")
AddEventHandler("Badlands_Saloon_Job:AddToInv", function(type)
    local _source = source
    local ItemData = data.getItem(_source, type)
    ItemData.AddItem(1)
    TriggerClientEvent('gui:ReloadMenu', _source)
end)

RegisterServerEvent("Badlands_Saloon_Job:DeleteObj")
AddEventHandler("Badlands_Saloon_Job:DeleteObj", function(netid)
	for k , v in pairs(Objects) do
		if v == netid then
			table.remove(Objects , k)
			break
		end
	end
    TriggerClientEvent('Badlands_Saloon_Job:getObj', -1 , Objects)
end)

RegisterServerEvent("Badlands_Saloon_Job:ShareObj")
AddEventHandler("Badlands_Saloon_Job:ShareObj", function(netid)
	table.insert(Objects , netid)
    TriggerClientEvent('Badlands_Saloon_Job:getObj', -1 , Objects)
end)


RegisterServerEvent("Badlands_Saloon_Job:Serve")
AddEventHandler("Badlands_Saloon_Job:Serve", function(model)
    local _source = source
    local user = RedEM.GetPlayer(_source)
        local money = user.getMoney()
		if money >= PriceTable[model] then
			user.removeMoney(PriceTable[model])
			TriggerClientEvent("Badlands_Saloon_Job:SpawnObject", _source, model)
		else
            TriggerClientEvent("redemrp_notification:start",source, 'You dont have enough money $', 5)
		end
    end)

RegisterServerEvent("Badlands_Saloon_Job:CheckJob")
AddEventHandler("Badlands_Saloon_Job:CheckJob", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)

        if user.getJob() == (Config.JobTitle) then
            TriggerClientEvent("Badlands_Saloon_Job:OpenMenu",_source)
        end
    end)