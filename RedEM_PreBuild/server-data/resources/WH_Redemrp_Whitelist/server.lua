local version = 1.0 -- Must match github repo latest or error will print in server console

local FormattedToken = "Bot " .. Config.Bot_Token

tracked = {}

RegisterNetEvent('WH_Whitelist:PlayerLoaded')
AddEventHandler('WH_Whitelist:PlayerLoaded', function()
	local license = ExtractIdentifiers(source).license;
	if (tracked[license] == nil) then 
		tracked[license] = true;
	end
end)

--card = '{"type":"AdaptiveCard","$schema":"https://adaptivecards.io/schemas/adaptive-card.json","version":"1.2","body":[{"type":"Container","items":[{"type":"TextBlock","text":"WH_Whitelist","wrap":true,"fontType":"Default","size":"ExtraLarge","weight":"Bolder","color":"Light","horizontalAlignment":"Center"},{"type":"TextBlock","text":"' .. Config.Splash.Heading1 .. '","wrap":true,"size":"Large","weight":"Bolder","color":"Light"},{"type":"TextBlock","text":"' .. Config.Splash.Heading2 .. '","wrap":true,"color":"Light","size":"Medium"},{"type":"ColumnSet","height":"stretch","minHeight":"100px","bleed":true,"horizontalAlignment":"Center","columns":[{"type":"Column","width":"stretch","items":[{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Discord","url":"' .. Config.Splash.Discord_Link .. '","style":"positive"}]}],"height":"stretch"},{"type":"Column","width":"stretch","items":[{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Website","style":"positive","url":"' .. Config.Splash.Website_Link .. '"}]}]}]},{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Click to join Badger\'s Discord","style":"destructive","iconUrl":"https://i.gyazo.com/c629f37bb1aeed2c1bc1768fdc93bc1a.gif","url":"https://discord.com/invite/WjB5VFz"}]}],"style":"default","bleed":true,"height":"stretch","isVisible":true}]}'
card = '{"type":"AdaptiveCard","$schema":"https://adaptivecards.io/schemas/adaptive-card.json","version":"1.2","body":[{"type":"Image","url":"' .. Config.Splash.Header_IMG .. '","horizontalAlignment":"Center"},{"type":"Container","items":[{"type":"TextBlock","text":"","wrap":true,"fontType":"Default","size":"ExtraLarge","weight":"Bolder","color":"Light","horizontalAlignment":"Center"},{"type":"TextBlock","text":"' .. Config.Splash.Heading1 .. '","wrap":true,"size":"Large","weight":"Bolder","color":"Light", "horizontalAlignment":"Center"},{"type":"TextBlock","text":"' .. Config.Splash.Heading2 .. '","wrap":true,"color":"Light","size":"Medium","horizontalAlignment":"Center"},{"type":"ColumnSet","height":"stretch","minHeight":"100px","bleed":true,"horizontalAlignment":"Center","columns":[{"type":"Column","width":"stretch","items":[{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Discord","url":"' .. Config.Splash.Discord_Link .. '","style":"positive"}]}],"height":"stretch"},{"type":"Column","width":"stretch","items":[{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Website","style":"positive","url":"' .. Config.Splash.Website_Link .. '"}]}]}]},{"type":"ActionSet","actions":[]}],"style":"default","bleed":true,"height":"stretch","isVisible":true}]}'
if Config.Splash.Enabled then 
	AddEventHandler('playerConnecting', function(name, setKickReason, deferrals) 
		-- Player is connecting
		deferrals.defer();
		local src = source;
		local toEnd = false;
		local count = 0;
		while not toEnd do 
			deferrals.presentCard(card,
			function(data, rawData)
			end)
			Wait((1000))
			count = count + 1;
			if count == Config.Splash.Wait then 
				toEnd = true;
			end
		end
		deferrals.done();
	end)
end 

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoleIdFromRoleName(name)
	if (Caches.RoleList ~= nil) then 
		return tonumber(Caches.RoleList[name]);
	else 
		local roles = GetGuildRoleList();
		return tonumber(roles[name]);
	end
end

function CheckEqual(role1, role2)
	local checkStr1 = false;
	local checkStr2 = false;
	local roleID1 = role1;
	local roleID2 = role2;
	if type(role1) == "string" then checkStr1 = true end;
	if type(role2) == "string" then checkStr2 = true end; 
	if checkStr1 then 
		local roles = GetGuildRoleList();
		for roleName, roleID in pairs(roles) do 
			if roleName == role1 then 
				roleID1 = roleID;
			end
		end
		local roles2 = Config.RoleList;
		for roleRef, roleID in pairs(roles2) do 
			if roleRef == role1 then 
				roleID1 = roleID;
			end
		end
	end
	if checkStr2 then 
		local roles = GetGuildRoleList();
		for roleName, roleID in pairs(roles) do 
			if roleName == role2 then 
				roleID2 = roleID;
			end
		end
		local roles2 = Config.RoleList;
		for roleRef, roleID in pairs(roles2) do 
			if roleRef == role2 then 
				roleID2 = roleID;
			end
		end
	end
	if tonumber(roleID1) == tonumber(roleID2) then 
		return true;
	end
	return false;
end

function IsDiscordEmailVerified(user) 
    local discordId = nil
    local isVerified = false;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                -- It is valid data 
                --print("The data for User " .. GetPlayerName(user) .. " is: ");
                --print(data.avatar);
                isVerified = data.verified;
                --print("---")
            end
        else 
        end
    end
    return isVerified;
end

function GetDiscordEmail(user) 
    local discordId = nil
    local emailData = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                -- It is valid data 
                --print("The data for User " .. GetPlayerName(user) .. " is: ");
                --print(data.avatar);
                emailData = data.email;
                --print("---")
            end
        else 
        end
    end
    return emailData;
end

function GetDiscordName(user) 
    local discordId = nil
    local nameData = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                -- It is valid data 
                --print("The data for User " .. GetPlayerName(user) .. " is: ");
                --print(data.avatar);
                nameData = data.username .. "#" .. data.discriminator;
                --print("---")
            end
        else 
        end
    end
    return nameData;
end

function GetGuildIcon()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		if (data.icon:sub(1, 1) and data.icon:sub(2, 2) == "_") then 
			-- It's a gif 
			return 'https://cdn.discordapp.com/icons/' .. Config.Guild_ID .. "/" .. data.icon .. ".gif";
		else 
			-- Image 
			return 'https://cdn.discordapp.com/icons/' .. Config.Guild_ID .. "/" .. data.icon .. ".png";
		end 
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
	return nil;
end

function GetGuildSplash()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		-- Image 
		return 'https://cdn.discordapp.com/splashes/' .. Config.Guild_ID .. "/" .. data.icon .. ".png";
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
	return nil;
end 

function GetGuildName()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		-- Image 
		return data.name;
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
	return nil;
end

function GetGuildDescription()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		-- Image 
		return data.description;
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
	return nil;
end

function GetGuildMemberCount()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID.."?with_counts=true", {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		-- Image 
		return data.approximate_member_count;
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
	return nil;
end

function GetGuildOnlineMemberCount()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID.."?with_counts=true", {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		return data.approximate_presence_count;
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
	return nil;
end

function GetDiscordAvatar(user) 
    local discordId = nil
    local imgURL = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
	end
	if discordId then 
		if Caches.Avatars[discordId] == nil then 
			local endpoint = ("users/%s"):format(discordId)
			local member = DiscordRequest("GET", endpoint, {})
			if member.code == 200 then
				local data = json.decode(member.data)
				if data ~= nil and data.avatar ~= nil then 
					-- It is valid data 
					--print("The data for User " .. GetPlayerName(user) .. " is: ");
					--print(data.avatar);
					if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
						--print("IMG URL: " .. "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif")
						imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif";
					else 
						--print("IMG URL: " .. "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png")
						imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
					end
					--print("---")
				end
			else 
				print("[Wolfhouse_Admin_WL] ERROR: Code 200 was not reached. Error provided: " .. member.data)
			end
			Caches.Avatars[discordId] = imgURL;
		else 
			imgURL = Caches.Avatars[discordId];
		end 
	else 
		print("[Wolfhouse_Admin_WL] ERROR: Discord ID was not found...")
	end
    return imgURL;
end

Caches = {
	Avatars = {}
}
function ResetCaches()
	Caches = {};
end

function GetGuildRoleList()
	if (Caches.RoleList == nil) then 
		local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
		if guild.code == 200 then
			local data = json.decode(guild.data)
			-- Image 
			local roles = data.roles;
			local roleList = {};
			for i = 1, #roles do 
				roleList[roles[i].name] = roles[i].id;
			end
			Caches.RoleList = roleList;
		else
			print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
			Caches.RoleList = nil;
		end
	end
	return Caches.RoleList;
end

function GetDiscordRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break;
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Config.Guild_ID, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
			print("[Wolfhouse_Admin_WL] ERROR: Code 200 was not reached... Returning false. [Member Data NOT FOUND]")
			return false
		end
	else
		print("[Wolfhouse_Admin_WL] ERROR: Discord was not connected to user's Fivem account...")
		return false
	end
	return false
end

function GetDiscordNickname(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Config.Guild_ID, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local nickname = data.nick
			return nickname;
		else
			print("[Wolfhouse_Admin_WL] ERROR: Code 200 was not reached. Error provided: "..member.data)
			return nil;
		end
	else
		print("[Wolfhouse_Admin_WL] ERROR: Discord was not connected to user's Fivem account...")
		return nil;
	end
	return nil;
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		print("[Wolfhouse_Admin_WL] Permission system guild set to: "..data.name.." ("..data.id..")")
	else
		print("[Wolfhouse_Admin_WL] An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code))
	end
end)

-----------------------------------------------------------------------------VERSION CHECK--------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    versionchecker()
end)

function versionchecker()
    local data = getdatafromapi("https://raw.githubusercontent.com/Wollffus/filevalidation/main/WH_Redemrp_Whitelist.json", function(data)
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
	if GetCurrentResourceName() ~= "WH_Redemrp_Whitelist" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1SCRIPT NAME OTHER THAN ORIGINAL")
		print("^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED")
		print("^1CHANGE NAME TO: ^2WH_Redemrp_Whitelist^1")
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
	print('^3 Maintained by WolfHouse Studios Dev Team ^7')
	print('^1 If you require support join:^5 https://discord.gg/zGVDppYxfk ^7')
end)
--
