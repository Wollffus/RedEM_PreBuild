# Badlands_Graverobbing
Are you looking for extra bandit style activities for your players or friends?
Venture beyond the grave with a shovel and test your luck! This will bring fun for
your players as well as lawmen for those looking to bring more bandit style roleplay to their servers.

Animation for digging as well as shovel props
Configurable for up to 6 items to be randomly found within the grave inside the config.lua

If you know how to change the getPlayerFromId function to your framework, or want notification or progress bars swapped out for
yours, you can send the line of code that would be needed that way it can be changed in the script for you.

## Requirements
- [RedEM:RP] (https://github.com/RedEM-RP) -- This is for the getplayer by ID function. If you know what is needed to convert to your framework I can change
- [redemrp_progressbars] (https://github.com/Wollffus/redemrp_progressbars) -- Forked version incase you need it
- [redemrp_notification] (https://github.com/Wollffus/redemrp_notification) -- Forked version incase you need it

# How to install
- unzip the folder
- drag `Badlands_Graverobbing` to your resources folder

- ensure `Badlands_Graverobbing` in your server.cfg
- restart your server

```lua
    -- Grave Robbing Items Below -- Can be switched to whatever you want in the config
    ["shovel"] = {
        label = "Shovel",
        description = "Good for yard work, or other things",
        weight = 5.00,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 2,
        imgsrc = "items/shovel.png",
        type = "item_standard",
    },
    ["humanbones"] = {
        label = "Human Bones",
        description = "You should probably put this back",
        weight = 0.001,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 200,
        imgsrc = "items/humanbones.png",
        type = "item_standard",
    },
    ["rustypocketwatch"] = {
        label = "Old Pocket Watch",
        description = "An old rusty pocket watch",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/rustypocketwatch.png",
        type = "item_standard",
    },
    ["silvercoin"] = {
        label = "Silver Coin",
        description = "This seems like it has some value",
        weight = 0.3,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/silvercoin.png",
        type = "item_standard",
    },
    ["oldbible"] = {
        label = "Old Bible",
        description = "King James Version Bible",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/oldbible.png",
        type = "item_standard",
    },
    ["silverring"] = {
            label = "Silver Ring",
            description = "This seems like is has some value",
            weight = 0.4,
            canBeDropped = true,
            canBeUsed = false,
            requireLvl = 0,
            limit = 20,
            imgsrc = "items/silverring.png",
            type = "item_standard",
    },
```