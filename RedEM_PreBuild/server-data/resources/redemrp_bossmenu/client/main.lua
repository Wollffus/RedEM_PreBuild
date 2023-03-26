RedEM = exports["redem_roleplay"]:RedEM()

local PlayerJob = nil
local PlayerJobgrade = nil
local promptGroup
local BossMenuPrompt = nil
local BossMenuPromptShown = false
local NearAnything = false
local FoundSomething = false
local varString = CreateVarString(10, "LITERAL_STRING", "Boss Menu")
local Timeout = nil


RegisterNetEvent("redemrp_bossmenu:client:ReceiveJob", function(job, grade)
    PromptSetEnabled(BossMenuPrompt, false)
    PromptSetVisible(BossMenuPrompt, false)
    BossMenuPromptShown = false
    PlayerJob, PlayerJobgrade = job, grade
end)

RegisterNetEvent("redem_roleplay:JobChange", function(job)
    TriggerServerEvent("redemrp_bossmenu:server:RequestJob")
end)

Citizen.CreateThread(function()
    BossMenuPrompt = PromptRegisterBegin()
    PromptSetActiveGroupThisFrame(promptGroup, varString)
    PromptSetControlAction(BossMenuPrompt, 0xE8342FF2) -- LEFT ALT
    PromptSetText(BossMenuPrompt, CreateVarString(10, "LITERAL_STRING", "~COLOR_GOLD~Job Menu"))
    PromptSetStandardMode(BossMenuPrompt, true)
    PromptSetEnabled(BossMenuPrompt, false)
    PromptSetVisible(BossMenuPrompt, false)
    PromptSetHoldMode(BossMenuPrompt, 1)
    N_0x0c718001b77ca468(BossMenuPrompt, 3.0)
    PromptSetGroup(BossMenuPrompt, promptGroup)
    PromptRegisterEnd(BossMenuPrompt)
    Wait(1000)
    if RedEM.GetPlayerData().isLoggedIn then
        TriggerServerEvent("redemrp_bossmenu:server:RequestJob")
    end
end)

local onCooldown = false

RegisterNetEvent("redemrp_bossmenu:client:ToggleDuty", function() TriggerServerEvent("redemrp_bossmenu:server:ToggleDuty") end)

RegisterNetEvent("redemrp_bossmenu:client:OpenBossMenu", function(ledgerAmt)
    if not ledgerAmt then ledgerAmt = 0 end
    local Position = GetEntityCoords(PlayerPedId())
    Citizen.CreateThread(function()
        while true do
            Wait(100)
            if #(Position - GetEntityCoords(PlayerPedId())) > 2.5 then
                TriggerEvent("redemrp_menu_base:getData", function(call)
                    call.CloseAll()
                end)
                return
            end
        end
    end)
    TriggerEvent("redemrp_menu_base:getData",function(MenuData)
        MenuData.CloseAll()
        local elements = {}
        if Config.Jobs[PlayerJob].HasDuty then
            table.insert(elements, {label = "Toggle Duty", value = 'duty', desc = "Go on/off duty."})
        end
        if Config.Jobs[PlayerJob].HasLockers then
            table.insert(elements, {label = "Access Locker #", value = 'locker', desc = "Access Locker by #"})
        end
        if Config.Jobs[PlayerJob].Grades[PlayerJobgrade].Personnel then
            table.insert(elements, {label = "Manage Personnel", value = 'personnel', desc = "Manage Personnel"})
        end
        if Config.Jobs[PlayerJob].Grades[PlayerJobgrade].Ledger then
            table.insert(elements, {label = "Access Ledger", value = 'ledger', desc = 'Ledger Balance:<br/><span style="color:limegreen;font-size:18pt">$'..ledgerAmt..'</span>'})
        end
        if Config.Jobs[PlayerJob].Grades[PlayerJobgrade].StorageAccess then
            table.insert(elements, {label = "Access Stash", value = 'stash', desc = "Access stash"})
        end

        if #elements == 0 then
            return RedEM.Functions.NotifyRight( "You don't have any options here.", 3000)
        end

        MenuData.Open('default', GetCurrentResourceName(), 'bossmenu', {
            title = "Boss Menu",
            subtext = "Job Interaction for Bosses",
            align = 'top-right',
            elements = elements,
        },
        function(data, menu)
            if data.current.value == 'duty' then
                if not onCooldown then
                    TriggerServerEvent("redemrp_bossmenu:server:ToggleDuty")
                    onCooldown = true
                    menu.close()
                    Citizen.SetTimeout(3000, function()
                        onCooldown = false
                    end)
                else
                    RedEM.Functions.NotifyRight( "You can only use this command once every 3 seconds!", 3000)
                    menu.close()
                end
            elseif data.current.value == 'locker' then
                MenuData.CloseAll()
                AddTextEntry("FMMC_MPM_TYP86", "Locker ID #")
                DisplayOnscreenKeyboard(3, "FMMC_MPM_TYP86", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0)
                    Citizen.Wait(0)
                end
                if (GetOnscreenKeyboardResult()) then
                    kbdRes = GetOnscreenKeyboardResult()
                else
                    menu.close()
                    return
                end
                
                if #(kbdRes) >= 1 then
                    TriggerServerEvent("redemrp_bossmenu:server:OpenLockerID", tonumber(kbdRes))
                else
                    RedEM.Functions.NotifyLeft("Invalid entry!", "Enter a valid ID.", "menu_textures", "menu_icon_alert", 4000)
                    menu.close()
                end
            elseif data.current.value == 'ledger' then
                local elements = {
                    {label = "Deposit Money", value = 'deposit', desc = "Deposit an amount"},
                    {label = "Withdraw Money", value = 'withdraw', desc = "Withdraw an amount"},
                }
        
                MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_ledger', {
                    title = "Ledger",
                    subtext = 'Balance:<br/><span style="color:limegreen;font-size:18pt">$'..ledgerAmt..'</span>',
                    align = 'top-right',
                    elements = elements,
                },
                function(data, menu)
                    if data.current.value == 'deposit' then
                        MenuData.CloseAll()
                        AddTextEntry("FMMC_MPM_TYP3", "Deposit Amount $")
                        DisplayOnscreenKeyboard(3, "FMMC_MPM_TYP3", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Citizen.Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            kbdRes = GetOnscreenKeyboardResult()
                        else
                            menu.close()
                            return
                        end
                        
                        if #(kbdRes) >= 1 then
                            TriggerServerEvent("redemrp_bossmenu:server:LedgerDeposit", tonumber(kbdRes))
                        else
                            RedEM.Functions.NotifyLeft("Invalid entry!", "Enter a valid amount.", "menu_textures", "menu_icon_alert", 4000)
                            menu.close()
                        end
                    elseif data.current.value == 'withdraw' then
                        MenuData.CloseAll()
                        AddTextEntry("FMMC_MPM_TYP4", "Withdraw Amount $")
                        DisplayOnscreenKeyboard(3, "FMMC_MPM_TYP4", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Citizen.Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            kbdRes = GetOnscreenKeyboardResult()
                        else
                            menu.close()
                            return
                        end
                        
                        if #(kbdRes) >= 1 then
                            TriggerServerEvent("redemrp_bossmenu:server:LedgerWithdraw", tonumber(kbdRes))
                        else
                            RedEM.Functions.NotifyLeft("Invalid entry!", "Enter a valid amount.", "menu_textures", "menu_icon_alert", 4000)
                            menu.close()
                        end
                    end
                end,
                function(data, menu)
                    menu.close()
                end)
            elseif data.current.value == 'personnel' then
                local elements = {
                    {label = "Hire Employee", value = 'hire', desc = "<span style=\"color:limegreen\">Hire someone</span>"},
                    {label = "Set Employee Grade", value = 'setgrade', desc = "Set someone's grade"},
                    {label = "Fire Online Employee", value = 'fire', desc = "<span style=\"color:#fc1c1c\">Fire someone</span>"},
                    {label = "Fire Offline Employee", value = 'fireo', desc = "<span style=\"color:#fc1c1c\">Fire someone who's offline</span>"},
                }
                MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_personnelmenu', {
                    title = "Personnel Management",
                    subtext = "Manage Employees",
                    align = 'top-right',
                    elements = elements,
                },
                function(data, menu)
                    if data.current.value == 'hire' then
                        MenuData.CloseAll()
                        AddTextEntry("FMMC_MPM_TYP5", "New Member ID#:")
                        DisplayOnscreenKeyboard(3, "FMMC_MPM_TYP5", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Citizen.Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            kbdRes = GetOnscreenKeyboardResult()
                        else
                            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
                            return
                        end
                        
                        if #(kbdRes) >= 1 then
                            TriggerServerEvent("redemrp_bossmenu:server:HireMember", kbdRes)
                            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
                        else
                            RedEM.Functions.NotifyLeft("Invalid entry!", "Enter a valid Player ID.", "menu_textures", "menu_icon_alert", 4000)
                            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
                        end
                    elseif data.current.value == 'setgrade' then
                        MenuData.CloseAll()
                        TriggerServerEvent("redemrp_bossmenu:server:GetGradeList")
                    elseif data.current.value == 'fire' then
                        MenuData.CloseAll()
                        TriggerServerEvent("redemrp_bossmenu:server:GetFireList")
                    elseif data.current.value == 'fireo' then
                        MenuData.CloseAll()
                        TriggerServerEvent("redemrp_bossmenu:server:GetOfflineFireList")
                    end
                end,
                function(data, menu)
                    menu.close()
                    TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
                end)
            elseif data.current.value == 'setgrade' then
                MenuData.CloseAll()
                TriggerServerEvent("redemrp_bossmenu:server:GetGradeList")
            elseif data.current.value == 'stash' then
                MenuData.CloseAll()
                TriggerServerEvent("redemrp_bossmenu:server:RequestBossStash")
            end
        end,
        function(data, menu)
            menu.close()
        end)
    end)
end)

RegisterNetEvent("redemrp_bossmenu:client:FinishSetGrade", function()
    AddTextEntry("FMMC_MPM_TYP8", "Rank #:")
    DisplayOnscreenKeyboard(3, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Citizen.Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        kbdRes = GetOnscreenKeyboardResult()
    else
        return
    end
    
    if #(kbdRes) >= 1 then
        TriggerServerEvent("redemrp_bossmenu:server:SetGrade", kbdRes)
    else
        RedEM.Functions.NotifyLeft("Invalid entry!", "Enter a valid Player ID.", "menu_textures", "menu_icon_alert", 4000)
        TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
    end
end)

FiringPlayer = nil
FiringIdentifier = nil
FiringCharID = nil
FiringName = nil
RegisterNetEvent("redemrp_bossmenu:client:ViewFireList", function(FireList)
    TriggerEvent("redemrp_menu_base:getData",function(MenuData)
        MenuData.CloseAll()
        local elements = {}
        for k,v in ipairs(FireList) do
            table.insert(elements, {label = v.char .. " ("..v.name..")", value = v.id, desc = "Fire "..v.name.."?"})
        end

        MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_firelist', {
            title = "Fire Employee",
            subtext = "List of <span style=\"color:lightgreen\">ONLINE</span> Employees",
            align = 'top-right',
            elements = elements,
        },
        function(data, menu)
            FiringPlayer = data.current.value
            FiringName = data.current.label

            local elements = {
                {label = "<span style=\"color:#FF2D2D\">Confirm</span>", value = 'confirm', desc = "Fire "..FiringName.."?"},
                {label = "Cancel", value = 'cancel', desc = "Cancel this action."},
            }

            MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_firelistconfirm', {
                title = "Fire Employee",
                subtext = "Are you sure?",
                align = 'top-right',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "confirm" then
                    TriggerServerEvent("redemrp_bossmenu:server:FireMember", FiringPlayer)
                elseif data.current.value == "cancel" then
                    menu.close()
                end
            end,
            function(data, menu)
                menu.close()
            end)
        end,
        function(data, menu)
            menu.close()
            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
        end)
    end)
end)

GradePlayer = nil
GradeIdentifier = nil
GradeCharID = nil
GradeName = nil
RegisterNetEvent("redemrp_bossmenu:client:ViewGradeList", function(GradeList)
    TriggerEvent("redemrp_menu_base:getData",function(MenuData)
        MenuData.CloseAll()
        local elements = {}
        for k,v in ipairs(GradeList) do
            table.insert(elements, {label = v.char .. " ("..v.name..")", value = v.id, desc = "Fire "..v.name.."?"})
        end

        MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_gradelist', {
            title = "Change Employee Grade",
            subtext = "List of <span style=\"color:lightgreen\">ONLINE</span> Employees",
            align = 'top-right',
            elements = elements,
        },
        function(data, menu)
            GradePlayer = data.current.value
            GradeName = data.current.label

            local elements = {
                {label = "<span style=\"color:#FF2D2D\">Confirm</span>", value = 'confirm', desc = "Change Rank?"},
                {label = "Cancel", value = 'cancel', desc = "Cancel this action."},
            }

            MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_gradelistconfirm', {
                title = "Change Employee Grade",
                subtext = "Are you sure?",
                align = 'top-right',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "confirm" then
                    --GRADE STUFF
                    MenuData.CloseAll()
                    AddTextEntry("FMMC_MPM_TYP86", "Employee grade to change to:")
                    DisplayOnscreenKeyboard(3, "FMMC_MPM_TYP86", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Citizen.Wait(0)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        kbdRes = GetOnscreenKeyboardResult()
                    else
                        menu.close()
                        return
                    end
                    
                    if #(kbdRes) >= 1 then
                        TriggerServerEvent("redemrp_bossmenu:server:SetGrade", GradePlayer, tonumber(kbdRes))
                    else
                        RedEM.Functions.NotifyLeft("Invalid entry!", "Enter a valid grade.", "menu_textures", "menu_icon_alert", 4000)
                        menu.close()
                    end
                elseif data.current.value == "cancel" then
                    menu.close()
                end
            end,
            function(data, menu)
                menu.close()
            end)
        end,
        function(data, menu)
            menu.close()
            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
        end)
    end)
end)

RegisterNetEvent("redemrp_bossmenu:client:ViewOfflineFireList", function(FireList)
    TriggerEvent("redemrp_menu_base:getData",function(MenuData)
        MenuData.CloseAll()
        local elements = {}
        for k,v in ipairs(FireList) do
            table.insert(elements, {label = v.char .. " ("..v.name..")", id = v.id, charid = v.charid, desc = "Fire "..v.name.."?"})
        end

        MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_ofirelist', {
            title = "Fire Employee",
            subtext = "List of <span style=\"color:red\">OFFLINE</span> Employees",
            align = 'top-right',
            elements = elements,
        },
        function(data, menu)
            FiringIdentifier = data.current.id
            FiringCharID = data.current.charid
            FiringName = data.current.label

            local elements = {
                {label = "<span style=\"color:#FF2D2D\">Confirm</span>", value = 'confirm', desc = "Fire "..FiringName.."?"},
                {label = "Cancel", value = 'cancel', desc = "Cancel this action."},
            }

            MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_ofirelistconfirm', {
                title = "Fire Employee",
                subtext = "Are you sure?",
                align = 'top-right',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "confirm" then
                    TriggerServerEvent("redemrp_bossmenu:server:FireMemberOffline", FiringIdentifier, FiringCharID)
                elseif data.current.value == "cancel" then
                    menu.close()
                end
            end,
            function(data, menu)
                menu.close()
            end)
        end,
        function(data, menu)
            menu.close()
            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
        end)
    end)
end)

SetGradePlayer = nil
SetGradeName = nil
SetGradeNumber = nil
RegisterNetEvent("redemrp_bossmenu:client:ViewGradeList", function(FireList)
    TriggerEvent("redemrp_menu_base:getData",function(MenuData)
        MenuData.CloseAll()
        local elements = {}
        for k,v in ipairs(FireList) do
            table.insert(elements, {label = v.char .. " ("..v.name..")", value = v.id, desc = "Change the grade of "..v.name.."?"})
        end

        MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_gradelist', {
            title = "Set Employee Grade",
            subtext = "List of <span style=\"color:lightgreen\">ONLINE</span> Employees",
            align = 'top-right',
            elements = elements,
        },
        function(data, menu)
            SetGradePlayer = data.current.value
            SetGradeName = data.current.label

            local elements = {}
            for k,v in ipairs(Config.Jobs[PlayerJob].Grades) do
                table.insert(elements, {label = "[Rank "..k.."] "..v.Name, value = k, desc = "Set<br/><span style=\"color:orange\">"..SetGradeName.."</span><br/> grade to:<br/>"..v.Name})
            end

            table.insert(elements, {label = "Cancel", value = 'cancel', desc = "Cancel this action."})

            MenuData.Open('default', GetCurrentResourceName(), 'bossmenu_gradelistconfirm', {
                title = "Set Employee Grade",
                subtext = "Are you sure?",
                align = 'top-right',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "cancel" then
                    menu.close()
                else
                    TriggerServerEvent("redemrp_bossmenu:server:SetGrade", SetGradePlayer, data.current.value)
                end
            end,
            function(data, menu)
                menu.close()
            end)
        end,
        function(data, menu)
            menu.close()
            TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
        end)
    end)
end)

Citizen.CreateThread(function()
    while true do
        Wait(2)
        if Timeout then
            if GetGameTimer() - Timeout > 2000 then
                Timeout = nil
            end
        end
        if PlayerJob and PlayerJobgrade then
            if Config.Jobs[PlayerJob] then
                local PlayerPos = GetEntityCoords(PlayerPedId())
                FoundSomething = false
                for k,v in ipairs(Config.Jobs[PlayerJob].MenuLocations) do
                    local showPrompt = true
                    if Config.Jobs[PlayerJob].ShowPrompt then
                        if Config.Jobs[PlayerJob].ShowPrompt == false then
                            showPrompt = false
                        end
                    end
                    if showPrompt then
                        if #(PlayerPos - v) < 6.0 then
                            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, v.x, v.y, v.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.1, 128, 64, 0, 64, 0, 0, 2, 0, 0, 0, 0) --DrawMarker
                        end
                        if #(PlayerPos - v) < 1.0 then
                            NearAnything = true
                            FoundSomething = true
                            if not BossMenuPromptShown then
                                print("Showing boss menu prompt")
                                PromptSetEnabled(BossMenuPrompt, true)
                                PromptSetVisible(BossMenuPrompt, true)
                                BossMenuPromptShown = true
                            end
                            if PromptHasHoldModeCompleted(BossMenuPrompt) and not Timeout then
                                TriggerServerEvent("redemrp_bossmenu:server:RequestBossMenu")
                                Timeout = GetGameTimer()
                            end
                        end
                    end
                end
                if not FoundSomething then
					NearAnything = false
					if BossMenuPromptShown then
						print("Hiding boss menu prompt")
						PromptSetEnabled(BossMenuPrompt, false)
						PromptSetVisible(BossMenuPrompt, false)
						BossMenuPromptShown = false
					end
				end
            end
        else
            Wait(1000)
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    PromptDelete(BossMenuPrompt)
end)
