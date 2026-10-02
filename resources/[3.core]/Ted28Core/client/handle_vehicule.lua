-- Handle player exiting the vehicle
RegisterNetEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(vehicle, seat, displayName)
    local vehicleId = NetworkGetNetworkIdFromEntity(vehicle)
    if notifiedVehicles[vehicleId] then
        -- Effacer l'alerte ou arrêter toute action liée à l'alerte précédente
        -- Ici nous supposons que tu veux juste arrêter de montrer l'alerte si elle est encore affichée
        TriggerEvent('ox_lib:notify:stop')
        notifiedVehicles[vehicleId] = nil
    end
end)