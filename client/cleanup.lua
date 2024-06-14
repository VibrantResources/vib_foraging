-----------------
--CleanUp Timer--
-----------------

RegisterNetEvent('foraging:client:CleanUpTimer', function(data)
    local timer = 0

    if Config.CleanUpTimer > data.Cooldown.Minutes then
	    timer = data.Cooldown.Minutes * 60000
    else
        timer = Config.CleanUpTimer * 60000
    end

    Wait(timer)
    RemoveBlip(forageBlip)
end)