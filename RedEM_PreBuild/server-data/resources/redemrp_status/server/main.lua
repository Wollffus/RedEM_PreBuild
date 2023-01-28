RedEM = exports["redem_roleplay"]:RedEM()

local PlayersStatus = {}

AddEventHandler("redemrp:playerLoaded", function(source, Player)
    local _source = source
    local metadata = Player.GetMetaData()
    TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(_source), metadata.thirst, metadata.hunger)
end)

function UpdatePlayersStatus()
    SetTimeout(36000, function()
        Citizen.CreateThread(function()
            for _, playerId in pairs(GetPlayers()) do
                local tempPlayer = RedEM.GetPlayer(playerId)
                if tempPlayer then
                    local metadata = tempPlayer.GetMetaData()
                    if metadata.hunger - 0.17 >= 0.0 then
                        tempPlayer.SetMetaData("hunger", tonumber(string.format("%.2f", tonumber(metadata.hunger) - 0.17)))
                    end
                    if metadata.thirst - 0.2 >= 0.0 then
                        tempPlayer.SetMetaData("thirst", tonumber(string.format("%.2f", tonumber(metadata.thirst) - 0.2)))
                    end
                    TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(playerId), tempPlayer.GetMetaData().thirst, tempPlayer.GetMetaData().hunger)
                    Wait(10)
                end
            end
            UpdatePlayersStatus()
        end)
    end)
end
UpdatePlayersStatus()

RegisterServerEvent("redemrp_status:AddAmount", function(hunger, thirst)
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

    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger)
end)

RegisterServerEvent("redemrp_status:AddAmountForId", function(_source, hunger, thirst)
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

    TriggerClientEvent('redemrp_status:UpdateStatus', _source, Player.GetMetaData().thirst, Player.GetMetaData().hunger)
end)