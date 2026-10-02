-- ENLEVER ROULADE (REALISME)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlPressed(0, 25)
            then DisableControlAction(0, 22, true)
        end
    end
end)

-- ENLEVER TAPER AVEC R
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        DisableControlAction(0, 140, true)
    end
end)