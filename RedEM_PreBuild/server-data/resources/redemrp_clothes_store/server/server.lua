RedEM = exports["redem_roleplay"]:RedEM()

RegisterServerEvent('rdr_clothes_store:Save')
AddEventHandler('rdr_clothes_store:Save', function(Clothes, Name, price)
    local _source = source
    local _Name = Name
    local encode = json.encode(Clothes)
    local user = RedEM.GetPlayer(_source)
    local identifier = user.identifier
    local charid = user.charid
    local currentMoney = user.GetMoney()
    if currentMoney >= price then
        user.RemoveMoney(price)
        TriggerEvent("rdr_clothes_store:retrieveClothes", identifier, charid, function(call)
            if call then
                MySQL.update("UPDATE clothes SET `clothes`=@encode WHERE `identifier`=@identifier AND `charid`=@charid", {
                    encode = encode,
                    identifier = identifier,
                    charid = charid
                }, function(done)
                end)
            else
                MySQL.update(
                    'INSERT INTO clothes (`identifier`, `charid`, `clothes`) VALUES (@identifier, @charid, @clothes);',
                    {
                        identifier = identifier,
                        charid = charid,
                        clothes = encode
                    }, function(rowsChanged)
                    end)
            end
        end)
        if _Name then
            TriggerEvent("rdr_clothes_store:retrieveOutfits", identifier, charid, _Name, function(call)
                if call then

                    MySQL.update("UPDATE outfits SET `clothes`=@encode WHERE `identifier`=@identifier AND `charid`=@charid AND `name`=@name",
                        {
                            encode = encode,
                            identifier = identifier,
                            charid = charid,
                            name = _Name
                        }, function(done)
                        end)
                else

                    MySQL.update(
                        'INSERT INTO outfits (`identifier`, `charid`, `clothes`, `name`) VALUES (@identifier, @charid, @clothes , @name);',
                        {
                            identifier = identifier,
                            charid = charid,
                            clothes = encode,
                            name = _Name
                        }, function(rowsChanged)
                        end)
                end
            end)
        end
    else
        TriggerClientEvent("redemrp_skin:LoadSkinClient", _source)
    end
end)

RegisterServerEvent('rdr_clothes_store:LoadClothes')
AddEventHandler('rdr_clothes_store:LoadClothes', function(value)
    local _value = value
    local _source = source
    local _clothes = nil
    local user = RedEM.GetPlayer(_source)
    local identifier = user.identifier
    local charid = user.charid

    MySQL.query('SELECT * FROM clothes WHERE `identifier`=@identifier AND `charid`=@charid;', {
        identifier = identifier,
        charid = charid
    }, function(_clothes)
        if _clothes[1] then
            _clothes = json.decode(_clothes[1].clothes)
        else
            _clothes = {}
        end
        if _clothes ~= nil then
            if _value == 1 then
                TriggerClientEvent("rdr_clothes_store:ApplyClothes", _source, _clothes)
            elseif _value == 2 then
                TriggerClientEvent("rdr_clothes_store:OpenClothingMenu", _source, _clothes)
            end
        end
    end)
end)

RegisterServerEvent('rdr_clothes_store:SetOutfits')
AddEventHandler('rdr_clothes_store:SetOutfits', function(name)
    local _source = source
    local _name = name
    local user = RedEM.GetPlayer(_source)
    local identifier = user.identifier
    local charid = user.charid
    TriggerEvent('rdr_clothes_store:retrieveOutfits', identifier, charid, _name, function(call)
        if call then
            MySQL.update("UPDATE clothes SET `clothes`=@call WHERE `identifier`=@identifier AND `charid`=@charid", {
                call = call,
                identifier = identifier,
                charid = charid
            }, function(done)
            end)
            TriggerClientEvent("redemrp_skin:LoadSkinClient", _source)
            TriggerClientEvent("redemrp_skin:LoadSkinClient", _source)
        end
    end)
end)
RegisterServerEvent('rdr_clothes_store:DeleteOutfit')
AddEventHandler('rdr_clothes_store:DeleteOutfit', function(name)
    local _source = source
    local _name = name
    local user = RedEM.GetPlayer(_source)
    local identifier = user.identifier
    local charid = user.charid
    MySQL.query(
        'DELETE FROM outfits  WHERE `identifier`=@identifier AND `charid`=@charid AND`name`=@name;', {
            identifier = identifier,
            charid = charid,
            name = _name
        }, function(result)
        end)
end)

RegisterServerEvent('rdr_clothes_store:getOutfits')
AddEventHandler('rdr_clothes_store:getOutfits', function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local identifier = user.identifier
    local charid = user.charid
    TriggerEvent('redemrp_db:getOutfits', identifier, charid, function(call)
        if call then
            TriggerClientEvent('rdr_clothes_store:putInTable', _source, call)
        end
    end)
end)

AddEventHandler('redemrp_db:getOutfits', function(identifier, charid, callback)
    local Callback = callback
    MySQL.query('SELECT * FROM outfits WHERE `identifier`=@identifier AND `charid`=@charid;', {
        identifier = identifier,
        charid = charid
    }, function(outfits)
        if outfits[1] then
            Callback(outfits)
        else
            Callback(false)
        end
    end)
end)

AddEventHandler('rdr_clothes_store:retrieveClothes', function(identifier, charid, callback)
    local Callback = callback
    MySQL.query('SELECT * FROM clothes WHERE `identifier`=@identifier AND `charid`=@charid;', {
        identifier = identifier,
        charid = charid
    }, function(clothes)
        if clothes[1] then
            Callback(clothes[1])
        else
            Callback(false)
        end
    end)
end)

AddEventHandler('rdr_clothes_store:retrieveOutfits', function(identifier, charid, name, callback)
    local Callback = callback
    MySQL.query('SELECT * FROM outfits WHERE `identifier`=@identifier AND `charid`=@charid AND `name`=@name;',
        {
            identifier = identifier,
            charid = charid,
            name = name
        }, function(clothes)
            if clothes[1] then
                Callback(clothes[1]["clothes"])
            else
                Callback(false)
            end
        end)
end)

RegisterServerEvent("rdr_clothes_store:deleteClothes")
AddEventHandler("rdr_clothes_store:deleteClothes", function(charid, Callback)
    local _source = source
    local id
    for k, v in ipairs(GetPlayerIdentifiers(_source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end

    local Callback = callback
    MySQL.query('DELETE FROM clothes WHERE `identifier`=@identifier AND `charid`=@charid;', {
        identifier = id,
        charid = charid
    }, function(result)
        if result then
        else
        end
    end)
    MySQL.query('DELETE FROM outfits WHERE `identifier`=@identifier AND `charid`=@charid;', {
        identifier = id,
        charid = charid
    }, function(result)
        if result then
        else
        end
    end)
end)
