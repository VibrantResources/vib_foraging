-------------------------
--Mushroom target zones--
-------------------------

RegisterNetEvent('foraging:client:CreateTargetZone', function(coords, zCoord, mushroom, data)
    local mushroomZone = exports.ox_target:addSphereZone({
        coords = vector(coords.x, coords.y, zCoord),
        radius = 0.5,
        debug = Config.Debug,
        options = {
            {
                distance = 2,
                icon = "fa-solid fa-seedling",
                label = "Harvest mushrooms",
                event = 'foraging:client:PickUpMushroom',
                args = {
                    uniqueMushroom = mushroom,
                    areaData = data,
                },
            },
        },
    })
    TriggerServerEvent("foraging:server:UpdateMushroom", mushroom, mushroomZone)
end)

RegisterNetEvent("foraging:client:DestroyTargetZone", function(zoneId)
    exports.ox_target:removeZone(zoneId)
end)