# Badlands_Goldpanning

Gold panning made fun for your server !
The experience every server needs !!!

    - Gives Players random xp when they find gold
    - Random chances at different amounts of gold
    - Config options to make messages and find rates cater to your server
    - Group activity or solo, made great either way
    - Pan almost any body of water

## Requirements

|Requirements |RedEM:RP, redemrp_notification|
|---|---|
|Subscription based |No|
|Code accessible |No|
|Lines (approximately) |130|
|Support |Yes|(discord.gg/zGVDppYxfk)

- (https://github.com/RedEM-RP/redem_roleplay)
- (https://github.com/Wollffus/redemrp_notification) -- Forked version


# How to install
- unzip the folder
- drag `Badlands_Goldpanning` to your resources folder
- create an item named `goldnugget`
- ensure `Badlands_Goldpanning` in your server.cfg
- restart your server

```lua
    -- Gold Panning Items Below --
    ["goldpan"] = {
        label = "Gold Pan",
        description = "A tool to find gold in water",
        weight = 1.0,
        canBeDropped = true,
        canBeUsed = true,
        limit = 2,
        imgsrc = "items/goldpan.png",
        type = "item_standard"
    },
    ["goldnugget"] = {
        label = "Small Golden Nugget",
        description = "Seems like its worth its weight in gold",
        weight = 0.01,
        canBeDropped = true,
        canBeUsed = true,
        limit = 100,
        imgsrc = "items/goldnugget.png",
        type = "item_standard"
    },
```