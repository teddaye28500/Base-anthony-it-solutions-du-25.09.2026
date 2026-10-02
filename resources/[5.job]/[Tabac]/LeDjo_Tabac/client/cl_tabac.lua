ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

-- Facture
RegisterNetEvent('ledjo_tabac:sendbill')
AddEventHandler('ledjo_tabac:sendbill', function()
      local input = lib.inputDialog('FACTURE TABAC', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_tabac', 'Facture Tabac', amount)
			end
		end
    end
end)

-- Coffre
exports.qtarget:AddBoxZone("TabacCoffre", vector3(2874.700439, 4419.406738, 49.235516), 1.0 , 1.5, {
	name="TabacCoffre",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "ledjo_tabac:coffre",
				icon = "fa fa-university",
				label = "Coffre Tabac",
				job = "tabac",
			},
		},
	distance = 2.5
})


RegisterNetEvent('ledjo_tabac:coffre')
AddEventHandler('ledjo_tabac:coffre', function()
	OpenTabacCoffre()
end)

function OpenTabacCoffre()
	exports.ox_inventory:openInventory('stash', {id='TabacCoffre', owner= false, job = tabac})
end

-- Animations
loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

-- Blips
function CreateBlipCircle(coords, text, color, sprite)
	blip = AddBlipForCoord(coords)

	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 0.5)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	CreateBlipCircle(vector3(Config.TabacLocation.x, Config.TabacLocation.y, Config.TabacLocation.z), Config.TabacBlipText, Config.TabacBlipColor, Config.TabacBlipSprite)
end)
