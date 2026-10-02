local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

RegisterNetEvent('jsfour-idcard:openuseid')
AddEventHandler('jsfour-idcard:openuseid', function()
local playerPed = PlayerPedId()

	ESX.TriggerServerCallback('jsfour-idcard:getItemAmount', function(quantity)
		if quantity > 0 then
			local player, distance = ESX.Game.GetClosestPlayer()
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			if distance ~= -1 and distance <= 1.5 then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
			end
		else
			ESX.ShowNotification('You dont have Citizen ID.')
		end
	end, 'id_card')
end)

RegisterNetEvent('jsfour-idcard:openusedriver')
AddEventHandler('jsfour-idcard:openusedriver', function()
local playerPed = PlayerPedId()

	ESX.TriggerServerCallback('jsfour-idcard:getItemAmount', function(quantity)
		if quantity > 0 then
			local player, distance = ESX.Game.GetClosestPlayer()
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
			if distance ~= -1 and distance <= 1.5 then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			end
		else
			ESX.ShowNotification('You dont have Driver License Card.')
		end
	end, 'license_drive')
end)

RegisterNetEvent('jsfour-idcard:openuseweapon')
AddEventHandler('jsfour-idcard:openuseweapon', function()
local playerPed = PlayerPedId()

	ESX.TriggerServerCallback('jsfour-idcard:getItemAmount', function(quantity)
		if quantity > 0 then
			local player, distance = ESX.Game.GetClosestPlayer()
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
			if distance ~= -1 and distance <= 1.5 then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
			end
		else
			ESX.ShowNotification('You dont have Weapon License Card.')
		end
	end, 'license_weapon')
end)


