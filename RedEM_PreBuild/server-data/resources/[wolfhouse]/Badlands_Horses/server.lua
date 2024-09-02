RedEM = exports["redem_roleplay"]:RedEM()

local version = 1.4 -- Must match github repo latest or error will print in server console

local players_loaded = {}
math.randomseed(os.time())
inv = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    inv = call
end)


RegisterServerEvent('Badlands_Personalhorses:RemoveMoney')
AddEventHandler( 'Badlands_Personalhorses:RemoveMoney', function ( price )
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    Player.removeMoney(price)
end)
RegisterServerEvent("RegisterUsableItem:sugar")
AddEventHandler("RegisterUsableItem:sugar", function(source)
	local _source = source
	TriggerClientEvent("horseDrops:sugar", _source)
end)

RegisterServerEvent("horseDrops:delete_napar_predkosci")
AddEventHandler("horseDrops:delete_napar_predkosci", function()
	local _source = source
	local ItemData = inv.getItem(_source, 'horse_adrenaline')
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("horseDrops:deleteSugar")
AddEventHandler("horseDrops:deleteSugar", function()
	local _source = source
	local ItemData = inv.getItem(_source, 'sugar')
	ItemData.RemoveItem(1)
end)

RegisterServerEvent('Badlands_Personalhorses:buyhorse')
AddEventHandler( 'Badlands_Personalhorses:buyhorse', function ( args, name)
local _name = name

        local _src   = source
        local _price = args['Price']
        local _level = args['Level']
        local _model = args['Model']


        local Player = RedEM.GetPlayer(_src)
            u_identifier = Player.getIdentifier()
            u_level = Player.getLevel()
            u_charid = Player.getSessionVar("charid")
            u_money = Player.getMoney()


        if u_money < _price then
			TriggerClientEvent("ncrp_notify:Tip", _src, "~t8~"..Config.notenough , 3000)
            return
        end

        if u_level < _level then
		TriggerClientEvent("ncrp_notify:Tip", _src, "~t8~"..Config.noxp , 3000)
            return
        end

        local Player = RedEM.GetPlayer(_src)
        Player.removeMoney(_price)
--			user.addXP(5)

			local numBase0 = math.random(100,999)
			local numBase1 = math.random(0,9999)
			local number = string.format("%03d%04d", numBase0, numBase1)
        MySQL.Async.fetchAll('SELECT * FROM Badlands_Horses WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = u_identifier, charid = u_charid}, function(horses)
            local _HasHorses = {}
            if horses[1] then
                _HasHorses = json.decode(horses[1].horse)
                _HasHorses[#_HasHorses+1]={_model, number, _name}
                local data = json.encode(_HasHorses)
                local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['horse'] = data }
                MySQL.Async.execute(" UPDATE Badlands_Horses SET horse = @horse WHERE identifier = @identifier AND charid = @charid ", Parameters)
				TriggerClientEvent("ncrp_notify:Tip", _src, "You bought a new Horse" , 3000)
            else
                _HasHorses[1]={_model, number, _name}
                local data = json.encode(_HasHorses)
                local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['horse'] = data }
                MySQL.Async.execute("INSERT INTO Badlands_Horses ( `identifier`, `charid`, `horse` ) VALUES ( @identifier, @charid, @horse )", Parameters)
               TriggerClientEvent("ncrp_notify:Tip", _src, "You bought a new Horse" , 3000)
            end
        end)
        Wait(1000)
        TriggerEvent('Badlands_Personalhorses:AddOrDelNewHorseToParking',_model ,10, _src, number , _name)
end)


RegisterServerEvent('Badlands_Personalhorses:gethorses')
AddEventHandler('Badlands_Personalhorses:gethorses', function()
    local check = false
    local _src = source

    local Player = RedEM.GetPlayer(_src)
        if Player ~= nil then
            u_identifier = Player.getIdentifier()
            u_charid = Player.getSessionVar("charid")

            if check == false then
                local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
                local HasHorses = MySQL.Sync.fetchAll( "SELECT * FROM Badlands_Horses WHERE identifier = @identifier AND charid = @charid ", Parameters )

                if HasHorses[1] then
                    local horse = HasHorses[1].horse
                    local _horse = json.decode(horse)
                    MySQL.Async.fetchAll("DELETE FROM Badlands_Horses_stabled WHERE identifier = @identifier AND charid = @charid ", Parameters)
                    Wait(500)
                    for v,k in pairs(_horse) do
                        _horse[v] = {GetHashKey(k[1]), k[2], k[3]}
                    end
                    local data = json.encode(_horse)
                    local Parameters2 = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['horse'] = data }
                    MySQL.Async.execute("INSERT INTO Badlands_Horses_stabled ( `identifier`, `charid`, `horse` ) VALUES ( @identifier, @charid, @horse )", Parameters2)
                    TriggerClientEvent("Badlands_Personalhorses:gethorses_client", _src, _horse)
                end
            else

                local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
                local parked_horses = MySQL.Sync.fetchAll( "SELECT * FROM Badlands_Horses_stabled WHERE identifier = @identifier AND charid = @charid ", Parameters )
                local horse22 = parked_horses[1].horse
                local _horse22 = json.decode(horse22)
                TriggerClientEvent("Badlands_Personalhorses:gethorses_client", _src, _horse22)
            end
        end
end )


RegisterServerEvent('Badlands_Personalhorses:AddOrDelNewHorseToParking')
AddEventHandler('Badlands_Personalhorses:AddOrDelNewHorseToParking', function(model , var , source_ser, plate , name)
    local _src
	local _name = name
    if source_ser == "brak" then

        _src = source
    else
        _src = source_ser
    end

    local Player = RedEM.GetPlayer(_src)
        u_identifier = Player.getIdentifier()
        u_charid = Player.getSessionVar("charid")

        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
        local ParkedHorses = MySQL.Sync.fetchAll( "SELECT * FROM Badlands_Horses_stabled WHERE identifier = @identifier AND charid = @charid ", Parameters )
        local HasHorses = MySQL.Sync.fetchAll( "SELECT * FROM Badlands_Horses WHERE identifier = @identifier AND charid = @charid ", Parameters )
        if ParkedHorses[1] then
            local horse = ParkedHorses[1].horse
            local _horse = json.decode(horse)
            if var == 1 then
                local owned_horse = HasHorses[1].horse
                local _owned_horse = json.decode(owned_horse)
                local test = false
                for v,k in pairs(_owned_horse) do
					print(k[2])
                    if tonumber(k[2])== tonumber(plate) then
                        _horse[#_horse+1]= {model,plate, _name}
                        TriggerClientEvent("Badlands_Personalhorses:DeleteHorse", _src)
                        test = true
                    else
                    end
                end
                if test == false then
				TriggerClientEvent("ncrp_notify:Tip", _src, "~e~You are not the owner of this horse" , 3000)
                end
            elseif var == 10 then
                _horse[#_horse+1]= {GetHashKey(model), plate, _name}
            else
                for v,k in pairs(_horse) do
                    if k[2] == plate then
                        table.remove(_horse, v)
                    end
                end
			TriggerClientEvent('Badlands_Personalhorses:spawnHorse', _src, model, false , plate)
            end
            local data = json.encode(_horse)
            local Parameters2 = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['horse'] = data }
            MySQL.Async.execute(" UPDATE Badlands_Horses_stabled SET horse = @horse WHERE identifier = @identifier AND charid = @charid ", Parameters2)
            TriggerClientEvent("Badlands_Personalhorses:gethorses_client", _src, _horse)

        else
            local test = {}
            test[#test+1]= {GetHashKey(model), plate, _name}
            local data2 = json.encode(test)
            local Parameters3 = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['horse'] = data2 }
            MySQL.Async.execute("INSERT INTO Badlands_Horses_stabled ( `identifier`, `charid`, `horse` ) VALUES ( @identifier, @charid, @horse )", Parameters3)
            TriggerClientEvent("Badlands_Personalhorses:gethorses_client", _src, test)
        end
end )


-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    versionchecker()
end)

function versionchecker()
    local data = getdatafromapi("https://raw.githubusercontent.com/Wollffus/filevalidation/main/Badlands_Horses.json", function(data)
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
	if GetCurrentResourceName() ~= "Badlands_Horses" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2Badlands_Horses^1")
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