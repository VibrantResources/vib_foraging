QBCore = exports["qb-core"]:GetCoreObject()
lib.locale()

-------------
--Variables--
-------------

WildMushrooms = {}

----------
--Events--
----------

RegisterNetEvent('foraging:server:CreateMushrooms', function(data)
	local player = QBCore.Functions.GetPlayer(source)
	WildMushrooms[data.AreaName] = {}
	Context.Cooldowns[data.AreaName].ZoneTriggered = true

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

			Wait(500)
			local newMushroom = NetworkGetNetworkIdFromEntity(mushroom)
	
			TriggerClientEvent('foraging:client:CreateMushroomEntity', -1, data, newMushroom, mushroom)
		end, randomCoords)
	end
end)

RegisterNetEvent('foraging:server:EndForaging', function(data)
	local src = source
	local player = QBCore.Functions.GetPlayer(source)

	CreateThread(function()
		local cooldownInMs = data.CooldownInMinutes * 60000

		while true do
			local ctx = Context.Cooldowns[data.AreaName]
		 
			local timeSinceStartedInMs = (os.time() - ctx.Cooldown) * 1000
		
			if ctx.ZoneTriggered or timeSinceStartedInMs >= cooldownInMs then
				TriggerClientEvent('foraging:client:EndForaging', src)
				return
			end

			Wait(1000)
		end
	end)
end)

RegisterNetEvent('foraging:server:PickupMushroom', function(data)
	local mushroomStuff = data.args.areaData.MushroomsInfo

	if exports.ox_inventory:CanCarryItem(source, mushroomStuff.MushroomItem, mushroomStuff.AmountPerPickup) then
		exports.ox_inventory:AddItem(source, mushroomStuff.MushroomItem, mushroomStuff.AmountPerPickup)
		DeleteEntity(data.args.uniqueMushroom)
	else
		lib.notify(source, {
			title = locale("PlayerInventoryFull_Title"),
			description = locale("PlayerInventoryFull_Description"),
			type = 'error'
		})
	end
end)

RegisterNetEvent('foraging:server:MoneyRemoval', function(data)
	if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, data.AreaCost) then
		TriggerClientEvent('foraging:client:SellingBlips', source, data)
	end
end)

RegisterNetEvent('foraging:server:SellMushrooms', function(data)
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