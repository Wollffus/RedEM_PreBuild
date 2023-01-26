RedEM = exports["redem_roleplay"]:RedEM()

local BankPrompt = nil
local BankPromptShown = false
local NearAnything = false
local FoundSomething = false
local varString = CreateVarString(10, "LITERAL_STRING", "Use Bank")
local Timeout = nil
local inMenu = false
local Busy = false
local Balance = 0
local l_
local f_

Citizen.CreateThread(
    function()
        BankPrompt = PromptRegisterBegin()
        PromptSetActiveGroupThisFrame(promptGroup, varString)
        PromptSetControlAction(BankPrompt, 0xE8342FF2) -- LEFT ALT
        PromptSetText(BankPrompt, CreateVarString(10, "LITERAL_STRING", "Use Bank"))
        PromptSetStandardMode(BankPrompt, true)
        PromptSetEnabled(BankPrompt, false)
        PromptSetVisible(BankPrompt, false)
        PromptSetHoldMode(BankPrompt, 1)
        N_0x0c718001b77ca468(BankPrompt, 3.0)
        PromptSetGroup(BankPrompt, promptGroup)
        PromptRegisterEnd(BankPrompt)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(50)
			if Timeout then
				if GetGameTimer() - Timeout > 5000 then
					Timeout = nil
				end
			end
            local coords = GetEntityCoords(PlayerPedId())
            FoundSomething = false
			for k,v in pairs(Config.BankLocations) do
				if #(coords - v.Position) < 2.0 then
					NearAnything = true
					FoundSomething = true
					if not BankPromptShown and not inMenu then
						print("Showing bank prompt")
						PromptSetEnabled(BankPrompt, true)
						PromptSetVisible(BankPrompt, true)
						BankPromptShown = true
					end
					if PromptHasHoldModeCompleted(BankPrompt) and not Timeout then
						inMenu = true
						SetNuiFocus(true, true)
						SendNUIMessage({type = "openGeneral"})
						TriggerServerEvent("redemrp_banking:balancefc")
						PromptSetEnabled(BankPrompt, false)
						PromptSetVisible(BankPrompt, false)
						BankPromptShown = false
					end
				end
			end
            if not FoundSomething then
                NearAnything = false
                if BankPromptShown then
                    print("Hiding bank prompt")
                    PromptSetEnabled(BankPrompt, false)
                    PromptSetVisible(BankPrompt, false)
                    BankPromptShown = false
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName ~= GetCurrentResourceName() then return end
        PromptDelete(BankPrompt)
    end
)
--=================Deposit Event===================

RegisterNetEvent("redemrp_banking:client:ReceiveBalance",
    function(balance, namel, namef)
        Balance = balance
        Busy = false
        if namel ~= nil then
            l_ = namel
            f_ = namef
        end
        local playerName = f_ .. " " .. l_

        SendNUIMessage(
            {
                type = "balanceHUD",
                balance = Balance,
                player = playerName
            }
        )
    end
)

RegisterNetEvent("redemrp_banking:client:ResetTransaction", function()
    local playerName = f_ .. " " .. l_

    SendNUIMessage(
        {
            type = "balanceHUD",
            balance = Balance,
            player = playerName
        }
    )
end)

--=================Deposit Event======================

RegisterNUICallback(
    "deposit",
    function(data)
        TriggerServerEvent("redemrp_banking:deposit", tonumber(data.amount))
    end
)

--=============Safety Deposit Box Event ============--
RegisterNUICallback(
    "BankStash",
    function(data)
		if RedEM.GetPlayerData().isLoggedIn and RedEM.GetPlayerData().firstname ~= nil and RedEM.GetPlayerData().lastname ~= nil then
			inMenu = false
			SetNuiFocus(false, false)
			SendNUIMessage({type = "closeAll"})
			TriggerServerEvent("redemrp_banking:server:RequestBankStash")
		end
    end
)

RegisterNetEvent("redemrp_banking:client:CloseBank", function()
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = "closeAll"})
end)

--==================Withdraw Event====================

RegisterNUICallback(
    "withdrawl",
    function(data)
        TriggerServerEvent("redemrp_banking:withdraw", tonumber(data.amountw))
    end
)

RegisterNUICallback(
    "transfer1",
    function(data)
        TriggerServerEvent("redemrp_banking:transfer1", tonumber(data.amountw), data.firstname, data.lastname)
    end
)
--======================Balance Event======================

RegisterNUICallback(
    "balance",
    function()
        TriggerServerEvent("redemrp_banking:balancefc")
    end
)

--======================NUIFocusoff======================

RegisterNUICallback(
    "NUIFocusOff",
    function()
        inMenu = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = "closeAll"})
    end
)
