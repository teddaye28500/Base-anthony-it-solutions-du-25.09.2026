ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'unicorn', 'unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'public'})

RegisterServerEvent('annonceOunicornserveur')
AddEventHandler('annonceOunicornserveur', function()
    local message = Config.announceouvert.Unicorn
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🌟 Unicorn Ouvert ! 🌟',
        description = message,
        type = 'inform',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#862e9c',
            ['.description'] = {
                color = '#2f9e44'
            }
        },
        icon = 'bell'
    })
end)

RegisterServerEvent('annonceFunicornserveur')
AddEventHandler('annonceFunicornserveur', function()
    local message = Config.announcefermer.Unicorn
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🚪 Unicorn Fermé ! 🚪',
        description = message,
        type = 'error',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#2A0000',
            color = '#862e9c',
            ['.description'] = {
                color = '#f8f9fa'
            }
        },
        icon = 'times-circle'
    })
end)

RegisterServerEvent('annonceRunicornserveur')
AddEventHandler('annonceRunicornserveur', function()
    local message = Config.announcerecrutement.Unicorn
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '📝 Recrutement Unicorn ! 📝',
        description = message,
        type = 'success',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#862e9c',
            ['.description'] = {
                color = '#f8f9fa'
            }
        },
        icon = 'user-plus'
    })
end)

RegisterNetEvent('unicorn:SendAnnonce')
AddEventHandler('unicorn:SendAnnonce', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Unicorn',
        description = msg,
        type = 'info',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#862e9c',
            ['.description'] = {
                color = '#f8f9fa'
            }
        },
        icon = 'fa-solid fa-user-tie'
    })
end)

--COFFRE 

local borderstash = {
    id = 'Unicorn Coffre',
    label = 'Coffre Unicorn',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)

local borderstash = {
    id = 'Unicorn Frigo',
    label = 'Unicorn Frigo',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}


AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)

-- ACHAT 

RegisterServerEvent('add:waterserveur')
AddEventHandler('add:waterserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.eau then
            account.removeMoney(Config.prix.eau)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('water', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une Bouteille d\'eau.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:colaserveur')
AddEventHandler('add:colaserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.cola then
            account.removeMoney(Config.prix.cola)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('cola', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Cola.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:redbullserveur')
AddEventHandler('add:redbullserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.redbull then
            account.removeMoney(Config.prix.redbull)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('redbull', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Redbull.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:vodkaserveur')
AddEventHandler('add:vodkaserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.vodka then
            account.removeMoney(Config.prix.vodka)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('vodka', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un shot de Vodka.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:champagneserveur')
AddEventHandler('add:champagneserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.champagne then
            account.removeMoney(Config.prix.champagne)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('champagne', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu du Champagne.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:tequillaserveur')
AddEventHandler('add:tequillaserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.tequilla then
            account.removeMoney(Config.prix.tequilla)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('tequilla', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une Tequilla.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:cocktailserveur')
AddEventHandler('add:cocktailserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.cocktail then
            account.removeMoney(Config.prix.cocktail)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('cocktail', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Cocktail.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:jagerbombserveur')
AddEventHandler('add:jagerbombserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_unicorn'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
        if account.money >= Config.prix.jagerbomb then
            account.removeMoney(Config.prix.jagerbomb)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('jagerbomb', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Jagerbomb.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)