local smokinggroup = GetRandomIntInRange(0, 0xffffff)
local PromptJaranie1
local PromptJaranie2
local PromptEnd

RegisterCommand("smoke", function(source, args, rawCommand)
    if (args[1] == "dev") then
    TriggerEvent("ncrp_smokeanim:Start", "p_cigarette_cs01x")
    elseif (args[1] == "dev2") then
    TriggerEvent("ncrp_smokeanim:Start", "p_cigar01x")
    end
end, false)


function Jaranie1()
    Citizen.CreateThread(function()
        local str = 'Take a Puff'
        PromptJaranie1 = PromptRegisterBegin()
        PromptSetControlAction(PromptJaranie1, 0x07CE1E61)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PromptJaranie1, str)
        PromptSetEnabled(PromptJaranie1, true)
        PromptSetVisible(PromptJaranie1, true)
        PromptSetStandardMode(PromptJaranie1, 1)
        PromptSetGroup(PromptJaranie1, smokinggroup)
        PromptRegisterEnd(PromptJaranie1)
    end)
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end


function Jaranie2()
    Citizen.CreateThread(function()
        local str = 'Take a Drag'
        PromptJaranie2 = PromptRegisterBegin()
        PromptSetControlAction(PromptJaranie2, 0xF84FA74F)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PromptJaranie2, str)
        PromptSetEnabled(PromptJaranie2, true)
        PromptSetVisible(PromptJaranie2, true)
        PromptSetStandardMode(PromptJaranie2, 1)
        PromptSetGroup(PromptJaranie2, smokinggroup)
        PromptRegisterEnd(PromptJaranie2)
    end)
end


function JaranieEnd()
    Citizen.CreateThread(function()
        local str = 'Finish'
        PromptEnd = PromptRegisterBegin()
        PromptSetControlAction(PromptEnd, 0x8E90C7BB)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PromptEnd, str)
        PromptSetEnabled(PromptEnd, true)
        PromptSetVisible(PromptEnd, true)
        PromptSetStandardMode(PromptEnd, 1)
        PromptSetGroup(PromptEnd, smokinggroup)
        PromptRegisterEnd(PromptEnd)
    end)
end

  Citizen.CreateThread(function()
  Wait(2000)
  Jaranie1()
  Jaranie2()
  JaranieEnd()
  end)

function LoadDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end

end

RegisterNetEvent('ncrp_smokeanim:Start')
AddEventHandler('ncrp_smokeanim:Start', function(prop)
   Smoking(prop)
end)

function Smoking(prop)
    Citizen.CreateThread(function()
        LoadDict("amb_rest@world_human_smoking@male_d@idle_b")
        LoadDict("amb_rest@world_human_smoking@male_c@stand_enter")
        LoadDict("amb_rest@world_human_smoking@male_c@walk_exit")
        LoadDict("amb_rest@world_human_smoking@male_d@idle_c")
        LoadDict("amb_rest@world_human_smoking@male_d@idle_a")

        LoadDict("amb_rest@world_human_smoke_cigar@male_a@idle_a")
        LoadDict("amb_rest@world_human_smoke_cigar@male_a@idle_b")

        -- ENTITY ATTATCH
        local playerPed = PlayerPedId()
            local pos = GetEntityCoords(playerPed)
            local prop2 = GetHashKey(prop)
            local tempObj2 = CreateObject(prop2, pos.x, pos.y, pos.z, true, true, false)
            while not HasModelLoaded( prop2 ) do
                Wait(500)
                modelrequest( prop2 )
            end
            if prop == "p_cigarette_cs01x" then
            Citizen.InvokeNative(0x3BBDD6143FF16F98, playerPed, tempObj2, "p_cigarette_cs01x_PH_R_HAND", "WORLD_HUMAN_SMOKE", "WORLD_HUMAN_SMOKE_MALE_C", 1)
            elseif prop == "p_cigar01x" then
            Citizen.InvokeNative(0x3BBDD6143FF16F98, playerPed, tempObj2, "p_cigar01x_PH_R_HAND", "WORLD_HUMAN_SMOKE_CIGAR", 0, 1)
            else
        end

        TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_c@stand_enter", "enter_back", 1.0, 8.0, -1, 31, 0, false, false, false)
        Wait(7500)
        TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_d@idle_b", "idle_d", 1.0, 8.0, -1, 31, 0, false, false, false)
        while true do
            Wait(1)
			local SmokingName = CreateVarString(10, 'LITERAL_STRING', "Smoking")
            PromptSetActiveGroupThisFrame(smokinggroup, SmokingName)


            if PromptIsJustPressed(PromptJaranie1) then
                TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_d@idle_a", "idle_a", 1.0, 8.0, -1, 31, 0, false, false, false)
                Wait(10000)
                TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_d@idle_b", "idle_d", 1.0, 8.0, -1, 31, 0, false, false, false)
            end

            if PromptIsJustPressed(PromptJaranie2) then
                TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_d@idle_c", "idle_g", 1.0, 8.0, -1, 31, 0, false, false, false)
                Wait(7500)
                TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_d@idle_b", "idle_d", 1.0, 8.0, -1, 31, 0, false, false, false)
            end

            if PromptIsJustPressed(PromptEnd) then
                TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_smoking@male_c@walk_exit", "exit_back", 1.0, 8.0, -1, 31, 0, false, false, false)
                Wait(4000)
                ClearPedTasks(PlayerPedId())
                ClearPedTasks(playerPed)
                DeleteObject(tempObj2)
                break
            end

        end
    end)
end