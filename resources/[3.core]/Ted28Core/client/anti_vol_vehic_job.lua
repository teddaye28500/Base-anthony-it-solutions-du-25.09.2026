-- VOL DE VEHICULE DE FONCTITON

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local ped = GetPlayerPed(-1)
        local vehicleClass = GetVehicleClass(vehicle)
        PlayerData = ESX.GetPlayerData()

        if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == ped then
            if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
                local playerGroup = PlayerData.group
                if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic' and PlayerData.job.name ~= 'mecano' and PlayerData.job.name ~= 'bcso' and PlayerData.job.name ~= 'sheriff' and PlayerData.job.name ~= 'gouv' and playerGroup ~= 'user' then
                    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
                    local chance_kick = math.random()
                    local time = 9000
                    if chance_kick < 0.7 then
                        ClearPedTasksImmediately(ped)
                        TaskLeaveVehicle(ped, vehicle, 0)
                        print("Le joueur ^1" .. GetPlayerName(PlayerId()) .. "^0 a tenté de ^1voler un véhicule de fonction ^0(LSPD) !")   
                        ESX.ShowNotification("Le vol de véhicule de fonction est interdit !", "error", 3000)
                        
                        ClearPedTasksImmediately(ped)
                        TaskLeaveVehicle(ped, vehicle, 0)
                    end
                end
            end
        end
    end
end)