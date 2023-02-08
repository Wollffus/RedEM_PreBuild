RedEM = exports["redem_roleplay"]:RedEM()

local identifierUsed = 'steam'

RegisterServerEvent("redemrp_charselect:getCharacters", function()
    local _source = source
    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len(identifierUsed .. ":")) == (identifierUsed .. ":") then
            id = v
            break
        end
    end

    local randomRoutingBucket = math.random(1000000, 99999999)
    SetRoutingBucketPopulationEnabled(randomRoutingBucket, false)
    SetPlayerRoutingBucket(_source, randomRoutingBucket)

    MySQL.query('SELECT * FROM characters WHERE `identifier`=@identifier;', {identifier = id}, function(result)
        MySQL.query('SELECT * FROM skins WHERE `identifier`=@identifier;', {identifier = id}, function(result2)
            MySQL.query('SELECT * FROM clothes WHERE `identifier`=@identifier;', {identifier = id}, function(result3)
                TriggerClientEvent('redemrp_charselect:openSelectionMenu', _source, result, result2, result3)
            end)
        end)
    end)
end)

RegisterServerEvent("redemrp_charselect:ResetRoutingBucket", function()
    local _source = source
    SetPlayerRoutingBucket(_source, 0)
end)

RegisterServerEvent("redemrp_charselect:deleteCharacter", function(_charid)
    local _source = source
    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len(identifierUsed .. ":")) == (identifierUsed .. ":") then
            id = v
            break
        end
    end
    local timeout = 0
    while id == nil and timeout < 10 do Wait(100) ; timeout = timeout + 1 end 
    MySQL.query('DELETE FROM characters WHERE `identifier` = @identifier AND `characterid`=@characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM skins WHERE `identifier` = @identifier AND `charid`=@characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM clothes WHERE `identifier` = @identifier AND `charid`=@characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM horses WHERE `identifier` = @identifier AND `charid`=@characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM user_inventory WHERE `identifier` = @identifier AND `charid`=@characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM user_bills WHERE `owner` = @identifier AND `ownerCharId` = @characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM outfits WHERE `identifier` = @identifier AND `charid` = @characterid;', {identifier = id, characterid=_charid})
    MySQL.query('DELETE FROM stashes WHERE `stashid` = @stashid;', {stashid = "bankstash_"..id.."_".._charid})
    MySQL.query('DELETE FROM stashes WHERE `stashid` = @stashid;', {stashid = "campstorage_"..id.."_".._charid})

    TriggerClientEvent("redemrp_charselect:characterRemoved", _source)
end)