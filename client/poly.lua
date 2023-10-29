------------------
--Polyzone Stuff--
------------------

currentZone = nil

CreateThread(function()
    for k, zone in pairs(Config.ForageLocations) do
        lib.zones.poly({
            points = zone.PolyZonePoints,
            thickness = 8,
            debug = Config.Debug,
            onEnter = function(self)
                lib.notify({
                    title = "Shroooooms",
                    description = "You enetered a mushroom patch",
                    type = 'inform',
                })
                Inside = true
            end,
            onExit = function(self)
                lib.notify({
                    title = "Shroooooms",
                    description = "you've wandered off ... are you O.K?",
                    type = 'inform',
                })
                Inside = false
            end,
        })
    end
end)