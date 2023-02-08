RedEM = exports["redem_roleplay"]:RedEM()

RegisterServerEvent('redemrp_banking:server:Withdraw', function(amount)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local currentBankMoney = user.bankmoney
    if amount ~= nil and amount > 0 and currentBankMoney >= amount then
        user.AddMoney(amount)
        user.RemoveBankMoney(amount)
        TriggerClientEvent("redem_roleplay:Tip", _source, "Withdrew $"..amount, 3000)
        TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.bankmoney, user.GetName())
    else
        TriggerClientEvent("redem_roleplay:Tip", _source, "Invalid amount!" , 3000)
    end
end)

RegisterServerEvent('redemrp_banking:server:Deposit', function(amount)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local currentMoney = user.money
    if amount ~= nil and amount > 0 and currentMoney >= amount then
        user.RemoveMoney(amount)
        user.AddBankMoney(amount)
        TriggerClientEvent("redem_roleplay:Tip", _source, "Deposited $"..amount, 3000)
        TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.bankmoney, user.GetName())
    else
        TriggerClientEvent("redem_roleplay:Tip", _source, "Invalid amount!" , 3000)
    end
end)

RegisterServerEvent("redemrp_banking:server:RequestBalance", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    if user then
        TriggerClientEvent("redemrp_banking:client:ReceiveBalance", _source, user.bankmoney, user.GetName())
    end
end)

RegisterNetEvent('redemrp_banking:server:RequestBankStash', function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    if user then
        TriggerClientEvent("redemrp_inventory:OpenStash", _source, "bankstash_"..user.citizenid)
    end
end)