CreatorMenuData = {}
CreatorMenuData.Opened = {}
CreatorMenuData.RegisteredTypes = {}

CreatorMenuData.RegisteredTypes['default'] = {
    open = function(namespace, name, data)
        SendNUIMessage({
            redemrp_creator_menu_action = 'openMenu',
            redemrp_creator_menu_namespace = namespace,
            redemrp_creator_menu_name = name,
            redemrp_creator_menu_data = data
        })
    end,
    close = function(namespace, name)
        SendNUIMessage({
            redemrp_creator_menu_action = 'closeMenu',
            redemrp_creator_menu_namespace = namespace,
            redemrp_creator_menu_name = name,
            redemrp_creator_menu_data = data
        })
    end
}

function CreatorMenuData.Open(type, namespace, name, data, submit, cancel, change, close)
    local menu = {}

    menu.type = type
    menu.namespace = namespace
    menu.name = name
    menu.data = data
    menu.submit = submit
    menu.cancel = cancel
    menu.change = change

    menu.close = function()
        CreatorMenuData.RegisteredTypes[type].close(namespace, name)

        for i = 1, #CreatorMenuData.Opened, 1 do
            if CreatorMenuData.Opened[i] then
                if CreatorMenuData.Opened[i].type == type and CreatorMenuData.Opened[i].namespace == namespace and
                    CreatorMenuData.Opened[i].name == name then
                    CreatorMenuData.Opened[i] = nil
                end
            end
        end

        if close then
            close()
        end

    end

    menu.update = function(query, newData)

        for i = 1, #menu.data.elements, 1 do
            local match = true

            for k, v in pairs(query) do
                if menu.data.elements[i][k] ~= v then
                    match = false
                end
            end

            if match then
                for k, v in pairs(newData) do
                    menu.data.elements[i][k] = v
                end
            end
        end

    end

    menu.refresh = function()
        CreatorMenuData.RegisteredTypes[type].open(namespace, name, menu.data)
    end

    menu.setElement = function(i, key, val)
        menu.data.elements[i][key] = val
    end

    menu.setElements = function(newElements)
        menu.data.elements = newElements
    end

    menu.setTitle = function(val)
        menu.data.title = val
    end

    menu.removeElement = function(query)
        for i = 1, #menu.data.elements, 1 do
            for k, v in pairs(query) do
                if menu.data.elements[i] then
                    if menu.data.elements[i][k] == v then
                        menu.data.elements[i] = nil
                        break
                    end
                end

            end
        end
    end
    CreatorMenuData.Opened[#CreatorMenuData.Opened + 1] = menu
    CreatorMenuData.RegisteredTypes[type].open(namespace, name, data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    return menu
end

function CreatorMenuData.Close(type, namespace, name)
    for i = 1, #CreatorMenuData.Opened, 1 do
        if CreatorMenuData.Opened[i] then
            if CreatorMenuData.Opened[i].type == type and CreatorMenuData.Opened[i].namespace == namespace and CreatorMenuData.Opened[i].name ==
                name then
                CreatorMenuData.Opened[i].close()
                CreatorMenuData.Opened[i] = nil
            end
        end
    end
end

function CreatorMenuData.CloseAll()
    for i = 1, #CreatorMenuData.Opened, 1 do
        if CreatorMenuData.Opened[i] then
            CreatorMenuData.Opened[i].close()
            CreatorMenuData.Opened[i] = nil
        end
    end
end

function CreatorMenuData.GetOpened(type, namespace, name)
    for i = 1, #CreatorMenuData.Opened, 1 do
        if CreatorMenuData.Opened[i] then
            if CreatorMenuData.Opened[i].type == type and CreatorMenuData.Opened[i].namespace == namespace and CreatorMenuData.Opened[i].name ==
                name then
                return CreatorMenuData.Opened[i]
            end
        end
    end
end

function CreatorMenuData.GetOpenedMenus()
    return CreatorMenuData.Opened
end

function CreatorMenuData.IsOpen(type, namespace, name)
    return CreatorMenuData.GetOpened(type, namespace, name) ~= nil
end

function CreatorMenuData.ReOpen(oldMenu)
    CreatorMenuData.Open(oldMenu.type, oldMenu.namespace, oldMenu.name, oldMenu.data, oldMenu.submit, oldMenu.cancel,
        oldMenu.change, oldMenu.close)
end

local Timer, MenuType = 0, 'default'

RegisterNUICallback('menu_submit', function(data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = CreatorMenuData.GetOpened(MenuType, data._namespace, data._name)

    if menu.submit ~= nil then
        menu.submit(data, menu)
    end
end)

RegisterNUICallback('playsound', function()
    PlaySoundFrontend("NAV_LEFT", "PAUSE_MENU_SOUNDSET", true, 0)
end)

RegisterNUICallback('menu_cancel', function(data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = CreatorMenuData.GetOpened(MenuType, data._namespace, data._name)

    if menu.cancel ~= nil then
        menu.cancel(data, menu)
    end
end)

RegisterNUICallback('menu_change', function(data)
    local menu = CreatorMenuData.GetOpened(MenuType, data._namespace, data._name)

    for i = 1, #data.elements, 1 do
        menu.setElement(i, 'value', data.elements[i].value)

        if data.elements[i].selected then
            menu.setElement(i, 'selected', true)
        else
            menu.setElement(i, 'selected', false)
        end
    end

    if menu.change ~= nil then
        menu.change(data, menu)
    end
end)

Citizen.CreateThread(function()
    local PauseMenuState = false
    local MenusToReOpen = {}
    while true do
        Citizen.Wait(0)
        if #CreatorMenuData.Opened > 0 then

            if (IsControlJustReleased(0, 0x43DBF61F) or IsDisabledControlJustReleased(0, 0x43DBF61F)) then
                SendNUIMessage({
                    redemrp_creator_menu_action = 'controlPressed',
                    redemrp_creator_menu_control = 'ENTER'
                })
            end

            if (IsControlJustReleased(0, 0x308588E6) or IsDisabledControlJustReleased(0, 0x308588E6)) then
                SendNUIMessage({
                    redemrp_creator_menu_action = 'controlPressed',
                    redemrp_creator_menu_control = 'BACKSPACE'
                })
            end

            if (IsControlJustReleased(0, 0x911CB09E) or IsDisabledControlJustReleased(0, 0x911CB09E)) then
                SendNUIMessage({
                    redemrp_creator_menu_action = 'controlPressed',
                    redemrp_creator_menu_control = 'TOP'
                })
            end

            if (IsControlJustReleased(0, 0x4403F97F) or IsDisabledControlJustReleased(0, 0x4403F97F)) then
                SendNUIMessage({
                    redemrp_creator_menu_action = 'controlPressed',
                    redemrp_creator_menu_control = 'DOWN'
                })
            end

            if (IsControlJustReleased(0, 0xAD7FCC5B) or IsDisabledControlJustReleased(0, 0xAD7FCC5B)) then
                SendNUIMessage({
                    redemrp_creator_menu_action = 'controlPressed',
                    redemrp_creator_menu_control = 'LEFT'
                })
            end

            if (IsControlJustReleased(0, 0x65F9EC5B) or IsDisabledControlJustReleased(0, 0x65F9EC5B)) then
                SendNUIMessage({
                    redemrp_creator_menu_action = 'controlPressed',
                    redemrp_creator_menu_control = 'RIGHT'
                })
            end

            if IsPauseMenuActive() then
                if not PauseMenuState then
                    PauseMenuState = true
                    for k, v in pairs(CreatorMenuData.GetOpenedMenus()) do
                        table.insert(MenusToReOpen, v)
                    end
                    CreatorMenuData.CloseAll()
                end
            end
        else
            if PauseMenuState and not IsPauseMenuActive() then
                PauseMenuState = false
                Citizen.Wait(1000)
                for k, v in pairs(MenusToReOpen) do
                    CreatorMenuData.ReOpen(v)
                end
                MenusToReOpen = {}
            end
        end
    end
end)

AddEventHandler('redemrp_creator_menu:getData', function(cb)
    cb(CreatorMenuData)
end)