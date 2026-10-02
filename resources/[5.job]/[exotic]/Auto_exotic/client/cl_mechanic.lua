ESX = nil

Citizen.CreateThread(function()
	ESX = exports["es_extended"]:getSharedObject()

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	Citizen.Wait(10)
end)


local ConfigZone = Config.vet , Config.Blips, Config.Boss
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false



------Diagnostique


local options = {
    {
        name = 'exotic_diag',
        event = 'esx_mecanojob:menu-diag',
        icon = 'fa-solid fa-road',
        label = 'Diagnostique',
		groups= {['exotic'] = 0}

	
    },
}
  
  exports.ox_target:addGlobalVehicle(options)


  RegisterNetEvent("esx_mecanojob:menu-diag")
  AddEventHandler("esx_mecanojob:menu-diag", function(data)
	  local playerPed = PlayerPedId()
	  local vehicle   = data.entity
	  local carModel = GetEntityModel(data.entity)
	  local coords    = GetEntityCoords(playerPed)
	  local text = "* L'individu diagnostique le véhicule *"
  
	  if IsPedSittingInAnyVehicle(playerPed) then
		  lib.notify({
			title = 'Mécano Infos',
			description = 'Ne fais pas sa à l\'intérieur du véhicules',
			position = 'top',
			type = 'error'
		})
		  return
	  end
  
	  if DoesEntityExist(vehicle) then
		  SetVehicleDoorOpen(vehicle, 4, false)
		  IsBusy = true
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
		  Citizen.CreateThread(function()
			  TriggerServerEvent('3dme:shareDisplay', text)
			  Citizen.Wait(15000)
			  local veh_prop = ESX.Game.GetVehicleProperties(vehicle)
			  local etat_moteur = "Inconnu"
			  local engineHealth = tonumber(veh_prop and veh_prop.engineHealth) or 1000
			  if engineHealth >= 950 then
				  etat_moteur = "~g~Bon état~w~\n\nTemps de réparation : 5 min\nTarif : 100$"
			  elseif engineHealth >= 900 then
				  etat_moteur = "~y~Correct~w~\n\nTemps de réparation : 10 min\nTarif : 125$"
			  elseif engineHealth >= 850 then
				  etat_moteur = "~o~Médiocre~w~\n\nTemps de réparation : 30 min\nTarif : 150$"
			  else
				  etat_moteur = "~r~DANGER\n\nTemps de réparation : 60 min\nTarif : 175$"
			  end
			  diag = (veh_prop and veh_prop.plate or GetVehicleNumberPlateText(vehicle) or ""):gsub("%s+", "")
			  ESX.ShowAdvancedNotification('Mécano', "Diagnostique", "Diagnostique du véhicule :\nMoteur : " .. etat_moteur, "CHAR_GANGAPP", 1)
			  ClearPedTasksImmediately(playerPed)
			  SetVehicleDoorShut(vehicle, 4, false)
		  end)
	  else
		  lib.notify({
			title = 'Mécano Infos',
			description = 'Pas de voiture à cotée',
			position = 'top',
			type = 'error'
		})
	  end
  end)

-----Reparation


local options = {
    {
        name = 'exotic_repair',
        event = 'esx_mecanojob:menu-repair',
        icon = 'fa-solid fa-road',
        label = 'Réparer',
		groups= 'exotic',
    },
}
  
  exports.ox_target:addGlobalVehicle(options)

RegisterNetEvent("esx_mecanojob:menu-repair")
AddEventHandler("esx_mecanojob:menu-repair", function(data)
	local playerPed = PlayerPedId()
	local vehicle   = data.entity
	local coords    = GetEntityCoords(playerPed)
	local text = "* L'individu répare le véhicule *"

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(('inside_vehicle'))
		return
	end

	if DoesEntityExist(vehicle) then
		local plate = (GetVehicleNumberPlateText(vehicle) or ""):gsub("%s+", "")
		if diag and plate == diag then
			IsBusy = true
			SetVehicleDoorOpen(vehicle, 4, false)
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			TriggerServerEvent('3dme:shareDisplay', text)
			Citizen.CreateThread(function()
				Citizen.Wait(15000)

				local fuel = GetVehicleFuelLevel(vehicle)
				SetVehicleFixed(vehicle)
				SetVehicleFuelLevel(vehicle, fuel)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, true, true)
				ClearPedTasksImmediately(playerPed)
				SetVehicleDoorShut(vehicle, 4, false)

				lib.notify({
					title = 'Mecano Infos',
					description = 'Véhicule réparé',
					position = 'top',
					type = 'success'
				})
				IsBusy = false
			end)
		else
			lib.notify({
				title = 'Mecano Infos',
				description = 'Vous n\'avez pas fait le diagnostique du véhicule.',
				position = 'top',
				type = 'error'
			})
		end
	else
		lib.notify({
		title = 'Notification title',
		description = 'Pas de voiture a cotée',
		position = 'top',
		type = 'error'
		})
	end
end)



---------------TowTruck Remoquarge


local options = {
    {
        name = 'exotic_tow_on',
        event = 'white:tow',
        icon = 'fa-solid fa-road',
        label = 'Mettre sur le plateau',
		groups= 'exotic',
    },
}
  
  exports.ox_target:addGlobalVehicle(options)

  local options = {
    {
        name = 'exotic_tow_off',
        event = 'white:tow',
        icon = 'fa-solid fa-road',
        label = 'Descendre du plateau',
		groups= 'exotic',
    },
}


local currentlyTowedVehicle = nil

RegisterNetEvent('white:tow')
AddEventHandler('white:tow', function()
	
	local playerped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
			
	if isVehicleTow then
	
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
		
		if currentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerped, true) then
					if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						currentlyTowedVehicle = targetVehicle
						lib.notify({
							title = 'Mécnao Job',
							description = 'Véhicules attacher avec succès',
							position = 'top',
							type = 'success'
						})
					else
						lib.notify({
							title = 'Mécano Job',
							description = 'Es tu attardé? Vous ne pouvez pas remorquer votre propre dépanneuse avec votre propre dépanneuse?',
							position = 'top',
							type = 'error'
						})
					
					end
				end
			else
				lib.notify({
					title = 'Mécano Job',
					description = 'Es tu attardé? Vous ne pouvez pas remorquer votre propre dépanneuse avec votre propre dépanneuse?',
					position = 'top',
					type = 'error'
				})
			end
		else
			AttachEntityToEntity(currentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(currentlyTowedVehicle, true, true)
			currentlyTowedVehicle = nil
			lib.notify({
				title = 'Mécano Job',
				description = 'Le véhicule a été détaché avec succès!',
				position = 'top',
				type = 'success'
			})
		
		end
	end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end






-------------Lave Auto
exports.ox_target:addGlobalVehicle(options)


local options = {
  {
	  name = 'exotic_wash',
	  event = 'LaverVoiture',
	  icon = 'fa-solid fa-eraser fa-beat',--<<font-awesome-icon :icon="['fat', 'car-wash']" />
	  label = 'Laver la voiture',
	  groups= 'exotic',
  },
}

exports.ox_target:addGlobalVehicle(options)

RegisterNetEvent("LaverVoiture")
AddEventHandler("LaverVoiture", function(data)
  local vehicle = data and data.entity
  local playerPed = PlayerPedId()

  if IsPedSittingInAnyVehicle(playerPed) then
    lib.notify({
      title = 'Mécano Job',
      description = 'Sors du véhicule pour le laver.',
      position = 'top',
      type = 'error'
    })
    return
  end

  if not vehicle or not DoesEntityExist(vehicle) then
    lib.notify({
      title = 'Mécano Job',
      description = 'Pas de voiture à côté.',
      position = 'top',
      type = 'error'
    })
    return
  end

  ESX.TriggerServerCallback("esx_ambulancejob:getItemAmount", function(amount)
    if amount and amount >= 1 then
      TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
      Citizen.Wait(10 * 1000)
      ClearPedTasksImmediately(playerPed)
      if DoesEntityExist(vehicle) then
        SetVehicleDirtLevel(vehicle, 0.0)
        WashDecalsFromVehicle(vehicle, 1.0)
      end
      TriggerServerEvent('exotic:removeChiffon')
      lib.notify({
        title = 'Mécano Job',
        description = 'Le véhicule est maintenant propre.',
        position = 'top',
        type = 'success'
      })
    else
      lib.notify({
        title = 'Mécano Job',
        description = 'Tu n\'as pas de chiffon sur toi',
        position = 'top',
        type = 'error'
      })
    end
  end, "chiffon")
end)







------------------Menu Annonce

RegisterNetEvent('Mechanic:ouvert')
AddEventHandler('Mechanic:ouvert', function()
TriggerServerEvent('Mechanic:Ouvert')
end)

RegisterNetEvent('Mechanic:fermer')
AddEventHandler('Mechanic:fermer', function()
TriggerServerEvent('Mechanic:Fermer')
end)

RegisterNetEvent('Mecaperso')
AddEventHandler('Mecaperso', function()
local msg = KeyboardInput("Message", "", 100)
TriggerServerEvent('Mecaperso', msg)
end)

RegisterNetEvent('white:annonce', function(data)
	lib.registerContext({
		id = 'Menu Annonce',
		title = 'Menu Annonce',
		onExit = function()
			print('Hello there')
		end,
		options = {
			{
				title = 'Annonce Ouverture ',
				description = 'Faire l\'annonce d\'ouverture',
				arrow = true,
				event = "Mechanic:ouvert",
			},
			{
				title = 'Annonce Fermeture',
				description = 'Faire l\'annonce de la fermeture',
				arrow = true,
				event = 'Mechanic:fermer',
			},
			{
				title = 'Annonce Perso',
				description = 'Faire l\'annonce Personalisée',
				arrow = true,
				event = 'Mecaperso',
			},
			{
				title = 'Go Back',
				menu = 'mecanof6',
			}
			
		},
	})

	lib.showContext('Menu Annonce')
	
end)


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end



---------------Bossss

CreateThread(function()
	for k, v in pairs(Config.Boss) do
exports.ox_target:addBoxZone({
    coords = vec3(v.coords),
    size = vec3(1, 1, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'box',
			event = "Mecanojob:OpenBossMenu",
            icon = 'fa-solid fa-desktop',
            label = 'BossAction',
        }
    }
})
end
end)



RegisterNetEvent('Mecanojob:OpenBossMenu')
AddEventHandler('Mecanojob:OpenBossMenu',function()
    OpenBossMenu()
end)

function OpenBossMenu()
	TriggerEvent('esx_society:openBossMenu', 'exotic', function(data, menu)
		menu.close()
		end, { wash = false })
end






----------- Vestiaire


CreateThread(function()
	for k, v in pairs(Config.vet) do
	exports.ox_target:addBoxZone({
		coords = vec3(v.coords),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'Vestiaire',
				event = 'white:mechanic',
				icon = 'fa-solid fa-shirt fa-beat',
				label = 'Vestiaire Mécano',
				canInteract = function(entity, distance, coords, name)
					return true
				end
			}
		}
	})
	end
	end)

RegisterNetEvent('white:mechanic', function(data)
	lib.registerContext({
		id = 'Menu Vetements',
		title = 'Menu Vetements',
		onExit = function()
		end,
		options = {
			{
				title = 'Reprendre Votre Tenue civils',
				description = 'Prendre vos propre vetement',
				onSelect = function(args)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
				end,
			},
			{
				title = 'Tenue De servic',
				description = 'Prendre sa tenue de service',
				arrow = true,
				event = 'mechanictenue',
			}
		}
	})

	lib.showContext('Menu Vetements')
	
end)

RegisterNetEvent('mechanictenue')
AddEventHandler('mechanictenue', function()
    local playerPed = PlayerPedId()
    setUniform('mechanic_wear', playerPed)
end)

function setUniform(job, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification(('Pas d\'outfits'))
            end

            if job == 'mechanic_wear' then
                SetPedArmour(playerPed, 100)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification(('Pas d\'outfits'))
            end

            if job == 'mechanic_wear' then
                SetPedArmour(playerPed, 100)
            end
        end
    end)
end




-----Blips

Citizen.CreateThread(function()

    local blipMarker = Config.Blips.MECHANIC
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto Exotic")
    EndTextCommandSetBlipName(blipCoord)


end)





---------------Menu F6



function menuf6mecano()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'exotic' then
        lib.registerContext({
            id = 'mecanof6',
            title = 'Menu Mecano',
            onExit = function()
            end,
            options = {
				{
                    title = 'Recrutement',
					icon = 'fa fa-fire',
                    description = 'Menu Recrutement',
                    event = 'white:gestion'
                },
                {
                    title = 'Annonce',
					icon = 'fa fa-fire',
                    description = 'Menu Annonce',
                    event = 'white:annonce'
                },
				{
                    title = 'Mission Pnj',
					icon = 'fa fa-fire',
                    description = 'Mission Pnj',
                    event = 'mech:flatbedveh'
                },
				{
					title = 'Facture',
					icon = 'fa fa-fire',
					description = 'Ouvrire le Menu Facture',
					event = 'Ven_mechanic:sendbill'
				},
				{
					title = 'Custom véhicule',
					icon = 'fa-solid fa-screwdriver-wrench',
					description = 'Ouvrir le menu status',
					onSelect = function()
						TriggerEvent('advanced_vehicles:showStatusUI')
					end
				},
            }
        })
    lib.showContext('mecanof6')
	end
end


-- Facture
RegisterNetEvent('Ven_mechanic:sendbill')
AddEventHandler('Ven_mechanic:sendbill', function()
      local input = lib.inputDialog('FACTURE MECANO', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_exotic', 'Facture Mecano', amount)
			end
		end
    end
end)


RegisterCommand("mecano", function()
    local user = PlayerPedId()	
	menuf6mecano()
end)

RegisterKeyMapping("mecano", "Open your car menu", "keyboard", "F6")

-----fourriere

local options = {
    {
        name = 'exotic_impound',
        event = 'fourriere',
        icon = 'fa-solid fa-road',
        label = 'Mettre en fourrière',
		groups= {['exotic'] = 0}

	
    },
}
  
  exports.ox_target:addGlobalVehicle(options)

  RegisterNetEvent("fourriere")
  AddEventHandler("fourriere", function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			lib.notify({
				title = 'Mécano Infos',
				description = 'la voiture a été mis en fourrière',
				position = 'top',
				type = 'success'
			})
			ESX.Game.DeleteVehicle(vehicle)
		   
		else
			lib.notify({
				title = 'Mécano Infos',
				description = 'Mais toi place conducteur, ou sortez de la voiture',
				position = 'top',
				type = 'error'
			})
		end
	else
		local vehicle = ESX.Game.GetVehicleInDirection()

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
			Citizen.Wait(5000)
			ClearPedTasks(playerPed)
			lib.notify({
				title = 'Mécano Infos',
				description = 'la voiture a été mis en fourrière',
				position = 'top',
				type = 'success'
			})
			ESX.Game.DeleteVehicle(vehicle)

		else
			lib.notify({
				title = 'Mécano Infos',
				description = 'Aucune voitures autour',
				position = 'top',
				type = 'error'
			})
		end
	end
end)


local options = {
    {
        name = 'exotic_flatbed',
        event = 'mech:flatbedveh',
        icon = 'fa-solid fa-road',
        label = 'Flatbed',
		groups= {['exotic'] = 0}

	
    },
}
  
  exports.ox_target:addGlobalVehicle(options)

RegisterNetEvent('mech:flatbedveh')
AddEventHandler('mech:flatbedveh', function()
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, true)

		local towmodel = GetHashKey("flatbed")
		local isVehicleTow = IsVehicleModel(vehicle, towmodel)

		if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()

		if CurrentlyTowedVehicle == nil then
			  if targetVehicle ~= 0 then
				  if not IsPedInAnyVehicle(playerPed, true) then
					  if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						CurrentlyTowedVehicle = targetVehicle
						lib.notify({
							title = 'Mécano Infos',
							description = 'Véhicule à été attaché avec succès',
							position = 'top',
							type = 'success'
						})
					else
						ESX.ShowNotification(('cant_attach_own_tt'))
						lib.notify({
							title = 'Mécano Infos',
							description = 'Vous ne pouvez  atteler sa propre dépanneuse',
							position = 'top',
							type = 'error'
						})
					end
				end
			else
				lib.notify({
					title = 'Mécano Infos',
					description = 'Voiture non attacher',
					position = 'top',
					type = 'error'
				})
			end
		else
			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(CurrentlyTowedVehicle, true, true)

			CurrentlyTowedVehicle = nil
			lib.notify({
				title = 'Mécano Infos',
				description = 'Véhicle Attacher sur le flatbed',
				position = 'top',
				type = 'success'
			})
			lib.notify({
				title = 'Mécano Infos',
				description = 'Véhicules Détacher du flatbed',
				position = 'top',
				type = 'error'
			})
		end
	else
		ESX.ShowNotification(('imp_flatbed'))-- '~r~Action impossible!~s~ Vous avez besoin d\'un ~b~Flatbed~s~ pour charger un véhicule',
		lib.notify({
			title = 'Mécano Infos',
			description = 'Action impossible! Vous avez besoin d\'un Flatbed pour charger un véhicule',
			position = 'top',
			type = 'error'
		})
	end
end)



exports.ox_target:addBoxZone({
    coords = vec3(558.87805175781, -171.54510498047, 54.20853729248),  
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'boss',
            icon = 'fa-solid fa-cube',
            label = 'Magasin exotic',
            onSelect = function()
                exports.ox_inventory:openInventory('shop', { type = 'TestShop', id = 1 })
            end
        }
    }
})


