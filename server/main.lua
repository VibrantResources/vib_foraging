QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

WildMushrooms = {}

----------
--Events--
----------

RegisterNetEvent('foraging:server:CreateMushrooms', function(data) -- Create mushroom objects after selecting area
	local player = QBCore.Functions.GetPlayer(source)

	for i = 1, data.MushroomsInfo.MushroomAmount do
		Wait(1000)
		local randomCoords = getRandomPointInArea(data.AreaCoords, data.AreaRadius)

		lib.callback('foraging:client:GetZCoords', player.PlayerData.source, function(zCoord)
			local mushroom = CreateObject(data.MushroomsInfo.MushroomModel, randomCoords.x, randomCoords.y, zCoord, true, true, false)
			FreezeEntityPosition(mushroom, true)
			local id = os.time() .. QBCore.Shared.RandomInt(3)

			WildMushrooms[mushroom] = {
				id = id,
				Coords = coords,
				ZoneId = nil,
			}
			TriggerClientEvent("foraging:client:CreateTargetZone", -1, randomCoords, zCoord, mushroom, data)
		end, randomCoords)
	end
end)

RegisterServerEvent("foraging:server:UpdateMushroom", function(mushroom, mushroomZone) -- Add target zone id to unique mushroom table
    WildMushrooms[mushroom].ZoneId = mushroomZone
end)

RegisterNetEvent('foraging:server:PickupMushroom', function(data) -- Pick up mushroom, destroying zone & object too
	local zoneId = WildMushrooms[data.args.uniqueMushroom].ZoneId
	local mushroomStuff = data.args.areaData.MushroomsInfo

	if exports.ox_inventory:CanCarryItem(source, mushroomStuff.MushroomItem, mushroomStuff.AmountPerPickup) then
		exports.ox_inventory:AddItem(source, mushroomStuff.MushroomItem, mushroomStuff.AmountPerPickup)
		WildMushrooms[data.args.uniqueMushroom] = nil
		DeleteEntity(data.args.uniqueMushroom)
		TriggerClientEvent('foraging:client:DestroyTargetZone', -1, zoneId)
	else
		lib.notify(source, {
			title = 'Full inventory',
			description = 'Your inventory is full',
			type = 'error'
		})
	end
end)

RegisterNetEvent('foraging:server:MoneyCheck', function(data)
	if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, data.AreaCost) then
		TriggerClientEvent('foraging:client:SellingBlips', source, data)
	end
end)

RegisterNetEvent("foraging:server:SellMushrooms", function(data)
    local itemCount = exports.ox_inventory:Search(source, 'count', data.item)
    local payOut = itemCount * data.price

	if exports.ox_inventory:CanCarryItem(source, Config.MushroomShop.MoneyItem, payOut) then
		if exports.ox_inventory:RemoveItem(source, data.item, itemCount) then
			exports.ox_inventory:AddItem(source, Config.MushroomShop.MoneyItem, payOut)
			lib.notify(source, {
				title = "Attention",
				description = "You've made $"..payOut,
				type = 'success'
			})
		end
	else
		lib.notify(source, {
			title = "Attention",
			description = "Inventory is full!",
			type = 'inform'
		})
	end
end)

------------------
--Cooldown Stuff--
------------------

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