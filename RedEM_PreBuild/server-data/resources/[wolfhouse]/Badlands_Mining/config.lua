Config = {}


Config.PickaxeModel = `p_pickaxe01x`
Config.WorkDuration = 25--seconds

Config.Checkpoints = {
    rotate = true,
    size = 0.5,
    height = 0.2,
    rgba = {255, 192, 0, 50},
}

Config.Blip = {
    {x = 2756.14, y = 1364.12, z = 67.88, sprite = 1970061205, name = "Mining Area", enabled = true},--Annesburg Mine
    {x = -1516.6765136719, y = 741.62310791016, z = 125.7699508667, sprite = 1970061205, name = "Mining Area", enabled = true},--Diablo Cave
    {x = -4430.7797851562, y = -2181.6166992188, z = 42.719188690186, sprite = 1970061205, name = "Mining Area", enabled = true},--Hidden Cave
    {x = 2296.1799316406, y = 1030.5914306641, z = 80.378128051758, sprite = 1970061205, name = "Mining Area", enabled = true},--Elysian Cave
}

Config.Walk = {
    Male = {
        ["BoneID"] = 338,
        ["PX"] = 0.05,
        ["PY"] = -0.03,
        ["PZ"] = -0.01,
        ["PRX"] = 0.0,
        ["PRY"] = 90.0,
        ["PRZ"] = 81.0,
    },
    Female = {
        ["BoneID"] = 397,
        ["PX"] = 0.04,
        ["PY"] = -0.05,
        ["PZ"] = -0.03,
        ["PRX"] = 0.0,
        ["PRY"] = 90.0,
        ["PRZ"] = 81.0,
    },
}

Config.Work = {
    Male = {
        ["BoneID"] = 227,
        ["PX"] = 0.0,
        ["PY"] = 0.01,
        ["PZ"] = -0.13,
        ["PRX"] = 12.0,
        ["PRY"] = 0.0,
        ["PRZ"] = 270.0,
    },
    Female = {
        ["BoneID"] = 285,
        ["PX"] = 0.0,
        ["PY"] = -0.01,
        ["PZ"] = -0.26,
        ["PRX"] = 9.0,
        ["PRY"] = 0.0,
        ["PRZ"] = 270.0,
    },
}

Config.Prompts = {
    Title = "Pickaxe",
    Stop = {0x5966D52A, "Put Away"},
    Work = {0x39336A4F, "Work"},
}

Config.Anims = {
    walk = {"amb_wander@code_human_coal_carry@shovel@male_a@wip_walk_cart", "wip_walk_cart", 31},
    work = {"amb_work@world_human_pickaxe@wall@male_d@idle_a", "idle_b", 1},
}

Config.BasicLoot = "rock"

Config.Texts = {
    Pickaxe = "Pickaxe",
    CantMine = "You can not mine here!",
    CantUse = "You can not use it right now!",
    MiningAt = "Mining at",
    Collected = "You collected",
    And = "and"
}

Config.MinePoints = {
    [1] = {x = 2756.08, y = 1301.94, z = 69.94, h = 89.46, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [2] = {x = 2756.13, y = 1303.79, z = 69.93, h = 78.14, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [3] = {x = 2756.47, y = 1305.79, z = 69.93, h = 94.48, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [4] = {x = 2759.91, y = 1302.31, z = 69.93, h = 242.61, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [5] = {x = 2759.84, y = 1304.34, z = 69.93, h = 259.32, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [6] = {x = 2760.54, y = 1309.80, z = 69.95, h = 282.90, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [7] = {x = 2760.69, y = 1311.33, z = 69.97, h = 261.58, name = "Annesburg Mine", luck = 15, items = {"ironore","ruby"},},
    [8] = {x = 2731.94, y = 1332.33, z = 69.62, h = 6.03, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [9] = {x = 2728.59, y = 1332.54, z = 69.62, h = 355.74, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [10] = {x = 2728.18, y = 1329.81, z = 69.59, h = 165.24, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [11] = {x = 2731.32, y = 1329.41, z = 69.59, h = 180.42, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [12] = {x = 2717.59, y = 1314.04, z = 69.73, h = 23.36, name = "Annesburg Mine", luck = 15, items = {"diamond","silverore"},},
    [13] = {x = 2715.60, y = 1313.57, z = 69.70, h = 3.80, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [14] = {x = 2713.83, y = 1313.57, z = 69.71, h = 20.41, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [15] = {x = 2710.73, y = 1308.77, z = 69.70, h = 95.94, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [16] = {x = 2712.18, y = 1308.46, z = 69.70, h = 198.41, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [17] = {x = 2714.20, y = 1308.04, z = 69.74, h = 177.67, name = "Annesburg Mine", luck = 10, items = {"ironore", "diamond"},},
    [18] = {x = 2723.26, y = 1375.58, z = 68.87, h = 138.18, name = "Annesburg Mine", luck = 10, items = {"ironore","golden_nugget"},},
    [19] = {x = 2762.07, y = 1364.55, z = 68.09, h = 240.15, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [20] = {x = 2757.65, y = 1371.29, z = 68.09, h = 29.73, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [21] = {x = 2753.47, y = 1368.02, z = 67.84, h = 42.62, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [22] = {x = 2755.97, y = 1359.25, z = 68.02, h = 191.08, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [23] = {x = 2752.93, y = 1360.37, z = 68.59, h = 97.42, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [24] = {x = 2769.78, y = 1382.17, z = 68.02, h = 353.39, name = "Annesburg Mine", luck = 20, items = {"ironore"},},
    [25] = {x = 2778.89, y = 1377.3, z = 68.12, h = 278.33, name = "Annesburg Mine", luck = 15, items = {"diamond"},},
    [26] = {x = 2778.73, y = 1372.95, z = 68.18, h = 256.33, name = "Annesburg Mine", luck = 20, items = {"ironore"},},

    [27] = {x = -2720.0471191406, y = 685.81365966797, z = 175.71385192871, h = 89.05591583252, name = "Diablo Cave", luck = 5, items = {"golden_nugget", "ironore"},},
    [28] = {x = -2716.8845214844, y = 683.94274902344, z = 175.73341369629, h = 264.20483398438, name = "Diablo Cave", luck = 5, items = {"golden_nugget"},},
    [29] = {x = -2717.7546386719, y = 725.88208007812, z = 176.26705932617, h = 133.59625244141, name = "Diablo Cave", luck = 20, items = {"golden_nugget"},},
    [30] = {x = -2726.13671875, y = 730.04162597656, z = 171.47245788574, h = 72.942947387695, name = "Diablo Cave", luck = 5, items = {"golden_nugget"},},
    [31] = {x = -2733.1181640625, y = 722.98400878906, z = 170.31278991699, h = 49.429893493652, name = "Diablo Cave", luck = 5, items = {"golden_nugget"},},
    [32] = {x = -2712.927734375, y = 718.3076171875, z = 171.26075744629, h = 285.18231201172, name = "Diablo Cave", luck = 20, items = {"golden_nugget", "ironore"},},

    [33] = {x = -4430.77, y = -2181.61, z = 42.71, h = 98.11, name = "Hidden Cave", luck = 15, items = {"golden_nugget"},},
    [34] = {x = -4428.17, y = -2182.5, z = 42.91, h = 301.47, name = "Hidden Cave", luck = 15, items = {"golden_nugget"},},
    [35] = {x = -4428.08, y = -2185.9, z = 42.82, h = 143.84, name = "Hidden Cave", luck = 15, items = {"golden_nugget"},},


    [36] = {x = 2277.31, y = 1060.52, z = 78.73, h = 185.18, name = "Elysian Cave", luck = 10, items = {"emerald", "ironore"},},
    [37] = {x = 2294.21, y = 1034.12, z = 80.28, h = 136.97, name = "Elysian Cave", luck = 10, items = {"emerald", "ironore"},},
    [38] = {x = 2295.01, y = 1041.05, z = 79.83, h = 305.64, name = "Elysian Cave", luck = 10, items = {"emerald", "ironore"},},
    [39] = {x = 2289.89, y = 1041.15, z = 79.46, h = 103.46, name = "Elysian Cave", luck = 10, items = {"emerald", "ironore"},},
    [40] = { x =2297.94, y = 1033.95, z = 79.72, h = 250.58, name = "Elysian Cave", luck = 15, items = {"emerald", "silverore"},},
    [41] = { x =2296.71, y = 1030.71, z = 80.31, h = 186.27, name = "Elysian Cave", luck = 15, items = {"emerald", "silverore"},},

    [42] = {x = 1511.75, y = -7167.36, z = 65.51, h = 284.63, name = "Guarma Cave", luck = 55, items = {"ironore"},},
    [43] = {x = 1509.9, y = -7164.75, z = 64.78, h = 104.28, name = "Guarma Cave", luck = 55, items = {"ironore"},},
    [44] = {x = 1510.42, y = -7161.7, z = 63.81, h = 290.2, name = "Guarma Cave", luck = 55, items = {"ironore"},},
    [45] = {x = 1509.17, y = -7158.45, z = 63.3, h = 89.96, name = "Guarma Cave", luck = 55, items = {"ironore"},},
    [46] = {x = 1508.94, y = -7154.4, z = 62.69, h = 239.72, name = "Guarma Cave", luck = 55, items = {"ironore"},},
}

Config.Textures = {
    cross = {"scoretimer_textures", "scoretimer_generic_cross"},
    locked = {"menu_textures","stamp_locked_rank"},
    tick = {"scoretimer_textures","scoretimer_generic_tick"},
    money = {"inventory_items", "money_moneystack"},
}

--[[
-- Mining Items Below --
["pickaxe"] =
{
    label = "Pickaxe",
    description = "Worktool",
    weight = 1.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/pickaxe.png",
    type = "item_standard",
},
["rock"] =
    {
    label = "Rock",
    description = "Ore",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
     imgsrc = "items/rock.png",
    type = "item_standard",
},
["golden_nugget"] =
{
    label = "Gold nugget",
    description = "Ore",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
    imgsrc = "items/golden_nugget.png",
    type = "item_standard",
},
["ruby"] =
{
    label = "Ruby",
    description = "Gem",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
    imgsrc = "items/ruby.png",
    type = "item_standard",
},
 ["diamond"] =
{
    label = "Diamond",
    description = "Gem",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
    imgsrc = "items/diamond.png",
    type = "item_standard",
},
["emerald"] =
{
    label = "Emerald",
    description = "Gem",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
    imgsrc = "items/emerald.png",
    type = "item_standard",
},
["silverore"] =
{
    label = "Silver ore",
    description = "Ore",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
    imgsrc = "items/silverore.png",
    type = "item_standard",
},
["ironore"] =
{
    label = "Iron ore",
    description = "Ore",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 100,
    imgsrc = "items/ironore.png",
    type = "item_standard",
},
--]]