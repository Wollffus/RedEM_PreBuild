local foundResources = {}
local neededResources = {"redemrp_menu_base"}

local detectNeededResources = function()
    for k,v in ipairs(neededResources)do
        if GetResourceState(v) == "started" then
            foundResources[v] = true
			print("^4[redemrp_clothing] ^2["..v.."] ^0 Found ^0")
        else
			print("^4[redemrp_clothing] ^1["..v.."] ^0Not Found, missing features ^0")
		end
    end
	print("^4[redemrp_clothing] ^0 Loaded ^0")
end

detectNeededResources()




RegisterServerEvent('redemrp_clothing:Save')
AddEventHandler('redemrp_clothing:Save', function(clothes, saveOutfit , name, cb)
	local _source = source
    local _clothes = clothes
    local _name = name
    local decode = json.decode(clothes)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local currentMoney = user.getMoney()
        print (currentMoney)
	if currentMoney >= 0 then
		--user.removeMoney(10)
                 TriggerClientEvent("redemrp_clothes_remove:clothesData", _source, _clothes)
        TriggerEvent("redemrp_clothing:retrieveClothes", identifier, charid, function(call)

                if call then

                    MySQL.Async.execute("UPDATE clothes SET `clothes`='" .. _clothes .. "' WHERE `identifier`=@identifier AND `charid`=@charid", {identifier = identifier, charid = charid}, function(done)
                        end)
                else

                    MySQL.Async.execute('INSERT INTO clothes (`identifier`, `charid`, `clothes`) VALUES (@identifier, @charid, @clothes);',
                        {
                            identifier = identifier,
                            charid = charid,
                            clothes = _clothes
                        }, function(rowsChanged)
                        end)
                end
        end)
        if saveOutfit then
            TriggerEvent("redemrp_clothing:retrieveOutfits", identifier, charid, _name, function(call)

                    if call then

                        MySQL.Async.execute("UPDATE outfits SET `clothes`='" .. _clothes .. "' WHERE `identifier`=@identifier AND `charid`=@charid AND `name`=@name", {identifier = identifier, charid = charid , name = name}, function(done)
                            end)
                    else

                        MySQL.Async.execute('INSERT INTO outfits (`identifier`, `charid`, `clothes`, `name`) VALUES (@identifier, @charid, @clothes , @name);',
                            {
                                identifier = identifier,
                                charid = charid,
                                clothes = _clothes,
                                name = _name
                            }, function(rowsChanged)
                            end)
                    end
            end)
        end
		else
		  TriggerClientEvent("redemrp_skin:LoadSkinClient" , _source)
	end

    end)
end)



RegisterServerEvent('redemrp_clothing:loadClothes')
AddEventHandler('redemrp_clothing:loadClothes', function(value)
    local _value = value
    local _source = source
    local skin = nil
    local _clothes = nil
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")

            MySQL.Async.fetchAll('SELECT * FROM clothes WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = identifier, charid = charid}, function(_clothes)
                if _clothes[1] then
                    _clothes = _clothes[1].clothes
                else
                    local json = json.encode({})
                    _clothes = json
                end
                if _clothes ~= nil then
                    if _value == 1 then
                        TriggerClientEvent("redemrp_clothing:load", _source, _clothes)
                    elseif _value == 2 then
                        TriggerClientEvent("redemrp_clothing:OpenClothingMenu", _source, _clothes)
                    elseif _value == 3 then
                        TriggerClientEvent("redemrp_clothes_remove:start", _source, _clothes)

                    end
                else
                    TriggerClientEvent("redemrp_clothing:load_def" , _source)
                end

            end)
    end)
end)
RegisterServerEvent('redemrp_clothing:SetOutfits')
AddEventHandler('redemrp_clothing:SetOutfits', function(name)
    local _source = source
    local _name = name
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        TriggerEvent('redemrp_clothing:retrieveOutfits',identifier, charid,_name, function(call)
            if call then
                MySQL.Async.execute("UPDATE clothes SET `clothes`='" .. call .. "' WHERE `identifier`=@identifier AND `charid`=@charid", {identifier = identifier, charid = charid}, function(done)
                    end)
                TriggerClientEvent("redemrp_skin:LoadSkinClient" , _source)
				 TriggerClientEvent("redemrp_clothes_remove:clothesData", _source, call)
            end
        end)
    end)
end)
RegisterServerEvent('redemrp_clothing:DeleteOutfit')
AddEventHandler('redemrp_clothing:DeleteOutfit', function(name)
    local _source = source
    local _name = name
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        MySQL.Async.fetchAll('DELETE FROM outfits  WHERE `identifier`=@identifier AND `charid`=@charid AND`name`=@name;', {identifier = identifier, charid = charid,  name = _name}, function(result)
            end)
    end)
end)

RegisterServerEvent('redemrp_clothing:getOutfits')
AddEventHandler('redemrp_clothing:getOutfits', function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        TriggerEvent('redemrp_db:getOutfits',identifier, charid, function(call)
            if call then
                TriggerClientEvent('redemrp_clothing:putInTable', _source, call)
            end
        end)
    end)
end)

AddEventHandler('redemrp_db:getOutfits', function(identifier,charid,callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM outfits WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = identifier, charid = charid}, function(outfits)
        if outfits[1] then
            Callback(outfits)
        else
            Callback(false)
        end
    end)
end)

AddEventHandler('redemrp_clothing:retrieveClothes', function(identifier, charid, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM clothes WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = identifier, charid = charid}, function(clothes)
        if clothes[1] then
            Callback(clothes[1])
        else
            Callback(false)
        end
    end)
end)

AddEventHandler('redemrp_clothing:retrieveOutfits', function(identifier, charid, name, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM outfits WHERE `identifier`=@identifier AND `charid`=@charid AND `name`=@name;', {identifier = identifier, charid = charid, name = name}, function(clothes)
        if clothes[1] then
            Callback(clothes[1]["clothes"])
        else
            Callback(false)
        end
    end)
end)


RegisterServerEvent("redemrp_clothing:deleteClothes")
AddEventHandler("redemrp_clothing:deleteClothes", function(charid, Callback)
    local _source = source
    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end

    local Callback = callback
    MySQL.Async.fetchAll('DELETE FROM clothes WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = id, charid = charid}, function(result)
        if result then
        else
        end
    end)
    MySQL.Async.fetchAll('DELETE FROM outfits WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = id, charid = charid}, function(result)
        if result then
        else
        end
    end)
end)
