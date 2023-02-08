
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


Citizen.CreateThread(function()
    for name, info in pairs(Config.Items) do
        RegisterServerEvent("RegisterUsableItem:" .. name)
        AddEventHandler("RegisterUsableItem:" .. name, function(source)
            TriggerEvent("redemrp_inventory:getData", function(Inventory)
                local Player = RedEM.GetPlayer(source)
                local meta = Player.GetMetaData()

                Player.SetMetaData("hunger", tonumber(meta.hunger) + info.hunger)
                Player.SetMetaData("thirst", tonumber(meta.thirst) + info.thirst)
                if Player.GetMetaData().hunger > 100.0 then Player.SetMetaData("hunger", 100) end
                if Player.GetMetaData().thirst > 100.0 then Player.SetMetaData("thirst", 100) end

                local ItemData = Inventory.getItem(source, name)
                ItemData.RemoveItem(1)
                TriggerClientEvent('redemrp_status:UpdateStatus', source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
                info.action(source, name)
            end)
        end)
    end
end)


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------