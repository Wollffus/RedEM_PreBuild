RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent('redemrp_smallresources:handcuffItem')
AddEventHandler('redemrp_smallresources:handcuffItem', function()
    CuffsMenu()
end)

local elements_cuffs = {
    {label = "Cuff/Uncuff", value = "cuff_item" , desc =  "Cuff/Uncuff Player" },
    {label = "Search", value = "search_item" , desc =  "Search the Player" },
    {label = "Put on the bag / Take off the bag", value = "put_bag" , desc =  "Put on the bag / Take off the bag" },

}

function CuffsMenu()
    MenuData.CloseAll()


    MenuData.Open(

        'default', GetCurrentResourceName(), 'cuffs_menu',

        {

            title    = 'Handcuffs menu',

            subtext    = 'Actions',

            align    = 'top-left',

            elements = elements_cuffs,

        },

        function(data, menu)
            if data.current.value == "cuff_item" then
                local closestPlayer = GetClosestPlayer()
                TriggerServerEvent('redemrp_smallresources:handcuffIt', GetPlayerServerId(closestPlayer))
            elseif data.current.value == "search_item" then
                local closestPlayer = GetClosestPlayer()
                if IsPedCuffed(GetPlayerPed(closestPlayer)) and not IsEntityDead(GetPlayerPed(closestPlayer)) then
                    TriggerEvent('redemrp_inventory:SearchPlayer', GetPlayerServerId(closestPlayer))
                end
            elseif data.current.value == "put_bag" then
                local closestPlayer = GetClosestPlayer()
                if IsPedCuffed(GetPlayerPed(closestPlayer))  or IsEntityDead(GetPlayerPed(closestPlayer)) then
                    TriggerServerEvent('redemrp_smallresources:putBag', GetPlayerServerId(closestPlayer))
                end
            end
        end,

        function(data, menu)

            menu.close()


        end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        if isHandcuffed then
            SetEnableHandcuffs(playerPed, true)
            DisableControlAction(0, 0x295175BF, true)
            DisableControlAction(0, 0x6E9734E8, true)
            DisableControlAction(0, 0xD8F73058, true)
            DisableControlAction(0, 0x4CC0E2FE, true)
            DisableControlAction(0, 0xDE794E3E, true)
            DisableControlAction(0, 0x06052D11, true)
            DisableControlAction(0, 0x5966D52A, true)
            DisableControlAction(0, 0xCEFD9220, true)
            DisableControlAction(0, 0xC75C27B0, true)
            DisableControlAction(0, 0x41AC83D1, true)
            DisableControlAction(0, 0xADEAF48C, true)
            DisableControlAction(0, 0x9D2AEA88, true)
            DisableControlAction(0, 0xE474F150, true)
        else
            Citizen.Wait(500)
        end
    end
end)

function GetClosestPlayer()
    local players         = GetPlayers()
    local closestDistance = 5
    local closestPlayer   = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords, plyCoords)
            if(closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end

    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end


function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end