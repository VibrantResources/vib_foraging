-------------------------
--Mushroom target zones--
-------------------------

RegisterNetEvent('foraging:client:CreateMushroomEntity', function(data, newMushroom, mushroom)
    Wait(500)
    local newMushroomEntity = NetworkGetEntityFromNetworkId(newMushroom)

    local entityTarget = exports.ox_target:addLocalEntity(newMushroomEntity, {
        {
            label = locale("InteractWithSpawnedMushroom"),
            onSelect = function(data)
                TriggerEvent('foraging:client:PickUpMushroom', data)
            end,
            args = {
                uniqueMushroom = mushroom,
                areaData = data,
            },
            icon = "fa-solid fa-seedling",
            iconColor = "green",
            distance = 2.0
        }
    })
end)

RegisterNetEvent('foraging:client:CreateNudistEntity', function(data, nudistEntity)
    Wait(500)
    local newNudistEntity = NetworkGetEntityFromNetworkId(nudistEntity)

    local entityTarget = exports.ox_target:addLocalEntity(newNudistEntity, {
        {
            label = locale("InteractWithSpawnedPed"),
            onSelect = function(data)
                TriggerEvent('foraging:client:SpeakToNudist', data)
            end,
            icon = "fa-solid fa-comment-dots",
            iconColor = "green",
            distance = 2.0
        }
    })
end)