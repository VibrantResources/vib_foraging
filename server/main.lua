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