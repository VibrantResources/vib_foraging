-----------------
--Ped Variables--
-----------------

Nudists = {}

--------------------
--Ped Spawn Thread--
--------------------

CreateThread(function()
    lib.requestModel(Config.DealerPed.PedModel)
    local dealer = CreatePed(1, Config.DealerPed.PedModel, Config.DealerPed.Location.x, Config.DealerPed.Location.y, Config.DealerPed.Location.z-1, true, true)
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

RegisterNetEvent('foraging:client:AmbientNudists', function(data, nudistEntity)
    Wait(500)
    local newNudistEntity = NetworkGetEntityFromNetworkId(nudistEntity)
    lib.requestAnimSet('MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP')

    TaskWanderInArea(newNudistEntity, data.AreaCoords, 10.0, 15, 2.0)
    SetPedMovementClipset(newNudistEntity, 'MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP', 1)
end)

RegisterNetEvent('foraging:client:CleanUpNudists', function(data, nudistEntity)
    Wait(500)
    local newNudistEntity = NetworkGetEntityFromNetworkId(nudistEntity)

    exports.ox_target:removeLocalEntity(newNudistEntity)
    SetPedAsNoLongerNeeded(newNudistEntity)
end)