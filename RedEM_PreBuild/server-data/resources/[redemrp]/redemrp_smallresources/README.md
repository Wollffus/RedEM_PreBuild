# redemrp_smallresources
A collection of resources most servers need and utilize. Most resources are
roleplay essentials, bringing more immersion to your servers.

- Remove Aim assist
- Add bath houses (True/False options in config)
- Add blip maker (True/False options in config)
- Add coordinates command /coords (True/False options in config)
- Delete horse commmand /dh
- Door openener (opens locked base game doors)
- Gun twirl, gun trick (True/False options in config)
- Handcuffs as an item w/search option
- Handsup command /hu (True/False options in config)
- Display player id above head (True/False options in config) (Change default key in config)
- Pointing animation with (True/False options in config) (Change default key in config)
- Smoking animations
- Gold Stamina bar

## Requirements
- RedEM:RP

## Optional
 - N/A

# How to install

- unzip the folder
- drag `redemrp_smallresources` into your resources folder
- ensure `redemrp_smallresources` in your server.cfg
- restart your server

# Items

- Cuffs item for redemrp_inventory 2.0

	["handcuffs"] =
    {
        label = "Handcuffs",
        description = "Popular item for police, bandits & married couples",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/handcuffs.png",
        type = "item_standard",
    },

- Cuffs item for VORP (VORP IS NOT SUPPORTED BY DEFAULT)

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('handcuffs', 'Handcuffs', 10, 1, 'item_standard', 1);