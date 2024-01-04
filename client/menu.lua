RegisterNetEvent('foraging:client:MushroomMenu', function(data)
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = locale("MainMenu_ShopTitle"),
        description = locale("MainMenu_ShopDescription"),
        event = 'foraging:client:ShopMenu',
        icon = "fa-solid fa-basket-shopping",
        iconColor = "yellow",
    }

    headerMenu[#headerMenu + 1] = {
        title = locale("MainMenu_LocationsTitle"),
        description = locale("MainMenu_LocationsDescription"),
        event = 'foraging:client:LocationMenu',
        icon = "fa-solid fa-seedling",
        iconColor = "green",
    }

    lib.registerContext({
        id = 'mushroom_menu',
        title = locale("MainMenu_MenuTitle"),
        options = headerMenu
    })

    lib.showContext('mushroom_menu')
end)

RegisterNetEvent('foraging:client:LocationMenu', function()
    local player = cache.ped
    local headerMenu = {}

    for _, Area in pairs(Config.ForageLocations) do
        local cooldown = lib.callback.await("foraging:server:GetCooldown", false, Area)

        if cooldown > 0 then
            headerMenu[#headerMenu + 1] = {
                title = Area.ContextMenuInfo.Title,
                description = locale("MushroomPatchAlreadyHarvested"),
                readOnly = true,
                icon = Area.ContextMenuInfo.Icon,
                iconColor = Area.ContextMenuInfo.IconColor,
            }
        else
            headerMenu[#headerMenu + 1] = {
                title = Area.ContextMenuInfo.Title,
                description = Area.ContextMenuInfo.Description.."\n\nThis'll cost you $"..Area.AreaCost,
                icon = Area.ContextMenuInfo.Icon,
                iconColor = Area.ContextMenuInfo.IconColor,
                event = 'foraging:client:ChooseLocation',
                args = Area,
            }
        end
    end

    lib.registerContext({
        id = 'location_menu',
        title = locale("LocationMenu_MenuTitle"),
        menu = 'mushroom_menu',
        onBack = function()
            lib.showContext('mushroom_menu')
        end,
        options = headerMenu
    })

    lib.showContext('location_menu')
end)

RegisterNetEvent('foraging:client:ShopMenu', function() -- Menu that lets players sell items
    local player = cache.ped
    local headerMenu = {}

    for item, price in pairs(Config.DealerPed.MushroomShop.ItemsForSale) do
        headerMenu[#headerMenu + 1] = {
            title = exports.ox_inventory:Items(item).label,
            description = "I can buy these "..exports.ox_inventory:Items(item).label.." for $"..price.." each",
            icon = "fa-solid fa-sack-dollar",
            iconColor = "green",
            serverEvent = 'foraging:server:SellMushrooms',
            args = {
                item = item,
                price = price,
            },
        }
    end

    lib.registerContext({
        id = 'shop_menu',
        title = locale("MainMenu_ShopTitle"),
        menu = 'mushroom_menu',
        onBack = function()
            lib.showContext('mushroom_menu')
        end,
        options = headerMenu
    })

    lib.showContext('shop_menu')
end)