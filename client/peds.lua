CreateThread(function()
    local ped = lib.requestModel(Config.DealerPed.PedModel)

    dealer = CreatePed(1, ped, Config.DealerPed.Location, false, true)
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
                label = "Purchase Supplies",
                event = 'foraging:client:GetRandomForageLocation',
                distance = 2,
            },
        },
    })
end)