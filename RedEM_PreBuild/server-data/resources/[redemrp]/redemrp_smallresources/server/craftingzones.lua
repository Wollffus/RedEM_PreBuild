local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
	data.CreateCraftingStation("cooking_1", -5520.59, -2906.33, -1.78, "cooking" , "empty")  -- Tumbleweed cooking
    data.CreateCraftingStation("cooking_2", -3698.27, -2601.46, -13.35, "cooking" , "empty")    -- Armadillo cooking
	data.CreateCraftingStation("cooking_3", -819.61, -1319.08, 44.03, "cooking" , "empty") -- Blackwater cooking
	data.CreateCraftingStation("cooking_5", -1886.03,  1335.11,  200.72, "cooking" , "empty") -- snow village
	data.CreateCraftingStation("cooking_6", -1352.19,  2423.97,  307.83, "cooking" , "empty") -- colter
	data.CreateCraftingStation("cooking_7", -308.77,  805.51,  119.0, "cooking" , "empty") -- valentine
	data.CreateCraftingStation("cooking_8", -238.88,  767.58,  118.11, "cooking" , "empty")-- valentine
	data.CreateCraftingStation("cooking_9", 356.21,  1480.25,  179.83,"cooking" , "empty")-- fort wallace
	data.CreateCraftingStation("cooking_10", 1446.32,  375.73,  89.92,"cooking" , "empty") -- emerald ranch
	data.CreateCraftingStation("cooking_11", 2953.08,  1314.79,  44.84,"cooking" , "empty") -- annesburg
	data.CreateCraftingStation("cooking_12", 2521.53,  771.93,  74.88,"cooking" , "empty") -- butcher creek
	data.CreateCraftingStation("cooking_13", 2943.53,  523.37,  45.4,"cooking" , "empty") -- van horn
	data.CreateCraftingStation("cooking_14", 1905.97,  -721.07,  42.17,"cooking" , "empty") -- bayou
	data.CreateCraftingStation("cooking_15", 1337.95,  -1374.48,  84.31,"cooking" , "empty") -- parlour house
	data.CreateCraftingStation("cooking_16", 1408.13,  -1145.68,  75.63,"cooking" , "empty") -- rhodes
	data.CreateCraftingStation("cooking_17", 1002.02,  -1776.6,  47.6,"cooking" , "empty") -- braithwait
	data.CreateCraftingStation("cooking_18", 1898.87,  -1854.86,  43.19,"cooking" , "empty") -- shady belle
	data.CreateCraftingStation("cooking_19", 2630.05,  -1227.25,  59.61,"cooking" , "empty") -- bastille 
	data.CreateCraftingStation("cooking_20", 2795.53,  -1167.45,  47.95,"cooking" , "empty")-- doyles
	data.CreateCraftingStation("cooking_21", 2394.85,  -1082.3,  47.45,"cooking" , "empty") -- gov mansion
	data.CreateCraftingStation("cooking_22",-2365.8,  -2391.42, 62.5,"cooking" , "empty") -- mcfarland
	data.CreateCraftingStation("cooking_23",-1414.07, -2337.45, 43.11,"cooking" , "empty") -- theives landing
	data.CreateCraftingStation("cooking_24",-1814.08, -367.24,  162.9,"cooking" , "empty") -- strawberry
	data.CreateCraftingStation("cooking_25",468.92,  2262.28, 249.15,"cooking" , "empty") -- wapiti
	data.CreateCraftingStation("cooking_26",-1986.72,  -1638.96, 117.14,"cooking" , "empty")-- manzanita
	data.CreateCraftingStation("crafting_1", -5514.95, -3039.28, -2.42, "crafting" , "empty") -- Tumbleweed crafting
	data.CreateCraftingStation("crafting_2", -3687.06, -2620.08, -13.44, "crafting" , "empty") -- Armadillo crafting
	data.CreateCraftingStation("crafting_3", -860.74, -1281.43, 43.53, "crafting" , "empty") -- Blackwater crafting
	data.CreateCraftingStation("crafting_4", 2935.82, 561.44, 44.97, "crafting" , "empty") -- Van Horn
	data.CreateCraftingStation("crafting_5", 3017.65, 1352.32, 42.77, "crafting" , "empty") -- Annesburg
	data.CreateCraftingStation("crafting_6", 2361.23,-1450.34,46.1, "crafting" , "empty") -- St.Denis
	data.CreateCraftingStation("crafting_7", 464.79, 2245.85, 248.25, "crafting" , "empty") -- Wapiti
	data.CreateCraftingStation("crafting_8", -356.03, 741.79, 117.12, "crafting" , "empty") -- Valentine
	data.CreateCraftingStation("crafting_9", -1327.36,2473.38, 309.67, "crafting" , "empty") -- Colter
	data.CreateCraftingStation("crafting_10", -2587.75, 409.91, 148.99, "crafting" , "empty") -- Big Valley Ranch
	data.CreateCraftingStation("crafting_11", -1819.87, -421.72,160.01, "crafting" , "empty") -- Strawberry
	data.CreateCraftingStation("crafting_12", 1415.71, 276.89, 89.54, "crafting" , "empty") -- emerald ranch
	data.CreateCraftingStation("crafting_13", -1985.34,-1646.41,117.12, "crafting" , "empty") -- Manzenita post
	data.CreateCraftingStation("crafting_14", -2401.79, -2382.11, 61.21, "crafting" , "empty") -- Mcfarlands
	data.CreateCraftingStation("crafting_15", 986.48, -2031.92, 48.87, "crafting" , "empty") -- Braithwait
	data.CreateCraftingStation("crafting_16", 1881.36, -1343.92, 42.53, "crafting" , "empty") -- Caliga hall
	data.CreateCraftingStation("crafting_17", 1880.13, -731.61, 42.07, "crafting" , "empty") -- Bayou
	data.CreateCraftingStation("smelting_1", -5514.21, -2945.82, -1.99, "smelting" , "empty") --Tumbleweed smelting
	data.CreateCraftingStation("smelting_2", -3681.39, -2565.47, -13.59, "smelting" , "empty") -- Armadillo smelting
	data.CreateCraftingStation("smelting_3", -866.81, -1286.4, 43.07, "smelting" , "empty") -- Blackwater smelting
	data.CreateCraftingStation("smelting_4",2515.36,  -1456.54,  46.33,"smelting" , "empty") -- St.D
	data.CreateCraftingStation("smelting_5",-369.45,  796.18,  116.26,"smelting" , "empty") -- Valentine
	data.CreateCraftingStation("smelting_6",-1346.84,  2402.14,  307.09,"smelting" , "empty") --Colter
	data.CreateCraftingStation("smelting_7",-2592.73,  408.23,  148.9,"smelting" , "empty")--big valley
	data.CreateCraftingStation("smelting_8",-1820.21,  -568.01,  156.02,"smelting" , "empty")--strawberry
	data.CreateCraftingStation("smelting_9",1414.94,  279.21,  89.51,"smelting" , "empty")--emerald
	data.CreateCraftingStation("smelting_10",-2396.69,  -2377.95,  61.24,"smelting" , "empty")--mcfarland
	data.CreateCraftingStation("smelting_11",1884.8,  -1350.59,  42.53,"smelting" , "empty")--caliga
    data.updateCraftings(-1)
end)
