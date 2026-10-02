ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})

--- Annonce Vigneron
RegisterServerEvent('NSX:vigneron:AnnonceOuvert')
AddEventHandler('NSX:vigneron:AnnonceOuvert', function()
    local message = Config.announceouvert.Vigneron
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Vigneron',
        description = message,
        type = 'inform',
        position = 'top-center',
        icon = 'bell'
    })
end)

RegisterServerEvent('NSX:vigneron:AnnonceFermer')
AddEventHandler('NSX:vigneron:AnnonceFermer', function()
    local message = Config.announcefermer.Vigneron
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Vigneron',
        description = message,
        type = 'error',
        position = 'top-center',
        icon = 'times-circle'
    })
end)

--- Coffre 
local borderstash = {
    id = 'vigneronCoffre',
    label = 'Coffre vigneron',
    slots = 90,
    weight = Config.PositionTarget.Poids,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)