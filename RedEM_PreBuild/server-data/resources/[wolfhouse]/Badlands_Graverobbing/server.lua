RedEM = exports["redem_roleplay"]:RedEM()

TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:shovel")
AddEventHandler("RegisterUsableItem:shovel", function(source)
    TriggerClientEvent('grave:TriggerRobbery', source)
end)

RegisterNetEvent("grave:Complete")
AddEventHandler("grave:Complete", function()
	local _source = source
    local frankntank = math.random(1, 20)

    if frankntank <= ((Config.Chances)) then
        local _source = source
        local Player = RedEM.GetPlayer(_source)
			local caboose = math.random(1,20)
            local wollffus = math.random(1,5)
            if caboose <= 1 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 2 then
                local ItemData = data.getItem(_source, (Config.item2))
                ItemData.AddItem(wollffus)
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 4 then
                local ItemData = data.getItem(_source, (Config.item3))
                ItemData.AddItem(wollffus)
            elseif caboose <= 5 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 6 then
                local ItemData = data.getItem(_source, (Config.item4))
                ItemData.AddItem(wollffus)
            elseif caboose <= 7 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 8 then
                local ItemData = data.getItem(_source, (Config.item5))
                ItemData.AddItem(wollffus)
            elseif caboose <= 9 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 10 then
                local ItemData = data.getItem(_source, (Config.item6))
                ItemData.AddItem(1)
            elseif caboose <= 11 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 12 then
                local ItemData = data.getItem(_source, (Config.item2))
                ItemData.AddItem(wollffus)
            elseif caboose <= 13 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 14 then
                local ItemData = data.getItem(_source, (Config.item3))
                ItemData.AddItem(wollffus)
            elseif caboose <= 15 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 16 then
                local ItemData = data.getItem(_source, (Config.item4))
                ItemData.AddItem(wollffus)
            elseif caboose <= 17 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 18 then
                local ItemData = data.getItem(_source, (Config.item5))
                ItemData.AddItem(wollffus)
            elseif caboose <= 19 then
                local ItemData = data.getItem(_source, (Config.item1))
                ItemData.AddItem(wollffus)
            elseif caboose <= 20 then
                local ItemData = data.getItem(_source, (Config.item3))
                ItemData.AddItem(wollffus)
            end

        TriggerClientEvent("redemrp_notification:start", _source, "You've found something, you should run!", 2)
    else

        TriggerClientEvent("redemrp_notification:start", _source, "Nothing is here", 2)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('^5 '..resourceName..'^2 Successfully Loaded ^7')
    print(version )
	print('^3 WolfHouse Studios Dev Team ^7')
end)