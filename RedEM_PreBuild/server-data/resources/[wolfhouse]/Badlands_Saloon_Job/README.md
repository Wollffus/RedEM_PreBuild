# Saloon Job
Want something a little extra for your RedM server?
Introducing a bartending resource, allowing players to serve at pubs.
Must have the job `bartender` for it to allow you to access the job menu.
Bartenders show animation of server item and place it on nearest table top prop.


## Requirements
- [RedEM:RP]
- [redemrp_menu_base]
- [redemrp_inventory]
- [redemrp_notification]

# How to install
- unzip the folder
- drag `Badlands_Saloon_Job` to your resources folder
- ensure `Badlands_Saloon_Job` in your server.cfg
- Restart your server (Make sure to add items [below] first)

# How to Get The stew animation to work

- Go to redemrp_status\client\client.lua
- Find function Eat()
- Than AFTER that function, add the following function

```lua
function EatBowl()
    TriggerEvent("redemrp_inventory:closeinv")
    local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    local amount = 0
    TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
    TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1183277175 then
            amount = amount + 1
            if amount >= 11 then
                DrunkTime = GetGameTimer()
                IsDrunk = true
                break
            end
        elseif Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == false then
            break
        else
            amount = 0
        end
    end
end
```

# Add Items to your VORP Server
- run the saloonjobitems.sql that is included to add the items to your database

# Add Items to your redemrp_inventory\config.lua
This is set up for redemrp_inventory 2.0

```lua
---------------------------Saloon Job-----------------------------

["bread"] =
{
    label = "Bread",
    description = "Just like mama made it.",
    weight = 1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 64,
    imgsrc = "items/bread.png",
    type = "item_standard",

},

["beer"] =
{
    label = "Beer",
    description = "It's 5pm some where",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/beer.png",
    type = "item_standard",
},

["good_whisky"] =
{
    label = "Good Whiskey",
    description = "A gentlemen's drink",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/good_whisky.png",
    type = "item_standard",
},

["dirty_whiskey"] =
{
    label = "Dirty Whiskey",
    description = "Because time is never wasted when you're wasted all the time.",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/dirty_whiskey.png",
    type = "item_standard",
},

["cigarettes"] =
{
    label = "Cigarettes",
    description = "Shmoke and a pancake?",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 64,
    imgsrc = "items/selfcigarettes.png",
    type = "item_standard",
},

["goulash"] =
{
    label = "Goulash",
    description = "A delicious stew",
    weight = 1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/goulash.png",
    type = "item_standard",
},

["capocollo"] =
{
    label = "Capocollo Meat",
    description = "Top tier meat, maybe a species of  Wolf?",
    weight = 1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/capocollo.png",
    type = "item_standard",
},

["cigar"] =
{
    label = "Cigar",
    description = "A pure cigar from the finest leaves",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 64,
    imgsrc = "items/selfcigars.png",
    type = "item_standard",
},

["water"] =
{
    label = "water",
    description = "That's some high quality H2O",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 64,
    imgsrc = "items/water.png",
    type = "item_standard",
},

["coffee"] =
{
    label = "Coffee",
    description = "The best part of waking up.",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/coffee.png",
    type = "item_standard",
},

["lemonade"] =
{
    label = "Lemonade",
    description = "Why's it so spicey",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/lemonade.png",
    type = "item_standard",
},

["minttea"] =
{
    label = "Mint Tea",
    description = "Minty",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/minttea.png",
    type = "item_standard",
},

["wine"] =
{
    label = "Wine",
    description = "It's time to get white girl wasted",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/wine.png",
    type = "item_standard",
},


["champagne"] =
{
    label = "Champagne",
    description = "Cheers!",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/champagne.png",
    type = "item_standard",
},
```

# Support https://discord.gg/zGVDppYxfk