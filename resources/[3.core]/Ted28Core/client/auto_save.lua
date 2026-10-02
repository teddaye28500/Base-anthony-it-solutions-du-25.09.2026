ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Wait(5 * 60 * 1000) -- 5 minutes en millisecondes
        print("[AutoSave] Sauvegarde automatique en cours...")
        ExecuteCommand("saveall")
    end
end)