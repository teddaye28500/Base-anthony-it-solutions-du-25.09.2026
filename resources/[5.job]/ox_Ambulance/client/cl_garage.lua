local Options = {}
local genderNum = 0
local peds = {}

for i = 1, #Config.ambulance do
    if i == 1 then
        Options[i] = {
            title = Config.ambulance[i].nom,
            args = Config.ambulance[i].modele,
            event = 'ambulance:delCar'
        }
    else
        Options[i] = {
            title = Config.ambulance[i].nom,
            args = Config.ambulance[i].modele,
            event = 'ambulance:spawnCar'
        }
    end
end
lib.registerContext({
    id = 'openambulancegarage',
    title = Config.Title.ambulance,
    options = Options,
})

RegisterNetEvent('ambulance:openambulancegarage')
AddEventHandler('ambulance:openambulancegarage', function()
    lib.showContext('openambulancegarage')
end)

function createCarAmbulance(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end


    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.SpawnVeh.ambulance, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    SetVehicleNumberPlateText(vehicle, plate)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
	exports.mono_garage:ClientInventoryKeys('add', plate) 
end

RegisterNetEvent('ambulance:spawnCar', function(data)
    createCarAmbulance(data)
end)

RegisterNetEvent('ambulance:delCar')
AddEventHandler('ambulance:delCar', function()
    local vehicle = ESX.Game.GetClosestVehicle()
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
	exports.mono_garage:ClientInventoryKeys('remove', plate) 
    DeleteEntity(vehicle)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)

			if dist < Config.PedsDistance and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end
			
			if dist >= Config.PedsDistance and peds[k] then
				if Config.Fade then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(peds[k].ped, i, false)
					end
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end)

function nearPed(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(1)
	end
	
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end	

	if Config.MinusOne then 
		local x, y, z = table.unpack(coords)
		ped = CreatePed(genderNum, GetHashKey(model), x, y, z - 1, heading, false, true)
		
	else
		ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	end
	
	SetEntityAlpha(ped, 0, false)
	
	if Config.Frozen then
		FreezeEntityPosition(ped, true) 
	end
	
	if Config.Invincible then
		SetEntityInvincible(ped, true) 
	end

	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(ped, true)
	end
	
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) 
	end
	
	if Config.Fade then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(ped, i, false)
		end
	end

	return ped
end


RegisterNetEvent('oliann:garage', function()
    lib.registerContext({
        id = 'garage',
        title = Config.Title.Garage, 
        options = {
            {
                title = Config.Title.GarageVeh,
                event = 'oliann:garage',
            },
        }
    })

    lib.showContext('garage')
end)

CreateThread(function()
    for i=1, #Config.Garage do
        exports.qtarget:AddBoxZone(i.."_garage_menu", Config.Garage[i].coords, 1.0, 1.0, {
            name=i.."_garage_menu",
            heading=Config.Garage[i].heading,
            debugPoly=false,
            minZ=Config.Garage[i].coords.z-1.5,
            maxZ=Config.Garage[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'ambulance:openambulancegarage',
                    icon = Config.Garage[i].icon,
                    label = Config.Garage[i].labeltarget,
                    job = "ambulance",
                }
            },
            distance = 1.5
        })
    end
end)