local occupiedTracks = {}

RegisterServerEvent('rdl_bowling:start')
AddEventHandler('rdl_bowling:start', function()
    TriggerClientEvent('rdl_bowling:chooseTrack', source, occupiedTracks)
end)

RegisterServerEvent('rdl_bowling:end')
AddEventHandler('rdl_bowling:end', function(track)
    local src, old = source, occupiedTracks
    occupiedTracks = {}
    for k, v in pairs(old) do 
        if v ~= src then
            occupiedTracks[k] = v
        end
    end
    TriggerClientEvent('rdl_bowling:cancel', src)
end)

RegisterServerEvent('rdl_bowling:choose')
AddEventHandler('rdl_bowling:choose', function(track)
    local src = source
    if not occupiedTracks[track] then
        occupiedTracks[track] = src
        TriggerClientEvent('rdl_bowling:play', src, track)
    else
        TriggerClientEvent('rdl_bowling:cancel', src)
    end
end)

AddEventHandler('playerDropped', function()
    local src, old = source, occupiedTracks
    occupiedTracks = {}
    for k, v in pairs(old) do 
        if v ~= src then
            occupiedTracks[k] = v
        end
    end
end)