# redemrp_farmerjob
A Simple Farmer Job with a lot of config options for RedEM:RP Framework

## 1. Description
It's a simple Farmer Job for RedEM:RP Framework, there is a lot of config options,
it's easy to install and use. Feel free to change anything you want.

## 2. Installation
- Be sure you have RedEM and RedEM:RP Installed
if not -> [RedEM](https://github.com/kanersps/redem) --> [RedEM:RP](https://github.com/RedEM-RP/redem_roleplay)
- Clone redemrp_farmerjob into [redemrp] folder
- add ```ensure redemrp_farmerjob``` in your server.cfg

## 3. Config

This is the default config.lua file
```
Config = {}

Config.FarmerJob = {x=1404.36,y=-1373.37,z=81.29} -- Farmer Job Position
Config.FarmerJobSprite = 1560611276 -- Farmer Job Blip sprite

Config.GatheringAnim = "WORLD_HUMAN_CROUCH_INSPECT" -- Scenario while Gathering
Config.FreezeWhileGather = true -- Freeze player while he's gathering
Config.SetJob = true -- Set job after Start working
Config.JobName = "farmer" -- Job name to set

Config.StartWorking = "Press DEL to start working as Farmer!" -- Start Working Message
Config.StartGather = "Press DEL to start gathering!" -- Start Gathering Message
Config.TimerMsg = "Gathering will be finished in" -- Finish message

Config.MinCash = 1 -- Min Payout
Config.MaxCash = 3 -- Max Payout
Config.MinExp = 1 -- Min EXP
Config.MaxExp = 2 -- Max EXP

Config.GatheringTime = 10000 -- Time to Gather
Config.NeededPoints = 4 -- Needed gathered points to recive a payout and exp
Config.PointDistance = 5.0 -- Distance needed to gathered

Config.ShowBlips = true -- Show Point blips
Config.PointSprite = 2033377404 -- Point Sprite

Config.Center = {x=1077.64,y=-1758.49,z=48.97} -- Center of points -- maded for security
Config.DistanceFromCenter = 100.0 -- Distance of the area where all points are located 

Config.Point1 = {x=1073.62,y=-1726.24,z=48.78} -- Point 1 location
Config.Point2 = {x=1082.53,y=-1750.89,z=49.4} -- Point 2 location
Config.Point3 = {x=1063.93,y=-1774.09,z=47.88} -- Point 3 location
Config.Point4 = {x=1083.6,y=-1805.67,z=48.62} -- Point 4 location
```

## 4. Credits
https://github.com/amakuu/
