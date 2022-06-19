if Trigger.BATHING then
local enter_prompt = false
local EnterBathPrompt = nil
local BathMenu = GetRandomIntInRange(0, 0xffffff)
--print('bathgroup: ' .. BathMenu)
local BathMenuName = 'Bath Menu'

local bathgroup = GetRandomIntInRange(0, 0xffffff)
--print('bathgroup: ' .. bathgroup)
local BathName = 'Bath'

local bathingprompts = false
local ScrubLeftLegPrompt = nil
local ScrubRightArmPrompt = nil
local ScrubHeadPrompt = nil
local ScrubHeadPrompt = nil
local ExitBathPrompt = nil
local MenuBathPrompt = nil

Citizen.CreateThread(function()
Wait(2000)
	SetupEnterBathPrompt()
	 Wait(1000)
    SetupScrubLeftLegPrompt()
	 Wait(1000)
    SetupScrubRightArmPrompt()
	 Wait(1000)
    SetupScrubHeadPrompt()
	 Wait(1000)
	SetupExitBathPrompt()
	 Wait(1000)
	SetupBathMenuPrompt()
end)

function SetupEnterBathPrompt()
    Citizen.CreateThread(function()
        local str = 'Take a Bath'
        EnterBathPrompt = PromptRegisterBegin()
        PromptSetControlAction(EnterBathPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(EnterBathPrompt, str)
        PromptSetEnabled(EnterBathPrompt, false)
        PromptSetVisible(EnterBathPrompt, false)
        PromptSetHoldMode(EnterBathPrompt, 1)
        PromptRegisterEnd(EnterBathPrompt)
    end)
end





function SetupScrubLeftLegPrompt()
    Citizen.CreateThread(function()
        local str = 'Scrub your Legs'
        ScrubLeftLegPrompt = PromptRegisterBegin()
        PromptSetControlAction(ScrubLeftLegPrompt, 0xD9D0E1C0)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ScrubLeftLegPrompt, str)
        PromptSetEnabled(ScrubLeftLegPrompt, true)
        PromptSetVisible(ScrubLeftLegPrompt, true)
        PromptSetStandardMode(ScrubLeftLegPrompt, 1)
        PromptSetGroup(ScrubLeftLegPrompt, BathMenu)
        PromptRegisterEnd(ScrubLeftLegPrompt)
    end)
end

function SetupScrubRightArmPrompt()
    Citizen.CreateThread(function()
        local str = 'Scrub your Arms'
        ScrubRightArmPrompt = PromptRegisterBegin()
        PromptSetControlAction(ScrubRightArmPrompt, 0xE30CD707)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ScrubRightArmPrompt, str)
        PromptSetEnabled(ScrubRightArmPrompt, true)
        PromptSetVisible(ScrubRightArmPrompt, true)
        PromptSetStandardMode(ScrubRightArmPrompt, 1)
        PromptSetGroup(ScrubRightArmPrompt, BathMenu)
        PromptRegisterEnd(ScrubRightArmPrompt)
    end)
end

function SetupScrubHeadPrompt()
    Citizen.CreateThread(function()
        local str = 'Scrub your Head'
        ScrubHeadPrompt = PromptRegisterBegin()
        PromptSetControlAction(ScrubHeadPrompt, 0xCEFD9220)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ScrubHeadPrompt, str)
        PromptSetEnabled(ScrubHeadPrompt, true)
        PromptSetVisible(ScrubHeadPrompt, true)
        PromptSetStandardMode(ScrubHeadPrompt, 1)
        PromptSetGroup(ScrubHeadPrompt, BathMenu)
        PromptRegisterEnd(ScrubHeadPrompt)
    end)
end

function SetupExitBathPrompt()
    Citizen.CreateThread(function()
        local str = 'Leave Bath'
        ExitBathPrompt = PromptRegisterBegin()
        PromptSetControlAction(ExitBathPrompt, 0x8E90C7BB)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ExitBathPrompt, str)
        PromptSetEnabled(ExitBathPrompt, true)
        PromptSetVisible(ExitBathPrompt, true)
        PromptSetHoldMode(ExitBathPrompt, true)
        PromptSetGroup(ExitBathPrompt, bathgroup)
        PromptRegisterEnd(ExitBathPrompt)
    end)
end

function SetupBathMenuPrompt()
    Citizen.CreateThread(function()
        local str = 'Bath Menu'
        MenuBathPrompt = PromptRegisterBegin()
        PromptSetControlAction(MenuBathPrompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(MenuBathPrompt, str)
        PromptSetEnabled(MenuBathPrompt, true)
        PromptSetVisible(MenuBathPrompt, true)
        PromptSetStandardMode(MenuBathPrompt, 1)
        PromptSetGroup(MenuBathPrompt, bathgroup)
        PromptRegisterEnd(MenuBathPrompt)
    end)
end

local bathData = {
    {
        coords = vector3(-816.94 , -1322.51 ,  43.68),
        coordsgoto =  vector3(-825.16 , -1321.88 ,  43.68),
        coordstarget =  vector3( -825.16 , -1321.88 ,  43.68),
        cameracoords1 = vector3( -826.02, -1318.83 ,44.45),
        cameracoords2 = vector3( -823.56, -1318.86 ,43.75),
        quitcoords = vector3( -825.16 , -1322.88 , 43.68),
        tp = vector3(-823.28,-1318.6,42.65),
        heading = 105.91
    },

    {
        coords = vector3(-323.69,773.50,117.43),
        coordsgoto =  vector3(-318.82 ,762.45 , 117.7),
        coordstarget =  vector3( -318.82 , 762.45 ,  117.7),
        cameracoords1 = vector3( -318.20, 760.11, 117.94),
        cameracoords2 = vector3( -316.8,761.87,116.80),
        quitcoords = vector3( -316.8,762.87,116.50),
        tp = vector3(-316.8,761.87,116.50),
        heading = 104.09
    },
}
Citizen.CreateThread(function()
    local zone
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for v,k in pairs(bathData) do
            local distance = Vdist(coords, k.coords)
            if distance < 1.5 then
                if enter_prompt == false and not zone then
                    PromptSetEnabled(EnterBathPrompt, true)
                    PromptSetVisible(EnterBathPrompt, true)
                    enter_prompt = true
                    zone = v
                end
            else
                if v == zone then
                    PromptSetEnabled(EnterBathPrompt, false)
                    PromptSetVisible(EnterBathPrompt, false)
                    enter_prompt = false
                    zone = nil
                end
            end
		if distance < 1.5 then
            if PromptHasHoldModeCompleted(EnterBathPrompt) then
                PromptSetEnabled(EnterBathPrompt, false)
                PromptSetVisible(EnterBathPrompt, false)
				ClearPedTasks(PlayerPedId())
				--print( k.coordsgoto.x)
                TaskGoToCoordAnyMeans(PlayerPedId(), k.coordsgoto.x , k.coordsgoto.y , k.coordsgoto.z ,1.0, 0, 0, 0, 1.0)
                while Vdist ( GetEntityCoords(PlayerPedId()), k.coordstarget.x , k.coordstarget.y , k.coordstarget.z)  > 0.75 do
                    Wait(5)
                    N_0xe296208c273bd7f0(-1, -1, 0, 17, 0, 0)
                end
                enter_prompt = false
                zone = nil
                test (v)
            end
		end
        end
    end
end)
		
		
function test (id)
    Citizen.CreateThread(function()
	  local bathmenu_active = true
     local ped = PlayerPedId()
        DoScreenFadeOut(1800)
        Wait(1800)

            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), -1725579161, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0)
			Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
			Wait(100)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7505EF42, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)  
			Wait(100)	
			TriggerEvent('load:czysto')			

        SetEntityCoords(ped, bathData[id].tp)
        SetEntityHeading(ped, bathData[id].heading)

        local dict = "mini_games@bathing@regular@arthur"
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Wait(10)
        end
        camera(bathData[id].cameracoords1.x ,bathData[id].cameracoords1.y,bathData[id].cameracoords1.z,  bathData[id].cameracoords2.x,bathData[id].cameracoords2.y,bathData[id].cameracoords2.z)

        TaskPlayAnim(ped, dict, "bathing_idle_02", 1.0, 8.0, -1, 1, 0, false, false, false)

        Wait(2000)
        DoScreenFadeIn(2000)
        Wait(2000)

        local washed = 0
        local clean1 = false
        local clean2 = falase

        local inbath = true   
        while inbath do
            Wait(0)

            if washed > 1 and not clean1 then
                ClearPedEnvDirt(ped)
                clean1 = true
            elseif washed > 2 and not clean2 then
                Citizen.InvokeNative(0xE3144B932DFDFF65 ,ped, 0.0, -1, 1, 1)
                ClearPedEnvDirt(ped)
                ClearPedDamageDecalByZone(ped ,10 ,"ALL")
                ClearPedBloodDamage(ped)
                Citizen.InvokeNative(0xD8544F6260F5F01E ,ped, 10)
                clean2 = true
            end

            if PromptHasStandardModeCompleted(ScrubRightArmPrompt) then
                TaskPlayAnim(ped, dict, "right_arm_scrub_medium", 1.0, 8.0, -1, 1, 0, false, false, false)
                Wait(5000)       
                TaskPlayAnim(ped, dict, "right_arm_finish", 1.0, 8.0, -1, 1, 0, false, false, false)
                Wait(1500)
                TaskPlayAnim(ped, dict, "bathing_idle_02", 1.0, 8.0, -1, 1, 0, false, false, false)
                bathmenu_active = true
                washed = washed + 1
            elseif PromptHasStandardModeCompleted(ScrubLeftLegPrompt) then
                TaskPlayAnim(ped, dict, "left_leg_scrub_medium", 1.0, 8.0, -1, 1, 0, false, false, false)
                Wait(5000)       
                TaskPlayAnim(ped, dict, "left_leg_finish", 1.0, 8.0, -1, 1, 0, false, false, false)
                Wait(1500)
                TaskPlayAnim(ped, dict, "bathing_idle_02", 1.0, 8.0, -1, 1, 0, false, false, false)
                bathmenu_active = true
                washed = washed + 1
            elseif PromptHasStandardModeCompleted(ScrubHeadPrompt) then
                TaskPlayAnim(ped, dict, "head_scrub_slow_loop", 1.0, 8.0, -1, 1, 0, false, false, false)
                Wait(5000)       
                TaskPlayAnim(ped, dict, "head_scrub_exit", 1.0, 8.0, -1, 1, 0, false, false, false)
                Wait(1500)
                TaskPlayAnim(ped, dict, "bathing_idle_02", 1.0, 8.0, -1, 1, 0, false, false, false)
                bathmenu_active = true
                washed = washed + 1
			elseif PromptHasStandardModeCompleted(MenuBathPrompt) then
				bathmenu_active = false  			  			  
            elseif PromptHasHoldModeCompleted(ExitBathPrompt) then
                DoScreenFadeOut(1800)
                Wait(1800)
                TriggerServerEvent("redemrp_skin:loadSkin")
                ClearPedTasks(ped)
                SetEntityCoords(ped, bathData[id].quitcoords)
                destory()

                Wait(5000)
                DoScreenFadeIn(2000)
                inbath = false
				enter_prompt = false 
            else
                if bathmenu_active == true then
					local test  = CreateVarString(10, 'LITERAL_STRING', "Bath")
					        N_0xe296208c273bd7f0(-1, -1, 0, 17, 0, 0)
                    PromptSetActiveGroupThisFrame(bathgroup, test)
                else
				local test2  = CreateVarString(10, 'LITERAL_STRING', "Bath Menu")
				        N_0xe296208c273bd7f0(-1, -1, 0, 17, 0, 0)
                    PromptSetActiveGroupThisFrame(BathMenu, test2)
                end
            end

        end
		end)
    end


function camera(x, y, z, lx, ly, lz)
	local _x, _y, _z, _lx, _ly, _lz = x, y, z, lx, ly, lz

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", _x, _y, _z, 300.00,0.00,0.00, 40.00, false, 0)
	PointCamAtCoord(cam, _lx, _ly, _lz)
	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)
	DisplayHud(false)
	DisplayRadar(false)
end

function destory()
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 0, true, true)
    DisplayHud(true)
    DisplayRadar(true)
	DestroyAllCams(true)
	cam = nil
end
end
