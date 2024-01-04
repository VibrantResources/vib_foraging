-------------
--Variables--
-------------

Context = {
    Cooldowns = {},
	ZoneTriggered
}

---------------------
--Cooldown Handling--
---------------------

RegisterNetEvent("foraging:server:TriggerCooldown", function(data)
    Context.Cooldowns[data.AreaName] = {
		Cooldown = os.time(),
		ZoneTriggered = false,
	}
end)

lib.callback.register("foraging:server:GetCooldown", function(_, data)
	if Context.Cooldowns[data.AreaName] == nil then
		return 0
	end

	local cooldown = 0
	local savedTimestamp = Context.Cooldowns[data.AreaName].Cooldown

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneCooldownInSeconds = data.CooldownInMinutes * 60
	local timeExpires = savedTimestamp + zoneCooldownInSeconds
	local remainingTime = timeExpires - os.time()

	cooldown = remainingTime > 0 and remainingTime or 0

	if cooldown <= 0 then
		Context.Cooldowns[data.AreaName].Cooldown = -1
	end

	return cooldown
end)