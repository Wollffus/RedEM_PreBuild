Config = {}
Config.Shoptext = 'Press ~INPUT_JUMP~ to access Clothing Store' -- Text to open the clothing shop
Config.Cloakroomtext = 'Press ~INPUT_JUMP~ to change your Outfit' -- Text to open the clothing shop
Config.BlipName = 'Clothing Store' -- Blip Name Showed on map
Config.BlipNameCloakRoom = 'Wardrobe' -- Blip Name Showed on map
Config.EnableCommand = false -- Enable/Disable /clothing command
Config.BlipSprite = 1195729388	 -- Clothing shop sprite
Config.BlipSpriteCloakRoom = 1496995379	 -- Clothing shop sprite
Config.BlipScale = 0.2 -- Blip scale
Config.OpenKey = 0xD9D0E1C0 -- Opening key hash
Config.Zones = {
	vector3(-181.8676, 624.49322, 114.08956), -- VALENTINE
	vector3(1323.6649, -1288.453, 77.020866), -- RHODES
	vector3(2550.81,-1166.28,53.68), -- SAINT DENIS
	vector3(-767.94,-1294.95,43.84), -- BLACK WATER
	vector3(-1794.89,-385.22,160.33), -- STRAWBERRY
	vector3(-3731.783, -2610.405, -12.9377), -- Armadillo
	vector3(2927.3571, 1271.6688, 44.652835), -- Annesburg
	vector3(-5484.658, -2961.321, -1.745089), -- Tumbleweed
}

Config.Cloakroom = {
	vector3(-171.7564, 638.16632, 114.08965), -- VALENTINE
	vector3(-1816.561, -367.8912, 163.29634), -- STRAWBERRY
	vector3(-767.4958, -1291.484, 43.83496), -- BLACKWATER
	vector3(1235.8572, -1304.43, 76.90277), -- RHODES
	vector3(2556.49,-1160.14,53.74), -- SAINT DENIS
	vector3(-3727.226, -2610.616, -12.93387), -- Armadillo
	vector3(-5508.13, -2913.663, -1.751304), -- Tumbleweed
	vector3(2002.7088, -5505.448, 44.389133), -- Guarma Wedding 1
	vector3(1976.2947, -5511.198, 42.824645), -- Guarma Wedding 2
}

Config.Label = {
	["boot_accessories"] = "Boot Accessories",
	["pants"] = "Pants",            	
	["cloaks"] = "Cloak",            	
	["hats"] = "Hat",             	
	["vests"] = "Vest",            	
	["chaps"] = "Chaps",             	
	["shirts_full"] = "Shirt",       	
	["badges"] = "Badge",           	
	["masks"] = "Mask",            	
	["spats"] = "Spats",           	
	["neckwear"] = "Neck",         	
	["boots"] = "Boots",            	
	["accessories"] = "Accessories",      	
	["jewelry_rings_right"] = "Jewelry Right",
	["jewelry_rings_left"]	= "Jewelry Left",
	["jewelry_bracelets"] = "Bracelets",	
	["gauntlets"] = "Gauntlets",        	
	["neckties"] = "Necktie",        	
	["holsters_knife"] = "Knife Holster",   	
	["talisman_holster"] = "Talisman Holster",
	["loadouts"] = "Loadouts",          	
	["suspenders"] = "Suspenders",      	
	["talisman_satchel"] = "Talisman Satchel", 	
	["satchels"] = "Satchel",         	
	["gunbelts"] = "Gunbelt",          	
	["belts"] = "Belt",            	
	["belt_buckles"] = "Belt Buckle",     	
	["holsters_left"] = "Holster Left",    	
	["holsters_right"] = "Holster Right",   	
	["talisman_wrist"] = "Wrist Talisman",   	
	["coats"] = "Coat",            	
	["coats_closed"] = "Coat Closed",     	
	["ponchos"] = "Poncho",           	
	["eyewear"] = "Eyewear",          	
	["gloves"] = "Gloves",           	
	["holsters_crossdraw"] = "Crossdraw Holster", 	
	["aprons"] = "Aprons",			
	["skirts"] = "Skirts",
	["hair_accessories"] = "Hair Accessories",
	["dresses"] = "Dresses",  
	["armor"] = "Armor",    	
}


Config.Price = {
    ["boot_accessories"] = 4,
    ["pants"] = 2,
    ["cloaks"] = 4,
    ["hats"] = 2,
    ["vests"] = 2,
    ["chaps"] = 2,
    ["shirts_full"] = 2,
    ["badges"] = 10,
    ["masks"] = 5,
    ["spats"] = 3,
    ["neckwear"] = 2,
    ["boots"] = 2,
    ["accessories"] = 5,
    ["jewelry_rings_right"] = 10,
    ["jewelry_rings_left"] = 10,
    ["jewelry_bracelets"] = 6,
    ["gauntlets"] = 3,
    ["neckties"] = 3,
    ["holsters_knife"] = 3,
    ["talisman_holster"] = 3,
    ["loadouts"] = 5,
    ["suspenders"] = 3,
    ["talisman_satchel"] = 3,
    ["satchels"] = 3,
    ["gunbelts"] = 3,
    ["belts"] = 2,
    ["belt_buckles"] = 6,
    ["holsters_left"] = 5,
    ["holsters_right"] = 5,
    ["talisman_wrist"] = 5,
    ["coats"] = 5,
    ["coats_closed"] = 5,
    ["ponchos"] = 3,
    ["eyewear"] = 5,
    ["gloves"] = 3,
    ["holsters_crossdraw"] = 4,
    ["aprons"] = 4,
    ["skirts"] = 2,
    ["hair_accessories"] = 2,
	["dresses"] = 1,  
	["armor"] = 20,    	
}

Config.MenuElements = {
	["head"] = {
		label = "Head",
		category = {
			"hats",
			"eyewear",
			"masks",
			"neckwear",
			"neckties",
		}
	},
	["torso"] = {
		label = "Torso",
		category = {
			"cloaks",
			"vests",
			"shirts_full",
			"holsters_knife",
			"loadouts",
			"suspenders",
			"gunbelts",
			"belts",
			"holsters_left",
			"holsters_right",
			"coats",
			"coats_closed",
			"ponchos",
			"dresses",			
		}
	},
	["legs"] = {
		label = "Legs",
		category = {
			"pants",
			"chaps",
			"skirts",
		}
	},
	["foot"] = {
		label = "Boots",
		category = {
			"boots",
			"spats",
			"boot_accessories",
		}
	},
	["hands"] = {
		label = "Hands",
		category = {
			"jewelry_rings_right",
			"jewelry_rings_left",
			"jewelry_bracelets",
			"gauntlets",
			"gloves",
		}
	},
	["accessories"] = {
		label = "Accessories",
		category = {
			"accessories",
			"talisman_wrist",
			"talisman_holster",
			"belt_buckles",
			"satchels",
			"holsters_crossdraw",
			"aprons",
			"bows",
			"armor",
			"badges",
			"hair_accessories",
		}
	},
}