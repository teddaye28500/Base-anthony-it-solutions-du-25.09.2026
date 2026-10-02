TriggerEvent('esx_society:registerSociety', 'tabac', 'tabac', 'society_tabac', 'society_tabac', 'society_tabac', {type = 'public'})

----------------------------------- Coffre Tabac -----------------------------------

local borderstash = {
    id = 'TabacCoffre',
    label = 'Coffre Tabac',
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

RegisterServerEvent('ledjo_tabac:add')
AddEventHandler('ledjo_tabac:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', source, 'Tu a recu $'..amount 'success')
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)

RegisterServerEvent('ledjo_tabac:remove')
AddEventHandler('ledjo_tabac:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)

ESX.RegisterServerCallback('ledjo_tabac:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

----------------------------------- Annonce Ouvert -----------------------------------


RegisterServerEvent('Tabac:AnnonceOuvert')
AddEventHandler('Tabac:AnnonceOuvert', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tabac', '~b~Annonce Tabac', 'Tabac Ouvert', 'CHAR_AMANDA', 7)
    end
end)

----------------------------------- Annonce Fermer -----------------------------------

RegisterServerEvent('Tabac:AnnonceFermer')
AddEventHandler('Tabac:AnnonceFermer', function()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tabac', '~b~Annonce Tabac', 'Tabac Fermer', 'CHAR_AMANDA', 7)
    end
end)

RegisterServerEvent('osc:Addsocietyaccount')
AddEventHandler('osc:Addsocietyaccount', function(amount)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
        account.addMoney(amount)
    end)
end)

