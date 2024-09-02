RedEM = exports["redem_roleplay"]:RedEM()

local version = 1.4

RegisterServerEvent('Badlands_HorseCustomization:Save')
AddEventHandler('Badlands_HorseCustomization:Save', function(components, price, plate, cb)
    local _components = components
    local _price = price
	local _plate = plate
	local _name = name
    local decode = json.decode(components)

    local _source = source
    local Player = RedEM.GetPlayer(_source)

	local identifier = Player.getIdentifier()
     local charid = Player.getSessionVar("charid")
        local currentMoney = Player.getMoney()
        if currentMoney >= _price then
            Player.removeMoney(_price)
            TriggerEvent("Badlands_HorseCustomization:retrieveComponents", _plate, function(call)

                    if call then

                        MySQL.Async.execute("UPDATE horse_components SET `components`='" .. _components .. "' WHERE `plate`=@plate", {plate = _plate}, function(done)
                            end)
                    else

                        MySQL.Async.execute('INSERT INTO horse_components (`identifier`, `charid` , `plate`, `components`) VALUES (@identifier, @charid, @plate, @components);',
                            {
								identifier = identifier,
								charid = charid,
                                plate = _plate,
                                components = _components
                            }, function(rowsChanged)
                            end)
                    end
            end)


        else
            TriggerClientEvent("redemrp_notification:start", source, "You do not have money" , 2, "error")
			TriggerClientEvent("Badlands_HorseCustomization:loadhorsecomponent", source)
        end
end)



RegisterServerEvent('Badlands_HorseCustomization:loadComponents')
AddEventHandler('Badlands_HorseCustomization:loadComponents', function(plate, var ,target)
local _target = target
	local value = var
    local _source = source
    local components = nil
	local _plate = plate
    local Player = RedEM.GetPlayer(_source)
        local identifier = Player.getIdentifier()
        local charid = Player.getSessionVar("charid")

            MySQL.Async.fetchAll('SELECT * FROM horse_components WHERE `plate`=@plate;', {plate = _plate}, function(components)
                if components[1] then
                    components = components[1].components
                else

                    local elementy = {
                        ["czaprak"] = 1,
                        ["bag"] = 1,
                        ["tail"] = 1,
                        ["mane"] = 1,
                        ["saddle"] = 1,
                        ["stirrups"] =1,
                        ["mat"] = 1,


                    }
                    local json = json.encode(elementy)
                    components = json
                end

                if components ~= nil then
				if value == 0 then
                        TriggerClientEvent("Badlands_HorseCustomization:load", _source, components, _target)
				elseif value == 1 then

					TriggerClientEvent("Badlands_HorseCustomization:startUi", _source, components)

				end
                end

        end)
end)


AddEventHandler('Badlands_HorseCustomization:retrieveComponents', function(plate, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM horse_components WHERE `plate`=@plate;', {plate = plate}, function(components)
        if components[1] then
            Callback(components[1])
        else
            Callback(false)
        end
    end)
end)


RegisterServerEvent("Badlands_HorseCustomization:delete")
AddEventHandler("Badlands_HorseCustomization:delete", function(charid, Callback)
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

-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    versionchecker()
end)

function versionchecker()
    local data = getdatafromapi("https://raw.githubusercontent.com/Wollffus/filevalidation/main/Badlands_HorseCustomization.json", function(data)
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
	if GetCurrentResourceName() ~= "Badlands_HorseCustomization" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2Badlands_HorseCustomization^1")
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
	print('^3 Maintained by Wolfhouse Studios Dev Team ^7')
	print('^1 If you require support join:^5 https://discord.gg/zGVDppYxfk ^7')
    print('^3 https://digitalresources.tebex.io ^7')
end)
--