Config = Config or {}

Config.Debug = true
Config.MoneyItem = "money"
Config.CleanUpTimer = 0.1 -- Time in minutes bfore a zones spawned props/peds get deleted. (This helps avoid object clutter if players leave and don't comeback)

Config.DealerPed = {
    ChanceForPedAggression = 50, -- % chance for peds to be aggressive upon interaction
    PedModel = "s_m_m_movspace_01", -- Ped model for shop
    Location = vector4(1565.35, 3212.97, 40.41, 104.87), -- Location shop ped spawns
    MushroomShop = {
        MoneyItem = "black_money",
        ItemsForSale = {
            schwingleborp_mushrooms = 100,
            squishybop_mushrooms = 100,
        }
    }
}

Config.ForageLocations = {
    {
        AreaName = 'Big Shroom Tings', -- Used for context menu
        AreaCoords = vector3(1565.35, 3212.97, 40.41), -- Where mushroom area is
        AreaRadius = 15.0, -- Radius mushrooms will spawn randomly around [AreaCoords] above (Keep this as a decimal to allow peds to wander)
        AreaCost = 1500, -- How much it charges the player to be given each location
        MushroomsInfo = {
            MushroomAmount = 5, -- How many muhsrooms spawn
            MushroomModel = "prop_stoneshroom1", -- Model that spawns (Can be a filing cabinet if you really fucking wanted XD)
            MushroomItem = "schwingleborp_mushrooms", -- Name of item given to player upon picking up mushrooms
            AmountPerPickup = 1, -- How many [MushroomItem] is given to the player each time they pickup
            RareMushroomSpawnChance = 50, -- Chance for a rare mushroom to spawn when talking to Nudists
        },
        NudistInfo = {
            AmountOfNudists = 5, -- How many nudists spawn
            NudistModels = {
                "a_m_m_acult_01",
                "a_m_y_hippy_01",
                "cs_omega",
                "a_f_y_beach_01",
                "a_f_y_hippie_01"
            },
        },
        Cooldown = {
            Minutes = 5, -- Specific area cooldown in minutes
        },
        ContextMenuInfo = { -- Context menu text for this zone
            Title = "Big Shroom Tings",
            Description = "If you're after the biggest bang for your buck, then you've chose the right area!",
            Icon = "fa-solid fa-fire", -- Up to you to find one that works if you change this [https://fontawesome.com/]
            IconColor = "red",
        },
    },
    {
        AreaName = 'Small Shroom Tings',
        AreaCoords = vector3(1635.03, 3231.14, 40.41),
        AreaRadius = 15.0,
        AreaCost = 1000,
        MushroomsInfo = {
            MushroomAmount = 5,
            MushroomModel = "prop_stoneshroom1",
            MushroomItem = "squishybop_mushrooms",
            AmountPerPickup = 1,
            RareMushroomSpawnChance = 50,
        },
        NudistInfo = {
            AmountOfNudists = 5,
            NudistModels = {
                "a_m_m_acult_01",
                "a_m_y_hippy_01",
                "cs_omega",
                "a_f_y_beach_01",
                "a_f_y_hippie_01"
            },
        },
        Cooldown = {
            Minutes = 5,
        },
        ContextMenuInfo = {
            Title = "Small Shroom Tings",
            Description = "A milder effect but people seem to love the constant vibe ...",
            Icon = "fa-solid fa-water",
            IconColor = "blue",
        },
    },
}