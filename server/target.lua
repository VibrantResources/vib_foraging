RegisterServerEvent('foraging:server:UpdateMushroom', function(mushroom, mushroomZone) -- Add target zone id to unique mushroom table
    WildMushrooms[mushroom].ZoneId = mushroomZone
end)