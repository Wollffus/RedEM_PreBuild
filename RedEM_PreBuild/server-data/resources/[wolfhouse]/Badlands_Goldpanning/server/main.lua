RedEM = exports["redem_roleplay"]:RedEM()

TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:goldpan")
AddEventHandler("RegisterUsableItem:goldpan", function(source)
    TriggerClientEvent('Badlands_Goldpanning:StartGoldPan', source)
end)

RegisterNetEvent("golden_nugget")
AddEventHandler("golden_nugget", function()
    local item = ((Config.item))
    local wolf = math.random(1,10)
    if wolf < (Config.nuggetchance) then
        local _source = source
        local Player = RedEM.GetPlayer(_source)
            local ItemData = data.getItem(source, (Config.itemdata))
            local rexandember = math.random(1,5)
            ItemData.AddItem(rexandember)
        TriggerClientEvent("redemrp_notification:start",source, (Config.foundmessage), 5)
    else
        TriggerClientEvent("redemrp_notification:start",source, (Config.nofindmessage), 5)
    end
end)