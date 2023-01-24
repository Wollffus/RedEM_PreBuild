local list = {}
local list_f = {}
local b_list = {}
local b_list_f = {}

local legs = nil
local legs2 = nil
local torso = nil
local torso2 = nil
local ComponentNumber = {}


local cam = nil
local c_zoom = 2.8
local c_offset = -0.15
local isCreatorOpened = false


function ShowSkinCreator(enable)

    local _elements = list
    if not IsPedMale(PlayerPedId()) then
        _elements = list_f
    end
    SendNUIMessage({
        openSkinCreator = enable,
        elements = _elements,
        numbers = ComponentNumber,
        translation = Config.Label
    })
    SetNuiFocus(enable, enable)
    isCreatorOpened = enable
end


function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then
        return i, t[i]
    end
end

function reversedipairs(t)
    return reversedipairsiter, t, #t + 1
end

Citizen.CreateThread(function()
    for i,v in reversedipairs(cloth_hash_names) do
        if v.category_hashname ~= "BODIES_LOWER"
            and v.category_hashname ~= "BODIES_UPPER"
            and  v.category_hashname ~= "heads"
            and  v.category_hashname ~= "hair"
            and  v.category_hashname ~= "teeth"
            and  v.category_hashname ~= "eyes"
            and  v.category_hashname ~= "beards_chin"
            and  v.category_hashname ~= "beards_chops"
            and  v.category_hashname ~= ""
            and  v.category_hashname ~= "beards_mustache" then
            if v.ped_type == "female" and v.is_multiplayer then
                ComponentNumber[v.category_hashname] = 1
                if list_f[v.category_hashname] == nil then
                    list_f[v.category_hashname] = {}
                end
                table.insert(list_f[v.category_hashname], v.hash)
            elseif v.ped_type == "male" and v.is_multiplayer then
                ComponentNumber[v.category_hashname] = 1
                if  list[v.category_hashname] == nil then
                    list[v.category_hashname] = {}
                end
                table.insert(list[v.category_hashname], v.hash)
            end
        end
    end
	b_list , b_list_f = table.unpack(exports.redemrp_skin.GetBodyComponents())
end)


RegisterNetEvent('redemrp_clothing:OpenClothingMenu')
AddEventHandler('redemrp_clothing:OpenClothingMenu', function(clothes)
    local _clothes = json.decode(clothes)
	torso =  exports.redemrp_skin.GetTorso()
	legs = exports.redemrp_skin.GetLegs()
	for i,v  in pairs(_clothes) do
        ComponentNumber[i] = tonumber(v)
    end
    ShowSkinCreator(true)
    camera(2.8,-0.15)
end)

RegisterCommand("loadcloath", function(source, args)
    TriggerServerEvent("redemrp_clothing:loadClothes", 1)
end)

RegisterNetEvent('redemrp_clothing:load_def')
AddEventHandler('redemrp_clothing:load_def', function(clothes)
       TriggerServerEvent("redemrp_skin:loadSkin")
end)


RegisterNUICallback('exit', function()
    TriggerServerEvent("redemrp_skin:loadSkin")
    ShowSkinCreator(false)
    destory()
end)

RegisterNUICallback('saveClothes', function(data)
    SetNuiFocus(false, false)
    local ped = PlayerPedId()
    local saveOutfit = false
    local json = json.encode(data)
    --print(json)
    FreezeEntityPosition(ped, false)
    destory()
    if data.name ~= nil and data.name ~= "" then
        saveOutfit = true
        TriggerServerEvent("redemrp_clothing:Save", json, saveOutfit , data.name, function(cb)
            if cb then
                print("DONE")
            else
                print("ERROR")
            end
        end)
    else

        TriggerServerEvent("redemrp_clothing:Save", json, saveOutfit ,function(cb)
            if cb then
                print("DONE")
            else
                print("ERROR")
            end
        end)
    end

    ShowSkinCreator(false)
end)

RegisterNUICallback('updateClothes', function(data)
    for k,v in pairs(data) do

        if ComponentNumber[k] ~=  tonumber(v) and v ~= nil then
            ComponentNumber[k] = tonumber(v)
            if IsPedMale(PlayerPedId()) then
                Change(v, list, k)
            else
                Change(v, list_f, k)
            end
        end
    end
end)

function Change(id, t , category)
    local hash = t[category][tonumber(id)]
    if ComponentNumber[category] <= 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), GetHashKey(category), 0)
        if category == "pants" or category == "boots" then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(legs),false,true,true)
        end

        if category == "shirts_full" then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(torso),false,true,true)
        end
    else

        Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  tonumber(hash), false, true, true)
    end
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xAAB86462966168CE, PlayerPedId(), 1)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
end



RegisterNetEvent('redemrp_clothing:load')
AddEventHandler('redemrp_clothing:load', function(clothes , target)
    Citizen.CreateThread(function()
        local _target
        local test = false
        local _clothes
        local _t = target
        if _t ~= nil then
            _target = _t
            _clothes = clothes
        else
            _target = PlayerPedId()
            _clothes = json.decode(clothes)
        end
        if _clothes ~= nil and _clothes.pants then
            SetEntityAlpha(_target, 0)
            while test == false do
                for k,v in pairs(_clothes) do
                    Wait(5)
                    local id = tonumber(v)
                    if id ~= nil then
                        if id > 1 then
                            if IsPedMale(_target) then
                                if list[k] ~= nil then
                                    Citizen.InvokeNative(0xD3A7B003ED343FD9 , _target, tonumber(list[k][id]), false, true, true)
                                end
                            else
                                if list_f[k] ~= nil then
                                    Citizen.InvokeNative(0xD3A7B003ED343FD9 , _target, tonumber(list_f[k][id]), false, true, true)
                                end
                            end
                        end
                    end
                end
                Wait(250)
                Citizen.InvokeNative(0x704C908E9C405136, _target)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0)
                Wait(250)
                test = Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, _target)
            end
        end
        SetEntityAlpha(_target, 255)
        if _t ~= nil then
            TriggerEvent('redemrp_identity:removeLoadingScreen')
        end

    end)
end)



local headingss = 334.00
RegisterNUICallback('heading', function(data)
    local playerPed = PlayerPedId()
    headingss = headingss + data.value
    SetEntityHeading(playerPed, headingss)
end)


RegisterNUICallback('camera', function(data)
    if data.zoom ~= nil then
        if c_zoom + data.zoom < 2.8 and  c_zoom + data.zoom > 0.7 then
            c_zoom = c_zoom + data.zoom
        end
    end
    if data.offset ~= nil then
        if  c_offset + data.offset < 1.2 and  c_offset + data.offset > -1.0 then
            c_offset = c_offset + data.offset
        end
    end
    camera(c_zoom ,c_offset)
end)

RegisterNUICallback('defcam', function(data)
    camera(2.8,-0.15)
    c_zoom = 2.8
    c_offset = -0.15
end)

function destory()
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    DisplayHud(true)
    DisplayRadar(true)
    DestroyAllCams(true)
    cam = nil
end

function camera(zoom, offset)
    DestroyAllCams(true)
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local heading = 45.0
    local zoomOffset = zoom
    local camOffset = offset
    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }
    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }
    local angleToLook = heading - 140.0
    if angleToLook > 360 then
        angleToLook = angleToLook - 360
    elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
    end
    angleToLook = angleToLook * math.pi / 180.0
    local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
    }
    local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y)
    }
    local add = (1.3*zoom)
    SetEntityHeading(playerPed, headingss)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, coords.z + camOffset, 300.00,0.00,0.00, 40.00, false, 0)
    PointCamAtCoord(cam, posToLook.x-add, posToLook.y, coords.z + camOffset)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    DisplayHud(false)
    DisplayRadar(false)
end

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        local blip = N_0x554d9d53f696d002(1664425300, v)
        SetBlipSprite(blip, Config.BlipSprite, 1)
        SetBlipScale(blip, Config.BlipScale)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
    end
    for k,v in pairs(Config.Cloakroom) do
        local blip = N_0x554d9d53f696d002(1664425300, v)
        SetBlipSprite(blip, Config.BlipSpriteCloakRoom, 1)
        SetBlipScale(blip, Config.BlipScale)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipNameCloakRoom)
    end
end)


AddEventHandler('redemrp_clothing:SendOutfit', function()
    TriggerServerEvent("redemrp_clothing:loadClothes", 3)
end)


local Outfits_tab = {}
RegisterNetEvent('redemrp_clothing:OpenOutfits')
AddEventHandler('redemrp_clothing:OpenOutfits', function()
    TriggerServerEvent('redemrp_clothing:getOutfits')
end)

RegisterNetEvent('redemrp_clothing:putInTable')
AddEventHandler('redemrp_clothing:putInTable', function(outfit)
    Outfits_tab = {}
    for i, k in pairs(outfit) do
        table.insert(Outfits_tab, {name = outfit[i].name})
    end
    Outfits()
end)



MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)
function Outfits()
    local elements_outfits = {}

    if Outfits_tab ~= nil then
        for j, z in pairs(Outfits_tab) do
            table.insert (elements_outfits , {label = Outfits_tab[j].name, value = Outfits_tab[j].name , desc =  "Wybierz strój" })
        end
    end


    MenuData.CloseAll()


    MenuData.Open(

        'default', GetCurrentResourceName(), 'outfits_menu',

        {

            title    = 'Outfits',

            subtext    = 'Choose your outfit',

            align    = 'top-left',

            elements = elements_outfits,

        },

        function(data, menu)
            OutfitsManage(data.current.value)
        end,

        function(data, menu)

            menu.close()


        end

    )

end
local elements_outfits_manage = {
    {label = "Put On", value = "SetOutfits" , desc =  "Put on your outfit" },
    {label = "Delete Outfit", value = "DeleteOutfit" , desc =  "Delete your outfit" },



}
function OutfitsManage(outfit)

    MenuData.CloseAll()
    MenuData.Open(
        'default', GetCurrentResourceName(), 'outfits_menu_manage',

        {

            title    = 'Outfits',

            subtext    = 'Actions',

            align    = 'top-left',

            elements = elements_outfits_manage,

        },

        function(data, menu)
            menu.close()
            TriggerServerEvent('redemrp_clothing:'..data.current.value , outfit)
        end,

        function(data, menu)

            Outfits()


        end

    )

end

local active = false
local target


Citizen.CreateThread(function()
    while true do
        Wait(1)
        local canwait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if isCreatorOpened then
            DrawLightWithRange(coords.x+1 , coords.y+1 , coords.z + 1, 255, 255, 255, 2.5 ,10.0)
        end
        for k,v in pairs(Config.Zones) do
            local dist =  Vdist(coords, v)
            if dist < 2 then
                if dist  < 20 then
                    canwait = false
                end
                if not active then
                    active = true
                    target = k
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.Shoptext, Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                end
                if IsControlJustReleased(0, Config.OpenKey) then
                    TriggerServerEvent("redemrp_clothing:loadClothes", 2)
                end
            else
                if active and k == target then
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    active = false
                end
            end
        end
        if canwait then
            Wait(1000)
        end

    end
end)




local active2 = false
local target2
Citizen.CreateThread(function()
    while true do
        Wait(1)
        local canwait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Cloakroom) do
            local dist =  Vdist(coords, v)
            if dist < 2 then
                if dist  < 20 then
                    canwait = false
                end
                if not active2 then
                    active2 = true
                    target2 = k
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.Cloakroomtext, Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                end
                if IsControlJustReleased(0, Config.OpenKey) or IsDisabledControlJustReleased(0, Config.OpenKey) then
                    TriggerEvent('redemrp_clothing:OpenOutfits')
                end
            else
                if active2 and k == target2 then
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    active2 = false
                end
            end
        end
        if canwait then
            Wait(1000)
        end
    end
end)

function GetClothesComponents()
	return {list , list_f}
end
