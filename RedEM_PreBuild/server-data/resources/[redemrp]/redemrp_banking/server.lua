RegisterServerEvent('redemrp_banking:withdraw')
AddEventHandler('redemrp_banking:withdraw', function(amount)
    local _source = source

    local base = 0
	local _amount = tonumber(amount)
	if amount ~= nil then
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
		local money = user.getBankMoney()
            if _amount == nil or _amount <= 0 or _amount > money then
                 TriggerClientEvent("redemrp_notification:start",_source, "Invalid amount" , 2, "error")
            else
                user.addMoney(_amount)
				user.removeBankMoney(_amount)
                TriggerClientEvent("redemrp_notification:start",_source, "Money Withdrawn Successfully.." , 2, "success")
				TriggerEvent('redemrp_banking:balance',_source)

            end
    end)
	end
end)

RegisterServerEvent('redemrp_banking:deposit')
AddEventHandler('redemrp_banking:deposit', function(amount)
    local _source = source
	local _amount = tonumber(amount)
	if amount ~= nil then
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local currentMoney = user.getMoney()
        if _amount == nil or _amount <= 0 or _amount > currentMoney then
           TriggerClientEvent("redemrp_notification:start",_source, "Invalid amount" , 2, "error")
        else
            user.removeMoney(_amount)
			user.addBankMoney(_amount)
            TriggerClientEvent("redemrp_notification:start",_source, "Successfully Deposited." , 2, "success")
			TriggerEvent('redemrp_banking:balance',_source)
        end
    end)
	end
end)

RegisterServerEvent('redemrp_banking:balance')
AddEventHandler('redemrp_banking:balance', function(source)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
		local money = user.getBankMoney()
           TriggerClientEvent('currentbalance1', _source, money ,namel, namef)
    end)
end)

RegisterServerEvent('redemrp_banking:balance2')
AddEventHandler('redemrp_banking:balance2', function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
		local namel = user.getLastname()
		local namef = user.getFirstname()
         TriggerClientEvent('currentbalance1', _source, money ,namel, namef)

    end)
end)

AddEventHandler('getIdentifierFromName', function(namel, namef, callback)
    local Callback = callback
	local firstname = namef
	local lastname = namel
    MySQL.Async.fetchAll('SELECT identifier, characterid FROM characters WHERE `firstname`=@firstname AND `lastname`=@lastname;', {firstname = firstname, lastname = lastname}, function(name)
		if name[1]then
        local  identifier = name[1].identifier
		local  charid = name[1].characterid
            Callback(identifier , charid)
        end
    end)
end)
