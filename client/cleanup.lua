-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:client:CleanUpTimer', function(data)
    if Config.CleanUpTimer > data.Cooldown.Minutes then
	    timer = data.Cooldown.Minutes * 60000
    else
        timer = Config.CleanUpTimer * 60000
    end

    Wait(250)
    Wait(timer)
    RemoveBlip(forageBlip)
end)

RegisterNetEvent('foraging:client:CleanUpZones', function(zoneId)
    exports.ox_target:removeZone(zoneId)
end)