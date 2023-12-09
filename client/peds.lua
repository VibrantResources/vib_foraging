CreateThread(function()
    lib.requestModel(Config.DealerPed.PedModel)
    dealer = CreatePed(1, Config.DealerPed.PedModel, Config.DealerPed.Location, false, true)
    SetEntityInvincible(dealer, true)
    SetBlockingOfNonTemporaryEvents(dealer, true)
    FreezeEntityPosition(dealer, true)

    exports.ox_target:addSphereZone({
        coords = vec3(Config.DealerPed.Location.x, Config.DealerPed.Location.y, Config.DealerPed.Location.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                icon = "fa-solid fa-seedling",
                iconColor = "green",
                label = "Speak to Groovy dude",
                event = 'foraging:client:MushroomMenu',
                distance = 2,
                args = Config.DealerPed.ShopInfo,
            },
        },
    })
end)