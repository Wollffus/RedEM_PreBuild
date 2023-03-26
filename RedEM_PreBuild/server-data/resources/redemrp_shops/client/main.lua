local MenuActive = false
local camera
local lastPreView
local spawnCoords
local canChange = true
local items_list = {}
Citizen.CreateThread(function()
	Wait(5000)
    TriggerServerEvent("redemrp_shops:RequestItems")
    OpenShop()
end)


MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)


local PromptShop
local OpenShopGroup = GetRandomIntInRange(0, 0xffffff)
print('OpenShopGroup: ' .. OpenShopGroup)

function OpenShop()
    Citizen.CreateThread(function()
        local str = "Open Shop"
        PromptShop = PromptRegisterBegin()
        PromptSetControlAction(PromptShop, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PromptShop, str)
        PromptSetEnabled(PromptShop, true)
        PromptSetVisible(PromptShop, true)
        PromptSetHoldMode(PromptShop, true)
        PromptSetGroup(PromptShop, OpenShopGroup)
        PromptRegisterEnd(PromptShop)

    end)
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local can_wait = true
        local coords   = GetEntityCoords(PlayerPedId())

        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Pos, 1 do
                local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                if distance <= 15.0 then
                    can_wait = false
                end

                if distance < Config.EnableDistance and not MenuActive then
                    local ShopGroupName  = CreateVarString(10, 'LITERAL_STRING', "Shop")
                    PromptSetActiveGroupThisFrame(OpenShopGroup, ShopGroupName)
					 if PromptHasHoldModeCompleted(PromptShop) and not MenuActive then
                        MenuActive = true
                        spawnCoords = v.Spawn[i]
                        OpenShopMenu(k)
					end
                end

            end
        end

        if can_wait == true then
            Wait(1000)
        end

    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Pos, 1 do
            if v.Legal then
                local blip = N_0x554d9d53f696d002(1664425300, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                SetBlipSprite(blip, Config.BlipSprite, 1)
                SetBlipScale(blip, Config.BlipScale)
                Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
            end
        end
    end
end)




function OpenShopMenu(zone)
    items_list = {}
    local _zone = zone
    for i=1, #Config.Zones[_zone].Items, 1 do
        local item = Config.Zones[_zone].Items[i]
        table.insert(items_list, {label = item.label, value = i , desc = "Item Price: "..item.price , obj =  item.object , name = item.item , zone = _zone })
    end
    StartCam()


    MenuData.Open(

        'default', GetCurrentResourceName(), 'shop_menu',

        {

            title    = 'Shop',

            subtext    = 'Cheapest items',

            align    = 'top-left',

            elements = items_list,

        },

        function(data, menu)
            TriggerServerEvent('redemrp_shops:BuyItem', data.current.name, 1 , data.current.zone)
        end,

        function(data, menu)
            menu.close()
            EndCam()
            if lastPreView ~= nil then
                DeleteEntity(lastPreView)
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end
            MenuActive = false
        end,

        function(data, menu)

            if canChange == true then
                canChange = false
                PreView (data.current.obj)
                canChange = true
            end
        end
    )
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

function PreView (model)
    if model == "empty" then return end
    if lastPreView ~= nil then
        DeleteEntity(lastPreView)
        while DoesEntityExist(lastPreView) do
            Wait(1)
        end
    end
    local _model = GetHashKey( model )
    while not HasModelLoaded( _model ) do
        Wait(1)
        modelrequest( _model )
    end
    lastPreView = CreateObject( _model, spawnCoords.x , spawnCoords.y, spawnCoords.z , 0.0, false, false )
    while not DoesEntityExist(lastPreView) do
        Wait(1)
    end
    SetEntityAsMissionEntity(lastPreView, true, true)
    FreezeEntityPosition(lastPreView , true)
    PointCamAtEntity(camera, lastPreView)
end

function StartCam()
    DestroyAllCams(true)
    DoScreenFadeOut(800)
    Wait(800)
    local camera_pos = GetObjectOffsetFromCoords(spawnCoords.x , spawnCoords.y, spawnCoords.z ,0.0 ,1.0, 1.0, 1.0)
    camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camera_pos.x, camera_pos.y, camera_pos.z, 00.00, 00.00, 40.00, 30.00, true, 0)
    SetCamActive(camera,true)
    RenderScriptCams(true, true, 1000, true, true)
    if canChange == true then
        canChange = false
        PreView (items_list[1].obj)
        canChange = true
    end
    DisplayHud(false)
    DisplayRadar(false)
    DoScreenFadeIn(1500)
    Wait(1500)
end

function EndCam()
	DoScreenFadeOut(800)
    Wait(800)
    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(camera, false)
    camera = nil
    DisplayHud(true)
    DisplayRadar(true)
    DestroyAllCams(true)
    DoScreenFadeIn(1500)
end


RegisterNetEvent('redemrp_shops:GetItems')
AddEventHandler('redemrp_shops:GetItems', function(ShopItems)
    for k,v in pairs(ShopItems) do
        if (Config.Zones[k] ~= nil) then
            Config.Zones[k].Items = v
        end
    end
end)
