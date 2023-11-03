RegisterNetEvent('foraging:client:MushroomMenu', function()
	local headerMenu = {}

    for k, v in pairs(Config.ForageLocations) do
        headerMenu[#headerMenu + 1] = {
            title = v.ContextMenuInfo.Title,
            description = v.ContextMenuInfo.Description,
            icon = v.ContextMenuInfo.Icon,
            iconColor = v.ContextMenuInfo.IconColor,
            event = 'foraging:client:ChooseLocation',
            args = v,
        }
    end

    lib.registerContext({
        id = 'mushroom_menu',
        title = "Funky Happenings",
        options = headerMenu
    })

    lib.showContext('mushroom_menu')
end)