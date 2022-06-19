RegisterServerEvent("RegisterUsableItem:handcuffs")
AddEventHandler("RegisterUsableItem:handcuffs", function(source)
    TriggerClientEvent('redemrp_smallresources:handcuffItem', source)
end)