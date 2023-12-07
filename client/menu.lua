RegisterNetEvent('foraging:client:MushroomMenu', function(data)
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Willys wonderous waves",
        description = "These groovy green guys are the gateway to another plane maaaan ...",
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
        title = "Lucid lougning",
        options = headerMenu
    })

    lib.showContext('mushroom_menu')
end)

RegisterNetEvent('foraging:client:LocationMenu', function()
    local player = cache.ped
    local headerMenu = {}

    for _, Area in pairs(Config.ForageLocations) do
        headerMenu[#headerMenu + 1] = {
            title = Area.ContextMenuInfo.Title,
            description = Area.ContextMenuInfo.Description,
            metadata = {
                { "This'll cost you $"..Area.AreaCost }
            },
            icon = Area.ContextMenuInfo.Icon,
            iconColor = Area.ContextMenuInfo.IconColor,
            event = 'foraging:client:ChooseLocation',
            args = Area,
        }
    end

    lib.registerContext({
        id = 'location_menu',
        title = "Funky findings",
        options = headerMenu
    })

    lib.showContext('location_menu')
end)