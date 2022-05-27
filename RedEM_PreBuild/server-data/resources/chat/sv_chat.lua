RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

TriggerEvent('redemrp:getPlayerFromId', source, function(user)
     if (user.getGroup() == "superadmin" or user.getGroup() == "admin")  then
	  --   TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
		TriggerClientEvent("sendProximityMessage", -1, source, GetPlayerName(source), message, { 235, 52, 52 })
		TriggerEvent("ncrp_discordlogs:DiscordChat", source, GetPlayerName(source), "**[LOCAL OOC]** " ..message)
       -- TriggerClientEvent('chatMessage', -1, source,  { 235, 52, 52 }, message)
    end

    print(author .. '^7: ' .. message .. '^7')
	 else

    --TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
      --  TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message , )
		TriggerClientEvent("sendProximityMessage", -1, source, GetPlayerName(source), message, { 255, 255, 255 })
		TriggerEvent("ncrp_discordlogs:DiscordChat", source, GetPlayerName(source), "**[LOCAL OOC]** " ..message)
                if string.match(message, "xd") or string.match(message, "XD") or string.match(message, "xD")  then
                   DropPlayer(source,"XD")
                end
    end

    print(author .. '^7: ' .. message .. '^7')
	end
	end)
end)

AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message,1,string.len("/"))=="/" then
		--ne doit rien se passer c'est une commande
	else
		
	end
	CancelEvent()
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
AddEventHandler('chat:init', function()
   -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
end)

AddEventHandler('playerDropped', function(reason)
    --TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
end)

RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)
