local Options = {}

for i = 1, #Config.cars.taxi do
    if i == 1 then
        Options[i] = { title = Config.cars.taxi[i].nom, args = Config.cars.taxi[i].modele, event = 'taxi:delCar'}
    else
        Options[i] = { title = Config.cars.taxi[i].nom, args = Config.cars.taxi[i].modele, event = 'taxi:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opentaxigarage',
        title = Config.title.taxi,
        options = Options,
    })

RegisterNetEvent('taxi:opentaxigarage')
AddEventHandler('taxi:opentaxigarage',function()
	lib.showContext('opentaxigarage')
end)

function createCartaxi(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.SpawnVeh.taxi, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    SetVehicleNumberPlateText(vehicle, plate) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    TriggerServerEvent('addkeys', plate)
end

RegisterNetEvent('taxi:spawnCar', function(data)
    createCartaxi(data)
end)

RegisterNetEvent('taxi:delCar')
AddEventHandler('taxi:delCar',function()
    local vehicle = ESX.Game.GetClosestVehicle()
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    TriggerServerEvent('removekeys', plate)
    DeleteEntity(vehicle)
end)

Citizen.CreateThread(function()
	local hash = GetHashKey(Config.pedgaragetaxiped)
	while not HasModelLoaded(hash) do
	RequestModel(hash)
	Wait(1000)
	end
	ped = CreatePed(Config.pedgaragetaxiped, Config.pedgaragetaxiped, Config.pedtaxigarage.x,Config.pedtaxigarage.y,Config.pedtaxigarage.z,Config.pedtaxigarage.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
end)