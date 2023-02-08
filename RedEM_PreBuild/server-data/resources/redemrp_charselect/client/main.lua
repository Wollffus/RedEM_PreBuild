RedEM = exports["redem_roleplay"]:RedEM()

local characters = {}
local PlayerSkins = {}
local PlayerClothes = {}
local PlayerSex = {}
local Cameras = {}
local CharScene = 1
local CanChangeCamera = true
local ActiveCam = nil
local CharsList = nil
local SelectingChar = nil
local SelectingPed = nil
local LightOn = false

local effectName

local MenuData

TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

RegisterNetEvent('redemrp_charselect:SpawnCharacter', function(new)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    DestroyAllCams()
    TriggerServerEvent("redemrp_respawn:CheckPos")
end)

local isHidden = false

Citizen.CreateThread(function()
    while true do
        local isRadarHidden = IsRadarHidden()

        if isRadarHidden and not isHidden then
            SendNUIMessage({type = 2})
            isHidden = true
        elseif not isRadarHidden and isHidden then
            SendNUIMessage({type = 3})
            isHidden = false
        end
        Citizen.Wait(100)
    end
end)

local loadingscreenremoved = false

RegisterNetEvent('redemrp_charselect:removeLoadingScreen', function()
    if not loadingscreenremoved then
        OpenCharacterMenu()
        loadingscreenremoved = true
    end
end)

OpenCharacterMenu = function()
    MenuData.CloseAll()
    local elements = {}
    for k,v in ipairs(CharsList) do
        if v.citizenid then
            if #v.citizenid ~= 7 then
                table.insert(elements, {label = "<strong>"..v.firstname .. " " .. v.lastname.."</strong>", desc = v.characterid, image="items/character_exists.png", value = v.characterid})
            else
                table.insert(elements, {label = "<strong>"..v.firstname .. " " .. v.lastname.."</strong>", desc = v.characterid, image="items/character_exists.png", value = v.characterid})
            end
        else
            table.insert(elements, {label = "<strong>"..v.firstname .. " " .. v.lastname.."</strong>", desc = v.characterid, image="items/character_exists.png", value = v.characterid})
        end
    end
    table.insert(elements, {label = "<strong>Create a New Character</strong>", desc = "Create a new character.", image="items/character_new.png", value = "new"})
    MenuData.Open('default', GetCurrentResourceName(), 'charselect', {
        title    = "REDEM:RP 2023",
        subtext  = "Character Selection",
        align    = 'top-right',
        opacity  = '0.95',
        elements = elements,
    },
    function(data, menu)
        if data.current.value == "new" then
            if #CharsList < 4 then
                MenuData.CloseAll()
                SendNUIMessage({
                    new = true
                })
                SetNuiFocus(true, true)
            else
                RedEM.Functions.NotifyLeft("Character Limit Reached!", "You can't have more than 4 characters!", "menu_textures", "menu_icon_alert", 3000)
            end
        else
            print("Selecting character "..data.current.value)
            SelectingChar = data.current.value
            local elements = {
                {label = "Select Character", desc = "Spawn into this character?", image="items/charsel_confirm.png",value = "select"},
                {label = "Delete Character", desc = "Delete this character?", image="items/charsel_delete.png", value = "delete"}
            }
            MenuData.Open('default', GetCurrentResourceName(), 'charselect2', {
                title    = "REDEM:RP",
                subtext  = "Character Selection",
                align    = 'top-right',
                opacity  = '0.95',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "select" then
                    while not CanChangeCamera do Wait(100) end
                    TriggerServerEvent("redemrp:selectCharacter", SelectingChar)
                elseif data.current.value == "delete" then
                    local elements = {
                        {label = "<span style=\"color:red;\">Confirm Deletion</span>", desc = "Confirm deleting this character?", image="items/charsel_confirm.png", value = "confirm"},
                        {label = "Cancel", desc = "Cancel deletion", image="items/charsel_cancel.png", value = "cancel"}
                    }
                    MenuData.Open('default', GetCurrentResourceName(), 'charselect3', {
                        title    = "REDEM:RP",
                        subtext  = "Delete Character",
                        align    = 'top-right',
                        opacity  = '0.95',
                        elements = elements,
                    },
                    function(data, menu)
                        if data.current.value == "confirm" then
                            local charId = tonumber(SelectingChar)
                            MenuData.CloseAll()

                            AddTextEntry("FMMC_MPM_TYP71", "\"confirm\" to delete your character ("..CharsList[charId].firstname.." "..CharsList[charId].lastname.."), ESC to cancel")
                            DisplayOnscreenKeyboard(0, "FMMC_MPM_TYP71", "", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Citizen.Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                kbdRes = GetOnscreenKeyboardResult()
                            else
                                return OpenCharacterMenu()
                            end
                            
                            if #(kbdRes) >= 1 then
                                if kbdRes == "confirm" then
                                    DoScreenFadeOut(500)
                                    Wait(500)
                                    TriggerServerEvent('redemrp_charselect:deleteCharacter', charId)
                                    for v, k in pairs (characters) do
                                        DeletePed(k)
                                        characters[v] = nil
                                        PlayerSkins[v] = nil
                                        PlayerClothes[v] = nil
                                        PlayerSex[v] = nil
                                    end
                                else
                                    return OpenCharacterMenu()
                                end
                            end
                        elseif data.current.value == "cancel" then
                            menu.close()
                        end
                    end,
                    function(data, menu)
                        menu.close()
                    end)
                end
            end,
            function(data, menu)
               menu.close()
            end)
        end
    end,
    function(data, menu)
    end,
    function(data, menu)
        if data.current.value ~= "new" then
            while not CanChangeCamera do Wait(100) end
            if CanChangeCamera then
                CanChangeCamera = false
                local i = data.current.value
                print(i)
                local charscene = Config.CharScenes[CharScene][i]
                ClearPedTasksImmediately(characters[i])
                SelectingPed = i
                if not charscene.Scenario then
                    if IsPedMale(characters[i]) then
                        TaskStartScenarioInPlace(characters[i], charscene.ScenarioMale, -1, true, false, false, false)
                    else
                        TaskStartScenarioInPlace(characters[i], charscene.ScenarioFemale, -1, true, false, false, false)
                    end
                else
                    TaskStartScenarioInPlace(characters[i], charscene.Scenario, -1, true, false, false, false)
                end

                if charscene.Light then
                    LightOn = true
                else
                    LightOn = false
                end
                --DoScreenFadeOut(500)
                --Wait(500)
                AnimpostfxStopAll()
                effectName = nil
                AnimpostfxPlay("CamTransition01")
                DestroyAllCams()
                local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                SetCamCoord(cam, charscene.CamCoord.x, charscene.CamCoord.y, charscene.CamCoord.z)
                SetCamRot(cam, 0.0, 0.0, charscene.CamCoord.w)
                if not charscene.PointCam then
                    PointCamAtCoord(cam, charscene.PedCoord.x, charscene.PedCoord.y, charscene.PedCoord.z + 1.0)
                else
                    PointCamAtCoord(cam, charscene.PointCam.x, charscene.PointCam.y, charscene.PointCam.z)
                end
                if charscene.CamFov ~= nil then
                    SetCamFov(cam, charscene.CamFov)
                end
                SetCamActive(cam, true)
                RenderScriptCams(true, false, 1, true, true)
                CanChangeCamera = true
            end
        else
            DoSkyEffect()
        end
    end)
    Wait(250)
    DoScreenFadeIn(500)
    Wait(500)
    SendNUIMessage({
        loading = false
    })
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if LightOn and SelectingPed then
            local coords = GetEntityCoords(characters[SelectingPed])
            local lightcoords = GetOffsetFromEntityInWorldCoords(characters[SelectingPed], 0.0, 1.0, 0.0)
            DrawLightWithRange(lightcoords.x, lightcoords.y, lightcoords.z, 239, 255, 138, 2.5,10.0)
        end
    end
end)

RegisterNetEvent('redemrp_charselect:openSelectionMenu', function(characters,skins,clothes)
    Citizen.CreateThread(function()
        --CharScene = math.random(1,#Config.CharScenes)
        --Config.CharScenes[CharScene] = shuffle(Config.CharScenes[CharScene])
        CharScene = 4
        Config.CharScenes[CharScene] = shuffle(Config.CharScenes[CharScene])
        SetEntityAlpha(PlayerPedId(), 0)
        CharsList = characters
        local ped = PlayerPedId()
        SetEntityCoords(PlayerPedId(), 1.505, 1015.63, 202.4088)
        FreezeEntityPosition(PlayerPedId(), true)
        DestroyAllCams()
        --DoScreenFadeOut(250)
        DisplayHud(false)
        DisplayRadar(false)
        for k, v in ipairs(characters) do
            PlayerSkins[v.characterid] = FindCharacterSkin(skins, v.characterid)
            PlayerSex[v.characterid] = PlayerSkins[v.characterid].sex
            PlayerClothes[v.characterid] = FindCharacterClothes(clothes, v.characterid)
        end
        createCharacters()
        local FirstPed = 1
        for k,v in ipairs(characters) do
            FirstPed = v.characterid
            break
        end
        SelectingPed = FirstPed
        local charscene = Config.CharScenes[CharScene][FirstPed]
        if charscene.Light then
            LightOn = true
        else
            LightOn = false
        end
        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(cam, charscene.CamCoord.x, charscene.CamCoord.y, charscene.CamCoord.z)
        SetCamRot(cam, 0.0, 0.0, charscene.CamCoord.w)
        if not charscene.PointCam then
            PointCamAtCoord(cam, charscene.PedCoord.x, charscene.PedCoord.y, charscene.PedCoord.z + 1.0)
        else
            PointCamAtCoord(cam, charscene.PointCam.x, charscene.PointCam.y, charscene.PointCam.z)
        end
            
        if charscene.CamFov ~= nil then
            SetCamFov(cam, charscene.CamFov)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
        CanChangeCamera = true
        Wait(250)
        TriggerEvent("redemrp_charselect:removeLoadingScreen")
    end)
end)

function FindCharacterClothes(clothes, charid)
    for k, v in ipairs(clothes) do
        if v.charid == charid then
            print("Identity Clothes Found")
            return json.decode(v.clothes)
        end
    end
    return {}
end

function FindCharacterSkin(skins, charid)
    for k, v in ipairs(skins) do
        if v.charid == charid then
            print("Identity SKIN Found")
            return json.decode(v.skin)
        end
    end
    return {}
end

function createCharacters()
    SetEntityCoords(PlayerPedId(), Config.CharScenes[CharScene].MainPedCoord)
    local maleHash = GetHashKey("mp_male")
    local femaleHash = GetHashKey("mp_female")
    modelrequest( maleHash)
    while not HasModelLoaded(maleHash) do
        Wait(100)
    end
    modelrequest(femaleHash)
    while not HasModelLoaded(femaleHash) do
        Wait(100)
    end
    for i=1,4 do
        if PlayerSex[i] ~= nil then
            if tonumber(PlayerSex[i]) == 1 then
                characters[i] = CreatePed(maleHash, Config.CharScenes[CharScene][i].PedCoord.x, Config.CharScenes[CharScene][i].PedCoord.y, Config.CharScenes[CharScene][i].PedCoord.z, Config.CharScenes[CharScene][i].PedCoord.w, true, false, 0, 0)
                while not DoesEntityExist(characters[i]) do
                    Wait(100)
                end
            elseif tonumber(PlayerSex[i]) == 2 then
                characters[i] = CreatePed(femaleHash, Config.CharScenes[CharScene][i].PedCoord.x, Config.CharScenes[CharScene][i].PedCoord.y, Config.CharScenes[CharScene][i].PedCoord.z, Config.CharScenes[CharScene][i].PedCoord.w, true, false, 0, 0)
                while not DoesEntityExist(characters[i]) do
                    Wait(100)
                end
            end

            if characters[i] ~= nil then
                print("Characters["..i.."] spawned")
                NetworkSetEntityInvisibleToNetwork(characters[i],true)
                SetEntityAsMissionEntity(characters[i], true, true)
                Citizen.InvokeNative(0x283978A15512B2FE, characters[i], true)
                SetEntityInvincible(characters[i], true)
                SetEntityCanBeDamagedByRelationshipGroup(characters[i], false, GetHashKey("PLAYER"))
                TriggerEvent("RedEM:client:ApplySkin", PlayerSkins[i] , characters[i], PlayerClothes[i])

                FreezeEntityPosition(characters[i], true)
                if not Config.CharScenes[CharScene][i].Scenario then
                    if IsPedMale(characters[i]) then
                        TaskStartScenarioInPlace(characters[i], Config.CharScenes[CharScene][i].ScenarioMale, -1, true, false, false, false)
                    else
                        TaskStartScenarioInPlace(characters[i], Config.CharScenes[CharScene][i].ScenarioFemale, -1, true, false, false, false)
                    end
                else
                    TaskStartScenarioInPlace(characters[i], Config.CharScenes[CharScene][i].Scenario, -1, true, false, false, false)
                end
                Wait(150)
            end
        end
	end
end

function FindScenarioOfTypeHash(x, y, z, hash, dist, p1, p2)
    return Citizen.InvokeNative(0xF533D68FF970D190, x, y, z, hash, dist, p1, p2)
end

Citizen.CreateThread(function()
    DoScreenFadeOut(100)
    Wait(100)
    SendNUIMessage({
        version = RedEM.Version,
    })
    Wait(100)
    ShutdownLoadingScreen()
    Wait(7000)
    TriggerServerEvent('redemrp_charselect:getCharacters')
end)

RegisterNetEvent("RedEM:DisableCrime", function(toggle)
    DisableCrime = toggle
    SendNUIMessage({
        crime = DisableCrime,
    })
end)

StartSkyCam = function(cb)
    local coords = GetGameplayCamCoord()
    local rot = GetGameplayCamRot(1)
    local fov = GetGameplayCamFov()
    local tcam = CreateCamera("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(tcam,coords.x, coords.y, coords.z)
    SetCamFov(tcam,fov)
    SetCamRot(tcam,rot.x, rot.y, rot.z,true)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    if GetInteriorFromEntity(PlayerPedId()) == 0 then
        SetCamParams(tcam, coords.x, coords.y, coords.z+100.0, 90.0, rot.y, rot.z, 90.0, 1000, 1, 1, 1)
    else
        local offsetCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.25)
        SetCamParams(tcam, offsetCoords.x, offsetCoords.y, offsetCoords.z, rot.x, rot.y, rot.z, 90.0, 1000, 1, 1, 1)
    end
    PointCamAtEntity(tcam, PlayerPedId(), 0.0, 0.0, 0.0, 1)
    Wait(1000)
    if cb then cb() end
end

StopSkyCam = function()
    RenderScriptCams(false, true, 1000, true, true)
    DestroyAllCams()
end

RegisterNetEvent("redemrp_charselect:characterRemoved", function()
    loadingscreenremoved = false
    TriggerServerEvent('redemrp_charselect:getCharacters')
end)

RegisterCommand("logout", function(source, args)
    RedEM.TriggerCallback("redemrp_respawn:IsPlayerDead", function(isDead)
        if not isDead then
            StartSkyCam(function()
                DoScreenFadeOut(500)
                Citizen.Wait(1000)
                StopSkyCam()
                Citizen.InvokeNative(0x1B83C0DEEBCBB214, PlayerPedId())
                RemoveAllPedWeapons(PlayerPedId(), true, true)
                loadingscreenremoved = false
                TriggerEvent("redemrp_inventory:client:ResetWeapons")
                TriggerServerEvent("redemrp:PlayerLogout")
                TriggerServerEvent("redemrp_bossmenu:server:LogoutOffDuty")
                TriggerEvent("redemrp_respawn:client:StopSavingPosition")
                TriggerEvent("redemrp_sisika:client:Logout")
                Citizen.Wait(1000)
                TriggerServerEvent('redemrp_charselect:getCharacters')
            end)
        else
            RedEM.Functions.NotifyRight( "You can't logout while you're dead.", 3000)
        end
    end)
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    local cam
    local _ped = tonumber(data.pedid) + 1  
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    local charId = tonumber(data.id)
    TriggerServerEvent("redemrp:selectCharacter", charId)
end)

RegisterNetEvent("redemrp_charselect:client:FinishSelection", function(new)
    MenuData.CloseAll()
    if not new then
        TriggerEvent("redemrp_charselect:SpawnCharacter")
        TriggerEvent('playerSpawned')
        TriggerServerEvent("RedEM:server:LoadSkin")
        LightOn = false

        Citizen.Wait(1000)
        for v, k in pairs (characters) do
            DeletePed(k)
            characters[v] = nil
        end
        SetCamActive(cam, false)
        DestroyAllCams()

        Wait(1000)
        TriggerServerEvent("redemrp_charselect:ResetRoutingBucket")
    else
        TriggerEvent("redemrp_charselect:SpawnCharacter" , true)
        LightOn = false
        Wait(1000)
        for v, k in pairs (characters) do
            DeletePed(k)
            characters[v] = nil
        end
        Wait(1000)
        TriggerServerEvent("redemrp_charselect:ResetRoutingBucket")
    end
end)

--[[
RegisterNetEvent('rdr_creator:SkinLoaded', function(SkinData, Target, ClothesData)
    if Target ~= PlayerPedId() then
        TriggerEvent("redemrp_charselect:removeLoadingScreen")
    end
end)]]

RegisterNUICallback('newCharacter', function(data, cb)
    local function tchelper(first, rest)
        return first:upper()..rest:lower()
    end
    local fname = data.name:gsub("(%a)([%w_']*)", tchelper)
    local lname = data.lname:gsub("(%a)([%w_']*)", tchelper)
    AnimpostfxStopAll()
    effectName = nil
    TriggerServerEvent('redemrp:createCharacter', fname, lname)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('cancelNew', function(data, cb)
    SetNuiFocus(false, false)
    --DoScreenFadeOut(500)
    --Wait(500)
    AnimpostfxStopAll()
    effectName = nil
    TriggerServerEvent('redemrp_charselect:getCharacters')
    loadingscreenremoved = false
    for v, k in pairs (characters) do
        DeletePed(k)
		characters[v] = nil
	    PlayerSkins[v] = nil
		PlayerClothes[v] = nil
		PlayerSex[v] = nil
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if effectName and not AnimpostfxIsRunning(effectName) then
            AnimpostfxPlay(effectName)
        end
    end
end)

DoSkyEffect = function()
    AnimpostfxPlay("CamTransition01")
    effectName = "skytl_0900_01clear_nofade"
    if GetClockHours() >= 12 and GetClockHours() < 15 then
        effectName = "skytl_1200_01clear_nofade"
    elseif GetClockHours() >= 15 and GetClockHours() < 18 then
        effectName = "skytl_1500_01clear_nofade"
    elseif GetClockHours() >= 18 and GetClockHours() < 21 then
        effectName = "skytl_1800_01clear_nofade"
    elseif GetClockHours() >= 21 and GetClockHours() < 24 then
        effectName = "skytl_2100_01clear_nofade"
    elseif GetClockHours() >= 0 and GetClockHours() < 3 then
        effectName = "skytl_0000_01clear_nofade"
    elseif GetClockHours() >= 3 and GetClockHours() < 6 then
        effectName = "skytl_0300_01clear_nofade"
    elseif GetClockHours() >= 6 and GetClockHours() < 9 then
        effectName = "skytl_0600_01clear_nofade"
    end
    AnimpostfxPlay(effectName)
end