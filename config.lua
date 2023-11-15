Config = Config or {}

Config.Debug = true
Config.MoneyItem = "money"

Config.DealerPed = {
    PedModel = "s_m_m_movspace_01",
    Location = vector4(1619.52, 3216.23, 39.46, 193.79),

}

Config.ForageLocations = {
    {
        AreaName = 'Big Shroom Tings',
        AreaCoords = vector3(1601.67, 3222.11, 40.4),
        AreaRadius = 15,
        AreaCost = 1500,
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
            Title = "Big Shroom Tings",
            Description = "If you're after the biggest bang for your buck, then you've chose the right area!",
            Icon = "fa-solid fa-fire",
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