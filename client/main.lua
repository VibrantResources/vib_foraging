QBCore = exports["qb-core"]:GetCoreObject()
lib.locale()

-------------
--Variables--
-------------

ForagingStarted = false

----------------
--Events Stuff--
----------------

RegisterNetEvent('foraging:client:ChooseLocation', function(data)
    local hasMoney = exports.ox_inventory:Search('count', Config.MoneyItem)

    if hasMoney >= data.AreaCost then
        lib.alertDialog({
            header = "Mr Drug Man says:",
            content = "So ... you wanna know where I get my supply?"
            .. "\n\n You give me a couple racks and you'll get the best high you've ever had!",
            centered = true,
            cancel = false
        })
        TriggerServerEvent('foraging:server:MoneyRemoval', data)
    else
        lib.notify({
            title = locale("PlayerNotEnoughMoney_Title"),
            description = locale("PlayerNotEnoughMoney_Description"),
            type = 'error'
        })
    end
end)

RegisterNetEvent('foraging:client:PickUpMushroom', function(data)
    if lib.progressCircle({
        lable = locale("GatheringProgressBar_Label"),
        duration = Config.GenericStuff.PickUpDuration,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = 'amb@world_human_gardener_plant@male@base',
            clip = 'base',
            flag = 1,
        },
        prop = {
            {
                model = `prop_cs_trowel`,
                bone = 57005,
                pos = vec3(0.05, -0.01, 0.0),
                rot = vec3(75.0, 90.0, -100.0)
            },
        }
    }) then
        TriggerServerEvent("foraging:server:PickupMushroom", data)
    else
        lib.notify({
            title = "Canceled",
            description = "Canceled",
            type = "error"
        })
    end
end)

RegisterNetEvent('foraging:client:SpeakToNudist', function(data)
    local player = cache.ped

    if GetEntityHealth(data.entity) <= 0 then
        lib.notify({
            title = locale("NudistAlreadyDeadNotif_Title"),
            description = locale("NudistAlreadyDeadNotif_Description"),
            type = 'inform',
        })
        return
    end

    local randomChance = math.random(1, 100)

    if randomChance < Config.DealerPed.ChanceForPedAggression then
        PlayPedAmbientSpeechNative(data.entity, 'Generic_Fuck_You', 'Speech_Params_Force')
        TaskCombatPed(data.entity, player)
    else
        TaskTurnPedToFaceEntity(data.entity, player, -1)
        Wait(1000)
        PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HI', 'Speech_Params_Force')
        Wait(3000)
        TaskWanderInArea(data.entity, data.coords, 10.0, 15, 2.0)
        PlayPedAmbientSpeechNative(data.entity, 'GENERIC_BYE', 'Speech_Params_Force')
    end
end)

----------------------
--Choose Random Zone--
----------------------

-- RegisterNetEvent('foraging:client:GetRandomForageLocation', function()
--     local player = cache.ped
--     local randomLocation = math.random(1, #Config.ForageLocations)
--     local randomField = Config.ForageLocations[randomLocation]

-- 	lib.callback("foraging:server:GetCooldown", false, function(cooldown)
--         if cooldown > 0 then
--             lib.alertDialog({
-- 				header = "Slow down there, bucko ...",
-- 				content = "That patch has already been harvested, friend!",
-- 				centered = true,
-- 			})
--             return
--         end

--         lib.alertDialog({
--             header = "Mr Drug Man says:",
--             content = "So ... you wanna know where I get my supply?"
--             .. "\n\n You give me a couple racks and you'll get the best high you've ever had!",
--             centered = true,
--             cancel = false
--         })
--         SellingBlips(randomField)
--         TriggerServerEvent("foraging:server:TriggerCooldown", randomField)
--     end, randomField)
-- end)

-----------------
--Blip Controls--
-----------------

RegisterNetEvent('foraging:client:SellingBlips', function(data)
    ForagingStarted = true
    print(ForagingStarted)
    TriggerServerEvent("foraging:server:TriggerCooldown", data)
    TriggerServerEvent('foraging:server:EndForaging', data)

    forageBlip = AddBlipForRadius(data.AreaCoords, 30.0)
    SetBlipAlpha(forageBlip, 175)
    SetBlipColour(forageBlip, 2)

    CreateThread(function()
        while ForagingStarted == true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - data.AreaCoords)
    
            if distance < 75 then
                TriggerServerEvent('foraging:server:CreateMushrooms', data)
                TriggerServerEvent('foraging:server:NudistSpawn', data)
                TriggerServerEvent('foraging:server:CleanUpTimer', data)
                RemoveBlip(forageBlip)
                break
            end
            Wait(10)
        end
    end)
end)

RegisterNetEvent('foraging:client:EndForaging', function()
    RemoveBlip(forageBlip)
    ForagingStarted = false
end)

-------------
--Callbacks--
-------------

lib.callback.register('foraging:client:GetZCoords', function(coords)
    local ground, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)

    return z
end)