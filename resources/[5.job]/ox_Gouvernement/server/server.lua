ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'gouv', 'gouvernement', 'society_gouv', 'society_gouv', 'society_gouv', {type = 'public'})

RegisterServerEvent('annonceOgouvserveur')
AddEventHandler('annonceOgouvserveur', function()
    local message = Config.announceouvert.Gouv
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🏛️ Gouvernement - Ouverture 🏛️',
        description = message,
        type = 'inform',
        position = 'top-center',
        icon = 'bell'
    })
end)

RegisterServerEvent('annonceFgouvserveur')
AddEventHandler('annonceFgouvserveur', function()
    local message = Config.announcefermer.Gouv
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '⛔ Gouvernement - Fermeture ⛔',
        description = message,
        type = 'error',
        position = 'top-center',
        icon = 'times-circle'
    })
end)

RegisterServerEvent('annonceRgouvserveur')
AddEventHandler('annonceRgouvserveur', function()
    local message = Config.announcerecrutement.Gouv
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '📢 Gouvernement - Recrutement 📢',
        description = message,
        type = 'success',
        position = 'top-center',
        icon = 'user-plus'
    })
end)

RegisterNetEvent('gouv:SendAnnonce')
AddEventHandler('gouv:SendAnnonce', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Gouvernement',
        description = msg,
        type = 'info',
        position = 'top-center',
        icon = 'fa-solid fa-user-tie'
    })
end)

--COFFRE 

local borderstash = {
    id = 'Gouv Coffre',
    label = 'Coffre Gouvernement',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

-- Événement serveur pour envoyer la notification à tous les employés Gouv
RegisterNetEvent("gouv:alertEmployees")
AddEventHandler("gouv:alertEmployees", function()
    local players = ESX.GetPlayers()

    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            if xPlayer.job and xPlayer.job.name == "gouv" then
                TriggerClientEvent("gouv:notifyEmployee", playerId)
            end
        end
    end
end)


AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)

RegisterServerEvent('renfort')
AddEventHandler('renfort', function(coords, raison)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'gouv' then
            TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, raison)
        end
    end
end)

RegisterServerEvent('getAllSocietyFunds')
AddEventHandler('getAllSocietyFunds', function()
    local _src = source
    local accounts = {}

    MySQL.Async.fetchAll("SELECT * FROM addon_account_data", {}, function(results)
        for _, data in pairs(results) do
            local name = data.account_name:gsub("society_", "") -- Supprime "society_" du nom
            accounts[name] = data.money
        end

        TriggerClientEvent('openSocietyFundsMenu', _src, accounts)
    end)
end)

-- 📌 Menotter/Démenotter un joueur
RegisterNetEvent('fw_interact:handcuff')
AddEventHandler('fw_interact:handcuff', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and targetPlayer then
        TriggerClientEvent('fw_interact:handcuff', target)
        TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = 'Vous avez menotté/démenotté la personne.' })
        TriggerClientEvent('ox_lib:notify', target, { type = 'inform', description = 'Vous avez été menotté/démenotté.' })
    end
end)

-- 📌 Escorter un joueur
RegisterNetEvent('fw_interact:escort')
AddEventHandler('fw_interact:escort', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and targetPlayer then
        TriggerClientEvent('fw_interact:escort', target, source)
        TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = 'Vous commencez à escorter la personne.' })
        TriggerClientEvent('ox_lib:notify', target, { type = 'inform', description = 'Quelqu’un vous escorte.' })
    end
end)

-- 📌 Mettre un joueur dans un véhicule
RegisterNetEvent('fw_interact:putInVehicle')
AddEventHandler('fw_interact:putInVehicle', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and targetPlayer then
        TriggerClientEvent('fw_interact:putInVehicle', target)
        TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = 'Vous avez mis la personne dans un véhicule.' })
        TriggerClientEvent('ox_lib:notify', target, { type = 'inform', description = 'Vous avez été placé dans un véhicule.' })
    end
end)

-- 📌 Sortir un joueur du véhicule
RegisterNetEvent('fw_interact:OutVehicle')
AddEventHandler('fw_interact:OutVehicle', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and targetPlayer then
        TriggerClientEvent('fw_interact:OutVehicle', target)
        TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = 'Vous avez sorti la personne du véhicule.' })
        TriggerClientEvent('ox_lib:notify', target, { type = 'inform', description = 'Vous avez été sorti du véhicule.' })
    end
end)

-- 📌 Fouiller un joueur (Ox Inventory)
RegisterNetEvent('fw_interact:search')
AddEventHandler('fw_interact:search', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and targetPlayer then
        TriggerClientEvent('ox_inventory:openInventory', source, 'player', target)
        TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = 'Vous fouillez la personne.' })
        TriggerClientEvent('ox_lib:notify', target, { type = 'inform', description = 'Quelqu’un vous fouille.' })
    end
end)

-- 📌 Vérifier Identité (JSFour ID Card)
RegisterNetEvent('fw_interact:checkID')
AddEventHandler('fw_interact:checkID', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and targetPlayer then
        TriggerClientEvent('jsfour-idcard:open', source, target, source)
        TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = 'Vous consultez l’identité de la personne.' })
        TriggerClientEvent('ox_lib:notify', target, { type = 'inform', description = 'Quelqu’un consulte votre carte d’identité.' })
    end
end)
