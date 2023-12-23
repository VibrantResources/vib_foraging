RegisterNetEvent('foraging:client:MushroomMenu', function(data) -- Main menu after talking to Ped
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Willys wonderous waves",
        description = "These groovy green guys are the gateway to another plane maaaan ...",
        event = 'foraging:client:ShopMenu',
        icon = "fa-solid fa-plant",
        iconColor = "green",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Locations",
        description = "So, you wanna know where I'm picking all these groovy shrooms, eh ...",
        icon = "fa-solid fa-flower",
        iconColor = "green",
        event = 'foraging:client:LocationMenu',
    }

    lib.registerContext({
        id = 'mushroom_menu',
        title = "Lucid lounging",
        options = headerMenu
    })

    lib.showContext('mushroom_menu')
end)

RegisterNetEvent('foraging:client:LocationMenu', function() -- Menu that lets players choose locations
    local player = cache.ped
    local headerMenu = {}

    for _, Area in pairs(Config.ForageLocations) do
        local cooldown = lib.callback.await("foraging:server:GetCooldown", false, Area)

        if cooldown > 0 then
            headerMenu[#headerMenu + 1] = {
                title = Area.ContextMenuInfo.Title,
                description = "This patch has been harvested! Don't over do it!",
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
        title = "Funky findings",
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
        title = "Willys wonderous waves",
        menu = 'mushroom_menu',
        onBack = function()
            lib.showContext('mushroom_menu')
        end,
        options = headerMenu
    })

    lib.showContext('shop_menu')
end)