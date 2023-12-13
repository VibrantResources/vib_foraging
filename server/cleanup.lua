-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:server:CleanUpTimer', function(data)
	local timer = (Config.CleanUpTimer * 60000)

    Wait(timer)
    for k, v in pairs(WildMushrooms) do
        Wait(500)
        DeleteEntity(k)
        TriggerClientEvent('foraging:client:CleanUpZones', -1, WildMushrooms[k].ZoneId) 
    end
end)