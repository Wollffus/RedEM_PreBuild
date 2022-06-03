local logEnabled = false
math.randomseed(os.time())

RegisterCommand('rolldice', function(source, args)
    num = math.random(1,6)
    num2 = math.random(1,6)
    num3 = math.random(1,6)
	totalroll = num + num2 + num3
    local text = 'Rolled: \n'..num..'/6\n'..num2..'/6\n'..num3..'/6\n'..totalroll..'/18'
    for i = 1,#args do
        text = text .. '' .. args[i]
    end
    text = text .. ' '
    TriggerClientEvent('3dme:triggerDisplay', -1, text, source , "me")
end)

RegisterCommand('me', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' '
   TriggerClientEvent('3dme:triggerDisplay', -1, text, source , "me")
  -- TriggerClientEvent("sendProximityMessage", -1, source, "Me [" .. source .. "]", text, { 255, 255, 255 })
   TriggerEvent("ncrp_discordlogs:DiscordChat", source, GetPlayerName(source), "**[ME]**" .. text)
	if logEnabled then
		setLog(text, source)
	end
end)


RegisterCommand('try', function(source, args)
    local text = ''
	local random = math.random(1,2)
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' '
	if random == 1 then
		text = 'He succeeded in trying'..text
	else
		text = 'He failed trying '..text
	end
   TriggerClientEvent('3dme:triggerDisplay', -1, text, source , "try")
   --TriggerClientEvent("sendProximityMessage", -1, source, "Me [" .. source .. "]", text, { 32, 151, 247 })
   TriggerEvent("ncrp_discordlogs:DiscordChat", source, GetPlayerName(source), "**[TRY]**" .. text)
	if logEnabled then
		setLog(text, source)
	end
end)


RegisterCommand('do', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' '
    TriggerClientEvent('3dme:triggerDisplay', -1, text, source , "do")
	--TriggerClientEvent("sendProximityMessage", -1, source, "Me [" .. source .. "]", text, { 145, 209, 144 })
	TriggerEvent("ncrp_discordlogs:DiscordChat", source, GetPlayerName(source), "**[DO]**" .. text)
	if logEnabled then
		setLog(text, source)
	end
end)



function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end