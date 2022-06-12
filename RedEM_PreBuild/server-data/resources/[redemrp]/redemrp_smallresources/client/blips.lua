-- -- Blip Creator  -------------------------------------------------------------------------
-- Get blip hashes here https://github.com/Wollffus/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips
if Trigger.BLIPS then
local blips = {

    -- add  blips to map
    { name = 'Farmers Market', sprite = 1475879922, x =2842.96  , y = -1233.78  , z = 47.7  },
    { name = 'Gold Market', sprite = -1954662204, x = 2931.49, y = 1365.84, z = 45.19 },
    { name = 'Boat Rental', sprite = 62421675, x = 2140.02, y = -649.17, z = 42.36 },
    { name = 'Doctor', sprite = -1739686743, x = -288.0, y = 804.56, z = 119.39 },
	{ name = 'Saloon', sprite = 1879260108, x = -311.67, y = 806.43, z = 118.98 },
	{ name = 'Saloon', sprite = 1879260108, x = -817.69, y = -1318.75, z = 43.68 },
	{ name = 'Bank', sprite = -2128054417, x = -308.52, y = 775.99, z = 118.7 },
	{ name = 'Bank', sprite = -2128054417, x = -813.09, y = -1277.52, z = 43.64 },
	{ name = 'sheriff', sprite = 1322310532, x = -277.76, y = 804.97, z = 119.38 },
	{ name = 'sheriff', sprite = 1322310532, x = -764.14, y = -1270.92, z = 44.04 },
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end
end)
end
