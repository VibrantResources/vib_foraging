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

    for i = 1, data.NudistInfo.AmountOfNudists do
        Wait(1000)
        nudistPed = CreatePed(1, data.NudistInfo.NudistModel, data.AreaCoords, true, true)
        SetBlockingOfNonTemporaryEvents(nudistPed, true)
        SetEntityInvincible(nudistPed, true)
        TaskWanderInArea(nudistPed, data.AreaCoords.x, data.AreaCoords.y, data.AreaCoords.z, data.AreaRadius, 5, 2.0)
    end
end)