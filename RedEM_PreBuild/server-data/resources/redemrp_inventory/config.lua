Config = {}
Config.MaxWeight = 24.0

Config.Crafting = {
    ----------------------------------------------------------C O O K I N G B E L O W------------------------------------------------------------------------
    ["cooked_bread"] = {
        items = {
            "empty","empty","empty",
            "empty","bread","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },

    ["bread"] = {
        items = {
		    "empty","empty","empty",
		    "wheat","wheat","wheat",
		    "empty","empty","empty"
		    },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },

    ["cooked_fish"] = {
        items = {
            "empty","empty","empty",
            "empty","smallfish","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },

    ["cooked_fish2"] = {
        items = {
            "empty","empty","empty",
            "empty","mediumfish","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },

    ["cooked_fish3"] = {
        items = {
            "empty","empty","empty",
            "empty","largefish","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },

    ["cooked_meat"] = {
        items = {
            "empty","empty","empty",
            "empty","meat","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },

    ["cooked_corn"] = {
        items = {
            "empty","empty","empty",
            "empty","corn","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "cooking",
        amount = 1,
    },
    ----------------------------------------------------------C O O K I N G A B O V E------------------------------------------------------------------------

    ----------------------------------------------------------W E A P O N S B E L O W------------------------------------------------------------------------
    ["WEAPON_MELEE_KNIFE"] = {
        items = {
		    "empty","metal","empty",
		    "empty","metal","empty",
		    "empty","stick","empty"
		    },
        requireJob = "empty",
        type = "blacksmith",
        amount = 1,
    },

    ["WEAPON_MELEE_TORCH"] = {
        items = {
		    "cloth","good_whisky","cloth",
		    "cloth","stick","cloth",
		    "empty","stick","empty"
		    },
        requireJob = "empty",
        type = "empty",
        amount = 1,
    },

    ["WEAPON_THROWN_THROWING_KNIVES"] = {
        items = {
            "metal, 2","metal, 2","metal, 2",
            "metal, 2","metal, 2","metal, 2",
            "metal, 2","metal, 2","metal, 2"
            },
        requireJob = "empty",
        type = "blacksmith",
        amount = 10,
    },
    ----------------------------------------------------------W E A P O N S A B O V E------------------------------------------------------------------------

    ----------------------------------------------------------O P E N W O R L D B E L O W------------------------------------------------------------------------
    ["selfcigarettes"] = {
        items = {
		    "empty","tobacco","empty",
		    "empty","tobacco","empty",
		    "empty","rollpaper","empty"
		    },
        requireJob = "empty",
        type = "empty",
        amount = 1,
    },

    ["selfcigars"] = {
        items = {
		    "tobacco","tobacco","tobacco",
		    "tobacco","tobacco","tobacco",
		    "empty","rollpaper","empty"
		    },
        requireJob = "empty",
        type = "empty",
        amount = 1,
    },

    ["stick"] = {
        items = {
		    "empty","empty","empty",
		    "empty","planks","empty",
		    "empty","planks","empty"
		    },
        requireJob = "empty",
        type = "empty",
        amount = 4,
    },

    ["sharp_rock"] = {
        items = {
            "empty","empty","empty",
            "empty","rock","rock",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "empty",
        amount = 2,
    },

    ["AMMO_ARROW"] = {
        items = {
            "empty","sharp_rock","empty",
            "empty","stick","empty",
            "empty","feather","empty"
            },
        requireJob = "empty",
        type = "empty",
        amount = 1,
    },

    ["cloth"] = {
        items = {
            "cotton","cotton","cotton",
            "empty","empty","empty",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "empty",
        amount = 1,
    },

    ["bandage"] = {
        items = {
            "empty","empty","empty",
            "cloth","cloth","cloth",
            "empty","empty","empty"
            },
        requireJob = "empty",
        type = "empty",
        amount = 1,
    },

}
----------------------------------------------------------O P E N W O R L D A B O V E------------------------------------------------------------------------
Config.Items = {

    ["longaxe"] =
    {
        label = "Sturdy Axe",
        description = "A sturdy axe for chopping trees down",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/longaxe.png",
        type = "item_standard",
    },

    ["fish"] =
    {
        label = "Fish",
        description = "?????????",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/provision_fish_bluegill.png",
        type = "item_standard",
    },

    ["p_baitBread01x"] =
    {
        label = "Bait - Bread",
        description = "Fish love bread",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_baitBread01x.png",
        type = "item_standard",
    },

    ["p_baitCheese01x"] =
    {
        label = "Bait - Cheese",
        description = "French fish bait",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_baitCheese01x.png",
        type = "item_standard",
    },

    ["p_baitCorn01x"] =
    {
        label = "Bait - Corn",
        description = "Goes in the same as it comes out",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_baitCorn01x.png",
        type = "item_standard",
    },

    ["p_baitCricket01x"] =
    {
        label = "Bait - Cricket",
        description = "A dried cricket",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_baitCricket01x.png",
        type = "item_standard",
    },

    ["p_finisheDragonfly01x"] =
    {
        label = "Dragon Fly",
        description = "A creepy looking dragon fly bait",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_finisheDragonfly01x.png",
        type = "item_standard",
    },

    ["p_finisdFishlure01x"] =
    {
        label = "Fish Lure",
        description = "A low effort fish lure",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_finisdFishlure01x.png",
        type = "item_standard",
    },

    ["p_finishdcrawd01x"] =
    {
        label = "Swamp Bait",
        description = "An unknown bait ",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/p_finishdcrawd01x.png",
        type = "item_standard",
    },

    ["humanbones"] =
    {
        label = "Human Bones",
        description = "Human remains, seemed to have been dug up",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/humanbones.png",
        type = "item_standard",
    },

    ["water"] =
    {
        label = "Water",
        description = "One hydrogen molecule, two oxygen",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/water.png",
        type = "item_standard",
    },

    ["bread"] =
    {
        label = "Bread",
        description = "A stale loaf with unknown seeds",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/bread.png",
        type = "item_standard",
    },

	["blueberry"] =
    {
        label = "Blueberry",
        description = "A ripe & fit to eat fruit",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/blueberry.png",
        type = "item_standard",
    },

	["stew2"] =
    {
        label = "Stew",
        description = "A cheap stew of leftover meats & vegies",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/stew.png",
        type = "item_standard",
    },

    ["wood"] =
    {
        label = "Wood",
        description = "A poorly cut piece of wood",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/wood.png",
        type = "item_standard",
    },

	["crate"] =
    {
        label = "Crate",
        description = "A standard sized crate",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 6,
        imgsrc = "items/crate.png",
        type = "item_standard",
    },

    ["hitchingpost"] =
    {
        label = "Post",
        description = "A post to tie your transporation unit down",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 6,
        imgsrc = "items/hitchingpost.png",
        type = "item_standard",
    },


	["sharp_rock"] =
    {
        label = "Sharp Rock",
        description = "A rock that is sharp",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/sharp_rock.png",
        type = "item_standard",
    },

	["sharp_stick"] =
    {
        label = "Shark Stick",
        description = "A stick that is sharp",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/sharp_stick.png",
        type = "item_standard",
    },


	["reinforced_stick"] =
    {
        label = "Strong Stick",
        description = "A stick that is not sharp, but strong",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/reinforced_stick.png",
        type = "item_standard",
    },

	["sheet"] =
    {
        label = "Sheet",
        description = "Cloth sheet",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/sheet.png",
        type = "item_standard",
    },

	["pelt"] =
    {
        label = "Pelt",
        description = "An animal pelt",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/pelt.png",
        type = "item_standard",
    },

    ["kit_camp_simple"] =
    {
        label = "Simple Camp Kit",
        description = "A simple yet effective camp kit",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 5,
        imgsrc = "items/kit_camp_simple.png",
        type = "item_standard",
    },

    ["cooked_fish"] =
    {
        label = "Cooked Fish",
        description = "Medium rare cooked fish",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cooked_fish.png",
        type = "item_standard",
    },


    ["cooked_fish2"] =
    {
        label = "Medium Cooked Fish",
        description = "A medium sized cooked fish",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/cooked_fish2.png",
        type = "item_standard",
    },

    ["cooked_fish3"] =
    {
        label = "Large Cooked Fish",
        description = "A well done large cooked fish",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 10,
        imgsrc = "items/cooked_fish3.png",
        type = "item_standard",
    },

    ["housekey"] =
    {
        label = "House Key",
        description = "A random house key",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 10,
        imgsrc = "items/key.png",
        type = "item_standard",
    },

    ["selfcigarettes"] =
    {
        label = "Pack of Rolled Cigarettes",
        description = "Contains 15 cancer causing cigarettes.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/selfcigarettes.png",
        type = "item_standard",
    },

	["selfcigars"] =
    {
        label = "Box of Rolled Cigars",
        description = "Contains 10 premium rolled Cigars.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/selfcigars.png",
        type = "item_standard",
    },


    ["moonshine"] =
    {
        label = "Moonshine",
        description = "37% - Or close to",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 15,
        imgsrc = "items/moonshine.png",
        type = "item_standard",
    },

	["herbal_compress"] =
    {
        label = "Herbal Compress",
        description = "a herbal compress for wounds",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/herbal_compress.png",
        type = "item_standard",
    },

    ["strength_syrup"] =
    {
        label = "Strength Syrup ",
        description = "a quick acting liquid that will help bring someone around",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/strength_syrup.png",
        type = "item_standard",
    },

    ["herbal_cream"] =
    {
        label = "Herbal Cream",
        description = "a thick cream to be applied to wounds to help with healing",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/herbal_cream.png",
        type = "item_standard",
    },

    ["herbal_tea"] =
    {
        label = "Herbal Tea",
        description = "a tea with medical properties",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/herbal_tea.png",
        type = "item_standard",
    },

 	["tea_leaves"] =
    {
        label = "Tea leaves",
        description = "Tea leaves for a nice cup of tea",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tealeaves.png",
        type = "item_standard",
    },

	["ornatekey"] =
    {
        label = "Ornate Key",
        description = "Seems to open something valuable",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 1,
        imgsrc = "items/ornatekey.png",
        type = "item_standard",
    },

	["assaultplans"] =
    {
        label = "Assault Plans",
        description = "Notes about an assault on a military fort",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 1,
        imgsrc = "items/assaultplans.png",
        type = "item_standard",
    },

    ["cream"] =
    {
        label = "Cream",
        description = "Rich cream",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cream.png",
        type = "item_standard",
    },

    ["egg"] =
    {
        label = "Egg",
        description = "Rounded egg found in nest",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/egg.png",
        type = "item_standard",
    },

    ["sugar_cookie"] =
    {
        label = "Sugar Cookie",
        description = "Soft white sugar cookies",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/sugar_cookies.png",
        type = "item_standard",
    },

    ["pie_crust"] =
    {
        label = "Pie Crust",
        description = "flaky pie crust",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/pie_crust.png",
        type = "item_standard",
    },

    ["butter"] =
    {
        label = "Butter",
        description = "Thick butter from cows",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/butter.png",
        type = "item_standard",
    },

    ["milk"] =
    {
        label = "Milk",
        description = "Fresh milk",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/milk.png",
        type = "item_standard",
    },

    ["cocaine"] =
    {
        label = "Cocaine",
        description = "just like snow... pure",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cocaine.png",
        type = "item_standard",
    },

    ["lavendar"] =
    {
        label = "Lavendar",
        description = "a lovely purple flower",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/lavendar.png",
        type = "item_standard",
    },

    ["oil"] =
    {
        label = "Oil",
        description = "A slick liquid",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/oil.png",
        type = "item_standard",
    },

    ["baking_soda"] =
    {
        label = "Baking soda",
        description = "I say RISE",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/baking_soda.png",
        type = "item_standard",
    },

    ["flour"] =
    {
        label = "Flour",
        description = "freshly milled flour",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/flour.png",
        type = "item_standard",
    },


    ["bark"] =
    {
        label = "Bark",
        description = "just some bark",
    weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/bark.png",
        type = "item_standard",
    },

    ["moonshine_base"] =
    {
        label = "Mash",
        description = "Good mash for a bit of moonshine",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/moonshine_base.png",
        type = "item_standard",
    },

	["sugar"] =
    {
        label = "Sugar",
        description = "Raw Sugar",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/sugar.png",
        type = "item_standard",
    },

	["yeast"] =
    {
        label = "Yeast",
        description = "Bread or Beer?",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/yeast.png",
        type = "item_standard",
    },

	["beer"] =
    {
        label = "Beer",
        description = "A beer for the purpose of getting drunk and a bar fight.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/beer.png",
        type = "item_standard",
    },

    ["wine"] =
    {
        label = "Wine",
        description = "Wine",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/wine.png",
        type = "item_standard",
    },

    ["szampan"] =
    {
        label = "Champagne",
        description = "A bottle of bubbles the rich would say",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/szampan.png",
        type = "item_standard",
    },

	["stick"] =
    {
        label = "Stick",
        description = "Long & Brown, quite sticky.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/stick.png",
        type = "item_standard",
    },

	["planks"] =
    {
        label = "Plank",
        description = "( ͡° ͜ʖ ͡°)",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/planks.png",
        type = "item_standard",
    },

	["rollpaper"] =
    {
        label = "Rolling Paper",
        description = "To roll some smokeables.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/rollpaper.png",
        type = "item_standard",
    },

	["medikit"] =
    {
        label = "Medical Kit",
        description = "Great for use if you know first aid, otherwise useless",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/medikit.png",
        type = "item_standard",
    },

	["mbandage"] =
    {
        label = "Heal a patient or friend",
        description = "You could strangle someone with this quality bandage",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/mbandage.png",
        type = "item_standard",
    },

	["telegram"] =
    {
        label = "Carrier Telegram",
        description = "Have a bird fly your message to a friend",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/telegram.png",
        type = "item_standard",
    },

	["bandage"] =
    {
        label = "Bandage",
        description = "Great for use if you know first aid, otherwise useless",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/bandage.png",
        type = "item_standard",
    },

	["wateringcan"] =
    {
        label = "Watering Can",
        description = "Can to water",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/wateringcan.png",
        type = "item_standard",
    },

    ["goldpan"] =
    {
        label = "Gold Pan",
        description = "A pan for panning gold in rivers or lakes",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/goldpan.png",
        type = "item_standard",
    },

	["tent"] =
    {
        label = "Tent",
        description = "Tent for tent things",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tent.png",
        type = "item_standard",
    },

	["basic_tent"] =
    {
        label = "Basic Tent",
        description = "A basic tent",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tent.png",
        type = "item_standard",
    },

	["advanced_tent"] =
    {
        label = "Advanced Tent",
        description = "This bad boy will shield the water for days",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tent.png",
        type = "item_standard",
    },

	["cuffs"] =
    {
        label = "Cuffs",
        description = "Popular item for police, bandits & married couples",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cuffs.png",
        type = "item_standard",
    },

	["pot"] =
    {
        label = "Pots",
        description = "The worst kind of pot",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/pot.png",
        type = "item_standard",
    },

	["cigar"] =
    {
        label = "Cigar",
        description = "Inhale with style",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cigar.png",
        type = "item_standard",
    },

	["cigarettes"] =
    {
        label = "Cigarettes",
        description = "Tobacco has never tasted so great",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cigarettes.png",
        type = "item_standard",
    },

	["hairpomade"] =
    {
        label = "Hair Pomade",
        description = "Slick it back you filthy animal.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/hairpomade.png",
        type = "item_standard",
    },

	["notebook"] =
    {
        label = "Notebook",
        description = "Write down yer notes.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/notebook.png",
        type = "item_standard",
    },

	["pocket_watch"] =
    {
        label = "Pocket Watch",
        description = "Check out the time.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/pocketwatch.png",
        type = "item_standard",
    },

	["book"] =
    {
        label = "Book",
        description = "Git yer mind busy with some reading.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/book.png",
        type = "item_standard",
    },

	["pipe"] =
    {
        label = "Smoking Pipe",
        description = "A fancy way to smoke Tobacco.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/pipe.png",
        type = "item_standard",
    },

	["fan"] =
    {
        label = "Fancy Fan",
        description = "For the ladies to keep cool.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/fan.png",
        type = "item_standard",
    },

	["chewingtobacco"] =
    {
        label = "Chewing Tobacco",
        description = "Tobacco for yer mouth.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/chewingtobacco.png",
        type = "item_standard",
    },

	["cornseed"] =
    {
        label = "Cornseed",
        description = "Seed of the corn",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cornseed.png",
        type = "item_standard",
    },

	["stew"] =
    {
        label = "Goulash",
        description = "A big ol stew.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/stew.png",
        type = "item_standard",
    },

	["sugarsaneseed"] =
    {
        label = "Sugar Cane Seed",
        description = "Its a sugar canes way of reproducing",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/sugarsaneseed.png",
        type = "item_standard",
    },

	["tobaccoseed"] =
    {
        label = "Tobacco Seed",
        description = "Its a tobacco plants way of reproducing",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tobaccoseed.png",
        type = "item_standard",
    },

	["tobacco"] =
    {
        label = "Tobacco",
        description = "Smells like an old saloon.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tobacco.png",
        type = "item_standard",
    },

    ["opium"] =
    {
        label = "Opium",
        description = "a powerful processed drug",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/opium.png",
        type = "item_standard",
    },

    ["morphine"] =
    {
        label = "Morphine",
        description = "need something strong to help you relax?",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/morphine.png",
        type = "item_standard",
    },

	["cloth"] =
    {
        label = "Cloth",
        description = "Clearly a brown stain on this",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cloth.png",
        type = "item_standard",
    },

	["cooked_meat"] =
    {
        label = "Cooked Meat",
        description = "Medium rare, the only way to have it.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 35,
        imgsrc = "items/cooked_meat.png",
        type = "item_standard",
    },

	["meat"] =
    {
        label = "Meat",
        description = "A bit of pork for ya fork",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 35,
        imgsrc = "items/meat.png",
        type = "item_standard",
    },

	["poor_whisky"] =
    {
        label = "Dirty Whisky",
        description = "Grainy bottle with a whiskey of the poor man",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/poor_whisky.png",
        type = "item_standard",
    },

	["feather"] =
    {
        label = "Feathers",
        description = "Could be the last dodo feather.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/feather.png",
        type = "item_standard",
    },

	["marked_bills"] =
    {
        label = "Bank Notes",
        description = "These Marked Bills from the US Military fund",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/marked_bills.png",
        type = "item_standard",
    },

	["sapphire"] =
    {
        label = "Sapphire",
        description = "A blue precious Gemstone.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/sapphire.png",
        type = "item_standard",
    },

	["emerald"] =
    {
        label = "Emerald",
        description = "A green precious Gemstone.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/emerald.png",
        type = "item_standard",
    },

	["diamond"] =
    {
        label = "Diamond",
        description = "One of the most valuable and sought after Gemstones.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/diamond.png",
        type = "item_standard",
    },

	["rock"] =
    {
        label = "Rock",
        description = "It's not a boulder, its a rock.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/rock.png",
        type = "item_standard",
    },

	["arrows"] =
    {
        label = "Arrows",
        description = "A poorly built arrow, high drag.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/arrows.png",
        type = "item_standard",
    },

	["kwiaty_kaktusa"] =
    {
        label = "Aloe",
        description = "Aloe Vera",
    weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/kwiaty_kaktusa.png",
        type = "item_standard",
    },

	["jezowka"] =
    {
        label = "Echinacea",
        description = "Great for a vego diet",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/jezowka.png",
        type = "item_standard",
    },

	["szalwia"] =
    {
        label = "Sage",
        description = "A little brown...",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/szalwia.png",
        type = "item_standard",
    },

	["papryka"] =
    {
        label = "Pepper",
        description = "Black Pepper",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/papryka.png",
        type = "item_standard",
    },

	["tatarak"] =
    {
        label = "Sweet Flag",
        description = "DO NOT EAT...Tastes crap",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/tatarak.png",
        type = "item_standard",
    },

	["lisc_laurowy"] =
    {
        label = "Bay Leaf",
        description = "A simple leaf",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/lisc_laurowy.png",
        type = "item_standard",
    },

	["valeriana_officinalis"] =
    {
        label = "Valerian Medicine",
        description = "What a lively leaf",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/valeriana_officinalis.png",
        type = "item_standard",
    },

	["kolce"] =
    {
        label = "Marymus Spines",
        description = "Very spikey, dont hurt yaself!",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/kolce.png",
        type = "item_standard",
    },

	["milkweed"] =
    {
        label = "Milkweed",
        description = "Milkweed",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 50,
        imgsrc = "items/milkweed.png",
        type = "item_standard",
    },

	["bandaz_ziolowy"] =
    {
        label = "Herbal Bandage",
        description = "A bandage that looks to be made by a witch doctor",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/bandaz_ziolowy.png",
        type = "item_standard",
    },

	["napar_predkosci"] =
    {
        label = "Adernaline Infusion",
        description = "Feels like cocaine, nicotine & vodka mixed in a needle.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/napar_predkosci.png",
        type = "item_standard",
    },

	["napar_orzezwienia"] =
    {
        label = "Tonic",
        description = "A snake oil? I dont think so",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/napar_orzezwienia.png",
        type = "item_standard",
    },

	["mortar"] =
    {
        label = "Mortar",
        description = "A mortar",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/mortar.png",
        type = "item_standard",
    },

	["corn"] =
    {
        label = "Corn",
        description = "Goes in the same it comes out.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/corn.png",
        type = "item_standard",
    },

	["compass"] =
    {
        label = "Compass",
        description = "NORTH EAST SOUTH WEST",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/compass.png",
        type = "item_standard",
    },

	["flask"] =
    {
        label = "Flask",
        description = "A flask, great for quick sessions",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/flask.png",
        type = "item_standard",
    },

	["flask_clean"] =
    {
        label = "Clean Flask",
        description = "A newly made flask with the engraving: DudeRockTV",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/flask_clean.png",
        type = "item_standard",
    },

	["consumable_haycube"] =
    {
        label = "Haycube",
        description = "A block of hay is a nice treat for your steed.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/consumable_haycube.png",
        type = "item_standard",
    },

	["consumable_horse_stimulant"] =
    {
        label = "Horse Stimulant",
        description = "Gotta go fast.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/consumable_horse_stimulant.png",
        type = "item_standard",
    },

	["apple"] =
    {
        label = "Apple",
        description = "Not an orange",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/apple.png",
        type = "item_standard",


    },

	["cooked_bread"] =
    {
        label = "Toasted Bread",
        description = "A little char never hurt nobody.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cooked_bread.png",
        type = "item_standard",
    },

	["crafting_table"] =
    {
        label = "Crafting Table",
        description = "A table for arts & crafts",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/crafting_table.png",
        type = "item_standard",
    },

	["metal"] =
    {
        label = "Metal",
        description = "rusty metal",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/metal.png",
        type = "item_standard",
    },

	["metal_ore"] =
    {
        label = "Metal Ore",
        description = "An ore for metal",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/metal_ore.png",
        type = "item_standard",
    },

	["copper"] =
    {
        label = "Copper",
        description = "Its a fools gold",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/copper.png",
        type = "item_standard",
    },

	["moonshine_pot"] =
    {
        label = "Moonshine Pot",
        description = "A pot for brewing",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/moonshine_pot.png",
        type = "item_standard",
    },

	["moonshine_pipe"] =
    {
        label = "Moonshine Pipe",
        description = "A dirty pipe",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/moonshine_pipe.png",
        type = "item_standard",
    },

	["moonshine_barrel"] =
    {
        label = "Moonshine Barrel",
        description = "55 litres of pure perfection",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/moonshine_barrel.png",
        type = "item_standard",
    },

	["copper_ore"] =
    {
        label = "Copper Ore",
        description = "Copper Ore",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/copper_ore.png",
        type = "item_standard",
    },

	["cooked_corn"] =
    {
        label = "Cooked Corn",
        description = "Slightly burnt, but its alright.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 35,
        imgsrc = "items/cooked_corn.png",
        type = "item_standard",
    },

	["coffee"] =
    {
        label = "Coffee",
        description = "I allus has wan in the morning",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/coffee.png",
        type = "item_standard",
    },

	["lemonade"] =
    {
        label = "Lemonade",
        description = "It aint no beer, but it sure is tasty",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/lemonade.png",
        type = "item_standard",
    },

	["minttea"] =
    {
        label = "Mint Tea",
        description = "A herbal mixture in warm water",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/minttea.png",
        type = "item_standard",
    },

	["good_whisky"] =
    {
        label = "Good Whisky",
        description = "An award winning whisky, smooth and woody taste",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/good_whisky.png",
        type = "item_standard",
    },

	["shovel"] =
    {
        label = "Shovel",
        description = "A broken mining shovel, still works though!",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 1,
        limit = 20,
        imgsrc = "items/shovel.png",
        type = "item_standard",
    },

	["oldbuckle"] =
    {
        label = "Old Buckle",
        description = "Its old",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/oldbuckle.png",
        type = "item_standard",
    },

	["rustypocketwatch"] =
    {
        label = "Rusty Pocket Watch",
        description = "Old watch that seems to have dirt in all the cracks",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/rustypocketwatch.png",
        type = "item_standard",
    },

	["oldbible"] =
    {
        label = "Tattered Bible",
        description = "Bible engraved with 1706",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/oldbible.png",
        type = "item_standard",
    },

	["silvercoin"] =
    {
        label = "Silver Coin",
        description = "1800's Draped Bust Silver Dollar",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/silvercoin.png",
        type = "item_standard",
    },

	["silverring"] =
    {
        label = "Solid Silver Ring",
        description = "Seems to be covered in dirt, but melt-able",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/oldcoin.png",
        type = "item_standard",
    },

	["goldnugget"] =
    {
        label = "Gold Flakes",
        description = "Raw gold flakes",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 64,
        imgsrc = "items/goldnugget.png",
        type = "item_standard",
    },

    ["goldcoin"] =
    {
        label = "Solid Gold Coin",
        description = "The staple of all wealth",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/goldcoin.png",
        type = "item_standard",
    },

    ["gold"] =
    {
        label = "Gold",
        description = "The staple of all wealth",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/gold.png",
        type = "item_standard",
    },

	["carrotseed"] =
    {
        label = "Carrot Seed",
        description = "A seed for carrots",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/carrotseed.png",
        type = "item_standard",
    },

	["cottonseed"] =
    {
        label = "Cotton Seed",
        description = "A seed for cotton",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cottonseed.png",
        type = "item_standard",
    },

	["wheatseed"] =
    {
        label = "Wheat Seed",
        description = "A seed for wheat",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/wheatseed.png",
        type = "item_standard",
    },

	["broccoliseed"] =
    {
        label = "Broccoli Seed",
        description = "A seed for broccoli",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/broccoliseed.png",
        type = "item_standard",
    },

	["lettuceseed"] =
    {
        label = "Lettuce Seed",
        description = "A seed for lettuce",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/lettuceseed.png",
        type = "item_standard",
    },

	["cotton"] =
    {
        label = "Cotton",
        description = "All good business starts with cotton",
        weight = 0.1,        limit = 20,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cotton.png",
        type = "item_standard",
    },

	["wheat"] =
    {
        label = "Wheat",
        description = "A bakers delight",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/wheat.png",
        type = "item_standard",
    },

	["broccoli"] =
    {
        label = "Broccoli",
        description = "Kids hate it, you love it.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/broccoli.png",
        type = "item_standard",
    },

	["lettuce"] =
    {
        label = "Lettuce",
        description = "Infested with bugs, but still edible",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/lettuce.png",
        type = "item_standard",
    },

	["carrot"] =
    {
        label = "Carrot",
        description = "What's up Doc?",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/carrot.png",
        type = "item_standard",
    },

    ["bagienneseed"] =
    {
        label = "Swamp Herb Seeds",
        description = "Typical seeds",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/bagienneseed.png",
        type = "item_standard",
    },


    ["swampherb"] =
    {
        label = "Swamp Herb",
        description = "Herb of the Swamps",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/swampherb.png",
        type = "item_standard",
    },

    ["swampherbjoint"] =
    {
        label = "Swamp Herb Cigarette",
        description = "Twisted herbs of the swamps",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/swampherbjoint.png",
        type = "item_standard",
    },

	["capocollo"] =
    {
        label = "Capocollo",
        description = "Also known as Capicola or Gabagool.",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/cooked_meat.png",
        type = "item_standard",
    },
---------------------------------------------------------------------------------Ammo---------------------------------------------------------------------------
    ["AMMO_VOLCANIC"] =
    {
        label = "Volcanic Pistol Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_PISTOL_VOLCANIC.png",
        type = "item_standard",
    },

    ["AMMO_CARCANO"] =
    {
        label = "Carcano Sniper Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SNIPERRIFLE_CARCANO.png",
        type = "item_standard",
    },

    ["AMMO_ROLLINGBLOCK"] =
    {
        label = "Rollingblock Sniper Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        imgsrc = "items/AMMO_SNIPERRIFLE_ROLLINGBLOCK.png",
        type = "item_standard",
    },

    ["AMMO_DOUBLEBARREL"] =
    {
        label = "Double Barrel Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SHOTGUN_DOUBLEBARREL.png",
        type = "item_standard",

    },

    ["AMMO_PUMP"] =
    {
        label = "Pump Shotgun Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SHOTGUN_PUMP.png",
        type = "item_standard",
    },

    ["AMMO_REPEATING"] =
    {
        label = "Repeating Shotgun Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SHOTGUN_REPEATING.png",
        type = "item_standard",
    },

    ["AMMO_SHOTGUN_SEMIAUTO"] =
    {
        label = "Semi-Auto Shotgun Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SHOTGUN_SEMIAUTO.png",
        type = "item_standard",
    },

    ["AMMO_DOUBLEACTION"] =
    {
        label = "Double Action Ammo",
        description = "Double Action Revolver Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_DOUBLEACTION.png",
        type = "item_standard",
    },

    ["AMMO_SAWEDOFF"] =
    {
        label = "Sawed Off Shotgun Ammo",
        description = "(:",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SHOTGUN_SAWEDOFF.png",
        type = "item_standard",
    },

    ["AMMO_REVOLVER"] =
    {
        label = "Cattleman Ammo",
        description = "Cattleman Revolver Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_REVOLVER.png",
        type = "item_standard",
    },

    ["AMMO_SCHOFIELD"] =
    {
        label = "Schofield Ammo",
        description = "Schofield Revolver Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SCHOFIELD.png",
        type = "item_standard",
    },

    ["AMMO_LEMAT"] =
    {
        label = "Lemat Ammo",
        description = "Lemat Revolver Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_LEMAT.png",
        type = "item_standard",
    },

    ["AMMO_NAVY"] =
    {
        label = "Navy Ammo",
        description = "Navy Revolver Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_NAVY.png",
        type = "item_standard",
    },

    ["AMMO_SEMIAUTO"] =
    {
        label = "Semi-Auto Ammo",
        description = "Semi-Auto Pistol Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SEMIAUTO.png",
        type = "item_standard",
    },

    ["AMMO_MAUSER"] =
    {
        label = "Mauser Ammo",
        description = "Mauser Pistol Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_MAUSER.png",
        type = "item_standard",
    },

    ["AMMO_M1899"] =
    {
        label = "M1899 Ammo",
        description = "M1899 Pistol Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_M1899.png",
        type = "item_standard",
    },

    ["AMMO_VARMINT"] =
    {
        label = "Varmint Ammo",
        description = "Varmint Rifle Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_VARMINT.png",
        type = "item_standard",
    },

    ["AMMO_REPEATER"] =
    {
        label = "Evans Ammo",
        description = "Evans Repeater Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_REPEATER.png",
        type = "item_standard",
    },

    ["AMMO_LANCASTER"] =
    {
        label = "Lancaster Ammo",
        description = "Lancaster Repeater Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_LANCASTER.png",
        type = "item_standard",
    },

    ["AMMO_RIFLE"] =
    {
        label = "Bolt-Action Ammo",
        description = "Bolt-Action Rifle Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_RIFLE.png",
        type = "item_standard",
    },

    ["AMMO_SPRINGFIELD"] =
    {
        label = "Springfield Ammo",
        description = "Springfield Rifle Ammo",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_SPRINGFIELD.png",
        type = "item_standard",
    },

    ["AMMO_ARROW"] =
    {
        label = "Arrows",
        description = "Arrows, probably for a bow or something",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 40,
        imgsrc = "items/AMMO_ARROW.png",
        type = "item_standard",
    },
---------------------------------------------------------------------------------WEAPONS---------------------------------------------------------------------------
    ["WEAPON_MELEE_LANTERN_ELECTRIC"] =
	{
		label = "Electric Lamp",
		description = "A source of light, fire & fun",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("weapon_melee_davy_lantern"),
		imgsrc = "items/WEAPON_MELEE_LANTERN_ELECTRIC.png",
		type = "item_weapon",
	},

    ["WEAPON_MELEE_TORCH"] =
	{
		label = "Torch",
		description = "Great for travelers scared of the dark",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_MELEE_TORCH"),
		imgsrc = "items/WEAPON_MELEE_TORCH.png",
		type = "item_weapon",
	},

    ["WEAPON_FISHINGROD"] =
	{
		label = "Rod",
		description = "A mans second best friend",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_FISHINGROD"),
		imgsrc = "items/WEAPON_FISHINGROD.png",
		type = "item_weapon"
	},

    ["WEAPON_MELEE_HATCHET"] =
	{
		label = "Hatchet",
		description = "Uses include: Trees, Building, Fireplaces & Humans",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_MELEE_HATCHET"),
		imgsrc = "items/WEAPON_MELEE_HATCHET.png",
		type = "item_weapon"
	},

    ["WEAPON_MELEE_CLEAVER"] =
	{
		label = "Cleaver",
		description = "Keep out of reach of kids",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_MELEE_CLEAVER"),
		imgsrc = "items/WEAPON_MELEE_CLEAVER.png",
		type = "item_weapon"
	},

    ["WEAPON_MELEE_KNIFE"] =
	{
		label = "Knife",
		description = "Thats not a knife, this is a knife.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_MELEE_KNIFE"),
		imgsrc = "items/WEAPON_MELEE_KNIFE.png",
		type = "item_weapon"
	},

    ["WEAPON_THROWN_THROWING_KNIVES"] =
	{
		label = "Throwing Knives",
		description = "Throw me, ill hurt.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_THROWN_THROWING_KNIVES"),
		imgsrc = "items/WEAPON_THROWN_THROWING_KNIVES.png",
		type = "item_weapon"
	},

    ["WEAPON_MELEE_KNIFE_MINER"] =
	{
		label = "Mining Knife",
		description = "An old mining knife, quite large and heavy",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_MINER"),
		imgsrc = "items/WEAPON_MELEE_KNIFE_MINER.png",
		type = "item_weapon"
	},

    ["WEAPON_MELEE_KNIFE_VAMPIRE"] =
	{
		label = "Decorated Dagger",
		description = "A symbol of designer tastes",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_VAMPIRE"),
		imgsrc = "items/WEAPON_MELEE_KNIFE_VAMPIRE.png",
		type = "item_weapon"
	},

    ["WEAPON_LASSO"] =
	{
		label = "Lasso",
		description = "Capture, drag & bind.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_LASSO"),
		imgsrc = "items/WEAPON_LASSO.png",
		type = "item_weapon"
	},

    ["WEAPON_THROWN_TOMAHAWK"] =
	{
		label = "Tomahawk",
		description = "The weapon of the Native tribes.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_THROWN_TOMAHAWK"),
		imgsrc = "items/WEAPON_THROWN_TOMAHAWK.png",
		type = "item_weapon"
	},

    ["WEAPON_PISTOL_M1899"] =
	{
		label = "Pistol M1899",
		description = "A standard cost effective killing machine",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_PISTOL_M1899"),
		imgsrc = "items/WEAPON_PISTOL_M1899.png",
		type = "item_weapon"
	},

    ["WEAPON_PISTOL_MAUSER"] =
	{
		label = "Pistol Mauser",
		description = "A must for any advanced warfare",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_PISTOL_MAUSER"),
		imgsrc = "items/WEAPON_PISTOL_MAUSER.png",
		type = "item_weapon"
	},

    ["WEAPON_PISTOL_MAUSER_DRUNK"] =
	{
		label = "Decorated Mauser",
		description = "Gold, silver & metal... what a treat",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_PISTOL_MAUSER_DRUNK"),
		imgsrc = "items/WEAPON_PISTOL_MAUSER.png",
		type = "item_weapon"
	},

    ["WEAPON_PISTOL_SEMIAUTO"] =
	{
		label = "Pistol Semi-Automatic",
		description = "Goes bang more then once",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_PISTOL_SEMIAUTO"),
		imgsrc = "items/WEAPON_PISTOL_SEMIAUTO.png",
		type = "item_weapon"
	},

    ["WEAPON_PISTOL_VOLCANIC"] =
	{
		label = "Pistol Volcanic",
		description = "WARNING: Does not shoot lava",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_PISTOL_VOLCANIC"),
		imgsrc = "items/WEAPON_PISTOL_VOLCANIC.png",
		type = "item_weapon"
	},

    ["WEAPON_REPEATER_CARBINE"] =
	{
		label = "Repeated Carbine",
		description = "Medium range, high damage.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REPEATER_CARBINE"),
		imgsrc = "items/WEAPON_REPEATER_CARBINE.png",
		type = "item_weapon"
	},

    ["WEAPON_REPEATER_EVANS"] =
	{
		label = "Repeater Evans",
		description = "A feat in weapon mechanics",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REPEATER_EVANS"),
		imgsrc = "items/WEAPON_REPEATER_CARBINE.png",
		type = "item_weapon"
	},

    ["WEAPON_REPEATER_HENRY"] =
	{
		label = "Litchfield Bolt-Action Rifle",
		description = "Great range & accuracy",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REPEATER_HENRY"),
		imgsrc = "items/WEAPON_REPEATER_HENRY.png",
		type = "item_weapon"
	},

    ["WEAPON_RIFLE_VARMINT"] =
	{
		label = "Light Rifle",
		description = "Ride & Shoot!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_RIFLE_VARMINT"),
		imgsrc = "items/WEAPON_REPEATER_HENRY.png",
		type = "item_weapon"
	},

    ["WEAPON_REPEATER_WINCHESTER"] =
	{
		label = "Lancaster Repeater Rifle",
		description = "The famous lancaster",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REPEATER_WINCHESTER"),
		imgsrc = "items/weapon_repeater_lancaster.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_CATTLEMAN"] =
	{
		label = "Revolver Cattleman",
		description = "Its high noon!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN"),
		imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_CATTLEMAN_JOHN"] =
	{
		label = "Revolver Cattleman",
		description = "Its high noon!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN_JOHN"),
		imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_CATTLEMAN_MEXICAN"] =
	{
		label = "Revolver Cattleman",
		description = "Its high noon!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN_MEXICAN"),
		imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_DOUBLEACTION"] =
	{
		label = "Double Action Revolver",
		description = "Double the action, same weight.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION"),
		imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_DOUBLEACTION_EXOTIC"] =
	{
		label = "Exotic Double Action Revolver",
		description = "Just a bit more exotic*",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION_EXOTIC"),
		imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_DOUBLEACTION_GAMBLER"] =
	{
		label = "Self-Locking Revolver",
		description = "Dont forget to lock...",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION_GAMBLER"),
		imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_LEMAT"] =
	{
		label = "LeMat Revolver",
		description = "I think its french, it does go bang!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_LEMAT"),
		imgsrc = "items/WEAPON_REVOLVER_LEMAT.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_SCHOFIELD"] =
	{
		label = "Revolver Schofield",
		description = "Great for prison breaks",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_SCHOFIELD"),
		imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_SCHOFIELD_GOLDEN"] =
	{
		label = "Navy Revolver",
		description = "Just a typical revolver that is Navy",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_NAVY"),
		imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD_GOLDEN.png",
		type = "item_weapon"
	},

    ["WEAPON_REVOLVER_SCHOFIELD_CALLOWAY"] =
	{
		label = "Engraved Schofield",
		description = "Unreadable engravings",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_SCHOFIELD_CALLOWAY"),
		imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD.png",
		type = "item_weapon"
	},

    ["WEAPON_RIFLE_BOLTACTION"] =
	{
		label = "Bolt Action Rifle",
		description = "Jams a lot, but works well when it doesnt.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_RIFLE_BOLTACTION"),
		imgsrc = "items/WEAPON_RIFLE_BOLTACTION.png",
		type = "item_weapon"
	},

    ["WEAPON_SNIPERRIFLE_CARCANO"] =
	{
		label = "Carcano Rifle",
		description = "Range is the key!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_CARCANO"),
		imgsrc = "items/WEAPON_SNIPERRIFLE_CARCANO.png",
		type = "item_weapon"
	},

    ["WEAPON_SNIPERRIFLE_ROLLINGBLOCK"] =
	{
		label = "Rotary Rifle",
		description = "Line em up 500 metres away!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK"),
		imgsrc = "items/WEAPON_SNIPERRIFLE_ROLLINGBLOCK.png",
		type = "item_weapon"
	},

    ["WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC"] =
	{
		label = "Decorated Rifle",
		description = "Looks nice, probably still goes bang",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC"),
		imgsrc = "items/WEAPON_SNIPERRIFLE_ROLLINGBLOCK.png",
		type = "item_weapon"
	},

    ["WEAPON_RIFLE_SPRINGFIELD"] =
	{
		label = "Springfield Rifle",
		description = "Military standard",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_RIFLE_SPRINGFIELD"),
		imgsrc = "items/WEAPON_RIFLE_SPRINGFIELD.png",
		type = "item_weapon"
	},

    ["WEAPON_SHOTGUN_DOUBLEBARREL"] =
	{
		label = "Double Action Shotgun",
		description = "Poorly designed, does the trick though.",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_DOUBLEBARREL"),
		imgsrc = "items/WEAPON_SHOTGUN_DOUBLEBARREL.png",
		type = "item_weapon"
	},

    ["WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC"] =
	{
		label = "Decorated Gun",
		description = "Close range death machine",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC"),
		imgsrc = "items/WEAPON_SHOTGUN_DOUBLEBARREL.png",
		type = "item_weapon"
	},


    ["WEAPON_SHOTGUN_PUMP"] =
	{
		label = "Pump Shotgun",
		description = "WARNING: May mutilate",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_PUMP"),
		imgsrc = "items/WEAPON_SHOTGUN_PUMP.png",
		type = "item_weapon"
	},

    ["WEAPON_SHOTGUN_REPEATING"] =
	{
		label = "Repeating Shotgun",
		description = "Dont shoot too fast, you might jam it!",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_REPEATING"),
		imgsrc = "items/WEAPON_SHOTGUN_REPEATING.png",
		type = "item_weapon"
	},

    ["WEAPON_SHOTGUN_SAWEDOFF"] =
	{
		label = "Sawn-Off Shotgun",
		description = "Compact, high damage & close range",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_SAWEDOFF"),
		imgsrc = "items/WEAPON_SHOTGUN_SAWEDOFF.png",
		type = "item_weapon"
	},

    ["WEAPON_SHOTGUN_SEMIAUTO"] =
	{
		label = "Semi-Automatic Shotgun",
		description = "This may just save your life one day",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_SEMIAUTO"),
		imgsrc = "items/WEAPON_SHOTGUN_SEMIAUTO.png",
		type = "item_weapon"
	},

    ["WEAPON_BOW"] =
	{
		label = "Simple Bow",
		description = "A hunting bow",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_BOW"),
		imgsrc = "items/WEAPON_BOW.png",
		type = "item_weapon"
	},

    ["WEAPON_THROWN_DYNAMITE"] =
	{
		label = "Dynamite",
		description = "This baby will blow up in 3 seconds...",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		limit = 8,
		imgsrc = "items/WEAPON_THROWN_DYNAMITE.png",
		type = "item_standard"
	},

    ["WEAPON_THROWN_MOLOTOV"] =
	{
		label = "Molotov",
		description = "A poor mans grenade",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_THROWN_MOLOTOV"),
		imgsrc = "items/WEAPON_THROWN_MOLOTOV.png",
		type = "item_weapon"
	},

    ["WEAPON_KIT_BINOCULARS"] =
	{
		label = "Binoculars",
		description = "Left lens quite scratched...",
        weight = 0.1,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_KIT_BINOCULARS"),
		imgsrc = "items/WEAPON_KIT_BINOCULARS.png",
		type = "item_weapon"
	},
}
