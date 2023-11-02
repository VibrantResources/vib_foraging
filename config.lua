Config = Config or {}

Config.Debug = true
Config.RandomLocationFindMaxAttempts = 50
Config.MushroomModel = "mushroom"
Config.MoneyItem = "money"

Config.DealerPed = {
    PedModel = "s_m_m_movspace_01",
    Location = vector4(1619.52, 3216.23, 39.46, 193.79),

}

Config.ForageLocations = {
    {
        ZoneName = 'Big Shroom Tings',
        AmountOfMushrooms = 5,
        ZoneCoords = vector3(1601.67, 3222.11, 40.4),
        ZoneRadius = 15,
        MushroomModel = "prop_stoneshroom1",
        MushroomItem = "schwingleborp_mushrooms",
        AmountPerPickup = math.random(1, 3),
        ZoneCost = 1500,
        Cooldown = { -- How long in minutes between selling bulk drugs to this specific ped
        Minutes = 5,
    },
    },
    {
        ZoneName = 'Small Shroom Tings',
        AmountOfMushrooms = 5,
        ZoneCoords = vector3(1635.03, 3231.14, 40.41),
        ZoneRadius = 15,
        MushroomModel = "mushroom",
        MushroomItem = "tangletoes_mushrooms",
        AmountPerPickup = math.random(1, 3),
        ZoneCost = 1000,
        Cooldown = { -- How long in minutes between selling bulk drugs to this specific ped
        Minutes = 5,
    },
    },
}