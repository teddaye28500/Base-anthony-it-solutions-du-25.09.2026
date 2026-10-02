ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'yellowjack', 'yellowjack', 'society_yellowjack', 'society_yellowjack', 'society_yellowjack', {type = 'public'})

RegisterServerEvent('annonceOyellowjackserveur')
AddEventHandler('annonceOyellowjackserveur', function()
    local message = Config.announceouvert.Yellowjack
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🍻 Le Yellow Jack est OUVERT ! 🍻',
        description = message,
        type = 'inform',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#ffd43b',
            ['.description'] = {
                color = '#2f9e44'
            }
        },
        icon = 'beer'
    })
end)

RegisterServerEvent('annonceFyellowjackserveur')
AddEventHandler('annonceFyellowjackserveur', function()
    local message = Config.announcefermer.Yellowjack
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🚪 Le Yellow Jack ferme ses portes ! 🚪',
        description = message,
        type = 'error',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#2A0000',
            color = '#ffd43b',
            ['.description'] = {
                color = '#f8f9fa'
            }
        },
        icon = 'times-circle'
    })
end)

RegisterServerEvent('annonceRyellowjackserveur')
AddEventHandler('annonceRyellowjackserveur', function()
    local message = Config.announcerecrutement.Yellowjack
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🍹 Le Yellow Jack recrute ! 🍹',
        description = message,
        type = 'success',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#ffd43b',
            ['.description'] = {
                color = '#f8f9fa'
            }
        },
        icon = 'user-plus'
    })
end)

RegisterNetEvent('yellowjack:SendAnnonce')
AddEventHandler('yellowjack:SendAnnonce', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🍻 Yellowjack 🍻',
        description = msg,
        type = 'info',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#ffd43b',
            ['.description'] = {
                color = '#f8f9fa'
            }
        },
        icon = 'fa-solid fa-user-tie'
    })
end)

--COFFRE 

local borderstash = {
    id = 'Yellowjack Coffre',
    label = 'Coffre Yellowjack',
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
    id = 'Yellowjack Frigo',
    label = 'Yellowjack Frigo',
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
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
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
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
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
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
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

RegisterServerEvent('add:biereserveur')
AddEventHandler('add:biereserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
        if account.money >= Config.prix.biere then
            account.removeMoney(Config.prix.biere)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('biere', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une biere.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:whiskyserveur')
AddEventHandler('add:whiskyserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
        if account.money >= Config.prix.whisky then
            account.removeMoney(Config.prix.whisky)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('whisky', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu du whisky.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:caprisunserveur')
AddEventHandler('add:caprisunserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
        if account.money >= Config.prix.tequilla then
            account.removeMoney(Config.prix.tequilla)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('caprisun', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Caprisun.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:sangriaserveur')
AddEventHandler('add:sangriaserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
        if account.money >= Config.prix.sangria then
            account.removeMoney(Config.prix.sangria)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('sangria', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Sangria.' })
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
    
    -- Retirer 500$ de la société 'society_yellowjack'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_yellowjack', function(account)
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