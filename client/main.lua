QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

pickingAllowed = true
mushroomsSpawned = false
mushrooms = {}

-------------------
--Object Spawning--
-------------------

function SpawnMushrooms(zone)
    local playerPed = cache.ped
    local spawnedMushrooms = 0
    print(json.encode(zone, {indent = true}))

    while spawnedMushrooms < zone.AmountOfMushrooms do
        Wait(750)
        local randomCoords = getRandomPointInSphere(zone.ZoneCoords, zone.ZoneRadius)
        local unsafeMushroom = GetClosestObjectOfType(randomCoords, 2, Config.MushroomModel)

        if not unsafeMushroom then
            mushrooms = CreateObject(Config.MushroomModel, randomCoords.x, randomCoords.y, randomCoords.z, true)
            PlaceObjectOnGroundProperly(mushrooms)
            FreezeEntityPosition(mushrooms, true)
            spawnedMushrooms = spawnedMushrooms + 1
        else
            print("We waiting")
            Wait(10)
        end
    end
end