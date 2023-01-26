RegisterCommand('showjob', function(source)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local job = user.getJob()
        TriggerClientEvent('redem_roleplay:Tip', _source, job, 3000)
    end)
end)