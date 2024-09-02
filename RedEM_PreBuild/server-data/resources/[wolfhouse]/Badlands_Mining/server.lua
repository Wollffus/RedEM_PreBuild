local version = 1.1


data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

local TEXTURES = Config.Textures

RegisterServerEvent("RegisterUsableItem:pickaxe")
AddEventHandler("RegisterUsableItem:pickaxe", function(source)
    TriggerClientEvent('Badlands_Mining:usePickaxe', source)
end)

RegisterServerEvent("Badlands_Mining:reward")
AddEventHandler("Badlands_Mining:reward", function(id)
	local _source = source
    local _id = tonumber(id)
    local rockData = data.getItem(_source, Config.BasicLoot)
    local rockInfo = data.getItemData(Config.BasicLoot)
    local rocklabel = rockInfo.label
    rockData.AddItem(1)
    local items = Config.MinePoints[id].items
    local chance = Config.MinePoints[id].luck
    local random = math.random(1,100)
    if random <= chance then
        local itemr = math.random(1,#items)
        local itemData = data.getItem(_source, items[itemr])
        local itemInfo = data.getItemData(items[itemr])
        local label = itemInfo.label
        itemData.AddItem(1)
        TriggerClientEvent("Notification:left_pa", _source, Config.Texts.MiningAt.." "..Config.MinePoints[id].name, Config.Texts.Collected.." "..rocklabel.." "..Config.Texts.And.." "..label.."!", TEXTURES.tick[1], TEXTURES.tick[2], 2000)
        return
    end
	TriggerClientEvent("Notification:left_pa", _source, Config.Texts.MiningAt.." "..Config.MinePoints[id].name, Config.Texts.Collected.." "..rocklabel.."!", TEXTURES.tick[1], TEXTURES.tick[2], 2000)
end)

-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    versionchecker()
end)

function versionchecker()
    local data = getdatafromapi("https://raw.githubusercontent.com/Wollffus/filevalidation/main/Badlands_Mining.json", function(data)
        if data then
            local dataversion = data.version
            local change = data.changelog
            if version < dataversion then
                print("A new update is available!","\nYour version : " ..version,"\nNew version :  "..dataversion ,"\nChange log : \n".. change)
            end
        end
    end)
end

function getdatafromapi(url,cb)
    local data = nil
    PerformHttpRequest(url, function(code, result, headers)
        if result and #result then
            data = json.decode(result)
            cb(data)
        end
    end, "GET")
end
-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= "Badlands_Mining" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2Badlands_Mining^1")
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
	print('^3 Maintained by WolfHouse Studios Dev Team ^7')
	print('^1 If you require support join:^5 https://discord.gg/zGVDppYxfk ^7')
    print('^3 https://digitalresources.tebex.io ^7')
end)
--