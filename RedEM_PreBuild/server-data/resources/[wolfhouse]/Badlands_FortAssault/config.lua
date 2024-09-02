Config = {}

Config.RewardMoney = 1000 -- Amount of money player recieves for mission (Default $1250)
Config.StartMessage = '[~e~ENTER~q~] Take over the Fort!'
Config.NeedMessage = "You need a shovel to take down this flag"
Config.BackupMessage = "Looks like more of them are here!."
Config.FinishMessage = "Yee Haw !! We took down the fort"
Config.ItemChoice = "shovel" -- Item needed to start the mission

Config.RewardItem = "golden_nugget" -- Item given if complete (Random chance of 4-8 if this)
Config.RewardItem2 = "golden_nugget" -- Item given if complete (Random chance of 4-8 if this)
Config.RewardItem3 = "golden_nugget" -- Item given if complete (Random chance of 10-30 if this)
Config.RewardItem4 = "golden_nugget" -- Item given if complete (Random chance of 4-8 if this)
Config.RewardItem5 = "golden_nugget" -- Item given if complete (Random chance of 4-8 if this)

--------------------------------DONT TOUCH BELOW THIS UNLESS YOU HAVE A GOOD UNDERSTANDING OF WHAT TO DO--------------------------------

------------------------ Changing these numbers around will affect the way the zones and waves of spawn perform ------------------------


Config.DeadPedWipe = vector3(350.3, 1487.34, 179.52) -- Center of the fort, so bodies dont pile up
Config.DeadPedDist = 100.0 -- Distance from above position that bodies will be wiped
Config.WaitTime = 120000 -- Time in ms how often peds are wiped// Change this at your own risk from default tested values. (Default 120000)

Config.TotalTime = 600 -- Countdown (Default 600 = approx 10 minutes)
Config.Reinforcements = 540 -- Timer starts at 600, this by default will call reinforcements with 540 seconds on the timer (20 seconds after start)
Config.Reinforcements2 = 420 -- This by default will call reinforcements with 420 seconds on the timer (2 minutes 20 seconds after start)
Config.Reinforcements3 = 300 -- This by default will call reinforcements with 300 seconds on the timer (5 minutes 20 seconds after start)
Config.Reinforcements4 = 180 -- This by default will call reinforcements with 180 seconds on the timer (7 minutes 20 seconds after start)
Config.Reinforcements5 = 60 -- This by default will call reinforcements with 60 seconds on the timer (9 minutes 20 seconds after start)

Config.Armymen = {
    --------------------------------------------------------------ZONE 1--------------------------------------------------------------
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    { x = 368.64, y = 1514.73, z = 180.48 },
    --------------------------------------------------------------ZONE 2--------------------------------------------------------------
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    { x = 375.29, y = 1476.99, z = 179.64 },
    --------------------------------------------------------------ZONE 3--------------------------------------------------------------
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    { x = 374.29, y = 1401.00, z = 174.49 },
    --------------------------------------------------------------ZONE 4--------------------------------------------------------------
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    { x = 286.21, y = 1438.13, z = 162.86},
    --------------------------------------------------------------ZONE 5--------------------------------------------------------------
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    { x = 307.01, y = 1479.07, z = 178.95},
    --------------------------------------------------------------ZONE 6--------------------------------------------------------------
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    { x = 352.15, y = 1453.95, z = 178.92},
    --------------------------------------------------------------ZONE 7--------------------------------------------------------------
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    { x = 332.04, y = 1468.73, z = 179.35},
    --------------------------------------------------------------ZONE 8--------------------------------------------------------------
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    { x = 316.68, y = 1512.36, z = 183.11},
    --------------------------------------------------------------ZONE 9--------------------------------------------------------------
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    { x = 339.22, y = 1521.24, z = 183.11},
    --------------------------------------------------------------ZONE 10--------------------------------------------------------------
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48},
    { x = 405.18, y = 1449.85, z = 173.48} --(make sure last soldier spawn does not have a comma `,`)
}
