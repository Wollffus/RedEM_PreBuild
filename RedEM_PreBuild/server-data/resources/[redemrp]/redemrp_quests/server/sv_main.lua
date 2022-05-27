data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)


RegisterNetEvent("redemrp_quests:InitiateQuests")
AddEventHandler("redemrp_quests:InitiateQuests", function()
    CreateDialogs()
end)


function CreateDialogs()
    Citizen.CreateThread(function()
        for k, v in pairs(Config.Quests) do

        TriggerEvent("redemrp_dialog:createDialog", tonumber(Config.StartCount + k), Config.NPCTitle, Config.Quests[k]["Talk"]["Desc"],
        {
        {name = Config.Quests[k]["Talk"]["1"], func = function(source) TriggerClientEvent('redemrp_quests:StartQuest', source, Config.Quests[k]["Type"], Config.Quests[k]["Reward"], Config.Quests[k]["Xp"], Config.Quests[k]["Goal"]["Name"], Config.Quests[k]["Goal"]["Pos"]) end, focusOFF = true},
        {name = Config.Quests[k]["Talk"]["2"], func = function() end, focusOFF = true},
        {name = Config.Quests[k]["Talk"]["3"], func = function() end, focusOFF = true},
        }
        )


        end
    end)
end

RegisterNetEvent("redemrp_quests:GatherItem")
AddEventHandler("redemrp_quests:GatherItem", function(itemName)
    local _source = source
	local ItemData = data.getItem(_source, itemName)
	ItemData.AddItem(count)

end)

RegisterNetEvent("redemrp_quests:CheckItem")
AddEventHandler("redemrp_quests:CheckItem", function(itemName, money, xp)
    local _source = source
	local ItemData = data.getItem(_source, itemName)
    if ItemData.ItemAmount >= 1 then
        ItemData.RemoveItem(1)
        TriggerClientEvent("redemrp_quests:FinishMissionType1", _source)
        TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
            user.addMoney(tonumber(money))
            user.addXP(tonumber(xp))
        end)
    else
        TriggerClientEvent("redemrp_quests:MissionType1Failure", _source)
    end
end)

RegisterNetEvent("redemrp_quests:Payout")
AddEventHandler("redemrp_quests:Payout", function(money, xp)
    local _source = source
    TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
        user.addMoney(tonumber(money * 1.2))
        user.addXP(tonumber(xp))
    end)
    TriggerClientEvent("redemrp_quests:FinishMissionType2", _source)
end)

RegisterNetEvent("redemrp_quests:Payout2")
AddEventHandler("redemrp_quests:Payout2", function(money, xp)
    local _source = source
    TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
        user.addMoney(tonumber(money * 1.2))
        user.addXP(tonumber(xp))
    end)
    TriggerClientEvent("redemrp_quests:FinishMissionType3", _source)
end)