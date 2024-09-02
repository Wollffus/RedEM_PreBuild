local glowna
local adding = true
local lista_siodlo = {}
local lista_grzywa = {}
local lista_strzemiona  = {}
local lista_mata  = {}
local lista_ogon = {}
local lista_czaprak = {}
local lista_torba = {}


------------------------------------------
local 	siodlo = 1
local	grzywa = 1
local	kamizelka = 1
local	strzemiono = 1
local	czaprak = 1
local	torba = 1
local	mata = 1
local	ogon = 1

--------------------------------------------
local isSkinCreatorOpened = false

function ShowSkinCreator(enable)
    SetNuiFocus(enable, enable)
    SendNUIMessage({
        openSkinCreator = enable,
        siodlo = siodlo,
        grzywa = grzywa,
        strzemiono = strzemiono,
        mata = mata,
        ogon = ogon,
        czaprak = czaprak,
        torba = torba,

    })
end

--------------------------------------------

Citizen.CreateThread(function()
    while adding do
        Citizen.Wait(0)
        --print("Dzieje sie")
        for i, v in ipairs(horse_components) do
            if v.category == "czaprak" then
                table.insert(lista_czaprak, v.hash)
            elseif v.category == "bag" then
                table.insert(lista_torba, v.hash)
            elseif v.category == "tail" then
                table.insert(lista_ogon, v.hash)
            elseif v.category == "mane" then
                table.insert(lista_grzywa, v.hash)
            elseif v.category == "saddle" then
                table.insert(lista_siodlo, v.hash)
            elseif v.category == "stirrups" then
                table.insert(lista_strzemiona, v.hash)
            elseif v.category == "mat" then
                table.insert(lista_mata, v.hash)
            end
        end
        adding = false
    end
end)






function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
        local mult = 10^numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

RegisterNetEvent('Badlands_HorseCustomization:startUi')
AddEventHandler('Badlands_HorseCustomization:startUi', function(komponenty)

        local _komponenty = json.decode(komponenty)
        --print(tonumber( _komponenty.czaprak))
        czaprak = tonumber( _komponenty.czaprak)
        torba = tonumber(_komponenty.bag)
        ogon = tonumber(_komponenty.tail)
        grzywa =tonumber (_komponenty.mane)
        siodlo = tonumber(_komponenty.saddle)
        strzemiono = tonumber(_komponenty.stirrups)
        mata = tonumber(_komponenty.mat)
        ShowSkinCreator(true)
        isSkinCreatorOpened = true
        camera(3.8,0.1)

end)

RegisterNetEvent('Badlands_HorseCustomization:loadhorsecomponent')
AddEventHandler('Badlands_HorseCustomization:loadhorsecomponent', function()
    local horseID = GetMount(PlayerPedId())
    local id1 = round(DecorGetFloat(horseID, "id1"), -2)
    --print(id1)
	  TriggerServerEvent("Badlands_HorseCustomization:loadComponents",id1 , 0, horseID, function(cb)
        end)
end)

RegisterNUICallback('exit', function()
    local horseID = GetMount(PlayerPedId())
    local id1 = round(DecorGetFloat(horseID, "id1"), -2)
    --print(id1)
	  TriggerServerEvent("Badlands_HorseCustomization:loadComponents",id1 , 0, horseID, function(cb)
        end)
    isSkinCreatorOpened = false
    ShowSkinCreator(false)
    destory()
end)

RegisterNUICallback('saveComponents', function(data, cb)
    SetNuiFocus(false, false)

    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    DisplayHud(true)
    DisplayRadar(true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    local price = Config.Price
    local json = json.encode(data)
    local horseID = GetMount(PlayerPedId())
    local id1 = round(DecorGetFloat(horseID, "id1"), -2)
    --print(id1)
    TriggerServerEvent("Badlands_HorseCustomization:Save", json, price, id1 ,function(cb)
        if cb then
            print("DONE")
        else
            print("ERROR")
        end
    end)

    DestroyAllCams()
    isSkinCreatorOpened = false
    ShowSkinCreator(false)
end)






RegisterNUICallback('updateComponents', function(data, cb)
   -- print("chuj")
    TriggerEvent("Badlands_HorseCustomization:updateComponents" , data)
end)

RegisterNetEvent('Badlands_HorseCustomization:updateComponents')
AddEventHandler('Badlands_HorseCustomization:updateComponents', function(data)
  --  print(tonumber(data.saddle))
  --  print("gowno")
    if czaprak ~= tonumber(data.czaprak) and data.czaprak ~= nil then
        czaprak = tonumber(data.czaprak)
        glowna = lista_czaprak
        zmiana(data.czaprak)
    end

    if torba ~= tonumber(data.bag) and data.bag ~= nil then
        torba = tonumber(data.bag)
        glowna = lista_torba
        zmiana(data.bag)
    end

    if ogon ~= tonumber(data.tail) and data.tail ~= nil then
        ogon = tonumber(data.tail)
        glowna = lista_ogon
        zmiana(data.tail)
    end

    if grzywa ~= tonumber(data.mane) and data.mane ~= nil then
        grzywa = tonumber(data.mane)
        glowna = lista_grzywa
        zmiana(data.mane)
    end

    if siodlo ~= tonumber(data.saddle) and data.saddle ~= nil then
        siodlo = tonumber(data.saddle)
        glowna = lista_siodlo
        zmiana(data.saddle)
    end

    if strzemiono ~= tonumber(data.stirrups) and data.stirrups ~= nil then
        strzemiono = tonumber(data.stirrups)
        glowna = lista_strzemiona
        zmiana(data.stirrups)
    end

    if mata ~= tonumber(data.mat) and data.mat ~= nil then
        mata = tonumber(data.mat)
        glowna = lista_mata
        zmiana(data.mat)
    end


end)





function zmiana(wartosc)
    local wartosc2 = tonumber(wartosc)
   -- print(wartosc2)
    local hash = ("0x" .. glowna[wartosc2])
    local target = GetMount(PlayerPedId())
    --print(glowna[wartosc2])

    if glowna == lista_mata and wartosc2 == 1 then

        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0xEFB31921, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component

    elseif glowna == lista_strzemiona and wartosc2 == 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0xEFB31921, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component

    elseif glowna == lista_siodlo  and wartosc2 == 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0xBAA7E618, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component

    elseif glowna == lista_grzywa  and wartosc2 == 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0xAA0217AB, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component

    elseif glowna == lista_ogon and wartosc2 == 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0xA63CAE10, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component

    elseif glowna == lista_torba  and wartosc2 == 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0x80451C25, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component

    elseif glowna == lista_czaprak  and wartosc2 == 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, target, 0x17CEB41A, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, target, 0, 1, 1, 1, 0) -- Actually remove the component


    else

        Citizen.InvokeNative(0xD3A7B003ED343FD9 , target,  tonumber(hash), true, true, true)
    end

end


RegisterNetEvent('Badlands_HorseCustomization:load')
AddEventHandler('Badlands_HorseCustomization:load', function(data ,target)
--print(data)
    local _komponenty = json.decode(data)
    local hash = nil
    local wartosc = 1
    local _target = target
--print("lols")
    Citizen.InvokeNative(0xD710A5007C2AC539, _target, 0xEFB31921, 0) -- Set target category, here the hash is for hats
    Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0) -- Actually remove the component


    Citizen.InvokeNative(0xD710A5007C2AC539, _target, 0xEFB31921, 0) -- Set target category, here the hash is for hats
    Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0) -- Actually remove the component


    Citizen.InvokeNative(0xD710A5007C2AC539, _target, 0xBAA7E618, 0) -- Set target category, here the hash is for hats
    Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0) -- Actually remove the component

    Citizen.InvokeNative(0xD710A5007C2AC539, _target, 0xAA0217AB, 0) -- Set target category, here the hash is for hats
    Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0) -- Actually remove the component

    Citizen.InvokeNative(0xD710A5007C2AC539, _target, 0x80451C25, 0) -- Set target category, here the hash is for hats
    Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0) -- Actually remove the component


    Citizen.InvokeNative(0xD710A5007C2AC539, _target, 0x17CEB41A, 0) -- Set target category, here the hash is for hats
    Citizen.InvokeNative(0xCC8CA3E88256E58F, _target, 0, 1, 1, 1, 0)

    Wait(300)
    glowna = lista_czaprak
    wartosc = tonumber(_komponenty.czaprak)
    if wartosc > 1 then
        --print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
        --print("poszło5")
    end
    Wait(300)
    glowna = lista_torba
    wartosc = tonumber(_komponenty.bag)
    if wartosc > 1 then
        --print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
        --print("poszło1")
    end
    Wait(300)
    glowna = lista_ogon
    wartosc = tonumber(_komponenty.tail)
    if wartosc > 1 then
        --print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
        --print("poszło2")
    end
    Wait(300)
    glowna = lista_grzywa
    wartosc = tonumber(_komponenty.mane)
    if wartosc > 1 then
        --print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
        --print("poszło3")
    end
    Wait(300)
    glowna = lista_siodlo
    wartosc = tonumber(_komponenty.saddle)
    if wartosc > 1 then
      -- print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
       -- print("poszło4")
    end
    Wait(300)
    glowna = lista_strzemiona
    wartosc = tonumber(_komponenty.stirrups)
    if wartosc > 1 then
        --print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
        --print("poszło6")
    end

    Wait(300)
    glowna = lista_mata
    wartosc = tonumber(_komponenty.mat)
    if wartosc > 1 then
        --print(wartosc)
        hash = ("0x" .. glowna[wartosc])
        ladowanie(hash,_target)
        --print("poszło6")
    end
end)



function ladowanie(hash,target)
local _target = target
--print(hash)
--print(_target)
    Citizen.InvokeNative(0xD3A7B003ED343FD9 , _target,  tonumber(hash), true, true, true)
end

local headingss = 334.00
RegisterNUICallback('heading', function(data)
    local playerPed = GetMount(PlayerPedId())
    headingss = headingss + data.value
    SetEntityHeading(playerPed, headingss)
end)
RegisterNUICallback('defcam', function(data)
    camera(3.8,0.1)
end)

function destory()
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    DisplayHud(true)
    DisplayRadar(true)
    DestroyAllCams(true)
end

function camera(zoom, offset)
    DestroyAllCams(true)
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local heading = 45.0 + 180
    local zoomOffset = zoom
    local camOffset = offset
    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }
    --print(theta.x)
    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }
    --print(pos.x)
    local angleToLook = heading - 140.0
    if angleToLook > 360 then
        angleToLook = angleToLook - 360
    elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
    end
    --print(angleToLook)
    angleToLook = angleToLook * math.pi / 180.0
    local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
    }
    --print(thetaToLook.x)
    local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y)
    }
    --print(posToLook.x)
    local add = 2.0
    if zoom == 0.9 then
        add = 1.0
    else
        add = 3.0
    end
    SetEntityHeading(playerPed, 334.00)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, coords.z + camOffset, 300.00,0.00,0.00, 40.00, false, 0)
    PointCamAtCoord(cam, posToLook.x-add, posToLook.y, coords.z + camOffset)
    SetCamActive(cam, true)
	PointCamAtEntity(cam, playerPed)
    RenderScriptCams(true, true, 500, true, true)
    DisplayHud(false)
    DisplayRadar(false)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    Wait(0)
    for k,v in pairs(Config.Zones) do
        local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v)
        SetBlipSprite(blip, Config.BlipSprite, 1)
        SetBlipScale(blip, Config.BlipScale)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Zones) do
            if Vdist(coords, v) < 4 then
			       local horseID = GetMount(PlayerPedId())
                    local id1 = round(DecorGetFloat(horseID, "id1"), -2)
				if id1 ~= 0 then
                DrawTxt(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
                if IsControlJustReleased(0, Config.OpenKey) then                 
                        TriggerServerEvent("Badlands_HorseCustomization:loadComponents",id1, 1, function(cb)
                            end)
                    end
                end
            end
        end
    end
end)


