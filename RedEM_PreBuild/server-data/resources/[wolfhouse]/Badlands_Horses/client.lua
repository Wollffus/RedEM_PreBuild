local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }
local def_horse = nil

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0
local horse_name
local horseModel;
local horseSpawn = {}
local NumberHorseSpawn = 0
local horseID
local CurrentZoneActive = 0
local own_horses = {}
local first_connect = 0
local idOfTheHorse
local camera
local lastPreView
DecorRegister("id1", 1)


RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    if first_connect < 2 then
        TriggerServerEvent('Badlands_Personalhorses:gethorses')
        first_connect = first_connect + 1
    end
end)
function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
        local mult = 10^numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end
-- RegisterCommand("component", function(source, args)
-- local tenkon = GetMount(PlayerPedId())

-- Citizen.InvokeNative(0xD3A7B003ED343FD9 ,tenkon,  tonumber("0x"..args[1]), true, true, true)


-- end)

local group
local BrushPrompt
function Brush()
    Citizen.CreateThread(function()
        local str = 'Brush'
        BrushPrompt = PromptRegisterBegin()
        PromptSetControlAction(BrushPrompt, 0x63A38F2C)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(BrushPrompt, str)
        PromptSetEnabled(BrushPrompt, false)
        PromptSetVisible(BrushPrompt, false)
        PromptSetStandardMode(BrushPrompt, true)
        PromptRegisterEnd(BrushPrompt)

    end)
end

local LeadPrompt
function Lead()
    Citizen.CreateThread(function()
        local str = 'Lead'
        LeadPrompt = PromptRegisterBegin()
        PromptSetControlAction(LeadPrompt, 0x17D3BFF5)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(LeadPrompt, str)
        PromptSetEnabled(LeadPrompt, false)
        PromptSetVisible(LeadPrompt, false)
        PromptSetStandardMode(LeadPrompt, true)
        PromptRegisterEnd(LeadPrompt)

    end)
end

local active = false
local brush_ammount = 0
Citizen.CreateThread(function()
    Brush()
    Lead()
    while true do
        local id, id2 = GetPlayerTargetEntity(PlayerId())
        if id2 ~= 0 and id2 ~= nil and horseModel == id2 and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()) ,GetEntityCoords(id2)) < 2.0 then
            if active == false then
                group = PromptGetGroupIdForTargetEntity(id2)
                PromptSetGroup(LeadPrompt, group)
                PromptSetGroup(BrushPrompt, group)
                PromptSetEnabled(LeadPrompt, true)
                PromptSetVisible(LeadPrompt, true)
                PromptSetEnabled(BrushPrompt, true)
                PromptSetVisible(BrushPrompt, true)
                PromptSetPriority(BrushPrompt, 1)
                brush_ammount = 0
                -- PromptSetPriority(FeedPrompt, 1)
                active = true
            end
            if PromptHasStandardModeCompleted(BrushPrompt) then
                brush_ammount =   brush_ammount + 1
                Citizen.InvokeNative(0xCD181A959CFDD7F4 , PlayerPedId(), horseModel , GetHashKey("INTERACTION_BRUSH"), 0 , 0)
                if brush_ammount > 20 then
                    Citizen.InvokeNative(0xE3144B932DFDFF65 ,horseModel, 0.0, -1, 1, 1)
                    ClearPedEnvDirt(horseModel)
                    ClearPedDamageDecalByZone(horseModel ,10 ,"ALL")
                    ClearPedBloodDamage(horseModel)
                    Citizen.InvokeNative(0xD8544F6260F5F01E ,horseModel, 10)
                end

            end
            if PromptHasStandardModeCompleted(LeadPrompt) then

                Citizen.InvokeNative(0x9A7A4A54596FE09D, PlayerPedId(), horseModel)
                PromptSetEnabled(LeadPrompt, false)
                PromptSetVisible(LeadPrompt, false)
            end
        else
            PromptSetEnabled(LeadPrompt, false)
            PromptSetVisible(LeadPrompt, false)
            PromptSetEnabled(BrushPrompt, false)
            PromptSetVisible(BrushPrompt, false)
            active = false

        end
        Wait(10)
    end
end)

RegisterNetEvent('Badlands_Personalhorses:gethorses_client')
AddEventHandler('Badlands_Personalhorses:gethorses_client', function(data)
    own_horses = data

end)
local Horses = {
	{
        ['Text'] = "$15 - Mule",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~0",
        ['Param'] = {
            ['Price'] = 15,
            ['Model'] = "A_C_HorseMule_01",
            ['Level'] = 0
        }
    },
    {
        ['Text'] = "$50 - Tennesseewalker Chestnut",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~0",
        ['Param'] = {
            ['Price'] = 50,
            ['Model'] = "A_C_HORSE_TENNESSEEWALKER_CHESTNUT",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$75 - Morgan Bay",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~4",
        ['Param'] = {
            ['Price'] = 75,
            ['Model'] = "A_C_Horse_Morgan_Bay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$85 - Kentucky Saddle Grey",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~6",
        ['Param'] = {
            ['Price'] = 85,
            ['Model'] = "A_C_Horse_KentuckySaddle_Grey",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$100 - Mr Bill W",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~9",
        ['Param'] = {
            ['Price'] = 100,
            ['Model'] = "A_C_HORSE_GANG_BILL",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$125 - Kentucky Saddle Black",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~6",
        ['Param'] = {
            ['Price'] = 125,
            ['Model'] = "A_C_Horse_KentuckySaddle_Black",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$150 - Kentucky Saddle Buttermilk",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~6",
        ['Param'] = {
            ['Price'] = 150,
            ['Model'] = "A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC",
            ['Level'] = 0
        }
    },
    {
        ['Text'] = "$160 - SHIRE RAVENBLACK",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~9",
        ['Param'] = {
            ['Price'] = 160,
            ['Model'] = "A_C_HORSE_SHIRE_RAVENBLACK",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$160 - SHIRE DARK BAY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~10",
        ['Param'] = {
            ['Price'] = 160,
            ['Model'] = "A_C_Horse_Shire_DarkBay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$145 - BELGIAN BLOND",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~12",
        ['Param'] = {
            ['Price'] = 145,
            ['Model'] = "A_C_Horse_Belgian_BlondChestnut",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$145 - BELGIAN MEALY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~13",
        ['Param'] = {
            ['Price'] = 145,
            ['Model'] = "A_C_Horse_Belgian_MealyChestnut",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$140 - SUFFOLK PUNCH SORREL",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~15",
        ['Param'] = {
            ['Price'] = 150,
            ['Model'] = "A_C_Horse_SuffolkPunch_Sorrel",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$160 - SUFFOLK PUNCH RED",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~16",
        ['Param'] = {
            ['Price'] = 160,
            ['Model'] = "A_C_Horse_SuffolkPunch_RedChestnut",
            ['Level'] = 0
        }
    },
    {
        ['Text'] = "$350 - APPALOOSA LEOPARD",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~16",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_HORSE_APPALOOSA_LEOPARD",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$300 - APPALOOSA BLACK SNOWFLAKE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~16",
        ['Param'] = {
            ['Price'] = 300,
            ['Model'] = "A_C_Horse_Appaloosa_BlackSnowflake",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$400 - APPALOOSA FEW SPOTTED",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~16",
        ['Param'] = {
            ['Price'] = 400,
            ['Model'] = "A_C_Horse_Appaloosa_FewSpotted_PC",
            ['Level'] = 0
        }
    },
	
	{
        ['Text'] = "$400 - APPALOOSA LEOPARD BLANKED",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~16",
        ['Param'] = {
            ['Price'] = 400,
            ['Model'] = "A_C_Horse_Appaloosa_LeopardBlanket",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$250 - APPALOOSA BROWN",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~16",
        ['Param'] = {
            ['Price'] = 250,
            ['Model'] = "A_C_Horse_Appaloosa_BrownLeopard",
            ['Level'] = 0
        }
    },
    {
        ['Text'] = "$360 - NOKOTA WHITE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~18",
        ['Param'] = {
            ['Price'] = 360,
            ['Model'] = "A_C_Horse_Nokota_WhiteRoan",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$400 - NOKOTA BLUE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~19",
        ['Param'] = {
            ['Price'] = 400,
            ['Model'] = "A_C_Horse_Nokota_BlueRoan",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - THOROUGHBRED GREY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~20",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_Thoroughbred_DappleGrey",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$425 - THOROUGHBRED BLOOD BAY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~20",
        ['Param'] = {
            ['Price'] = 425,
            ['Model'] = "A_C_Horse_Thoroughbred_BloodBay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$425 - THOROUGHBRED BLACK",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~22",
        ['Param'] = {
            ['Price'] = 425,
            ['Model'] = "A_C_Horse_Thoroughbred_BlackChestnut",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$290 - MUSTANG WILD BAY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~24",
        ['Param'] = {
            ['Price'] = 290,
            ['Model'] = "A_C_Horse_Mustang_WildBay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$295 - MUSTANG TIGER",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~25",
        ['Param'] = {
            ['Price'] = 295,
            ['Model'] = "A_C_Horse_Mustang_TigerStripedBay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$300 - MUSTANG GOLDEN",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~26",
        ['Param'] = {
            ['Price'] = 300,
            ['Model'] = "A_C_Horse_Mustang_GoldenDun",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - DUTCH WARMBLOOD BROWN",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~24",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_DutchWarmblood_SealBrown",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$325 - DUTCH WARMBLOOD CHOCOLATE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~25",
        ['Param'] = {
            ['Price'] = 325,
            ['Model'] = "A_C_Horse_DutchWarmblood_ChocolateRoan",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$300 - HUNGARIAN GREY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~24",
        ['Param'] = {
            ['Price'] = 300,
            ['Model'] = "A_C_Horse_HungarianHalfbred_DarkDappleGrey",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - HUNGARIAN LIVER",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~25",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_HungarianHalfbred_LiverChestnut",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - HUNGARIAN FLAXEN",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~26",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_HungarianHalfbred_FlaxenChestnut",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$280 - AMERICAN PAINT GREY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~25",
        ['Param'] = {
            ['Price'] = 280,
            ['Model'] = "A_C_Horse_AmericanPaint_Greyovero",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$290 - AMERICAN PAINT WHITE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~26",
        ['Param'] = {
            ['Price'] = 290,
            ['Model'] = "A_C_Horse_AmericanPaint_SplashedWhite",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$295 - AMERICAN PAINT TOBIANO",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~27",
        ['Param'] = {
            ['Price'] = 295,
            ['Model'] = "A_C_Horse_AmericanPaint_Tobiano",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$310 - ANDALUSIAN ROSE GRAY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~28",
        ['Param'] = {
            ['Price'] = 310,
            ['Model'] = "A_C_Horse_Andalusian_RoseGray",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$330 - ANDALUSIAN PERLINO",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~28",
        ['Param'] = {
            ['Price'] = 330,
            ['Model'] = "A_C_Horse_Andalusian_Perlino",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - ANDALUSIAN DARK",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~28",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_Andalusian_DarkBay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - TURKOMAN SILVER",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~29",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_Turkoman_Silver",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$380 - TURKOMAN DARK",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~29",
        ['Param'] = {
            ['Price'] = 380,
            ['Model'] = "A_C_Horse_Turkoman_DarkBay",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$380 - TURKOMAN GOLD",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~30",
        ['Param'] = {
            ['Price'] = 380,
            ['Model'] = "A_C_Horse_Turkoman_Gold",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$350 - ARDENNES GRAY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~30",
        ['Param'] = {
            ['Price'] = 350,
            ['Model'] = "A_C_Horse_Ardennes_IronGreyRoan",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$380 - ARDENNES STRAWBERRY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~30",
        ['Param'] = {
            ['Price'] = 380,
            ['Model'] = "A_C_Horse_Ardennes_StrawberryRoan",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$380 - ARDENNES BAY ROAN",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~31",
        ['Param'] = {
            ['Price'] = 380,
            ['Model'] = "A_C_Horse_Ardennes_BayRoan",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$450 - MISSOURI FOX TROTTER SILVER",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~32",
        ['Param'] = {
            ['Price'] = 450,
            ['Model'] = "A_C_Horse_MissouriFoxTrotter_SilverDapplePinto",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$250 - KLADRUBER CREMELLO",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~33",
        ['Param'] = {
            ['Price'] = 250,
            ['Model'] = "A_C_Horse_Kladruber_Cremello",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$250 - KLADRUBER DAPPLE ROSE GREY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~34",
        ['Param'] = {
            ['Price'] = 250,
            ['Model'] = "A_C_Horse_Kladruber_DappleRoseGrey",
            ['Level'] = 0
        }
    },
		{
        ['Text'] = "$200 - KLADRUBER GREY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~34",
        ['Param'] = {
            ['Price'] = 200,
            ['Model'] = "A_C_Horse_Kladruber_Grey",
            ['Level'] = 0
        }
    },
		{
        ['Text'] = "$200 - KLADRUBER SILVER",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~34",
        ['Param'] = {
            ['Price'] = 200,
            ['Model'] = "A_C_Horse_Kladruber_Silver",
            ['Level'] = 0
        }
    },
		{
        ['Text'] = "$200 - KLADRUBER BLACK",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~34",
        ['Param'] = {
            ['Price'] = 200,
            ['Model'] = "A_C_Horse_Kladruber_Black",
            ['Level'] = 0
        }
    },
		{
        ['Text'] = "$200 - KLADRUBER WHITE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~34",
        ['Param'] = {
            ['Price'] = 200,
            ['Model'] = "A_C_Horse_Kladruber_White",
            ['Level'] = 0
        }
	},
	{
        ['Text'] = "$750 - ARABIAN GRAY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~36",
        ['Param'] = {
            ['Price'] = 750,
            ['Model'] = "A_C_Horse_Arabian_Grey",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$1500 - ARABIAN WHITE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~38",
        ['Param'] = {
            ['Price'] = 1500,
            ['Model'] = "A_C_Horse_Arabian_White",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$1250 - ARABIAN BLACK",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~40",
        ['Param'] = {
            ['Price'] = 1250,
            ['Model'] = "A_C_Horse_Arabian_Black",
            ['Level'] = 0
        }
    },
	
	{
        ['Text'] = "$1000 - ARABIAN ROSE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~40",
        ['Param'] = {
            ['Price'] = 1000,
            ['Model'] = "A_C_Horse_Arabian_RoseGreyBay",
            ['Level'] = 0
        }
    },
	
	{
        ['Text'] = "$1700 - ARABIAN WARPED BRINDLE",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~40",
        ['Param'] = {
            ['Price'] = 1700,
            ['Model'] = "A_C_Horse_Arabian_WarpedBrindle_PC",
            ['Level'] = 0
        }
    },
	
		{
        ['Text'] = "$2000 - ARABIAN WINTER",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~40",
        ['Param'] = {
            ['Price'] = 2000,
            ['Model'] = "A_C_Horse_Winter02_01",
            ['Level'] = 0
        }
    },
	{
        ['Text'] = "$2000 - ZEBRA",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~40",
        ['Param'] = {
            ['Price'] = 2000,
            ['Model'] = "A_C_HorseMulePainted_01",
            ['Level'] = 0
        }
    },
		{
        ['Text'] = "$1000 - LEGENDARNY DONKEY",
        ['SubText'] = "",
        ['Desc'] = "Required Level: ~pa~40",
        ['Param'] = {
            ['Price'] = 1000,
            ['Model'] = "A_C_Donkey_01",
            ['Level'] = 0
        }
    },
}

MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local cooldown_wateringcan = 0
RegisterNetEvent('horseDrops:sugar')
AddEventHandler('horseDrops:sugar', function()
    local ped = PlayerPedId()
    if IsPedOnMount(ped) then

        local horse = GetMount(ped)

        if cooldown_wateringcan <= 1 then
            Citizen.InvokeNative( 0xC6258F41D86676E0 , horse, 1 ,100)
            TriggerServerEvent("horseDrops:deleteSugar")
            cooldown_wateringcan = 1000
            startCooldown()
        end

    end

end)


local timer = 0
RegisterNetEvent('horseDrops:napar_predkosci')
AddEventHandler('horseDrops:napar_predkosci', function()

        local ped = PlayerPedId()
        if IsPedOnMount(ped) and timer == 0  then

            local horse = GetMount(ped)
            TriggerServerEvent("horseDrops:delete_napar_predkosci")
            while timer < 30000 do
                Wait(0)
                GiveAllAttitude( horse )
                timer = timer + 1
            end
            timer = 0
        end

end)


function startCooldown()
    if cooldown_wateringcan > 0 then
        Citizen.CreateThread(function()
            while cooldown_wateringcan > 0 do
                Wait(0)

                cooldown_wateringcan = cooldown_wateringcan - 1
            end
        end)
    end
end

function GiveAllAttitude( entity )
    -- | SET_ATTRIBUTE_POINTS | --
    Citizen.InvokeNative( 0x09A59688C26D88DF, entity, 0, 1100 )
    Citizen.InvokeNative( 0x09A59688C26D88DF, entity, 1, 1100 )
    Citizen.InvokeNative( 0x09A59688C26D88DF, entity, 2, 1100 )
    -- | ADD_ATTRIBUTE_POINTS | --
    Citizen.InvokeNative( 0x75415EE0CB583760, entity, 0, 1100 )
    Citizen.InvokeNative( 0x75415EE0CB583760, entity, 1, 1100 )
    Citizen.InvokeNative( 0x75415EE0CB583760, entity, 2, 1100 )
    -- | SET_ATTRIBUTE_BASE_RANK | --
    Citizen.InvokeNative( 0x5DA12E025D47D4E5, entity, 0, 10 )
    Citizen.InvokeNative( 0x5DA12E025D47D4E5, entity, 1, 10 )
    Citizen.InvokeNative( 0x5DA12E025D47D4E5, entity, 2, 10 )
    -- | SET_ATTRIBUTE_BONUS_RANK | --
    Citizen.InvokeNative( 0x920F9488BD115EFB, entity, 0, 10 )
    Citizen.InvokeNative( 0x920F9488BD115EFB, entity, 1, 10 )
    Citizen.InvokeNative( 0x920F9488BD115EFB, entity, 2, 10 )
    -- | SET_ATTRIBUTE_OVERPOWER_AMOUNT | --
    Citizen.InvokeNative( 0xF6A7C08DF2E28B28, entity, 0, 5000.0, false )
    Citizen.InvokeNative( 0xF6A7C08DF2E28B28, entity, 1, 5000.0, false )
    Citizen.InvokeNative( 0xF6A7C08DF2E28B28, entity, 2, 5000.0, false )
end

local function IsNearZone ( location )

    local player = PlayerPedId()
    local playerloc = GetEntityCoords(player, 0)

    for i = 1, #location do
        if #(playerloc - location[i]) < 2.0 then
            return true, i
        end
    end

end
local function IsNearZone2 ( location )

    local player = PlayerPedId()
    local playerloc = GetEntityCoords(player, 0)

    for i = 1, #location do
        if #(playerloc - location[i]) < 2.0 then
            return true, i
        end
    end

end
local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

    local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)

    SetTextCentre(centre)

    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end

    Citizen.InvokeNative(0xADA9255D, 10);

    DisplayText(str, x, y)

end
function MenuKoni()


    MenuData.CloseAll()
    local elements = {}
    for k,v in pairs(own_horses) do
        elements[#elements+1]= {label = v[3], value = k , desc = "Press to select: ".. v[3] }
    end



    MenuData.Open(

        'default', GetCurrentResourceName(), 'horses_menu',

        {

            title    = 'Your Horses',

            subtext    = 'Choose your horse',

            align    = 'top-left',

            elements = elements,

        },

        function(data, menu)



            menu.close()


            if horseSpawn[idOfTheHorse] == nil then
                def_horse = own_horses[data.current.value][1]
                horse_name = own_horses[data.current.value][3]
                TriggerServerEvent('Badlands_Personalhorses:AddOrDelNewHorseToParking', own_horses[data.current.value][1] ,2, "brak" ,own_horses[data.current.value][2], own_horses[data.current.value][3])
                TriggerEvent("ncrp_notify:Tip", "Your horse is being transported out of the pasture!" , 3000)
            else
                TriggerEvent("ncrp_notify:Tip", "You can only use one Horse!" , 3000)
            end




        end,

        function(data, menu)

            menu.close()


        end

    )





end


local horses_to_buy = {}
for k,v in pairs(Horses) do

    table.insert(horses_to_buy, {label = v["Text"], value = k , desc =  "The best horse at the best price", })
end
local canChange = true
function MenuKonie()

    DestroyAllCams(true)
    DoScreenFadeOut(1500)
    Wait(1500)
    local playercoords = GetEntityCoords(PlayerPedId())
    local camera_pos = GetObjectOffsetFromCoords(Config.PreView[CurrentZoneActive][1] ,Config.PreView[CurrentZoneActive][2]+90 ,3.0, 5.0, 4.0)
    camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camera_pos.x, camera_pos.y, camera_pos.z, 00.00, 00.00, 40.00, 30.00, true, 0)
    SetCamActive(camera,true)
    RenderScriptCams(true, true, 500, true, true)
    if canChange == true then
        canChange = false
        PreView (Horses[1].Param.Model)
        canChange = true

    end
    Wait(1000)
    DoScreenFadeIn(4000)
    Wait(1500)
    MenuData.CloseAll()


    MenuData.Open(

        'default', GetCurrentResourceName(), 'horse_menu',

        {

            title    = 'Horse Store',

            subtext    = 'Buying a Horse',

            align    = 'top-left',

            elements = horses_to_buy,

        },

        function(data, menu)

            menu.close()
            local output  = nil
            AddTextEntry('FMMC_MPM_NA', "Name:")
            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "Name", "", "", "", 30)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0)
                Citizen.Wait(0)
            end
            if (GetOnscreenKeyboardResult()) then
                output = GetOnscreenKeyboardResult()
            end
            if output ~= nil then

                TriggerServerEvent('Badlands_Personalhorses:buyhorse', Horses[data.current.value]['Param'] , output)
            else
                TriggerEvent("ncrp_notify:Tip", "~r~Incorrect name!" , 3000)
            end
            DestroyAllCams(true)
            if lastPreView ~= nil then
                DeleteEntity(lastPreView)
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end

        end,

        function(data, menu)

            menu.close()
            DestroyAllCams(true)
            if lastPreView ~= nil then
                DeleteEntity(lastPreView)
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end
        end,


        function(data, menu)

            if canChange == true then
                canChange = false
                PreView (Horses[data.current.value].Param.Model)
                canChange = true

            end
        end


    )

end

Citizen.CreateThread(function()
    local active = false

    while true do

        local IsZone, IdZone = IsNearZone( Config.Coords )
        local IsZone2, IdZone2 = IsNearZone2( Config.Coords_Del )
        local IsZone3, IdZone2 = IsNearZone( Config.GetHorse )

        if not IsZone and not IsZone2 and not IsZone3 and active then

            local blank = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())
            Citizen.InvokeNative(0xFA233F8FE190514C, blank)
            Citizen.InvokeNative(0xE9990552DEC71600)
            active = false
        end
        if IsZone then
            if active == false then
                local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.purchase, Citizen.ResultAsLong())
                Citizen.InvokeNative(0xFA233F8FE190514C, str)
                Citizen.InvokeNative(0xE9990552DEC71600)
                active = true
            end
            if IsControlJustReleased(0, 0xD9D0E1C0) then

                CurrentZoneActive = IdZone
                MenuKonie()
            end
        end

        if IsZone3 then
            if active == false then
                local str2 = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.unstable, Citizen.ResultAsLong())
                Citizen.InvokeNative(0xFA233F8FE190514C, str2)
                Citizen.InvokeNative(0xE9990552DEC71600)
                active = true

            end
            if IsControlJustReleased(0, 0xD9D0E1C0) then
                MenuKoni()
            end
        end

        if IsZone2 then
            local isMounted = IsPedOnMount(PlayerPedId())
            if isMounted then
                if active == false then
                    local str3 = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.stable, Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str3)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    active = true
                end
                if IsControlJustReleased(0, 0xD9D0E1C0) then
                    local horsePed = GetEntityModel(GetMount(PlayerPedId()))
                    horseID = GetMount(PlayerPedId())
                    local id1 = round(DecorGetFloat(horseID, "id1"), -2)

                    TriggerServerEvent('Badlands_Personalhorses:AddOrDelNewHorseToParking',horsePed ,1, "brak" , id1 , horse_name)
                end

            end
        end

        if IsControlJustReleased( 0, keys['H'] ) then
            pressLeft = GetGameTimer()
            pressTime = pressTime + 1
        end

        if pressLeft ~= nil and (pressLeft + 500) < GetGameTimer() and pressTime > 0 and pressTime < 1 then
            pressTime = 0
        end

        if pressTime == 1 then
            if recentlySpawned <= 0 then
                recentlySpawned = 10
                if def_horse ~= nil then
                    if horseSpawn[1] then
                        local EntityIsDead = IsEntityDead( horseSpawn[idOfTheHorse].model )

                        if EntityIsDead and horseSpawn[idOfTheHorse].model ~= nil and horseSpawn[idOfTheHorse].model ~= 0  then
                            local id1 = round(DecorGetFloat(horseSpawn[idOfTheHorse].model, "id1"), -2)

                            TriggerServerEvent('Badlands_Personalhorses:AddOrDelNewHorseToParking', def_horse ,1, "brak" ,id1, horse_name)
                            DeleteEntity(horseSpawn[idOfTheHorse].model)
                            def_horse = nil
                            horse_name = nil
							 horseSpawn[idOfTheHorse] = nil
                            TriggerEvent("ncrp_notify:Tip", "Your horse has been healed!" , 3000)
                            -- TriggerEvent("redemrp_notification:start", "Your horse has been healed!" , 3, "error")
                            Wait(3100)
                            math.randomseed(GetGameTimer())
                            local price = math.random(10,25)
                            TriggerEvent("ncrp_notify:Tip", "The cost of treating your horse: "..price.."$" , 3000)
                            TriggerServerEvent('Badlands_Personalhorses:RemoveMoney', price)
                        end

                        if not EntityIsDead then
                            TaskGoToEntity( horseSpawn[idOfTheHorse].model, PlayerPedId(), -1, 7.2, 2.0, 0, 0 )
                        end


                    end
                else

                end
            else
            end
            pressTime = 0
        end

        Citizen.Wait(0)
    end
end)

RegisterCommand("fleehorse", function(source, args, rawCommand)
  if horseSpawn[idOfTheHorse].model ~= nil and horseSpawn[idOfTheHorse].model ~= 0 and def_horse ~= nil then
     local id1 = round(DecorGetFloat(horseSpawn[idOfTheHorse].model, "id1"), -2)
     TriggerServerEvent('Badlands_Personalhorses:AddOrDelNewHorseToParking', def_horse ,1, "brak" ,id1, horse_name)
     DeleteEntity(horseSpawn[idOfTheHorse].model)
	 def_horse = nil
     horse_name = nil
	 horseSpawn[idOfTheHorse] = nil
	 TriggerEvent("ncrp_notify:Tip", "The horse was transported to the stable!" , 3000)
 end
end)

RegisterNetEvent('Badlands_Personalhorses:DeleteHorse')
AddEventHandler('Badlands_Personalhorses:DeleteHorse', function( _message )
    DeleteEntity(horseID)
    def_horse = nil
    horseSpawn[idOfTheHorse] = nil
end)

-- | Blips | --
Citizen.CreateThread(function()
    for _, info in pairs(Config.Coords) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, 564457427, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Horse Trader')
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(Config.GetHorse) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, 1938782895, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Stable (Pickup)')
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(Config.Coords_Del) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, 1210165179, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Stable (Put Away)')
    end
end)

-- | Notification | --


function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end


function PreView (model)
	local _model = GetHashKey( model )
    while not HasModelLoaded( _model ) do
        Wait(1)
        modelrequest( _model )
    end
    if lastPreView ~= nil then
        DeleteEntity(lastPreView)
        while DoesEntityExist(lastPreView) do
            Wait(1)
        end
    end
    lastPreView = CreatePed( _model, Config.PreView[CurrentZoneActive][1] , Config.PreView[CurrentZoneActive][2], false, false )
    while not DoesEntityExist(lastPreView) do
        Wait(1)
    end
    SetEntityAsMissionEntity(lastPreView, true, true)
    FreezeEntityPosition(lastPreView , true)
    SET_PED_RELATIONSHIP_GROUP_HASH( lastPreView, _model )
    SET_PED_DEFAULT_OUTFIT( lastPreView )
    PointCamAtEntity(camera, lastPreView)
end
-- | Spawn Horse | --

RegisterNetEvent( 'Badlands_Personalhorses:spawnHorse' )
AddEventHandler( 'Badlands_Personalhorses:spawnHorse', function ( horse, isInShop ,plate)
    local player = PlayerPedId()
    local model
    if tonumber(horse) == nil then
        model = GetHashKey( horse )
    else
        model = horse
    end
    local x, y, z, heading, a, b

    x, y, z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, 32.0, 0.3 ) )
    a, b = GetGroundZAndNormalFor_3dCoord( x, y, z + 10 )


    idOfTheHorse = NumberHorseSpawn + 1
    while not HasModelLoaded( model ) do
        Wait(500)
        modelrequest( model )
    end

    if horseSpawn[idOfTheHorse] == nil then

        horseModel = CreatePed( model, x, y, z, heading, 1, 1 )
        while not DoesEntityExist(horseModel) do
            Wait(300)
        end
        Wait(2000)
        SetEntityAsMissionEntity(horseModel, true, true)
        SET_PED_RELATIONSHIP_GROUP_HASH( horseModel, model )
        SET_PED_DEFAULT_OUTFIT( horseModel )
        local blip = SET_BLIP_TYPE( horseModel )
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, horse_name)
        GiveAllAttitude( horseModel )

        TaskGoToEntity( idOfTheHorse, player, -1, 7.2, 2.0, 0, 0 )

        horseSpawn[idOfTheHorse] = { id = idOfTheHorse, model = horseModel }
        Wait (2000)
        DecorSetFloat(horseModel, "id1", tonumber(plate..".0"))
        local tablica = round(DecorGetFloat(horseModel, "id1"), -2)
        Wait (2000)
        TriggerServerEvent("Badlands_HorseCustomization:loadComponents",tablica , 0, horseModel, function(cb)
            end)

    end

    SetModelAsNoLongerNeeded(model)

end )

function SET_BLIP_TYPE ( animal )
    Citizen.InvokeNative(0x4A48B6E03BABB4AC , animal, horse_name)
    return Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, animal)
end

function SET_ANIMAL_TUNING_BOOL_PARAM ( animal, p1, p2 )
    return Citizen.InvokeNative( 0x9FF1E042FA597187, animal, p1, p2 )
end

function SET_PED_DEFAULT_OUTFIT ( horse )
    return Citizen.InvokeNative( 0x283978A15512B2FE, horse, true )
end

function SET_PED_RELATIONSHIP_GROUP_HASH ( iVar0, iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH( iParam0 ) )
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH ( iParam0 )
    return Citizen.InvokeNative( 0x3CC4A718C258BDD0, iParam0 );
end

-- | Timer | --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if recentlySpawned > 0 then
            recentlySpawned = recentlySpawned - 1
        end
    end
end)
