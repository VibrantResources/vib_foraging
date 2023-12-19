-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:client:CleanUpTimer', function(data)
	local timer = (Config.CleanUpTimer * 60000)

    Wait(timer)
    RemoveBlip(forageBlip)
    for k, v in pairs(Nudists[data.AreaName]) do
        Wait(250)
        SetPedAsNoLongerNeeded(v)
        exports.ox_target:removeLocalEntity(v)
        Nudists[k] = nil
    end
end)

RegisterNetEvent('foraging:client:CleanUpZones', function(zoneId)
    exports.ox_target:removeZone(zoneId)
end)