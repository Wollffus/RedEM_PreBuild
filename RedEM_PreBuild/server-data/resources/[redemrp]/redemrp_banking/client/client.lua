
--=================Deposit Event===================
local l_
local f_
local active = false
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance, namel, namef)
if namel ~= nil then
 l_ = namel
 f_ = namef
 end
	local playerName = f_.." "..l_

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)

--=================Deposit Event======================

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('redemrp_banking:deposit', tonumber(data.amount))
end)


--==================Withdraw Event====================

RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('redemrp_banking:withdraw', tonumber(data.amountw))
end)

RegisterNUICallback('transfer1', function(data)
 TriggerEvent('redemrp_inventory:OpenPrivateLocker')
end)
--======================Balance Event======================

RegisterNUICallback('balance', function()
	TriggerServerEvent('redemrp_banking:balance')
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	active = false
end)
--======================NUIFocusoff======================



Citizen.CreateThread(function()
	Wait(0)
	for k,v in pairs(Config.Zones) do
		local blip = N_0x554d9d53f696d002(1664425300, v)
		SetBlipSprite(blip, Config.BlipSprite, 1)
		SetBlipScale(blip, Config.BlipScale)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
	end
end)

local PromptBank
local OpenBankGroup = GetRandomIntInRange(0, 0xffffff)
--print('OpenBankGroup: ' .. OpenBankGroup)

function OpenBank()
    Citizen.CreateThread(function()
        local str = "Bank"
        PromptBank = PromptRegisterBegin()
        PromptSetControlAction(PromptBank, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PromptBank, str)
        PromptSetEnabled(PromptBank, true)
        PromptSetVisible(PromptBank, true)
        PromptSetHoldMode(PromptBank, true)
        PromptSetGroup(PromptBank, OpenBankGroup)
        PromptRegisterEnd(PromptBank)

    end)
end
Citizen.CreateThread(function()
Wait(2000)
 OpenBank()
	while true do
	Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
	for k,v in pairs(Config.Zones) do
			if Vdist(coords, v) < 1.5 and not active then
				local BankGroupName  = CreateVarString(10, 'LITERAL_STRING', "Bank")
				 PromptSetActiveGroupThisFrame(OpenBankGroup, BankGroupName)
				if PromptHasHoldModeCompleted(PromptBank) then
					inMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGeneral'})
					TriggerServerEvent('redemrp_banking:balance2')
					active = true
				end
			end
		end
	end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end
