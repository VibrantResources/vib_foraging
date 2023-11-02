QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

RegisterNetEvent('foraging:server:PickupMushroom', function(data)
    local src = source

    if exports.ox_inventory:CanCarryItem(source, data.MushroomItem, data.AmountPerPickup) then
        exports.ox_inventory:AddItem(source, data.MushroomItem, data.AmountPerPickup)
    end
end)

-------------
--Cooldowns--
-------------

------------------
--Cooldown Stuff--
------------------

RegisterNetEvent("foraging:server:TriggerCooldown", function(fieldInfo)
    Context.Cooldowns[fieldInfo.ZoneName] = os.time()
end)

lib.callback.register("foraging:server:GetCooldown", function(_, fieldInfo)
    print("fieldInfo: ", json.encode(fieldInfo, {indent = true}))
	local cooldown = 0
	local savedTimestamp = Context.Cooldowns[fieldInfo.ZoneName]

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneCooldownInSeconds = fieldInfo.Cooldown.Minutes * 60
	local timeExpires = savedTimestamp + zoneCooldownInSeconds
	local remainingTime = timeExpires - os.time()

	cooldown = remainingTime > 0 and remainingTime or 0

	if cooldown <= 0 then
		Context.Cooldowns[fieldInfo.ZoneName] = -1
	end

	return cooldown
end)