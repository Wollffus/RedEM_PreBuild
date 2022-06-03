

-- Settings
local color = { r = 102, g = 0, b = 51, alpha = 255 } -- Color of the text 
local font = 7 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = {
    enable = false,
    color = { r = 35, g = 35, b = 35, alpha = 200 },
}
local chatMessage = true
local dropShadow = false

-- Don't touch
local nbrDisplaying = 1


RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source , typ)
     local offset = 1 + (nbrDisplaying*0.14)
    Display(GetPlayerFromServerId(source), text, offset, typ)
end)

function Display(mePlayer, text, offset , typ)
    local displaying = true
	local _typ = typ

    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        print(nbrDisplaying)
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 100.0 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text, _typ)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DrawText3D(x, y, z, text, me)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	local _me = me
    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(1)
		if _me == "me" then
    	SetTextColor(255, 255, 255,255)
		elseif _me == "do" then
		SetTextColor(145, 209, 144, 255)
		elseif _me == "try" then
		SetTextColor(32, 151, 247, 255)
		end
    	SetTextCentre(1)
		if (_x > 0 and _x < 1) or (_y > 0 and _y < 1) then
		 onScreen, _x, _y = GetHudScreenPositionFromWorldPosition(x, y, z)
		DisplayText(str,_x, _y)
		end
    	local factor = (string.len(text)) / 225
    	DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 100, 0)
    	--DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
    end
end