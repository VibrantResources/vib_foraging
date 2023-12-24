-----------------
--Ped Variables--
-----------------

Nudists = {}

--------------------
--Ped Spawn Thread--
--------------------

CreateThread(function()
    lib.requestModel(Config.DealerPed.PedModel)
    dealer = CreatePed(1, Config.DealerPed.PedModel, Config.DealerPed.Location.x, Config.DealerPed.Location.y, Config.DealerPed.Location.z-1, true, true)
    SetEntityInvincible(dealer, true)
    SetBlockingOfNonTemporaryEvents(dealer, true)
    FreezeEntityPosition(dealer, true)

    exports.ox_target:addSphereZone({
        coords = vec3(Config.DealerPed.Location.x, Config.DealerPed.Location.y, Config.DealerPed.Location.z),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                label = locale("InteractWithStartPed"),
                event = 'foraging:client:MushroomMenu',
                distance = 2,
                icon = "fa-solid fa-comment-dots",
                iconColor = "green",
                args = Config.DealerPed.ShopInfo,
            },
        },
    })
end)

------------------------
--Nudist control stuff--
------------------------

RegisterNetEvent('foraging:client:CleanUpNudists', function(data, nudistEntity)
    Wait(500)
    local newNudistEntity = NetworkGetEntityFromNetworkId(nudistEntity)

    exports.ox_target:removeLocalEntity(newNudistEntity)
end)