CreateThread(function()
    lib.requestModel(Config.DealerPed.PedModel)
    dealer = CreatePed(1, Config.DealerPed.PedModel, Config.DealerPed.Location, true, true)
    SetEntityInvincible(dealer, true)
    SetBlockingOfNonTemporaryEvents(dealer, true)
    FreezeEntityPosition(dealer, true)

    exports.ox_target:addSphereZone({
        coords = vec3(Config.DealerPed.Location.x, Config.DealerPed.Location.y, Config.DealerPed.Location.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                icon = "fa-solid fa-comment-dots",
                iconColor = "green",
                label = "Speak to Groovy dude",
                event = 'foraging:client:MushroomMenu',
                distance = 2,
                args = Config.DealerPed.ShopInfo,
            },
        },
    })
end)

RegisterNetEvent('foraging:client:NudistSpawn', function(data)
    local player = cache.ped
    print(json.encode(data, {indent = true}))
    for i = 1, data.NudistInfo.AmountOfNudists do
        local randomCoords = getRandomPointInArea(data.AreaCoords, data.AreaRadius)
        local ground, zCoord = GetGroundZFor_3dCoord(randomCoords.x, randomCoords.y, randomCoords.z, 0)
        print(zCoord)
        Wait(1000)
        nudistPed = CreatePed(1, data.NudistInfo.NudistModel, randomCoords.x, randomCoords.y, zCoord, true, true)
        SetBlockingOfNonTemporaryEvents(nudistPed, true)
        SetEntityInvincible(nudistPed, true)
        TaskWanderInArea(nudistPed, data.AreaCoords.x, data.AreaCoords.y, data.AreaCoords.z, data.AreaRadius, 15, 2.0)

        exports.ox_target:addLocalEntity(nudistPed, {
            {
                icon = 'fas fa-shopping-basket',
                label = "Speak to Nudist",
                onSelect = function()
                    print("Nudist spoken to")
                end,
                iconColor = "green",
                distance = 1.5
            }
		})
    end
end)