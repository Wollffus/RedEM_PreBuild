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

Citizen.CreateThread(function()
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
end)

Citizen.CreateThread(function()
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
                    PromptSetEnabled(BankPrompt, true)
                    PromptSetVisible(BankPrompt, true)
                    BankPromptShown = true
                end
                if PromptHasHoldModeCompleted(BankPrompt) and not Timeout then
                    inMenu = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({type = "openGeneral"})
                    TriggerServerEvent("redemrp_banking:server:RequestBalance")
                    PromptSetEnabled(BankPrompt, false)
                    PromptSetVisible(BankPrompt, false)
                    BankPromptShown = false
                end
            end
        end
        if not FoundSomething then
            NearAnything = false
            if BankPromptShown then
                PromptSetEnabled(BankPrompt, false)
                PromptSetVisible(BankPrompt, false)
                BankPromptShown = false
            end
        end
    end
end)

RegisterNetEvent("redemrp_banking:client:ReceiveBalance", function(balance, characterName)
    Balance = balance
    Busy = false

    SendNUIMessage({
        type = "balanceHUD",
        balance = Balance,
        player = characterName
    })
end)

RegisterNUICallback("BankStash", function(data)
    if RedEM.GetPlayerData().isLoggedIn then
        inMenu = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = "closeAll"})
        TriggerServerEvent("redemrp_banking:server:RequestBankStash")
    end
end)

RegisterNetEvent("redemrp_banking:client:CloseBank", function()
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = "closeAll"})
end)

RegisterNUICallback("Deposit", function(data)
    TriggerServerEvent("redemrp_banking:server:Deposit", tonumber(data.amount))
end)

RegisterNUICallback("Withdraw", function(data)
    TriggerServerEvent("redemrp_banking:server:Withdraw", tonumber(data.amount))
end)

RegisterNUICallback("NUIFocusOff", function()
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = "closeAll"})
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    PromptDelete(BankPrompt)
end)