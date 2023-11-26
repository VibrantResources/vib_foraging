QBCore = exports["qb-core"]:GetCoreObject()

----------------
--Events Stuff--
----------------

RegisterNetEvent('foraging:client:ChooseLocation', function(data)
    local player = cache.ped
    local hasMoney = exports.ox_inventory:Search('count', Config.MoneyItem)

    if hasMoney >= data.AreaCost then
        lib.callback("foraging:server:GetCooldown", false, function(cooldown)
            if cooldown > 0 then
                lib.alertDialog({
                    header = "Slow down there, bucko ...",
                    content = "That patch has already been harvested, friend!",
                    centered = true,
                })
                return
            end

            lib.alertDialog({
                header = "Mr Drug Man says:",
                content = "So ... you wanna know where I get my supply?"
                .. "\n\n You give me a couple racks and you'll get the best high you've ever had!",
                centered = true,
                cancel = false
            })
            TriggerServerEvent('foraging:server:MoneyCheck', data)
        end, data)
    else
        lib.notify({
            title = 'Attention',
            description = "You don't have enough money!",
            type = 'error'
        })
    end
end)

-------------------
--Object Spawning--
-------------------

RegisterNetEvent("foraging:client:CreateTargetZone", function(coords, zCoord, mushroom, data)
    local mushroomZone = exports.ox_target:addSphereZone({
        coords = vector(coords.x, coords.y, zCoord),
        radius = 0.5,
        debug = Config.Debug,
        options = {
            {
                distance = 2,
                icon = "fa-solid fa-box-archive",
                label = "Harvest mushrooms",
                event = 'foraging:client:PickUpMushroom',
                args = {
                    uniqueMushroom = mushroom,
                    areaData = data,
                },
            },
        },
    })
    TriggerServerEvent("foraging:server:UpdateMushroom", mushroom, mushroomZone)
end)

RegisterNetEvent("foraging:client:DestroyTargetZone", function(zoneId)
    exports.ox_target:removeZone(zoneId)
end)

RegisterNetEvent('foraging:client:PickUpMushroom', function(data)
    local player = cache.ped

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
        lib.notify({
            title = "Attention",
            description = "You've collected some mushrooms",
            type = 'success',
        })
    else
        lib.notify({
            title = "Canceled",
            description = "Canceled",
            type = "error"
        })
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
    forageBlip = AddBlipForRadius(data.AreaCoords, 30.0)
    SetBlipAlpha(forageBlip, 175)
    SetBlipColour(forageBlip, 2)

    CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - data.AreaCoords)
    
            if distance < 75 then
                TriggerServerEvent('foraging:server:CreateMushrooms', data)
                TriggerServerEvent("foraging:server:TriggerCooldown", data)
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