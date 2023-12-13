QBCore = exports["qb-core"]:GetCoreObject()

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
        TriggerServerEvent('foraging:server:MoneyCheck', data)
    else
        lib.notify({
            title = 'Attention',
            description = "You don't have enough money!",
            type = 'error'
        })
    end
end)

RegisterNetEvent('foraging:client:PickUpMushroom', function(data)
    if lib.progressCircle({
        lable = "Foraging for shrooommmssss",
        duration = 3000,
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
            title = 'Attention',
            description = "These mushrooms really did a number on these people ...",
            type = 'inform',
        })
        return
    end

    local randomChance = math.random(1, 100)

    if randomChance < Config.DealerPed.ChanceForPedAggression then
        TaskCombatPed(data.entity, player)
        exports.ox_target:removeLocalEntity(data.entity)
        Nudists[data.entity] = nil
        lib.notify({
            title = 'Fuck off',
            description = "These are my mushrooms!!!!!",
            type = 'error',
        })
    else
        TaskTurnPedToFaceEntity(data.entity, player, 6000)
        lib.notify({
            title = 'Hello',
            description = "Hi there! Wonderful day for some foraging, eh?",
            type = 'success',
        })
        Wait(6000)
        TaskWanderInArea(data.entity, data.coords, 10.0, 15, 2.0)
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
    TriggerServerEvent("foraging:server:TriggerCooldown", data)
    TriggerServerEvent('foraging:server:CleanUpTimer', data)
    TriggerEvent('foraging:client:CleanUpTimer', data)
    forageBlip = AddBlipForRadius(data.AreaCoords, 30.0)
    SetBlipAlpha(forageBlip, 175)
    SetBlipColour(forageBlip, 2)

    CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - data.AreaCoords)
    
            if distance < 75 then
                TriggerServerEvent('foraging:server:CreateMushrooms', data)
                TriggerEvent('foraging:client:NudistSpawn', data)
                RemoveBlip(forageBlip)
                break
            end
            Wait(10)
        end
    end)
end)

-------------
--Callbacks--
-------------

lib.callback.register('foraging:client:GetZCoords', function(coords)
    local ground, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)

    return z
end)