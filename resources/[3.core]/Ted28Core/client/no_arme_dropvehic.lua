--Enlève les armes dropée par les véhicules

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisablePlayerVehicleRewards(PlayerId())
    end
end)

Citizen.CreateThread(function()
    while true do
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.3) --Dégat Cout de poigs
    N_0x4757f00bc6323cfe(-1553120962, 0.2) --Dégat Véhicule
    Wait(0)
    end
end)