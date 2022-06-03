RegisterServerEvent('redemrp_banking:withdraw')
AddEventHandler('redemrp_banking:withdraw', function(amount)
    local _source = source
	
    local base = 0
	local _amount = tonumber(amount)
	--print(amount)
	if amount ~= nil then
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")		
        TriggerEvent("getBankMoney", identifier, charid, function(call)
            base = call
            if _amount == nil or _amount <= 0 or _amount > base then
                 TriggerClientEvent("redemrp_notification:start",_source, "Invalid amount" , 2, "error")
            else
                user.addMoney(_amount)
				TriggerEvent('removeBankMoney',_source, _amount)	
                TriggerClientEvent("redemrp_notification:start",_source, "Withdrawal made.." , 2, "success")
				Wait(1000)
				TriggerEvent('redemrp_banking:balance',_source)

            end
        end)
    end)
	end
end)

RegisterServerEvent('redemrp_banking:deposit')
AddEventHandler('redemrp_banking:deposit', function(amount)
    local _source = source
	local _amount = tonumber(amount)
	if amount ~= nil then
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local currentMoney = user.getMoney()
        if _amount == nil or _amount <= 0 or _amount > currentMoney then
           TriggerClientEvent("redemrp_notification:start",_source, "Invalid amount" , 2, "error")
        else
            user.removeMoney(_amount)
			TriggerEvent('addBankMoney',_source, _amount)
            TriggerClientEvent("redemrp_notification:start",_source, "Deposit made." , 2, "success")
			Wait(1000)
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
        TriggerEvent("getBankMoney", identifier, charid, function(call)
           TriggerClientEvent('currentbalance1', _source, call ,namel, namef)
			

        end)
    end)
end)

RegisterServerEvent('redemrp_banking:balance2')
AddEventHandler('redemrp_banking:balance2', function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
		local namel = user.getLastname()
		local namef = user.getFirstname()
	--	print(namel)
	--	print(namef)
        TriggerEvent("getBankMoney", identifier, charid, function(call)
         TriggerClientEvent('currentbalance1', _source, call ,namel, namef)
			

        end)
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
		print(identifier)
		print(charid)
            Callback(identifier , charid)
        end
    end)
end)

AddEventHandler('getBankMoney', function(identifier, charid, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT bank FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', {identifier = identifier, characterid = charid}, function(money)
        if money[1]then
            bank = money[1].bank
            Callback(bank)
        end
    end)
end)
RegisterServerEvent('redemrp_banking:transfer1')
AddEventHandler('redemrp_banking:transfer1', function(_amount, firstname , lastname)
if _amount ~= nil and firstname ~= nil and lastname ~= nil then
local _source = source
local function tchelper(first, rest)
   return first:upper()..rest:lower()
end
local fn = firstname
local ln = lastname
local firstname2 = fn:gsub("(%a)([%w_']*)", tchelper)
local lastname2 = ln:gsub("(%a)([%w_']*)", tchelper)



    TriggerEvent("getIdentifierFromName", lastname2, firstname2, function(call , call2)
        print(call)
        print(call2)
        TriggerEvent('transferMoney', _source, _amount ,call, call2)
    end) 
	end
end)


RegisterCommand('givemoney', function(source, args)
    local namel = args[3]
    local namef = args[2]
    local amount = args[1]

    TriggerEvent("getIdentifierFromName", namel, namef, function(call , call2)
        print(call)
        print(call2)
        TriggerEvent('transferMoney', source, amount ,call, call2)
    end)

end)

AddEventHandler('transferMoney', function(source, amount , targetI , targerC)
    local acctept = false
    local _amount = amount
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        TriggerEvent("getBankMoney", identifier, charid, function(call)
            Wait(500)
            if call ~= nil and call >= _amount and call > 0 then
                local  bankmoney = call-_amount
                acctept = true
                MySQL.Async.execute("UPDATE characters SET `bank`='" .. bankmoney .. "' WHERE `identifier`=@identifier AND `characterid`=@characterid", {identifier = identifier, characterid = charid}, function(done)
                end)
                Wait(500)
                TriggerEvent("getBankMoney", targetI, targerC, function(callT)
                    local bankmoneyT = callT+_amount
                    MySQL.Async.execute("UPDATE characters SET `bank`='" .. bankmoneyT .. "' WHERE `identifier`=@identifier AND `characterid`=@characterid", {identifier = targetI, characterid = targerC}, function(done)
					TriggerClientEvent("redemrp_notification:start", source, "The transfer of "..tonumber(_amount).."$ has been made", 2, "success")
					Wait(500)
					TriggerEvent('redemrp_banking:balance',source)
                end)
            end)
            else
                TriggerClientEvent("redemrp_notification:start", source, "You don't have enough money in the bank" , 2, "error")
            end
        end)
    end)
end)


AddEventHandler('removeBankMoney', function(source, amount)
		
		       local _amount = amount
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local bankmoney = 0
        MySQL.Async.fetchAll('SELECT bank FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', {identifier = identifier, characterid = charid}, function(money)
            if money[1]then
                bank = money[1].bank
              
            end
			Wait(500)
            if (bank-_amount) < 0 then
                bankmoney = 0
            else
                bankmoney = bank-_amount
            end
            MySQL.Async.execute("UPDATE characters SET `bank`='" .. bankmoney .. "' WHERE `identifier`=@identifier AND `characterid`=@characterid", {identifier = identifier, characterid = charid}, function(done)
                end)

        end)
    end)
end)


AddEventHandler('addBankMoney', function(source, amount)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local _amount = amount
        local bankmoney = 0
        MySQL.Async.fetchAll('SELECT bank FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', {identifier = identifier, characterid = charid}, function(money)
            if money[1]then
                bank = money[1].bank
               
            end
            local bankmoney =  bank+_amount
            MySQL.Async.execute("UPDATE characters SET `bank`='" .. bankmoney .. "' WHERE `identifier`=@identifier AND `characterid`=@characterid", {identifier = identifier, characterid = charid}, function(done)
                end)

        end)
    end)
end)
