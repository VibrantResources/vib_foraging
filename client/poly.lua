----------------------
--PolyZone Variables--
----------------------

CorrectZone = nil
CurrentZone = {
    Name = nil,
}

------------------
--Polyzone Stuff--
------------------

--// Generate Random Coords
function getRandomPointInSphere(spherecoords, radius)
    local coords = spherecoords
    local newRadius = radius/2
  
    local x = coords.x + math.random(math.floor(-newRadius), math.floor(newRadius))
    local y = coords.y + math.random(math.floor(-newRadius), math.floor(newRadius))
    local z = coords.z + math.random(0, 1)
  
    local xOffset = x - coords.x
    local yOffset = y - coords.y
  
    x = coords.x + (xOffset - yOffset )
    y = coords.y + (yOffset + xOffset )
  
    return vec3(x, y, z)
end

--// Polyzone creation
CreateThread(function()
    for _, zone in pairs(Config.ForageLocations) do
        lib.zones.sphere({
            coords = zone.ZoneCoords,
            radius = zone.ZoneRadius,
            debug = Config.Debug,
            onEnter = function(self)
                CurrentZone = {
                    Name = zone.ZoneName,
                }
                lib.notify({
                    title = "Shroooooms",
                    description = "You enetered: "..CurrentZone.Name,
                    type = 'inform',
                })
                SpawnMushrooms(zone)
                Inside = true
            end,
            onExit = function(self)
                CurrentZone = {
                    Name = nil,
                }
                lib.notify({
                    title = "Shroooooms",
                    description = "Left zone",
                    type = 'inform',
                })
                Inside = false
            end,
        })
    end
end)