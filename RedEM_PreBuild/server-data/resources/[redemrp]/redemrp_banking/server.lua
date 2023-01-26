RedEM = exports["redem_roleplay"]:RedEM()

RegisterServerEvent('redemrp_banking:withdraw', function(amount)
    local _source = source
    local base = 0
	local _amount = tonumber(amount)
	----print(amount)
	if amount ~= nil then
        local user = RedEM.GetPlayer(_source)
        local money = user.bankmoney
        if _amount == nil or _amount <= 0 or _amount > money then
            TriggerClientEvent("redem_roleplay:Tip",_source, "Invalid amount!" , 3000)
        else
            user.AddMoney(_amount)
            user.RemoveBankMoney(_amount)
            TriggerClientEvent("redem_roleplay:Tip",_source, "Withdrew $".._amount , 3000)
            TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.GetBankMoney(), user.GetLastName(), user.GetFirstName())
        end
	end
end)

RegisterServerEvent('redemrp_banking:deposit', function(amount)
    local _source = source
	local _amount = tonumber(amount)
	if amount ~= nil then
        local user = RedEM.GetPlayer(_source)
        local currentMoney = user.money
        if _amount == nil or _amount <= 0 or _amount > currentMoney then
            TriggerClientEvent("redem_roleplay:Tip",_source, "Invalid amount!" , 3000)
        else
            user.RemoveMoney(_amount)
            user.AddBankMoney(_amount)
            TriggerClientEvent("redem_roleplay:Tip",_source, "Deposited $".._amount , 3000)
            TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.GetBankMoney(), user.GetLastName(), user.GetFirstName())
        end
	end
end)

RegisterServerEvent("redemrp_banking:balance", function(thesource)
    local _source = source and source or thesource
    local user = RedEM.GetPlayer(_source)
    TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.GetBankMoney(), user.GetLastName(), user.GetFirstName())
end)

RegisterServerEvent("redemrp_banking:balancefc", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.GetBankMoney(), user.GetLastName(), user.GetFirstName())
end)

RegisterNetEvent('redemrp_banking:server:RequestBankStash', function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    if user then
        TriggerClientEvent("redemrp_inventory:OpenStash", _source, "bankstash_"..user.citizenid)
    end
end)