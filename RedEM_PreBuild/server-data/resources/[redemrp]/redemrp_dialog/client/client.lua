RegisterCommand("getdialog", function(source, args, rawCommand)
    if Config.Debug then
    print("Dialog get incoming...")
    TriggerServerEvent('redemrp_dialog:listDialog', tonumber(args[1]))
    end
end)

RegisterCommand("getdialogs", function(source, args, rawCommand)
    if Config.Debug then
    print("Dialog get all incoming...")
    TriggerServerEvent('redemrp_dialog:listDialogs')
    end
end)

RegisterCommand("opendialog", function(source, args, rawCommand)
    if Config.Debug then
    print("Dialog open incoming...")
    TriggerServerEvent('redemrp_dialog:openDialog', tonumber(args[1]))
    end
end)

RegisterNetEvent("redemrp_dialog:openDialogClient")
AddEventHandler("redemrp_dialog:openDialogClient", function(id, title, subtitle, options)
    -- DEBUG PRINTS --
    if Config.Debug then
    print("Opening Dialog...")
    print("ID: " .. id)
    print("Title: " .. title)
    print("Subtitle: " .. subtitle)
    print("Options: ")
    for k,v in pairs(options) do 
        print(" - " .. v.name)
    end
end
    -- END OF PRINTS --

        SendNUIMessage({
            type = 'showdialog',
            id = id,
            title = title,
            subtitle = subtitle,
            options = options
        })
        SetNuiFocus(true, true)
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false)
end)
RegisterNetEvent("redemrp_dialog:SetNuiFocus")
AddEventHandler("redemrp_dialog:SetNuiFocus", function()
    SetNuiFocus(false)
end)
RegisterNUICallback('choice', function(data, cb)
    if Config.Debug then
print(data.dialogid)
    end
 TriggerServerEvent('redemrp_dialog:UseOption', tonumber(data.dialogid), tonumber(data.optionid))
end)
