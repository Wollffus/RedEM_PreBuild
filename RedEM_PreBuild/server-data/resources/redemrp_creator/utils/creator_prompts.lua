
local PromptGroup = CreatePromptGroup("Plastic Surgeon")
local CraftPrompt = CreatePrompt("Access Character Creator ($30)", 0x8AAA0AD4, true, PromptGroup)
local PromptTimeout = GetGameTimer() - 1000
local PromptShown = false
local Surgeons = {
    vector3(1248.6032, -1312.959, 76.892616),
    vector3(-1803.121, -432.2877, 158.82919),
}

local Blips = {}

CraftPrompt.HoldCompleted = function()
    if GetGameTimer() - PromptTimeout > 1000 then
        PromptTimeout = GetGameTimer()
        TriggerServerEvent("rdr_creator:server:TryCreator")
    end
end

Citizen.CreateThread(function()
    for k,v in pairs(Surgeons) do
        local newBlip = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z) -- blip_objective
        SetBlipSprite(newBlip, 3370945993, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, newBlip, "Plastic Surgeon") -- SetBlipNameFromPlayerString
        SetBlipScale(newBlip, 1.5)
        Citizen.InvokeNative(0x662D364ABF16DE2F, newBlip, GetHashKey("BLIP_MODIFIER_MP_COLOR_1"))
        table.insert(Blips, newBlip)
    end
    while true do
        Wait(200)
        local PlayerPos = GetEntityCoords(PlayerPedId())
        local FoundAnything = false
        for _,pos in pairs(Surgeons) do
            local distance = #(PlayerPos - pos)
            if distance < 1.5 then
                FoundAnything = true
                if not PromptShown then
                    PromptShown = true
                    PromptGroup:HideAll()
                    PromptGroup:Show({ CraftPrompt })
                    CraftPrompt:Enabled(true)
                    print("Surgeon prompt shown")
                end
            end
        end
        if PromptShown and not FoundAnything then
            PromptShown = false
            PromptGroup:HideAll()
            CraftPrompt:Enabled(false)
            print("Surgeon prompt hidden")
            TriggerEvent("redemrp_menu_base:getData", function(call)
                call.CloseAll()
            end)
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for k,v in pairs(Blips) do
            RemoveBlip(v)
        end
    end
end)