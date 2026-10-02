TabacItemCount = {2, 5}

RegisterServerEvent('TabacRecolte:pickedUp')
AddEventHandler('TabacRecolte:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItemCount = math.random(TabacItemCount[1], TabacItemCount[2])
	
	if xPlayer.canCarryItem('tabac', 1) then

		xPlayer.addInventoryItem('tabac', xItemCount)

	else
		TriggerClientEvent('esx:showNotification', source, 'Ton inventaire est plein!')
	end
end)

ESX.RegisterServerCallback('TabacRecolte:checkItem', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('shovel')

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('ledjo_tabac:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)


