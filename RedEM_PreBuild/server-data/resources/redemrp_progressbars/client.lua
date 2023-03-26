local TextureDicts = {"rpg_meter", "rpg_meter_track", "generic_textures"}

function RequestDict(dicts)
    for k, v in pairs(dicts) do
        while not HasStreamedTextureDictLoaded(v) do
            Wait(0)
            RequestStreamedTextureDict(v, true)
        end
    end
end

exports('DisplayProgressBar', function(time, desciption, cb)
    RequestDict(TextureDicts)
    local timer = (time / 100)
    local DisplayElemet = 0
    Citizen.CreateThread(function()
        while DisplayElemet < 99 do
            Wait(1)
            DrawSprite("generic_textures", "counter_bg_1b", 0.5, 0.9, 0.023, 0.04, 0.0, 0, 0, 0, 255)
            DrawSprite("rpg_meter_track", "rpg_meter_track_9", 0.5, 0.9, 0.03, 0.05, 0.0, 176, 176, 176, 120)
            DrawSprite("rpg_meter", "rpg_meter_" .. DisplayElemet, 0.5, 0.9, 0.03, 0.05, 0.0, 225, 225, 225, 255)
            Text(0.5001, 0.89, 0.28, tostring(DisplayElemet + 1), {225, 225, 225}, false, true)
            Text(0.5001, 0.93, 0.28, desciption, {255, 255, 255}, false, true)
        end
    end)
    
    if cb then
        Citizen.CreateThread(function()
            cb()
        end)
    end

    while DisplayElemet < 100 do
        DisplayElemet = DisplayElemet + 1
        Wait(timer)
    end
end)

function Text(x, y, scale, text, colour, align, force, w)
    local colour = colour or Config.GUI.TextColor
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextFontForCurrentCommand(7)
    SetTextScale(scale, scale)
    Citizen.InvokeNative(1758329440 & 0xFFFFFFFF, align)
    SetTextColor(colour[1], colour[2], colour[3], 255)
    if w then
        Citizen.InvokeNative(1868606292 & 0xFFFFFFFF, w.x, w.y)
    end
    SetTextDropshadow(3, 0, 0, 0, 255)
    DisplayText(str, x, y)
end
