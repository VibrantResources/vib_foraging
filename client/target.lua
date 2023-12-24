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
                label = locale("InteractWithSpawnedMushroom"),
                event = 'foraging:client:PickUpMushroom',
                args = {
                    uniqueMushroom = mushroom,
                    areaData = data,
                },
                icon = "fa-solid fa-seedling",
                iconColor = "green",
                distance = 2,
            },
        },
    })
    TriggerServerEvent("foraging:server:UpdateMushroom", mushroom, mushroomZone)
end)

RegisterNetEvent('foraging:client:CreateTargetEntity', function(data, nudistEntity)
    Wait(500)
    local newNudistEntity = NetworkGetEntityFromNetworkId(nudistEntity)

    local entityTarget = exports.ox_target:addLocalEntity(newNudistEntity, {
        {
            icon = "fa-solid fa-comment-dots",
            iconColor = "green",
            label = locale("InteractWithSpawnedPed"),
            onSelect = function(data)
                TriggerEvent('foraging:client:SpeakToNudist', data)
            end,
            iconColor = "green",
            distance = 2.0
        }
    })
end)

RegisterNetEvent("foraging:client:DestroyTargetZone", function(zoneId)
    exports.ox_target:removeZone(zoneId)
end)

RegisterNetEvent('foraging:client:RemoveLocalEntityTarget', function(data)

end)