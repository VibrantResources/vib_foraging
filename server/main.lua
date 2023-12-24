QBCore = exports["qb-core"]:GetCoreObject()
lib.locale()

-------------
--Variables--
-------------

WildMushrooms = {}

----------
--Events--
----------

RegisterNetEvent('foraging:server:CreateMushrooms', function(data) -- Create mushroom objects after selecting area
	local player = QBCore.Functions.GetPlayer(source)
	WildMushrooms[data.AreaName] = {}

	for i = 1, data.MushroomsInfo.MushroomAmount do
		Wait(500)
		local randomCoords = getRandomPointInArea(data.AreaCoords, data.AreaRadius)

		lib.callback('foraging:client:GetZCoords', player.PlayerData.source, function(zCoord)
			local mushroom = CreateObject(data.MushroomsInfo.MushroomModel, randomCoords.x, randomCoords.y, zCoord, true, true, false)
			FreezeEntityPosition(mushroom, true)

			table.insert(WildMushrooms[data.AreaName], mushroom)

			WildMushrooms[mushroom] = {
				Coords = coords,
				ZoneId = nil,
			}

			TriggerClientEvent("foraging:client:CreateTargetZone", -1, randomCoords, zCoord, mushroom, data)
		end, randomCoords)
	end
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
			title = locale("PlayerInventoryFull_Title"),
			description = locale("PlayerInventoryFull_Description"),
			type = 'error'
		})
	end
end)

RegisterNetEvent('foraging:server:MoneyCheck', function(data) -- Check if money is removed before giving information to player
	if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, data.AreaCost) then
		TriggerClientEvent('foraging:client:SellingBlips', source, data)
	end
end)

RegisterNetEvent('foraging:server:SellMushrooms', function(data) -- Sell mushrooms for money
    local itemCount = exports.ox_inventory:Search(source, 'count', data.item)
    local payOut = itemCount * data.price

	if exports.ox_inventory:CanCarryItem(source, Config.DealerPed.MushroomShop.MoneyItem, payOut) then
		if exports.ox_inventory:RemoveItem(source, data.item, itemCount) then
			exports.ox_inventory:AddItem(source, Config.DealerPed.MushroomShop.MoneyItem, payOut)
			lib.notify(source, {
				title = locale("PlayerSoldMushrooms_Title"),
				description = locale("PlayerSoldMushrooms_Description")..payOut,
				type = 'success'
			})
		end
	else
		lib.notify(source, {
			title = locale("PlayerInventoryFull_Title"),
			description = locale("PlayerInventoryFull_Description"),
			type = 'inform'
		})
	end
end)