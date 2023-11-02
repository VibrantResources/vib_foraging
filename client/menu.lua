RegisterNetEvent('foraging:client:MushroomMenu', function()
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Enquire",
        description = "Pay for information of a random wild mushroom patch",
        icon = 'fa-solid fa-question',
        iconColor = "yellow",
        event = "foraging:client:GetRandomForageLocation",
        readOnly = true,
    }

    headerMenu[#headerMenu + 1] = {
        title = "Sales",
        description = "Sell back for a small profit",
        icon = 'fa-solid fa-dollar',
        iconColor = "green",
        event = "foraging:client:SellMushrooms",
    }

    lib.registerContext({
        id = 'mushroom_menu',
        title = "Funky Happenings",
        options = headerMenu
    })

    lib.showContext('mushroom_menu')
end)