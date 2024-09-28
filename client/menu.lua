RegisterNetEvent('foraging:client:MushroomMenu', function(data)
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}

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