ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'weazel', 'weazel', 'society_weazel', 'society_weazel', 'society_weazel', {type = 'public'})

RegisterServerEvent('annonceOweazelserveur')
AddEventHandler('annonceOweazelserveur', function()
    local message = Config.announceouvert.Weazel
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'weazel',
        description = message,
        type = 'inform',
        position = 'top-center',
        icon = 'bell'
    })
end)

RegisterServerEvent('annonceFweazelserveur')
AddEventHandler('annonceFweazelserveur', function()
    local message = Config.announcefermer.Weazel
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Weazel',
        description = message,
        type = 'error',
        position = 'top-center',
        icon = 'times-circle'
    })
end)

RegisterServerEvent('annonceRweazelserveur')
AddEventHandler('annonceRweazelserveur', function()
    local message = Config.announcerecrutement.Weazel
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Weazel',
        description = message,
        type = 'success',
        position = 'top-center',
        icon = 'user-plus'
    })
end)

RegisterNetEvent('weazel:SendAnnonce')
AddEventHandler('weazel:SendAnnonce', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Weazel',
        description = msg,
        type = 'info',
        position = 'top-center',
        icon = 'fa-solid fa-user-tie'
    })
end)

--COFFRE 

local borderstash = {
    id = 'Weazel Coffre',
    label = 'Coffre Weazel',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

-- Événement serveur pour envoyer la notification à tous les employés Weazel
RegisterNetEvent("weazel:alertEmployees")
AddEventHandler("weazel:alertEmployees", function()
    local players = ESX.GetPlayers()

    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            if xPlayer.job and xPlayer.job.name == "weazel" then
                TriggerClientEvent("weazel:notifyEmployee", playerId)
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