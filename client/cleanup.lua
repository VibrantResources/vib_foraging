-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:client:CleanUpTimer', function(data)
	local timer = (Config.CleanUpTimer * 60000)

    Wait(timer)
    RemoveBlip(forageBlip)
    for k, v in pairs(Nudists) do
        Wait(250)
        SetPedAsNoLongerNeeded(k)
        exports.ox_target:removeLocalEntity(k)
        Nudists[k] = nil
    end
end)

RegisterNetEvent('foraging:client:CleanUpZones', function(zoneId)
    exports.ox_target:removeZone(zoneId)
end)