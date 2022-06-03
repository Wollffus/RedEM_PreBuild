RegisterCommand('bank', function(source)

			inMenu = true
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openGeneral'})
			TriggerServerEvent('redemrp_banking:balance2')
end)
--=================Deposit Event===================
local l_ 
local f_ 
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
print("poszlo")
print(data.firstname)
print(data.lastname)
	TriggerServerEvent('redemrp_banking:transfer1', tonumber(data.amountw) , data.firstname, data.lastname)
	
end)
--======================Balance Event======================

RegisterNUICallback('balance', function()
	TriggerServerEvent('redemrp_banking:balance')
end)


--======================NUIFocusoff======================

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)
