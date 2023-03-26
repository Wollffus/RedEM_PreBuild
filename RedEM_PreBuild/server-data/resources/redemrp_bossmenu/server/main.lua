RedEM = exports["redem_roleplay"]:RedEM()

SettingGrade = {}
Duty = {}
JobLedgers = {}
DutyCommandTimer = {}

Citizen.CreateThread(function()
    Wait(100)
    local ledgerfile = LoadResourceFile(GetCurrentResourceName(), 'ledgers.json')
    JobLedgers = json.decode(ledgerfile)
    print("Job ledgers loaded.")
end)

Citizen.CreateThread(function()
    while true do
        Wait(900000) -- 15 minutes
        DoPay()
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(900000 * 4) -- 15 minutes * 4 = 1 Hour
        DoPublicPay()
    end
end)

RegisterCommand("quitjob", function(source, args)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.job ~= "unemployed" then
            Player.SetJob("unemployed")
            Player.SetJobGrade(0)
            RedEM.Functions.NotifyRight(source, "You are now unemployed!", 5000)
        end
    end
end)

AddEventHandler("redemrp:playerLoaded", function(source, user)
    TriggerClientEvent("redemrp_bossmenu:client:ReceiveJob", source, user.getJob(), user.getJobgrade())
end)

function DoPay()
    for _,playerId in ipairs(GetPlayers()) do
        local id = tonumber(playerId)
        if Duty[id] then
            local user = RedEM.GetPlayer(id)
            if user then
                local job, grade = user.getJob(), user.getJobgrade()
                if Config.Jobs[job] then
                    if Config.Jobs[job].Grades[grade] then
                        if Config.Jobs[job].Grades[grade].Pay then
                            local pay = Config.Jobs[job].Grades[grade].Pay
                            RedEM.Functions.NotifyRight(id, "You received <strong style=\"color:lime\">$"..RedEM.Functions.CommaValue(string.format("%.2f", pay)).."</strong> from your government job!", 10000)
                            TriggerClientEvent("RedEM:client:PlaySound", id, 1)
                            user.AddMoney(pay)
                        end
                    end
                else
                    local pay = 2
                    RedEM.Functions.NotifyRight(id, "You received <strong style=\"color:lime\">$"..RedEM.Functions.CommaValue(string.format("%.2f", pay)).."</strong> from the government!", 10000)
                    TriggerClientEvent("RedEM:client:PlaySound", id, 1)
                    user.AddMoney(pay) -- If player doesn't have a job, give them universal basic income
                end
            end
        end
    end
end

function DoPublicPay()
    for _,playerId in ipairs(GetPlayers()) do
        local id = tonumber(playerId)
        local user = RedEM.GetPlayer(id)
        if user then
            TriggerClientEvent("RedEM:client:PlaySound", id, 1)
            user.AddMoney(2.5)
        end
    end
end

AddEventHandler('playerDropped', function(reason)
    local _source = source
    if Duty[_source] then
        Duty[_source] = nil
    end
end)

RegisterCommand("getjob", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.GetGroup() == "admin" or user.GetGroup() == "superadmin" then
        if args[1] ~= nil then
            local tuser = RedEM.GetPlayer(args[1])
            if tuser then
                local gradename = tuser.jobgrade
                if Config.Jobs[tuser.job] then
                    if Config.Jobs[tuser.job].Grades[tuser.jobgrade] then
                        if Config.Jobs[tuser.job].Grades[tuser.jobgrade].Name then
                            gradename = Config.Jobs[tuser.job].Grades[tuser.jobgrade].Name .. " ("..tuser.jobgrade..")"
                        end
                    end
                end
                local jobname = tuser.job
                if Config.Jobs[tuser.job] then
                    if Config.Jobs[tuser.job].Name then
                        jobname = Config.Jobs[tuser.job].Name
                    end
                end
                if Duty[source] then
                    RedEM.Functions.NotifyRight( source, "<br/><strong>Current Job for "..tuser.GetName().."</strong><br/>"..jobname.." ("..tuser.job..")<br/>"..gradename.." [ON DUTY]", 5000)
                else
                    RedEM.Functions.NotifyRight( source, "<br/><strong>Current Job for "..tuser.GetName().."</strong><br/>"..jobname.." ("..tuser.job..")<br/>"..gradename.." [OFF DUTY]", 5000)
                end
            end
        else
            RedEM.Functions.NotifyRight( source, "/getjob [Player ID]", 3000)
        end
    else
        RedEM.Functions.NotifyRight( source, "Insufficient permissions.", 3000)
    end
end, false)

function GetJobDuty(playerId)
    if Duty[playerId] then
        return true
    else return false end
end
exports("GetJobDuty", GetJobDuty)

RegisterCommand("job", function(source, args)
    local user = RedEM.GetPlayer(source)
    local job = user.job
    if job == "unemployed" then
        RedEM.Functions.NotifyRight( source, "You are unemployed!", 3000)
    else
        local gradename = "Rank UNKNOWN (".. user.jobgrade..")"
        if type(grade) == "string" then grade = tonumber(grade) end
        if Config.Jobs[user.job] then
            if Config.Jobs[user.job].Grades[user.jobgrade] then
                if Config.Jobs[user.job].Grades[user.jobgrade].Name then
                    gradename = Config.Jobs[user.job].Grades[user.jobgrade].Name .. " ("..user.jobgrade..")"
                end
            end
        end

        local jobname = user.job
        if Config.Jobs[user.job] then
            if Config.Jobs[user.job].Name then
                jobname = Config.Jobs[user.job].Name
            end
        end
        if Duty[source] then
            RedEM.Functions.NotifyRight( source, "<br/><strong>Current Job</strong><br/>"..jobname.." ("..user.job..")<br/>"..gradename.." [ON DUTY]", 5000)
        else
            RedEM.Functions.NotifyRight( source, "<br/><strong>Current Job</strong><br/>"..jobname.." ("..user.job..")<br/>"..gradename.." [OFF DUTY]", 5000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:RequestJob", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    if user then
        TriggerClientEvent("redemrp_bossmenu:client:ReceiveJob", _source, user.getJob(), user.getJobgrade())
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:LogoutOffDuty", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job = user.getJob()
    if Duty[_source] then
        if job == "police" or job == "police2" or job == "police3" or job == "police4" or job == "police5" or job == "marshal" or job == "court" or job == "ranger" then
            Duty[_source] = false
            TriggerEvent("redemrp_dutybot:server:toggleDuty", _source)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:ToggleDuty", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job = user.GetJob()
    if not Duty[_source] then
        Duty[_source] = true
        TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Job Duty', 'lightgreen', 
                "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " went **ON** duty for job "..user.getJob())
        RedEM.Functions.NotifyRight( source, "You are now on duty!", 3000)
        if job == "police" or job == "police2" or job == "police3" or job == "police4" or job == "police5" or job == "marshal" or job == "court" or job == "ranger" then
            TriggerEvent("redemrp_dutybot:server:toggleDuty", _source)
        end
    else
        TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Job Duty', 'red', 
            "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " went **OFF** duty for job "..user.getJob())
        Duty[_source] = false
        RedEM.Functions.NotifyRight( source, "You are now off duty!", 3000)
        if job == "police" or job == "police2" or job == "police3" or job == "police4" or job == "police5" or job == "marshal" or job == "court" or job == "ranger" then
            TriggerEvent("redemrp_dutybot:server:toggleDuty", _source)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:RequestBossMenu", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade] then
            TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
        else
            RedEM.Functions.NotifyRight( _source, "Your job rank is invalid, contact staff!", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:HireMember", function(targetId)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local targetUser = RedEM.GetPlayer(targetId)
            if targetUser then
                local targetJob = targetUser.GetJob()
                if targetJob == "unemployed" then
                    targetUser.SetJob(job)
                    targetUser.SetJobGrade(1)
                    TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Hired Employee', 'lightgreen', 
                        "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " hired "..
                        "["..targetId.."] **"..targetUser.GetFirstName().." "..targetUser.GetLastName().. "** (serverid: "..targetId.." | name: ".. GetPlayerName(targetId).." | steamid: "..targetUser.GetIdentifier().." | characterid: "..targetUser.GetActiveCharacter()..") into job "..job)
                    TriggerClientEvent("redem_roleplay:JobChange", _source, job)
                    RedEM.Functions.NotifyLeft(_source, "Employee hired!", "You hired "..targetUser.GetFirstName().." "..targetUser.GetLastName().."!", "menu_textures", "menu_icon_tick", 3000)
                    if not JobLedgers[job] then
                        JobLedgers[job] = 0
                    end
                    TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                else
                    RedEM.Functions.NotifyLeft(_source, "Already employed!", "This player has a job already!", "menu_textures", "menu_icon_alert", 3000)
                end
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:GetFireList", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local FireList = {}
            for _,targetId in ipairs(GetPlayers()) do
                local targetUser = RedEM.GetPlayer(targetId)
                if targetUser then
                    local targetJob = targetUser.GetJob()
                    if targetJob == job then
                        local targetName = targetUser.GetFirstName() .. " " .. targetUser.GetLastName()
                        local serverName = GetPlayerName(tonumber(targetId))
                        table.insert(FireList, {char = targetName, name = serverName, id = tonumber(targetId)})
                    end
                end
            end
            TriggerClientEvent("redemrp_bossmenu:client:ViewFireList", _source, FireList)
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)
RegisterServerEvent("redemrp_bossmenu:server:GetGradeList", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local GradeList = {}
            for _,targetId in ipairs(GetPlayers()) do
                local targetUser = RedEM.GetPlayer(targetId)
                if targetUser then
                    local targetJob = targetUser.GetJob()
                    local targetGrade = targetUser.GetJobGrade()
                    if targetJob == job and targetGrade < grade then
                        local targetName = targetUser.GetFirstName() .. " " .. targetUser.GetLastName()
                        local serverName = GetPlayerName(tonumber(targetId))
                        table.insert(GradeList, {char = targetName, name = serverName, id = tonumber(targetId)})
                    end
                end
            end
            TriggerClientEvent("redemrp_bossmenu:client:ViewGradeList", _source, GradeList)
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:GetOfflineFireList", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()

    local OnlineIds = {}
    for k,v in ipairs(GetPlayers()) do
        local targetUser = RedEM.GetPlayer(v)
        if targetUser then
            table.insert(OnlineIds, {id = targetUser.GetIdentifier(), charid = targetUser.GetActiveCharacter()})
        end
    end

    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local FireList = {}
            local Employees = MySQL.query.await("SELECT * FROM characters WHERE job = :job", { job = job })
            for _,Employee in pairs(Employees) do
                local continue = true
                for k,v in pairs(OnlineIds) do
                    if v.id == Employee.identifier and tonumber(v.characterid) == tonumber(Employee.charid) then
                        continue = false
                    end
                end
                if continue then
                    table.insert(FireList, {char = Employee.firstname.." "..Employee.lastname, name = "OFFLINE", id = Employee.identifier, charid = Employee.characterid})
                end
            end
            TriggerClientEvent("redemrp_bossmenu:client:ViewOfflineFireList", _source, FireList)
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:FireMemberOffline", function(id, charid)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local Employee = MySQL.query.await("SELECT * FROM characters WHERE identifier = :identifier AND characterid = :charid", { identifier = id, charid = charid })
            if Employee[1] then
                Employee = Employee[1]
                if Employee.identifier == id and Employee.characterid == charid then
                    MySQL.query.await("UPDATE characters SET job = 'unemployed', jobgrade = 0 WHERE identifier = :identifier AND characterid = :charid", { identifier = id, charid = charid })
                    RedEM.Functions.NotifyLeft(_source, "Employee fired!", "You fired "..Employee.firstname.." "..Employee.lastname.. "!", "menu_textures", "menu_icon_tick", 3000)
                    TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Fired Employee', 'red', 
                            "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().."** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " fired "..
                            "[OFFLINE] **"..Employee.firstname.." "..Employee.lastname.. "** (name: OFFLINE | steamid: "..Employee.identifier.." | characterid: "..Employee.characterid..") from job "..job)
                    if not JobLedgers[job] then
                        JobLedgers[job] = 0
                    end
                    TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                end
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:GetGradeList", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local GradeList = {}
            for _,targetId in ipairs(GetPlayers()) do
                local targetUser = RedEM.GetPlayer(targetId)
                if targetUser then
                    local targetJob = targetUser.GetJob()
                    if targetJob == job then
                        local targetName = targetUser.GetFirstName() .. " " .. targetUser.GetLastName()
                        local serverName = GetPlayerName(tonumber(targetId))
                        table.insert(GradeList, {char = targetName, name = serverName, id = tonumber(targetId)})
                    end
                end
            end
            TriggerClientEvent("redemrp_bossmenu:client:ViewGradeList", _source, GradeList)
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:FireMember", function(targetId)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local targetUser = RedEM.GetPlayer(targetId)
            local targetJob = targetUser.GetJob()
            if targetUser.identifier == user.identifier then
                TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                return RedEM.Functions.NotifyLeft(_source, "Error", "You can't fire yourself!", "menu_textures", "menu_icon_alert", 3000)
            end
            if targetJob == job then
                if targetUser.jobgrade >= grade then
                    TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                    return RedEM.Functions.NotifyLeft(_source, "Error", "You can't fire a higher or equal rank!", "menu_textures", "menu_icon_alert", 3000)
                end
                targetUser.SetJob("unemployed")
                targetUser.SetJobGrade(0)
                TriggerClientEvent("redem_roleplay:JobChange", _source, "unemployed")
                RedEM.Functions.NotifyLeft(_source, "Employee fired!", "You fired "..targetUser.GetFirstName().." "..targetUser.GetLastName().."!", "menu_textures", "menu_icon_tick", 3000)
                TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Fired Employee', 'red', 
                        "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " fired "..
                        "["..targetId.."] **"..targetUser.GetFirstName().." "..targetUser.GetLastName().. "** (serverid: "..targetId.." | name: ".. GetPlayerName(targetId).." | steamid: "..targetUser.GetIdentifier().." | characterid: "..targetUser.GetActiveCharacter()..") from job "..job)
                TriggerClientEvent("redemrp_bossmenu:client:ViewGradeList", _source, GradeList)
            else
                RedEM.Functions.NotifyLeft(_source, "Not your employee!", "This player doesn't work for you!", "menu_textures", "menu_icon_alert", 3000)
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:TrySetGrade", function(targetId)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            local targetUser = RedEM.GetPlayer(targetId)
            local targetJob = targetUser.GetJob()
            local targetGrade = targetUser.GetJobGrade()
            if targetJob == job and targetGrade <= grade then
                TriggerClientEvent("redemrp_bossmenu:client:FinishSetGrade", _source)
                SettingGrade[_source] = targetId
            else
                RedEM.Functions.NotifyLeft(_source, "Not your employee!", "This player doesn't work for you!", "menu_textures", "menu_icon_alert", 3000)
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterNetEvent("redemrp_bossmenu:server:SetGrade", function(targetId, gradeId)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if tonumber(targetId) == tonumber(_source) then
        return RedEM.Functions.NotifyLeft(_source, "Error", "You can't set your own grade!", "menu_textures", "menu_icon_alert", 3000)
    end
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Personnel then
            if targetId then
                local targetUser = RedEM.GetPlayer(targetId)
                local targetJob = targetUser.getJob()
                if targetJob == job and gradeId <= grade then
                    if Config.Jobs[job].Grades[tonumber(gradeId)] then
                        targetUser.SetJobGrade(tonumber(gradeId))
                        TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Grade Set', 'lightgreen', 
                        "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " set "..
                        "["..targetId.."] **"..targetUser.GetFirstName().." "..targetUser.GetLastName().. "** (serverid: "..targetId.." | name: ".. GetPlayerName(targetId).." | steamid: "..targetUser.GetIdentifier().." | characterid: "..targetUser.GetActiveCharacter()..") job grade to: "..job.." grade "..gradeId)
                        RedEM.Functions.NotifyLeft(_source, "Grade set!", "You set "..targetUser.GetFirstName().." "..targetUser.GetLastName().."'s grade to "..gradeId.."!", "menu_textures", "menu_icon_tick", 3000)
                        RedEM.Functions.NotifyLeft(targetId, "Grade set!", "Your job grade was to "..Config.Jobs[job].Grades[tonumber(gradeId)].Name.." ("..gradeId..")!", "menu_textures", "menu_icon_tick", 3000)
                        if not JobLedgers[job] then
                            JobLedgers[job] = 0
                        end
                        TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                    else
                        RedEM.Functions.NotifyLeft(_source, "Invalid grade!", "That grade doesn't exist!", "menu_textures", "menu_icon_alert", 3000)
                    end
                else
                    RedEM.Functions.NotifyLeft(_source, "Not your employee!", "This player doesn't work for you or cannot be set to this grade!", "menu_textures", "menu_icon_alert", 3000)
                end
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have personnel access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:RequestBossStash", function()
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].StorageAccess then
            TriggerClientEvent("redemrp_inventory:OpenStash", _source, "bossstash_"..job, 3000.0)
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have storage access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:OpenLockerID", function(lockerid)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job, grade = user.GetJob(), user.GetJobGrade()
    if Config.Jobs[job] then
        if Config.Jobs[job].HasLockers then
            TriggerClientEvent("redemrp_inventory:OpenStash", _source, "policelocker_"..lockerid, 1000.0)
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have storage access!", "menu_textures", "menu_icon_alert", 3000)
        end
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:LedgerDeposit", function(amount)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job = user.GetJob()
    if amount < 0 then return end
    if Config.Jobs[user.job] then
        if Config.Jobs[user.job].Grades[user.jobgrade].Ledger then
            if user.GetMoney() >= amount then
                user.RemoveMoney(amount)
                if not JobLedgers[job] then
                    JobLedgers[job] = 0
                end
                JobLedgers[job] = JobLedgers[job] + amount
                TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Ledger Deposit', 'lightgreen', 
                "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " deposited **$"..amount.."** into "..job.." ledger. New balance: "..JobLedgers[job])
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have ledger access!", "menu_textures", "menu_icon_alert", 3000)
        end
    else
        print("Job nil")
    end
end)

RegisterServerEvent("redemrp_bossmenu:server:LedgerWithdraw", function(amount)
    local _source = source
    local user = RedEM.GetPlayer(_source)
    local job = user.GetJob()
    local grade = user.GetJobGrade()
    if amount < 0 then return end
    if Config.Jobs[job] then
        if Config.Jobs[job].Grades[grade].Ledger then
            if not JobLedgers[job] then
                JobLedgers[job] = 0
            end
            if JobLedgers[job] >= amount then
                user.AddMoney(amount)
                JobLedgers[job] = JobLedgers[job] - amount
                TriggerClientEvent("redemrp_bossmenu:client:OpenBossMenu", _source, JobLedgers[job])
                TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Ledger Withdrawal', 'red', 
                "[".._source.."] **"..user.GetFirstName().." "..user.GetLastName().. "** (serverid: ".._source.." | name: ".. GetPlayerName(_source).." | steamid: "..user.GetIdentifier().." | characterid: "..user.GetActiveCharacter()..")" .. " withdrew **$"..amount.."** from "..job.." ledger. New balance: "..JobLedgers[job])
            end
        else
            RedEM.Functions.NotifyLeft(_source, "No access!", "You don't have ledger access!", "menu_textures", "menu_icon_alert", 3000)
        end
    else
        print("Job nil")
    end
end)

function JobLedgerDeposit(job, amount)
    if Config.Jobs[job] then
        if JobLedgers[job] then
            JobLedgers[job] = JobLedgers[job] + amount
            TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Ledger Deposit by Server', 'red', 
                "**$"..amount.."** was deposited into "..job.." job ledger by the server. New balance: "..JobLedgers[job])
        end
    end
end
exports('JobLedgerDeposit', JobLedgerDeposit)

function JobLedgerWithdraw(job, amount)
    if Config.Jobs[job] then
        if JobLedgers[job] then
            JobLedgers[job] = JobLedgers[job] - amount
            if JobLedgers[job] < 0 then 
                JobLedgers[job] = 0
            end
            TriggerEvent('redemrp_log:server:CreateLog', 'bossmenu', 'Ledger Withdrawal by Server', 'lightgreen', 
                "**$"..amount.."** was withdrawn from "..job.." job ledger by the server. New balance:"..JobLedgers[job])
        end
    end
end
exports('JobLedgerWithdraw', JobLedgerWithdraw)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
			SaveResourceFile(GetCurrentResourceName(), "ledgers.json", json.encode(JobLedgers), -1)
        end
    end
)

AddEventHandler('txAdmin:events:serverShuttingDown', function(eventData)
    CreateThread(function()
        print("^4[DB]^0 5 seconds before restart... saving all ledgers!")
        SaveResourceFile(GetCurrentResourceName(), "ledgers.json", json.encode(JobLedgers), -1)
    end)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        CreateThread(function()
            print("60 seconds before restart... saving all ledgers!")
            SaveResourceFile(GetCurrentResourceName(), "ledgers.json", json.encode(JobLedgers), -1)
        end)
    end
end)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
			SaveResourceFile(GetCurrentResourceName(), "ledgers.json", json.encode(JobLedgers), -1)
        end
    end
)