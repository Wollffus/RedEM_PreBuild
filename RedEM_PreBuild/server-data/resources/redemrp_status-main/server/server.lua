RedEM = exports["redem_roleplay"]:RedEM()

local PlayersStatus = {}

AddEventHandler("redemrp:playerLoaded", function(source, Player)
    local _source = source
    local metadata = Player.GetMetaData()
    TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(_source), metadata.thirst, metadata.hunger, metadata.stress)
end)

RegisterNetEvent("redemrp_status:server:FeedMe", function(source)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    Player.SetMetaData("hunger", 100)
    Player.SetMetaData("thirst", 100)
    TriggerClientEvent('redemrp_status:UpdateStatus', _source, 100, 100, Player.GetMetaData().stress)
end)

RegisterNetEvent("redemrp_status:server:ClearStress", function(source)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    Player.SetMetaData("stress", 0)
    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, 0)
end)

RegisterCommand("addstress", function(source, args)
    if args[1] then
        local amount = tonumber(args[1])
        local Player = RedEM.GetPlayer(source)
        Player.SetMetaData("stress", Player.GetMetaData().stress + amount)
        if Player.GetMetaData().stress > 100 then
            Player.SetMetaData("stress", 100)
        end
        TriggerClientEvent('redemrp_status:UpdateStatus', source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
        print("Stress now "..Player.GetMetaData().stress)
    end
end)

RegisterCommand("setstress", function(source, args)
    if args[1] then
        local amount = tonumber(args[1])
        local Player = RedEM.GetPlayer(source)
        Player.SetMetaData("stress", amount)
        if Player.GetMetaData().stress > 100 then
            Player.SetMetaData("stress", 100)
        end
        TriggerClientEvent('redemrp_status:UpdateStatus', source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
        print("Stress now "..Player.GetMetaData().stress)
    end
end)

function UpdatePlayersStatus()
    SetTimeout(30000, function()
        Citizen.CreateThread(function()
            for _, playerId in pairs(GetPlayers()) do
                local tempPlayer = RedEM.GetPlayer(playerId)
                if tempPlayer then
                    local metadata = tempPlayer.GetMetaData()
                    if metadata.hunger - 0.24 >= 0.0 then
                        tempPlayer.SetMetaData("hunger", tonumber(string.format("%.2f", tonumber(metadata.hunger) - 0.24)))
                    end
                    if metadata.thirst - 0.3 >= 0.0 then
                        tempPlayer.SetMetaData("thirst", tonumber(string.format("%.2f", tonumber(metadata.thirst) - 0.3)))
                    end
                    if metadata.stress >= 60.0 then
                        if metadata.stress + 0.2 <= 100.0 then
                            tempPlayer.SetMetaData("stress", tonumber(string.format("%.2f", tonumber(metadata.stress) + 0.2)))
                        end
                    else
                        if metadata.stress - 0.1 >= 0.0 then
                            tempPlayer.SetMetaData("stress", tonumber(string.format("%.2f", tonumber(metadata.stress) - 0.1)))
                        end
                    end
                    TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(playerId), tempPlayer.GetMetaData().thirst, tempPlayer.GetMetaData().hunger, tempPlayer.GetMetaData().stress)
                    Wait(10)
                end
            end
            UpdatePlayersStatus()
        end)
    end)
end
UpdatePlayersStatus()

RegisterServerEvent("redemrp_status:server:AddHungerThirst", function(hunger, thirst)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    local meta = Player.GetMetaData()

    Player.SetMetaData("hunger", tonumber(meta.hunger) + hunger)
    if Player.GetMetaData().hunger > 100 then
        Player.SetMetaData("hunger", 100)
    end
    Player.SetMetaData("thirst", tonumber(meta.thirst) + thirst)
    if Player.GetMetaData().thirst > 100 then
        Player.SetMetaData("thirst", 100)
    end

    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
end)

RegisterServerEvent("redemrp_status:server:AddStress", function(amount)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    local meta = Player.GetMetaData()

    Player.SetMetaData("stress", tonumber(meta.stress) + amount)
    if Player.GetMetaData().stress > 100 then
        Player.SetMetaData("stress", 100)
    end

    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
end)

RegisterServerEvent("redemrp_status:server:RelieveStress", function(amount)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    local meta = Player.GetMetaData()

    local newstress = tonumber(meta.stress) - amount
    Player.SetMetaData("stress", tonumber(meta.stress) - amount)
    if Player.GetMetaData().stress < 0 then
        Player.SetMetaData("stress", 0)
        newstress = 0
    end

    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, newstress)
end)

RegisterServerEvent("redemrp_status:server:AddHungerThirstForId", function(_source, hunger, thirst)
    local Player = RedEM.GetPlayer(_source)
    local meta = Player.GetMetaData()

    Player.SetMetaData("hunger", tonumber(meta.hunger) + hunger)
    if Player.GetMetaData().hunger > 100 then
        Player.SetMetaData("hunger", 100)
    end
    Player.SetMetaData("thirst", tonumber(meta.thirst) + thirst)
    if Player.GetMetaData().thirst > 100 then
        Player.SetMetaData("thirst", 100)
    end

    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
end)