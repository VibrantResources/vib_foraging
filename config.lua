Config = Config or {}

Config.Debug = false
Config.RandomLocationFindMaxAttempts = 50
Config.MushroomModel = "mushroom"

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
    },
    {
        ZoneName = 'Small Shroom Tings',
        AmountOfMushrooms = 5,
        ZoneCoords = vector3(1635.03, 3231.14, 40.41),
        ZoneRadius = 15,
        MushroomModel = "mushroom",
    },
}