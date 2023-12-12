-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:client:CleanUpTimer', function(data)
	local timer = (Config.CleanUpTimer * 60000)

    Wait(timer)
    for k, v in pairs(Nudists) do
        Wait(250)
        SetPedAsNoLongerNeeded(k)
        exports.ox_target:removeLocalEntity(k)
        Nudists[k] = nil
    end
end)