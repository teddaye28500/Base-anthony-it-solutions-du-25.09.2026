---DESACTIVATION DES FONCTIONNALITES NON RP DE CERTAINS VEHICULES

DisableBikeWings = true --Changer en false si vous voulez utiliser les ailes (sur l'oppressor par exemple)
DisableVehicleRocket = true --Changer en false si vous voulez activer le "Rocket Boost" (turbine)
DisableVehicleJump = true --Changer en false si vous voulez activer la fonctionnalité "sauter"
DisableVehicleTransform = true --Changer en false si vous voulez activer la fonctionnalité "transformation"
DisableVehicleWeapons = true --Changer en false si vous voulez activer les armes (mitraillette/missiles)

----END OF CONFIG---

Citizen.CreateThread(function()
    while true do
        local playerped = PlayerPedId()        
        if IsPedInAnyVehicle(playerped, false) then    
            if DisableBikeWings then
                DisableControlAction(0, 354, true)
            end
            if DisableVehicleRocket then
                DisableControlAction(0, 351, true)
            end
            if DisableVehicleJump then
                DisableControlAction(0, 350, true)
            end
            if DisableVehicleTransform then
                DisableControlAction(0, 357, true)
            end
            
            local veh = GetVehiclePedIsUsing(playerped)
            if DoesVehicleHaveWeapons(veh) == 1 and DisableVehicleWeapons and vehicleweaponhash ~= 1422046295 then
                vehicleweapon, vehicleweaponhash = GetCurrentPedVehicleWeapon(playerped)
                if vehicleweapon == 1 then
                    DisableVehicleWeapon(true, vehicleweaponhash, veh, playerped)
                    SetCurrentPedWeapon(playerped, GetHashKey("weapon_unarmed"))
                end
            end    
        end
        Citizen.Wait(0)
    end
end)