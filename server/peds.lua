-------------
--Variables--
-------------

Nudists = {}

----------
--Events--
----------

RegisterNetEvent('foraging:server:NudistSpawn', function(data)
    local player = QBCore.Functions.GetPlayer(source)
    Nudists[data.AreaName] = {}

    for i = 1, data.NudistInfo.AmountOfNudists do
        Wait(1000)
        local randomModel = math.random(1, #data.NudistInfo.NudistModels)
        local chosenModel = data.NudistInfo.NudistModels[randomModel]
        local randomCoords = getRandomPointInArea(data.AreaCoords, data.AreaRadius)

        lib.callback('foraging:client:GetZCoords', player.PlayerData.source, function(zCoord)
            nudistPed = CreatePed(1, chosenModel, randomCoords.x-0.2, randomCoords.y-0.2, zCoord, true, true)
            Wait(500)
            table.insert(Nudists[data.AreaName], nudistPed)
        end, randomCoords)

        Wait(500)
        local nudistEntity = NetworkGetNetworkIdFromEntity(nudistPed)

        TriggerClientEvent('foraging:client:CreateNudistEntity', -1, data, nudistEntity)
        TriggerClientEvent('foraging:client:AmbientNudists', -1, data, nudistEntity)
    end
end)