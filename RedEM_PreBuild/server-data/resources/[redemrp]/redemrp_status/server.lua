Inventory = {}
TriggerEvent("redemrp_inventory:getData", function(call)
    Inventory = call
end)

local PlayersStatus = {}

AddEventHandler("redemrp:playerLoaded", function(source, user)
    local _source = source
    local identifier = user.getIdentifier()
    local charid = user.getSessionVar("charid")
    MySQL.Async.fetchAll('SELECT * FROM status WHERE `identifier`=@identifier AND `charid`=@charid;', {
        identifier = identifier,
        charid = charid
    }, function(status)
        if status[1] then
            PlayersStatus[identifier .. "_" .. charid] = json.decode(status[1].status)
            PlayersStatus[identifier .. "_" .. charid].source = _source
            print("wwrp_status: Status Loaded!")
        else
            print("wwrp_status: Status Created!")

            local Created = {
                hunger = 100,
                thirst = 100,
                drunk = 0,
                drugs = 0,
                source = _source
            }
            local temp = {
                hunger = 100,
                thirst = 100,
                drunk = 0,
                drugs = 0
            }
            PlayersStatus[identifier .. "_" .. charid] = Created
            MySQL.Async.execute(
                'INSERT INTO status (`identifier`, `charid`, `status`) VALUES (@identifier, @charid, @status);', {
                    identifier = identifier,
                    charid = charid,
                    status = json.encode(temp)
                }, function(rowsChanged)
                end)
        end
        TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(PlayersStatus[identifier .. "_" .. charid].source),
            PlayersStatus[identifier .. "_" .. charid].thirst, PlayersStatus[identifier .. "_" .. charid].hunger)
    end)

end)

AddEventHandler("redemrp:playerDropped", function(user)
    local charid = user.getSessionVar("charid")
    local identifier = user.get('identifier')
    local temp = {}
    temp.hunger = PlayersStatus[identifier .. "_" .. charid].hunger
    temp.thirst = PlayersStatus[identifier .. "_" .. charid].thirst
    temp.drunk = PlayersStatus[identifier .. "_" .. charid].drunk
    temp.drugs = PlayersStatus[identifier .. "_" .. charid].drugs
    MySQL.Async.execute("UPDATE status SET `status`='" .. json.encode(temp) ..
        "' WHERE `identifier`=@identifier AND `charid`=@cid", {
            identifier = identifier,
            cid = charid
        }, function(done)
            PlayersStatus[identifier .. "_" .. charid] = nil
        end)

end)

function UpdatePlayersStatus()
    SetTimeout(12000, function()
        Citizen.CreateThread(function()
            for id, status in pairs(PlayersStatus) do
                if PlayersStatus[id].hunger - 0.2 >= 0.0 then
                    PlayersStatus[id].hunger = PlayersStatus[id].hunger - 0.17
                end
                if PlayersStatus[id].thirst - 0.2 >= 0.0 then
                    PlayersStatus[id].thirst = PlayersStatus[id].thirst - 0.2
                end
                TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(PlayersStatus[id].source), PlayersStatus[id].thirst, PlayersStatus[id].hunger)
                Wait(10)
            end
            UpdatePlayersStatus()
        end)
    end)
end
UpdatePlayersStatus()

function UpdateDb()
    SetTimeout(300000, function()
        Citizen.CreateThread(function()
            for id, status in pairs(PlayersStatus) do
                local temp = {}
                temp.hunger = PlayersStatus[id].hunger
                temp.thirst = PlayersStatus[id].thirst
                temp.drunk = PlayersStatus[id].drunk
                temp.drugs = PlayersStatus[id].drugs
                local identifier = id:sub(1, -3)
                local charid = id:sub(#id, #id)
                MySQL.Async.execute("UPDATE status SET `status`='" .. json.encode(temp) ..
                    "' WHERE `identifier`=@identifier AND `charid`=@cid", {
                        identifier = identifier,
                        cid = charid
                    }, function(done)
                    end)
                Wait(100)
            end
            UpdateDb()
        end)
    end)
end
UpdateDb()

Citizen.CreateThread(function()
    for name, info in pairs(Config.Items) do
        RegisterServerEvent("RegisterUsableItem:" .. name)
        AddEventHandler("RegisterUsableItem:" .. name, function(source)
            TriggerEvent('redemrp:getPlayerFromId', source, function(user)
                local identifier = user.getIdentifier()
                local charid = user.getSessionVar("charid")
                PlayersStatus[identifier .. "_" .. charid].hunger = PlayersStatus[identifier .. "_" .. charid].hunger + info.hunger
                PlayersStatus[identifier .. "_" .. charid].thirst = PlayersStatus[identifier .. "_" .. charid].thirst + info.thirst
                if PlayersStatus[identifier .. "_" .. charid].hunger > 100.0 then PlayersStatus[identifier .. "_" .. charid].hunger = 100 end
                if PlayersStatus[identifier .. "_" .. charid].thirst > 100.0 then PlayersStatus[identifier .. "_" .. charid].thirst = 100 end
                local ItemData = Inventory.getItem(tonumber(PlayersStatus[identifier .. "_" .. charid].source), name)
                ItemData.RemoveItem(1)
                TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(PlayersStatus[identifier .. "_" .. charid].source), PlayersStatus[identifier .. "_" .. charid].thirst, PlayersStatus[identifier .. "_" .. charid].hunger)
                info.action(tonumber(PlayersStatus[identifier .. "_" .. charid].source) , name)

            end)
        end)
    end
end)

RegisterServerEvent("redemrp_status:Restart")
AddEventHandler("redemrp_status:Restart", function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        PlayersStatus[identifier .. "_" .. charid].hunger = 25
        PlayersStatus[identifier .. "_" .. charid].thirst = 25
        TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(PlayersStatus[identifier .. "_" .. charid].source), PlayersStatus[identifier .. "_" .. charid].thirst, PlayersStatus[identifier .. "_" .. charid].hunger)
        local temp = {}
        temp.hunger = PlayersStatus[identifier .. "_" .. charid].hunger
        temp.thirst = PlayersStatus[identifier .. "_" .. charid].thirst
        temp.drunk = PlayersStatus[identifier .. "_" .. charid].drunk
        temp.drugs = PlayersStatus[identifier .. "_" .. charid].drugs
        MySQL.Async.execute("UPDATE status SET `status`='" .. json.encode(temp) ..
            "' WHERE `identifier`=@identifier AND `charid`=@cid", {
                identifier = identifier,
                cid = charid
            }, function(done)
            end)

    end)
end)

RegisterServerEvent("redemrp_status:AddAmount")
AddEventHandler("redemrp_status:AddAmount", function(hunger , thirst)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        PlayersStatus[identifier .. "_" .. charid].hunger = PlayersStatus[identifier .. "_" .. charid].hunger + hunger
        PlayersStatus[identifier .. "_" .. charid].thirst = PlayersStatus[identifier .. "_" .. charid].thirst + thirst
        if PlayersStatus[identifier .. "_" .. charid].hunger > 100.0 then PlayersStatus[identifier .. "_" .. charid].hunger = 100 end
        if PlayersStatus[identifier .. "_" .. charid].thirst > 100.0 then PlayersStatus[identifier .. "_" .. charid].thirst = 100 end
        TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(PlayersStatus[identifier .. "_" .. charid].source), PlayersStatus[identifier .. "_" .. charid].thirst, PlayersStatus[identifier .. "_" .. charid].hunger)
    end)
end)
