--- available client functions 
-- Eat()
-- Drink()
-- Wine()
-- Whisky()
-- Shampan()
-- Beer()
-- Coffe()
-- BoostStamina(10)


Config = {}
Config.Items = {

    ["water"] = {
        hunger = 0,
        thirst = 25,
        action = function(source, name)
            TriggerClientEvent('redemrp_status:Action-' .. name, source)
        end,
        ClientAction = function()
            Drink()
            BoostStamina(20)
            -- YOU CAN USE HERE ELSE CLIENT CODE
            -- print("water used") etc
        end
    },

    ["bread"] = {
        hunger = 25,
        thirst = 0,
        action = function(source, name)
            TriggerClientEvent('redemrp_status:Action-' .. name, source)
        end,
        ClientAction = function()
            Eat()
            BoostStamina(20)
        end
    },


}
