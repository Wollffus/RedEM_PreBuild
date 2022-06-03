----------------------------------------------------------------------------------
data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)
---------------------------------------------------------------------------------------
RegisterServerEvent("ml_policejob:checkjob")
AddEventHandler("ml_policejob:checkjob", function()
      local _src = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
print(user.getJob())
        if user.getJob() == 'police' then
            TriggerClientEvent('ml_policejob:open', _src)
        else
            print('not authorized')
        end
    end)
end)

RegisterServerEvent("ml_policejob:checkjob2")
AddEventHandler("ml_policejob:checkjob2", function()
      local _src = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
print(user.getJob())
        if user.getJob() == 'police' then
            TriggerClientEvent('ml_policejob:open2', _src)
        else
            print('not authorized')
        end
    end)
end)

--cuff

RegisterServerEvent('ml_policejob:cuffplayer')
AddEventHandler('ml_policejob:cuffplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        TriggerClientEvent('ml_policejob:cuff', target)
        print('servercuff')
    end)
end)

RegisterServerEvent('ml_policejob:uncuffplayer')
AddEventHandler('ml_policejob:uncuffplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        TriggerClientEvent('ml_policejob:uncuff', target)
        print('serveruncuff')
    end)
end)

--lasso


RegisterServerEvent('ml_policejob:lassoplayer')
AddEventHandler('ml_policejob:lassoplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        --TriggerClientEvent('ml_policejob:lasso', target)
		TriggerClientEvent('ml_policejob:hogtie', target)
        print('serverlasso')
    end)
end)


-- Server
RegisterServerEvent('ml_policejob:weaponlasso')
AddEventHandler('ml_policejob:weaponlasso', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_LASSO')
        ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('ml_policejob:weaponcattleman')
AddEventHandler('ml_policejob:weaponcattleman', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_REVOLVER_CATTLEMAN')
        ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('ml_policejob:weaponhenry')
AddEventHandler('ml_policejob:weaponhenry', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_REPEATER_HENRY')
        ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('ml_policejob:weaponpumpshotgun')
AddEventHandler('ml_policejob:weaponpumpshotgun', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_SHOTGUN_PUMP')
            print("Wollffus#0001")
        ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('ml_policejob:weaponrollingblock')
AddEventHandler('ml_policejob:weaponrollingblock', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK')
        ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('ml_policejob:weaponlantern')
AddEventHandler('ml_policejob:weaponlantern', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_MELEE_LANTERN_ELECTRIC')
        ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('ml_policejob:weaponknife')
AddEventHandler('ml_policejob:weaponknife', function()
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local ItemData = data.getItem(source, 'WEAPON_MELEE_KNIFE')
        ItemData.AddItem(1)
    end)
end)
