# redemrp_shops
A shops system for RedEM:RP

## 1. Requirements

[redemrp_inventory](https://github.com/RedEM-RP/redemrp_inventory)

[pNotify](https://github.com/Nick78111/pNotify)

[redemrp_menu_base](https://github.com/RedEM-RP/redemrp_menu_base)

## 2. Installation

Add ```ensure redemrp_shops``` in server.cfg after ```ensure redemrp_inventory``` and ```ensure redemrp_menu_base```

## 3. Configuration

All configuration is in config.lua and items.lua file with example 

Config file :
```
	Basic = { -- Basic is shop type
		Items = {}, -- dont touch this
		Legal = true, -- if true set blip
		Pos = {
			{x = -324.28,   y = 801.51, z = 117.88},		-- position to open shop
		},
		Spawn = {
			{x = -323.18,   y = 802.81, z = 117.94},	 -- spawn	object position		
		},
	},
```
Items file:
```
{store = "Basic" , item = "water" , price = 0.8 , object = "p_water01x"},
-- store is shop type
-- item is item name to spawn
-- price item price (:
-- object model to spawn 
```

## 4. Credits
[Ktos93](http://github.com/Ktos93)


Join discord to get support! - https://discord.gg/FKH4uwb
