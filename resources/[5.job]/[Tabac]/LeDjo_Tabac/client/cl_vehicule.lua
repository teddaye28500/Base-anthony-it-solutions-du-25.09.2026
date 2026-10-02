local Options = {}

Citizen.CreateThread(function()
	exports['qtarget']:AddBoxZone("TabacVehicule", vector3(2899.197510, 4399.423828, 50.234802), 1, 1, {
		name="TabacVehicule",
		heading=30,
		--debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
	  {
		  event = "ledjo_tabac:vehicule", 
		  icon = "fa fa-car",
		  label = "Vehicule Compagnie",
          job = "tabac",
	  },
    },
  distance = 2.5
})

end)


RegisterNetEvent('ledjo_tabac:vehicule')
AddEventHandler('ledjo_tabac:vehicule', function()
    lib.showContext('ledjo_tabac:vehicule')
end)


for i = 1, #Config.cars.Tabac do
    if i == 1 then
        Options[i] = { title = Config.cars.Tabac[i].nom, args = Config.cars.Tabac[i].modele, icon = "fa fa-car", event = 'ledjo_tabac:delCar'}
    else
        Options[i] = { title = Config.cars.Tabac[i].nom, args = Config.cars.Tabac[i].modele, icon = "fa fa-car", event = 'ledjo_tabac:spawnCar'}
    end
end
    lib.registerContext({
        id = 'ledjo_tabac:vehicule',
        title = (Config.title.Tabac),
        options = Options,
    })


function createCarTabac(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.SpawnVeh.Tabac, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate.Tabac..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('ledjo_tabac:spawnCar', function(data)
    createCarTabac(data)
end)

RegisterNetEvent('ledjo_tabac:delCar')
AddEventHandler('ledjo_tabac:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

Citizen.CreateThread(function()
	local hash = GetHashKey("a_m_m_beach_01")
	while not HasModelLoaded(hash) do
	RequestModel(hash)
	Wait(1000)
	end
	ped = CreatePed("a_m_m_beach_01", "a_m_m_beach_01", 2899.197510, 4399.423828, 49.234802, 199.278992, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
end)
