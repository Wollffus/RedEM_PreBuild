RedEM = exports["redem_roleplay"]:RedEM()

local version = 1.1 -- Must match github repo latest or error will print in server console

data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

-- ILLEGAL

RegisterServerEvent("RegisterUsableItem:cannabisseed")
AddEventHandler("RegisterUsableItem:cannabisseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_GINSENG_AB_SIM", "CRP_TOBACCOPLANT_BA_SIM", "CRP_TOBACCOPLANT_CA_SIM")
	local ItemData = data.getItem(_source, "cannabisseed")
	ItemData.RemoveItem(1)
end)


-- LEGAL
RegisterServerEvent("RegisterUsableItem:tobaccoseed")
AddEventHandler("RegisterUsableItem:tobaccoseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_TOBACCOPLANT_AA_SIM", "CRP_TOBACCOPLANT_AB_SIM", "CRP_TOBACCOPLANT_AC_SIM")
	local ItemData = data.getItem(_source, "tobaccoseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:sugarsaneseed")
AddEventHandler("RegisterUsableItem:sugarsaneseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_SUGARCANE_AA_SIM", "CRP_SUGARCANE_AB_SIM", "CRP_SUGARCANE_AC_SIM")
	local ItemData = data.getItem(_source, "sugarsaneseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:cornseed")
AddEventHandler("RegisterUsableItem:cornseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_CORNSTALKS_CB_SIM", "CRP_CORNSTALKS_CA_SIM", "CRP_CORNSTALKS_AB_SIM")
	local ItemData = data.getItem(_source, "cornseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:carrotseed")
AddEventHandler("RegisterUsableItem:carrotseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_CARROTS_SAP_BA_SIM", "CRP_CARROTS_AA_SIM", "CRP_CARROTS_BA_SIM")
	local ItemData = data.getItem(_source, "carrotseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:cottonseed")
AddEventHandler("RegisterUsableItem:cottonseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_COTTON_BC_SIM", "CRP_COTTON_BB_SIM", "CRP_COTTON_BA_SIM")
	local ItemData = data.getItem(_source, "cottonseed")
	ItemData.RemoveItem(1)
end)
--TEST
RegisterServerEvent("RegisterUsableItem:marymusseed")
AddEventHandler("RegisterUsableItem:marymusseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_COTTON_BC_SIM", "CRP_COTTON_BB_SIM", "CRP_COTTON_BA_SIM2")
	local ItemData = data.getItem(_source, "marymusseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:sweetflagseed")
AddEventHandler("RegisterUsableItem:sweetflagseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_SUGARCANE_AA_SIM", "CRP_SUGARCANE_AB_SIM", "CRP_SUGARCANE_AC_SIM2")
	local ItemData = data.getItem(_source, "sweetflagseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:enhinaceaseed")
AddEventHandler("RegisterUsableItem:enhinaceaseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_TOBACCOPLANT_AA_SIM", "CRP_TOBACCOPLANT_AB_SIM", "CRP_TOBACCOPLANT_AC_SIM2")
	local ItemData = data.getItem(_source, "enhinaceaseed")
	ItemData.RemoveItem(1)
end)

--TEST
RegisterServerEvent("RegisterUsableItem:wheatseed")
AddEventHandler("RegisterUsableItem:wheatseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_WHEAT_SAP_LONG_AA_SIM", "CRP_WHEAT_SAP_LONG_AB_SIM", "CRP_WHEAT_DRY_LONG_AA_SIM")
	local ItemData = data.getItem(_source, "wheatseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:broccoliseed")
AddEventHandler("RegisterUsableItem:broccoliseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_BROCCOLI_AA_SIM", "CRP_BROCCOLI_AA_SIM", "CRP_BROCCOLI_AA_SIM")
	local ItemData = data.getItem(_source, "broccoliseed")
	ItemData.RemoveItem(1)
end)

RegisterServerEvent("RegisterUsableItem:lettuceseed")
AddEventHandler("RegisterUsableItem:lettuceseed", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:planto1', _source, "CRP_LETTUCE_AA_SIM", "CRP_LETTUCE_AA_SIM", "CRP_LETTUCE_AA_SIM")
	local ItemData = data.getItem(_source, "lettuceseed")
	ItemData.RemoveItem(1)
end)


RegisterServerEvent("RegisterUsableItem:wateringcan")
AddEventHandler("RegisterUsableItem:wateringcan", function(source)
	TriggerClientEvent('redemrp_inventory:close_inventory', source)
    local _source = source
    TriggerClientEvent('Badlands_Farming:regar1', _source)
end)

RegisterServerEvent('Badlands_Farming:giveitem')
AddEventHandler('Badlands_Farming:giveitem', function(wollffus)
    local _source = source
	local user = RedEM.GetPlayer(_source)
	local count = math.random(5,10)
	local count2 = math.random(5,10)
	local job = user.getJob()


		if wollffus == "CRP_TOBACCOPLANT_AC_SIM" then
			local ItemData = data.getItem(_source, "tobacco")
			if job == (Config.job) then
			local amount = math.random(5,10)
			ItemData.AddItem(count)
			TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] tobacco', 3)
		else
			ItemData.AddItem(count)
			TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] tobacco', 3)
		end

		elseif wollffus == "CRP_SUGARCANE_AC_SIM" then
			local ItemData = data.getItem(_source, "sugar")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] sugar', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] sugar', 3)
			end

		elseif wollffus == "CRP_CORNSTALKS_AB_SIM" then
			local ItemData = data.getItem(_source, "corn")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] corn', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] corn', 3)
			end

		elseif wollffus == "CRP_CARROTS_BA_SIM" then
			local ItemData = data.getItem(_source, "carrot")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] carrot', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] carrot', 3)
			end

		elseif wollffus == "CRP_COTTON_BA_SIM" then
			local ItemData = data.getItem(_source, "cotton")
			if job == "doctor" then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] cotton', 3)
			else
				ItemData.AddItem(count2)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] cotton', 3)
			end

		elseif wollffus == "CRP_COTTON_BA_SIM2" then
			local ItemData = data.getItem(_source, "marymus")
			if job == "doctor" then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] marymus', 3)
			else
				ItemData.AddItem(count2)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] marymus', 3)
			end
		elseif wollffus == "CRP_SUGARCANE_AC_SIM2" then
			local ItemData = data.getItem(_source, "sweetflag")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] sweet flag', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] sweet flag', 3)
			end
			elseif wollffus == "CRP_TOBACCOPLANT_AC_SIM2" then
				local ItemData = data.getItem(_source, "enhinacea")
				if job == (Config.job) then
					local amount = math.random(5,10)
					ItemData.AddItem(amount)
					TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] enhinacea', 3)
				else
					ItemData.AddItem(count)
					TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] enhinacea', 3)
				end
		elseif wollffus == "CRP_WHEAT_DRY_LONG_AA_SIM" then
			local ItemData = data.getItem(_source, "wheat")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] wheat', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] wheat', 3)
			end
		elseif wollffus == "CRP_BROCCOLI_AA_SIM" then
			local ItemData = data.getItem(_source, "broccoli")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] broccoli', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] broccoli', 3)
			end

		elseif wollffus == "CRP_LETTUCE_AA_SIM" then
			local ItemData = data.getItem(_source, "lettuce")
			if job == (Config.job) then
				local amount = math.random(5,10)
				ItemData.AddItem(amount)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..(amount)'] lettuce', 3)
			else
				ItemData.AddItem(count)
				TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] lettuce', 3)
			end

		elseif wollffus == "CRP_TOBACCOPLANT_CA_SIM" then
			local ItemData = data.getItem(_source, "cannabis")
			if count == 1 then
				count = 2
			end
			 local Sheriff = 0
			local players = GetPlayers()
				for i,k in pairs(players) do
				   Wait(1)
				   local user = RedEM.GetPlayer(_source)
						if user ~= nil and user.getJob() == "sheriff" then
							Sheriff = Sheriff + 1
						end
				end
				if Sheriff == 0 then
					count = math.random(1, 2)
				end
			ItemData.AddItem(count)
			TriggerClientEvent("redemrp_notification:start", _source, 'You have collected[X'..count..'] cannabis', 3)
		end
    end)

RegisterServerEvent('ak_witness:CallToSherif')
AddEventHandler('ak_witness:CallToSherif', function(x, y, z, zone)
	local _source = source
	local players = GetPlayers()
    	for i,k in pairs(players) do
			local user = RedEM.GetPlayer(_source)
            	if user.getJob() == "sheriff" then
                	TriggerClientEvent('ak_witness:InfoSheriff', tonumber(k), x, y, z, zone)
            	end
    	end
end)

		-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    versionchecker()
end)

function versionchecker()
    local data = getdatafromapi("https://raw.githubusercontent.com/Wollffus/filevalidation/main/Badlands_Farming.json", function(data)
        if data then
            local dataversion = data.version
            local change = data.changelog
            if version < dataversion then
                print("A new update is available!","\nYour version : " ..version,"\nNew version :  "..dataversion ,"\nChange log : \n".. change)
            end
        end
    end)
end

function getdatafromapi(url,cb)
    local data = nil
    PerformHttpRequest(url, function(code, result, headers)
        if result and #result then
            data = json.decode(result)
            cb(data)
        end
    end, "GET")
end
-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= "Badlands_Farming" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2Badlands_Farming^1")
		print("^1=====================================^0")
	end
end)
-----------------------------------------------------------------------------CREDITS--------------------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('^5 '..resourceName..'^2 Successfully Loaded ^7')
    print(version )
	print('^3 Mantained by WolfHouse Studios Dev Team ^7')
	print('^1 If you require support join:^5 https://discord.gg/zGVDppYxfk ^7')
	print('^3 https://digitalresources.tebex.io ^7')
end)
--