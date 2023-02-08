## [Latest Documentation](https://sinatra.gitbook.io/redemrp/ "Latest Documentation")
![](https://img.shields.io/github/stars/RedEM-RP/redemrp_status) ![](https://img.shields.io/github/forks/RedEM-RP/redemrp_status) ![](https://img.shields.io/github/tag/RedEM-RP/redemrp_status) ![](https://img.shields.io/github/release/RedEM-RP/redemrp_status) ![](https://img.shields.io/github/issues/RedEM-RP/redemrp_status) ![](https://img.shields.io/discord/648268213859254309)
# redemrp_status
A status, basic needs system for RedEM:RP Framework

## 1. Requirements

[redemrp_inventory](https://github.com/RedEM-RP/redemrp_inventory/)

## 1. Installation
Add ```ensure redemrp_status``` after inventory in server.cfg

## 2. How to start
You can use build-in client function for items
* Eat()
* Drink()
* Wine()
* Whisky()
* Shampan()
* Beer()
* Coffe()
* BoostStamina(10)
 
or write own code in ClientAction function

```

 ["coffee"] = {
        hunger = 0,
        thirst = 30,
        action = function(source, name)
            TriggerClientEvent('redemrp_status:Action-' .. name, source)
        end,
        ClientAction = function()
            Coffe()
            BoostStamina(50)
            -- YOU CAN WRITE HERE YOUR OWN CODE
            -- print("water used") etc
        end
    },

```
You can also use server event to add thirst and hunger from other scripts
```
TriggerServerEvent('redemrp_status:AddAmount', hunger , thirst)
TriggerServerEvent('redemrp_status:AddAmount', 0 , 25)
```


![alt text](https://i.imgur.com/Pfi4dAj.png)
## 3. Credits
[Ktos93](http://github.com/Ktos93)
[youngsinatra99](http://github.com/youngsinatra99)

Join discord to get support! - https://discord.gg/FKH4uwb
