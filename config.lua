Config = Config or {}

Config.Debug = false
Config.MoneyItem = "money" -- Money item taken when paying for a foraging area
-- [Config.CleanUpTimer] is designed to allow automatic removal of spawned props and peds. If this timer is HIGHER than an Area's [CooldownInMinutes], the timer will
-- BECOME that Area's [CooldownInMinutess] time, if it's LESS then it'll stay as whatever is defined here
Config.CleanUpTimer = 0.2

Config.GenericStuff = {
    PickUpDuration = 1500, -- How long it takes to pick up a mushroom
}


Config.DealerPed = {
    ChanceForPedAggression = 15, -- % chance for peds to be aggressive upon interaction
    PedModel = "s_m_m_movspace_01", -- Shop ped model
    Location = vector4(-1123.97, 4892.84, 218.47, 9.02), -- Location of shop ped
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
        AreaCoords = vector3(3629.92, 5003.25, 12.47), -- Where you want the mushroom to spawn
        AreaRadius = 15.0, -- Radius mushrooms will spawn randomly around [AreaCoords] above (Keep this as a float to allow peds to wander)
        AreaCost = 1500, -- How much this location will charge the player
        MushroomsInfo = {
            MushroomAmount = 8, -- How many mushrooms spawn
            MushroomModel = "prop_stoneshroom1", -- Model that spawns (Can realistically be whatever you want)
            MushroomItem = "schwingleborp_mushrooms", -- Name of item given to player upon picking up mushrooms
            AmountPerPickup = 1, -- How many [MushroomItem] is given to the player each time they collect
        },
        NudistInfo = {
            AmountOfNudists = 5, -- How many NPC's spawn
            NudistModels = { -- Ped models that get randomly chosen when NPC's spawn
                "a_m_m_acult_01",
            },
        },
        CooldownInMinutes = 10,
        ContextMenuInfo = { -- Context menu text for this zone
            Title = "Big Shroom Tings",
            Description = "If you're after the biggest bang for your buck, then you've chose the right area!",
            Icon = "fa-solid fa-fire", -- Can be changed here, using the FREE ones [https://fontawesome.com/]
            IconColor = "red", -- What colour you want the above icon to be
        },
    },
    {
        AreaName = 'Small Shroom Tings',
        AreaCoords = vector3(-312.67, 3791.57, 68.0),
        AreaRadius = 15.0,
        AreaCost = 1000,
        MushroomsInfo = {
            MushroomAmount = 8,
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
        CooldownInMinutes = 1,
        ContextMenuInfo = {
            Title = "Small Shroom Tings",
            Description = "A milder effect but people seem to love the constant vibe ...",
            Icon = "fa-solid fa-water",
            IconColor = "blue",
        },
    },
}