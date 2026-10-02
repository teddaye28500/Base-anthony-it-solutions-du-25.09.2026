Citizen.CreateThread(function()
	local hash = GetHashKey("a_m_y_hasjew_01")
	while not HasModelLoaded(hash) do
	RequestModel(hash)
	Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVFEMALE", "a_m_y_hasjew_01", 2917.3665, 4370.5811, 49.4864, 63.9636, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	end)


exports.qtarget:AddBoxZone("TabacVente", vector3(2917.4900, 4370.6133, 50.4890), 1 , 1, {
	name="TabacVente",
	heading=35,
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "sellingstuff:tabac",
				icon = "fa fa-university",
				label = "Vente de cartouches",
				job = "tabac",
			},
		},
	distance = 2.5
})

RegisterNetEvent('sellingstuff:tabac')
AddEventHandler('sellingstuff:tabac', function()
	ESX.TriggerServerCallback('ledjo_tabac:getItemAmount', function(quantity)
		if quantity >= 1 then -- Quantité que tu vend
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
			FreezeEntityPosition(PlayerPedId(), true)
			lib.progressCircle({
				duration = 10000,
				label = "Vente de cartouches...",
				disable = {
					move = true,
					car = true,
					combat = true,
				}
			})
			ClearPedTasks(PlayerPedId())
			FreezeEntityPosition(PlayerPedId(), false)
			TriggerServerEvent('ledjo_tabac:remove', 'item', 5, 'cartourche')
			TriggerServerEvent('ledjo_tabac:add', 'money', 500)
			ESX.ShowNotification('L\'argent est recu par l employé')
		else
			ESX.ShowNotification('Tu as pas asser d\'items')
		end
	end, 'cartourche')
end)


function addMoneyToSociety(society, amount)
	local currentMoney = exports.society:getSocietyMoney(society)
	local newMoney = currentMoney + amount


	exports.society:setSocietyMoney(society, newMoney)
end



