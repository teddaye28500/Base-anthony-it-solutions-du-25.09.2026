ESX = exports["es_extended"]:getSharedObject()

--- Recolte raisin rouge & blanc

RegisterServerEvent('NSX:Rasin')
AddEventHandler('NSX:Rasin', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Quantités aléatoires de raisins
    local quantiteRaisinRouge = math.random(1, 2)
    local quantiteRaisinBlanc = math.random(2, 3)

    -- Vérifier l'espace dans l'inventaire
    local hasEnoughSpace = xPlayer.canCarryItem('raisinrouge', quantiteRaisinRouge) and xPlayer.canCarryItem('raisinblanc', quantiteRaisinBlanc)

    if hasEnoughSpace then

        TriggerClientEvent('NSX:RasinRecolteCircleBar', _source)

        Citizen.Wait(3500)

        -- Ajouter des raisins rouges et blancs au joueur
        xPlayer.addInventoryItem('raisinrouge', quantiteRaisinRouge)
        xPlayer.addInventoryItem('raisinblanc', quantiteRaisinBlanc)
        
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez recolte ' .. quantiteRaisinRouge .. ' Rasin Rouge & ' .. quantiteRaisinBlanc .. ' Rasin Blanc')
    else
        -- Si le joueur n'a pas assez d'espace, vous pouvez envoyer un message approprié ou prendre une autre action
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pas assez de place sur vous !')
    end
end)

--- Traite les raisin rouge & blanc

RegisterServerEvent('NSX:RaisinTraiteRouge')
AddEventHandler('NSX:RaisinTraiteRouge', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinrouge').count >= Config.RaisinRouge.removeraisinrouge

    if hasEnoughRaisinRouge then

        TriggerClientEvent('NSX:RasinTraiteCircleBar', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinrouge', Config.RaisinRouge.removeraisinrouge)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('raisinrougepressage', Config.RaisinRouge.addbarque)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pressé ' .. Config.RaisinRouge.removeraisinrouge .. ' raisins rouges.')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de raisins rouges.')
    end
end)

RegisterServerEvent('NSX:RaisinTraiteBlanc')
AddEventHandler('NSX:RaisinTraiteBlanc', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinblanc').count >= Config.RaisinBlanc.removeraisinblanc
    
    if hasEnoughRaisinRouge then

        TriggerClientEvent('NSX:RasinTraiteCircleBar', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinblanc', Config.RaisinBlanc.removeraisinblanc)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('raisinblancpressage', Config.RaisinBlanc.addbarque)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pressé ' .. Config.RaisinBlanc.removeraisinblanc .. ' raisins blanc.')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de raisins blanc.')
    end
end)

--- Traite les raisin rouge & blanc Pour devenir en bouteille
RegisterServerEvent('NSX:RaisinTraiteRouge2')
AddEventHandler('NSX:RaisinTraiteRouge2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinrougepressage').count >= Config.BarqueRouge.removebarquerouge

    if hasEnoughRaisinRouge then

        TriggerClientEvent('NSX:RasinTraiteCircleBar2', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinrougepressage', Config.BarqueRouge.removebarquerouge)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('vinrouge', Config.BarqueRouge.addvinrouge)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous utilisez ' .. Config.BarqueBlanc.removebarquerouge .. ' barquettes de raisin rouge pour ' .. Config.BarqueBlanc.addvinrouge .. ' vin rouge .')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de barquettes de raisin rouge.')
    end
end)

RegisterServerEvent('NSX:RaisinTraiteBlanc2')
AddEventHandler('NSX:RaisinTraiteBlanc2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinblancpressage').count >= Config.BarqueBlanc.removebarqueblanc

    if hasEnoughRaisinRouge then

        TriggerClientEvent('NSX:RasinTraiteCircleBar2', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinblancpressage', Config.BarqueBlanc.removebarqueblanc)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('vinblanc', Config.BarqueBlanc.addvinblanc)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous utilise ' .. Config.BarqueBlanc.removebarqueblanc .. ' barque de raisin blanc pour ' .. Config.BarqueBlanc.addvinblanc .. ' vin blanc .')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de barque de raisin blanc.')
    end
end)

-- Vente de Vin rouge
RegisterServerEvent('NSX:VinRougeVente')
AddEventHandler('NSX:VinRougeVente', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local vinRougeQuantity = xPlayer.getInventoryItem('vinrouge').count

    if vinRougeQuantity > 0 then
        local pricePerBottle = Config.Bouteille.prixduvinrouge
        local totalPrice = vinRougeQuantity * pricePerBottle

        xPlayer.removeInventoryItem('vinrouge', vinRougeQuantity)

        -- Ajout de l'argent à la société
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
            account.addMoney(totalPrice)

            -- ✅ Notification avec lib.notify()
            TriggerClientEvent('NSX:notifySuccess', _source, vinRougeQuantity, totalPrice)
        end)
    else
        -- ❌ Notification d'erreur avec lib.notify()
        TriggerClientEvent('NSX:notifyError', _source)
    end
end)

-- Vente de Vin blanc
RegisterServerEvent('NSX:VinBlancVente')
AddEventHandler('NSX:VinBlancVente', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local vinBlancQuantity = xPlayer.getInventoryItem('vinblanc').count

    if vinBlancQuantity > 0 then
        local pricePerBottle = Config.Bouteille.prixduvinblanc
        local totalPrice = vinBlancQuantity * pricePerBottle

        xPlayer.removeInventoryItem('vinblanc', vinBlancQuantity)

        -- Ajout de l'argent à la société
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
            account.addMoney(totalPrice)

            -- ✅ Notification avec lib.notify()
            TriggerClientEvent('NSX:notifySuccess', _source, vinBlancQuantity, totalPrice)
        end)
    else
        -- ❌ Notification d'erreur avec lib.notify()
        TriggerClientEvent('NSX:notifyError', _source)
    end
end)