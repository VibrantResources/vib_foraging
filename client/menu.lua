RegisterNetEvent('foraging:client:MushroomMenu', function()
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
        id = 'mushroom_menu',
        title = "Funky Happenings",
        options = headerMenu
    })

    lib.showContext('mushroom_menu')
end)