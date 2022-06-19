local gathering = false
local isFarmer = false
local finished = 0
local payout = math.random(Config.MinCash,Config.MaxCash)
local xp = math.random(Config.MinExp,Config.MaxExp)

Citizen.CreateThread(function()
    while not isFarmer do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.FarmerJob.x, Config.FarmerJob.y, Config.FarmerJob.z, true)
		if betweencoords <= 2.2 then
		DrawTxt(Config.StartWorking, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0x4AF4D473) and not pressing and not started then
				pressing = true
				if Config.SetJob then
				TriggerServerEvent('redemrp_farmerjob:setJob', Config.JobName) -- TEMP NOT WORKING
				else end
				isFarmer = true
				startMission()
			end
		end
	end
end)

Citizen.CreateThread(function()
	Wait(0)
	Citizen.InvokeNative(0x554d9d53f696d002, Config.FarmerJobSprite, Config.FarmerJob.x, Config.FarmerJob.y, Config.FarmerJob.z)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function startMission()
started = true
if Config.ShowBlips then
Citizen.InvokeNative(0x554d9d53f696d002, Config.PointSprite, Config.Point1.x, Config.Point1.y, Config.Point1.z)
Citizen.InvokeNative(0x554d9d53f696d002, Config.PointSprite, Config.Point2.x, Config.Point2.y, Config.Point2.z)
Citizen.InvokeNative(0x554d9d53f696d002, Config.PointSprite, Config.Point3.x, Config.Point3.y, Config.Point3.z)
Citizen.InvokeNative(0x554d9d53f696d002, Config.PointSprite, Config.Point4.x, Config.Point4.y, Config.Point4.z)
else end
Citizen.CreateThread(function()
while true do
	Wait(0)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point1.x, Config.Point1.y, Config.Point1.z, true)
	local betweencoords2 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point2.x, Config.Point2.y, Config.Point2.z, true)
	local betweencoords3 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point3.x, Config.Point3.y, Config.Point3.z, true)
	local betweencoords4 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Point4.x, Config.Point4.y, Config.Point4.z, true)
	if betweencoords <= Config.PointDistance and not gathering and isFarmer then
	DrawTxt(Config.StartGather, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0x4AF4D473) and not gathering then
				startGathering(1)
			end
	elseif betweencoords2 <= Config.PointDistance and not gathering and isFarmer then
	DrawTxt(Config.StartGather, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0x4AF4D473) and not gathering then
				startGathering(1)
			end
	elseif betweencoords3 <= Config.PointDistance and not gathering and isFarmer then
	DrawTxt(Config.StartGather, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0x4AF4D473) and not gathering then
				startGathering(1)
			end
			
	elseif betweencoords4 <= Config.PointDistance and not gathering and isFarmer then
	DrawTxt(Config.StartGather, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
		if IsControlJustPressed(2, 0x4AF4D473) and not gathering then
				startGathering(1)
			end
	else end
	end
end)
end

function startGathering(count)
local playerPed = PlayerPedId()
local coords = GetEntityCoords(playerPed)
local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Center.x, Config.Center.y, Config.Center.z, true)
if betweencoords <= Config.DistanceFromCenter and not gathering and isFarmer and started then -- SECURITY
	pressing = false
	FreezeEntityPosition(playerPed, Config.FreezeWhileGather)
	TaskStartScenarioInPlace(playerPed, GetHashKey(Config.GatheringAnim), Config.GatheringTime, true, false, false, false)
	local timer = GetGameTimer()+Config.GatheringTime
	if isFarmer and started then
	Citizen.CreateThread(function()
		while timer >= GetGameTimer() do
		Wait(0)
		gathering = true
		DrawTxt(Config.TimerMsg .. " " .. tonumber(string.format("%.0f", (((GetGameTimer() - timer) * -1)/1000))), 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			end
		ClearPedTasksImmediately(PlayerPedId())
		FreezeEntityPosition(playerPed, false)
		gathering = false
		finished = finished + count
		--print(finished)
		if isFarmer and started and finished < Config.NeededPoints then
		elseif isFarmer and started and finished >= Config.NeededPoints then
		TriggerServerEvent('redemrp_farmerjob:addMoney', payout, xp)
		finished = 0
		else end
		end)
	else end
else end
end