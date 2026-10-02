--Enleve les armes de tous les vehicule de police 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20)
        DisablePlayerVehicleRewards(PlayerId())
    end
end)