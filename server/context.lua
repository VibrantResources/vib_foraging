-------------
--Variables--
-------------

Context = {
    Cooldowns = {},
}

---------------------
--Cooldown Handling--
---------------------

RegisterNetEvent("foraging:server:TriggerCooldown", function(data) -- Trigger server side cooldown for selected area
    Context.Cooldowns[data.AreaName] = os.time()
end)

lib.callback.register("foraging:server:GetCooldown", function(_, data) -- Get current area cooldown
	local cooldown = 0
	local savedTimestamp = Context.Cooldowns[data.AreaName]

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneCooldownInSeconds = data.Cooldown.Minutes * 60
	local timeExpires = savedTimestamp + zoneCooldownInSeconds
	local remainingTime = timeExpires - os.time()

	cooldown = remainingTime > 0 and remainingTime or 0

	if cooldown <= 0 then
		Context.Cooldowns[data.AreaName] = -1
	end

	return cooldown
end)