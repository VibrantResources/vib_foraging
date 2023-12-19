-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:client:CleanUpTimer', function(data)
    if Config.CleanUpTimer > data.Cooldown.Minutes then
	    local timer = data.Cooldown.Minutes
        print("Timer was greater than cooldown: ",json.encode(timer, {indent = true}))
    else
        local timer = Config.CleanUpTimer
        print("Timer was less than cooldown: ",json.encode(timer, {indent = true}))
    end
    Wait(500)
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