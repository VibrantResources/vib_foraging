-----------------------------------
--Generate Random Coords at Point--
-----------------------------------

function getRandomPointInArea(areacoords, arearadius)
    local coords = areacoords
    local newRadius = arearadius/2

    local x = coords.x + math.random(math.floor(-newRadius), math.floor(newRadius))
    local y = coords.y + math.random(math.floor(-newRadius), math.floor(newRadius))
    local z = coords.z
  
    local xOffset = x - coords.x
    local yOffset = y - coords.y
  
    x = coords.x + (xOffset - yOffset )
    y = coords.y + (yOffset + xOffset )

    return vec3(x, y, z)
end