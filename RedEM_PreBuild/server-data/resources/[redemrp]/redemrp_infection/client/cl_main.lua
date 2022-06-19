local sick = 0
local isArmadillo = false
local wasDead = false
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if GetDistanceBetweenCoords(coords, -3667.04, -2611.41, -14.08, true) < Config.PlagueDistance then
			isArmadillo = true
		else
			isArmadillo = false
			sick = 0
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			while isArmadillo do
			Wait(0)
			DrawTxt(Config.msg, 0.50, 0.95, 0.3, 0.3, true, 255, 255, 255, 255, true)
			sick = sick + 1
			--print(sick)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.HurtRefresh)
			local playerPed = PlayerPedId()
				if wasDead == false then
					Wait(0)
						if sick > Config.TimeMax then
						ApplyDamageToPed(playerPed, Config.HurtAmount, true, true, true, true)
						applyDmg()
						--print("APPLYING DAMAGE")
						else end
				end
	end
end)

function applyDmg()
	Citizen.CreateThread(function()
	while true do
	Wait(0)
		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
		while Citizen.InvokeNative(0x2E9C3FCB6798F397, pl) do
			Wait(0)
			wasDead = true
			--print("DEAD")
			Wait(Config.SafeTime)
			--print("TIME RESETED")
			wasDead = false
		end
	end
	end)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end