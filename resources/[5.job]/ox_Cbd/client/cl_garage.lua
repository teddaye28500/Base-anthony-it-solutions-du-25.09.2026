-- Target

exports.qtarget:AddBoxZone("GarageCbd", vector3(197.14938354492, -265.08374023438, 50.474182128906), 2.4, 1, {

	name="GarageCbd",

	heading=266.7,

	debugPoly=false,           

	minZ=12.98,

	maxZ=15.98,

	}, {

		options = {

			{

				event = "GarageCbd",

				label = "Garage | Cbd",

                icon = "fa-solid fa-warehouse",

				job = "cbd",

			},

		},

		distance = 2.5

})



local Options = {}





-- Ped

Citizen.CreateThread(function()

    local pedModel = GetHashKey("s_m_m_autoshop_01")



    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do

        Wait(1)                                      

    end



    ped = CreatePed(4, pedModel, 197.934066, -265.041748, 49.578002, 164.409454, false, true)

    SetEntityHeading(ped, 164.409454)

    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)

    SetEntityInvincible(ped, true)

    SetPedCombatAttributes(ped, 46, true)

    SetPedCombatAbility(ped, 0)

    SetPedCanSwitchWeapon(ped, false)

    SetBlockingOfNonTemporaryEvents(ped, true)

    Wait(1500)

    FreezeEntityPosition(ped, true)

end)





RegisterNetEvent('GarageCbd')

AddEventHandler('GarageCbd', function()

    lib.showContext('GarageCbd')

end)





for i = 1, #Config.cars.GarageCbd do

    if i == 1 then

        Options[i] = { title = Config.cars.GarageCbd[i].nom, args = Config.cars.GarageCbd[i].modele, icon = "fa-solid fa-square-parking", event = 'cbd:delCar'}

    else

        Options[i] = { title = Config.cars.GarageCbd[i].nom, args = Config.cars.GarageCbd[i].modele, icon = "fa fa-car", event = 'cbd:spawnCar'}

    end

end

    lib.registerContext({

        id = 'GarageCbd',

        title = (Config.title.GarageCbd),

        options = Options,

    })





function createCar3(car)

    local car = GetHashKey(car)



    RequestModel(car)

    while not HasModelLoaded(car) do

        RequestModel(car)

        Wait(0)

    end



    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))

    local vehicle = CreateVehicle(car, Config.SpawnVeh.GarageCbd, true, false)

    SetEntityAsMissionEntity(vehicle, true, true)

    local plaque = Config.Plate.GarageCbd..math.random(1,9)

    SetVehicleNumberPlateText(vehicle, plaque) 

    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)

end



RegisterNetEvent('cbd:spawnCar', function(data)

    createCar3(data)

end)



RegisterNetEvent('cbd:delCar')

AddEventHandler('cbd:delCar',function()

    local veh = ESX.Game.GetClosestVehicle()

    DeleteEntity(veh)

end)

