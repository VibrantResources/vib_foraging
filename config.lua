Config = Config or {}

Config.Debug = true
Config.MoneyItem = "money" -- Money item taken when paying for a foraging area
-- [Config.CleanUpTimer] is designed to allow automatic removal of spawned props and peds. If this timer is HIGHER than an Area's [Cooldown.Minutes], the timer will
-- BECOME that Area's [Cooldown.Minutes] time, if it's LESS then it'll stay as whatever is defined here
Config.CleanUpTimer = 0.5


Config.DealerPed = {
    ChanceForPedAggression = 15, -- % chance for peds to be aggressive upon interaction
    PedModel = "s_m_m_movspace_01", -- Shop ped model
    Location = vector4(1565.35, 3212.97, 40.41, 104.87), -- Location of shop ped
    MushroomShop = {
        MoneyItem = "black_money", -- Money item given after selling items
        ItemsForSale = { -- [Item] / [item sale price]
            schwingleborp_mushrooms = 100,
            squishybop_mushrooms = 100,
        }
    }
}

Config.ForageLocations = {
    {
        AreaName = 'Big Shroom Tings', -- Must be unique for cooldown purposes
        AreaCoords = vector3(1565.35, 3212.97, 40.41), -- Where you want the mushroom to spawn
        AreaRadius = 15.0, -- Radius mushrooms will spawn randomly around [AreaCoords] above (Keep this as a float to allow peds to wander)
        AreaCost = 1500, -- How much this location will charge the player
        MushroomsInfo = {
            MushroomAmount = 5, -- How many mushrooms spawn
            MushroomModel = "prop_stoneshroom1", -- Model that spawns (Can realisticly be whatever you want)
            MushroomItem = "schwingleborp_mushrooms", -- Name of item given to player upon picking up mushrooms
            AmountPerPickup = 1, -- How many [MushroomItem] is given to the player each time they collect
        },
        NudistInfo = {
            AmountOfNudists = 5, -- How many NPC's spawn
            NudistModels = { -- Ped models that get randomly chosen when NPC's spawn
                "a_m_m_acult_01",
            },
        },
        Cooldown = {
            Minutes = 5, -- Specific area cooldown in minutes(Keep it as a whole number)
        },
        ContextMenuInfo = { -- Context menu text for this zone
            Title = "Big Shroom Tings",
            Description = "If you're after the biggest bang for your buck, then you've chose the right area!",
            Icon = "fa-solid fa-fire", -- Up to you to find one that works if you change this [https://fontawesome.com/]
            IconColor = "red", -- What colour you want the above icon to be
        },
    },
    {
        AreaName = 'Small Shroom Tings',
        AreaCoords = vector3(1595.28, 3220.28, 40.41),
        AreaRadius = 15.0,
        AreaCost = 1000,
        MushroomsInfo = {
            MushroomAmount = 5,
            MushroomModel = "prop_stoneshroom1",
            MushroomItem = "squishybop_mushrooms",
            AmountPerPickup = 1,
        },
        NudistInfo = {
            AmountOfNudists = 5,
            NudistModels = {
                "a_m_m_acult_01",
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