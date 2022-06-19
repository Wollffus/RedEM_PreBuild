local Props = {}

data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("redemrp_propplacer:SaveProp")
AddEventHandler("redemrp_propplacer:SaveProp", function(prophash, x ,y, z ,heading , time , type)
    local _source = source
		if type ~= nil and  type  ~= "m_b" and  type ~= "m_m"then
				data.CreateCraftingStation(heading.."-"..x, x, y, z , type , "empty")
			data.updateCraftings(-1)
		end
		if type  == "m_b" then
			TriggerEvent('tor_moonshiners:add_b', heading.."-"..x, x, y, z)
		end
		if type == "m_m" then
			TriggerEvent('tor_moonshiners:add_m', heading.."-"..x, x, y, z)
		end
    Props[heading.."-"..x] = {prophash = prophash , x = x, y = y , z = z , heading = heading , time = time , type = type }
    SaveResourceFile(GetCurrentResourceName(), "Props.json", json.encode(Props), -1)
    TriggerClientEvent('redemrp_propplacer:GetProps', -1, Props)
end)

RegisterServerEvent("redemrp_propplacer:Repair")
AddEventHandler("redemrp_propplacer:Repair", function(id)
 local _source = source
  local itemData =  data.getItem(_source , "wood")
   if itemData.ItemAmount > 0 then
   if Props[id].time + 43200000 <= 172800000 then
		Props[id].time =  Props[id].time + 43200000
	else
		Props[id].time =  172800000
	end
		TriggerClientEvent('redemrp_propplacer:GetProps', -1, Props)
		itemData.RemoveItem(1)
	else
		TriggerClientEvent("ak_notification:Left", _source, "Bag", "You dont have wood" , tonumber(2000))
   end
end)

function loadProps()
    prop = LoadResourceFile(GetCurrentResourceName(), "Props.json") or ""
    if prop ~= "" then
        Props = json.decode(prop)
    else
        Props = {}
    end
	local amount = 0
	 for k,v in pairs(Props) do
		amount = amount + 1
		if v.type ~= nil and  v.type  ~= "m_b" and  v.type ~= "m_m"then
			data.CreateCraftingStation(k,  v.x,  v.y,  v.z ,  v.type , "empty")
		end
		if v.type  == "m_b" then
			TriggerEvent('tor_moonshiners:add_b', k,  v.x,  v.y,  v.z)
		end
		if v.type == "m_m" and v.prophash == GetHashKey("p_still04x") then
			TriggerEvent('tor_moonshiners:add_m', k,  v.x,  v.y,  v.z)
		end
	 end
    --print("^4[redemrp_propplacer] ^2["..amount.."] Props Loaded ^0")
end

function RemoveTime()
    SetTimeout(600000, function()
        for k,v in pairs(Props) do
		if v.time ~= "perm" then
            v.time = v.time - 600000
            if v.time <= 0 then
                Props[k] = nil
				if v.type ~= nil and  v.type ~= "m_b" and  v.type ~= "m_m"then
					data.updateRemoveCraftings(k)
					data.updateCraftings(-1)
				end
					if v.type  == "m_b" then
						TriggerEvent('tor_moonshiners:remove_b', k)
					end
					if v.type == "m_m" then
						TriggerEvent('tor_moonshiners:remove_m', k)
					end
				
            end
			end
        end
		  SaveResourceFile(GetCurrentResourceName(), "Props.json", json.encode(Props), -1)
              TriggerClientEvent('redemrp_propplacer:GetProps', -1, Props)
		  RemoveTime()
    end)
end

RegisterServerEvent("redemrp_propplacer:PropRequest")
AddEventHandler("redemrp_propplacer:PropRequest", function()
    local _source = source
    TriggerClientEvent('redemrp_propplacer:GetProps', _source, Props)
end)
RegisterServerEvent("redemrp_propplacer:DeleteProp")
AddEventHandler("redemrp_propplacer:DeleteProp", function(id)
    local _source = source
    Props[id] = nil
    SaveResourceFile(GetCurrentResourceName(), "Props.json", json.encode(Props), -1)
    TriggerClientEvent('redemrp_propplacer:GetProps', -1, Props)
end)


RegisterServerEvent("redemrp_propplacer:DestroyProp")
AddEventHandler("redemrp_propplacer:DestroyProp", function(id)
    local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local job = user.getJob()
		if job == "sheriff" then
			if Props[id].type  == "m_b" then
						TriggerEvent('tor_moonshiners:remove_b', id)
			end
			if Props[id].type == "m_m" then
						TriggerEvent('tor_moonshiners:remove_m', id)
			end
			for k,v in pairs(Props) do
				
				if v.prophash == GetHashKey("p_barrelhalf04x") and  #(vector3(v.x , v.y , v.z) - vector3(Props[id].x , Props[id].y , Props[id].z)) < 7.0 then
					if v.type  == "m_b" then
						TriggerEvent('tor_moonshiners:remove_b', k)
					end
					if v.type == "m_m" then
						TriggerEvent('tor_moonshiners:remove_m', k)
					end
					Props[k] = nil
				end
			
			end
			Props[id].prophash = GetHashKey("mp006_p_moonshiner_still04x_dmg") 
                        Props[id].type = nil
			SaveResourceFile(GetCurrentResourceName(), "Props.json", json.encode(Props), -1)
			TriggerClientEvent('redemrp_propplacer:GetProps', -1, Props)
			TriggerClientEvent("redemrp_notification:start", _source,"Moonshine Stills were destroyed", 3, "error")
		else
		 TriggerClientEvent("redemrp_notification:start", _source,"You are not the sheriff", 3, "error")
		end
	end)
end)




loadProps()
RemoveTime()
