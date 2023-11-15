Config = Config or {}

Config.Debug = true
Config.MoneyItem = "money"

Config.DealerPed = {
    PedModel = "s_m_m_movspace_01",
    Location = vector4(1619.52, 3216.23, 39.46, 193.79),

}

Config.ForageLocations = {
    {
        AreaName = 'Big Shroom Tings', -- Used for context menu
        AreaCoords = vector3(1601.67, 3222.11, 40.4), -- Where mushroom area is
        AreaRadius = 15, -- Radius mushrooms will spawn randomly around [AreaCoords] above
        AreaCost = 1500, -- How much it charges the player to be given each location
        MushroomsInfo = {
            MushroomAmount = 5, -- How many muhsrooms spawn
            MushroomModel = "prop_stoneshroom1", -- Model that spawns (Can be a filing cabinet if you really fucking wanted XD)
            MushroomItem = "schwingleborp_mushrooms", -- Name of item given to player upon picking up mushrooms
            AmountPerPickup = 1, -- How many [MushroomItem] is given to the player each time they pickup
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
        AreaRadius = 15,
        AreaCost = 1000,
        MushroomsInfo = {
            MushroomAmount = 5,
            MushroomModel = "prop_stoneshroom1",
            MushroomItem = "schwingleborp_mushrooms",
            AmountPerPickup = 1,
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