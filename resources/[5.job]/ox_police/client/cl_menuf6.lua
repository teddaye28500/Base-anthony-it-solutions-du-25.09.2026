--####################################
--###### CODE AVEC RECRUTEMENT #######
--####################################

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

local  dragStatus = {}, {}, {}, {}
dragStatus.isDragged = false

--######################################################################################################################################
--################################################################## MENU ##############################################################
--######################################################################################################################################

function menupoliceduty()
	if  ESX.PlayerData.job and ESX.PlayerData.job.name == 'offpolice' then
        lib.registerContext({
            id = 'menupoliceduty',
            title = 'Menu Police',
            onExit = function()
            end,
            options = {
                {
					title = 'Prendre sont Service',
					icon = 'fa fa-fire',
					description = 'Prendre sont service',
					event = 'police2'
				},
            }
        })
    lib.showContext('menupoliceduty')
	end
end

function menupolice()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
	lib.registerContext({
		id = 'menupolice',
		title = 'Menu Police',
		onExit = function()
			print('Hello there')
		end,
		options = {
            {
                title = 'Fin de Service',
                icon = 'fa fa-fire',
                description = 'Mettre fin a sont service',
                event = 'police2'
            },
            {
                title = 'Renfort',
                icon = 'fa fa-fire',
                description = 'Appeler des renforts',
                event = 'police:renfort'
            },
            {
                title = 'Annonce',
                icon = 'fa fa-fire',
                description = 'Ouvrire le Menu Annonce',
                event = 'police:annonce'
            },
            {
                title = 'Recrutement',
                icon = 'fa fa-fire',
                description = 'Ouvrire le Menu Recrutement',
                event = 'police:gestion'
            },
            {
                title = 'Actions Citoyens',
                icon = 'fa fa-fire',
                description = 'Intéraction Citoyens',
                event = 'police:Citoyens'
            },
            {
                title = 'Actions Vehicules',
                icon = 'fa fa-fire',
                description = 'Intéraction Vehicules',
                event = 'police:vehicules'
            },
            {
                title = 'Actions Objects',
                icon = 'fa fa-fire',
                description = 'Intéraction Objets',
                event = 'police:objects'
            },
            {
                title = 'Facture',
                icon = 'fa fa-fire',
                description = 'Ouvrire le Menu Facture',
                event = 'oxy_police:sendbill'
            }
			
		},
	})

	lib.showContext('menupolice')
      end
end



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

RegisterCommand("offpolice", function()
	local user = PlayerPedId()	
	menupoliceduty()
  end)
  
  RegisterKeyMapping("offpolice", "Menu F6 offPolice", "keyboard", "F6")
  

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

  RegisterCommand("police", function()
	local user = PlayerPedId()	
	menupolice()
  end)
  
  RegisterKeyMapping("police", "Menu F6 Police", "keyboard", "F6")


--######################################################################################################################################
--################################################################## DUTY ##############################################################
--######################################################################################################################################

local PlayerData              = {}

Citizen.CreateThread(function()
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

RegisterNetEvent('police2')
AddEventHandler('police2', function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
    FreezeEntityPosition(cache.ped, true)
	ProgressBar(Config.LoadProgress.Duty.Duration, Config.LoadProgress.Duty.Label)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasksImmediately(PlayerPedId())
    TriggerServerEvent('oxy:policeduty')
end)

--######################################################################################################################################
--############################################################## ANNONCES ##############################################################
--######################################################################################################################################

RegisterNetEvent('police:ouvert')
AddEventHandler('police:ouvert', function()
TriggerServerEvent('Police:Ouvert')
end)

RegisterNetEvent('police:fermer')
AddEventHandler('police:fermer', function()
TriggerServerEvent('Police:Fermer')
end)

RegisterNetEvent('policeperso')
AddEventHandler('policeperso', function()
local msg = KeyboardInput("Message", "", 100)
TriggerServerEvent('Policeperso', msg)
end)



RegisterNetEvent('police:annonce', function(data)
	lib.registerContext({
		id = 'menuannonce',
		title = 'Menu Annonce',
		onExit = function()
			print('Hello there')
		end,
		options = {
			{
				title = 'Annonce Ouverture ',
				description = 'Faire l\'annonce d\'ouverture',
				arrow = true,
				event = "police:ouvert",
			},
			{
				title = 'Annonce Fermeture',
				description = 'Faire l\'annonce de la fermeture',
				arrow = true,
				event = 'police:fermer',
			},
			{
				title = 'Annonce Perso',
				description = 'Faire l\'annonce Personalisée',
				arrow = true,
				event = 'policeperso',
			},
            {
                title = 'Retourner',
                menu = 'menupolice',
              }
			
		},
	})

	lib.showContext('menuannonce')
	
end)

--######################################################################################################################################
--########################################################## RECRUTEMENTS ##############################################################
--######################################################################################################################################

--########################################################
--###### DEFINIR LA FONCTION ShowAboveRadarMessage #######
--########################################################

local ShowAboveRadarMessage = function(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end

--############################
--###### RESTE DU CODE #######
--############################

local Recruit = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
            ShowAboveRadarMessage('Aucun joueur à proximité')
        else
            TriggerServerEvent('police:Recruit', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 0)
        end
    end
end


local Promote = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
            ShowAboveRadarMessage('Aucun joueur à proximité')
        else
            TriggerServerEvent('police:Promote', GetPlayerServerId(closestPlayer))
        end
    end
end


local Exclude = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
            ShowAboveRadarMessage('Aucun joueur à proximité')
        else
            TriggerServerEvent('police:Exclude', GetPlayerServerId(closestPlayer))
        end
    end
end

RegisterNetEvent('police:gestion', function(data)
    lib.registerContext({
        id = 'policerecrutement',
        title = 'Menu Recrutement',
        options = {
            {
                title = 'Votre Job: '..ESX.PlayerData.job.label, 
    
              },
          {
            title = 'Recruter', 
            icon = "user-plus",
            iconColor = "green",
            description = 'Recruter un membre',
            onSelect = function()
                Recruit()
            end
          },
          {
            title = 'Promouvoir',
            icon = "user-pen",
            iconColor = "blue",
            description = 'Promouvoir un membre',
            onSelect = function()
                Promote()
            end
          },
          {
            title = 'Virer',
            icon = "user-minus",
            iconColor = "red",
            description = 'Virer un membre',
            onSelect = function()
                Exclude()
            end
          },
          {
            title = 'Retourner',
            menu = 'menupolice',
          }
        },
    })
    lib.showContext('policerecrutement')
    
    end)

--######################################################################################################################################
--########################################################### INTERACTIONS CITOYENS ####################################################
--######################################################################################################################################

RegisterNetEvent('police:Citoyens', function(data)
    lib.registerContext({
        id = 'policecitoyensactions',
        title = 'Menu Citoyens',
        options = {
            {
                title = 'PPA',
                icon = 'fa fa-fire',
                description = 'Donner le ppa',
                event = 'cartearmepolice'
            },
            {
                title = "Menotter",
                icon = 'fa fa-fire',
                description = "Menotter la personne proche",
                event = 'police:handcuff'
            },
            {
                title = "DéMenotter",
                icon = 'fa fa-fire',
                description = "DéMenotter la personne proche",
                event = 'police:uncuff',
            },
            {
                title = "Escorter",
                icon = 'fa fa-fire',
                description = "Escorter la personne proche",
                event = 'menu:DRAG'
            },
            {
                title = "Fouiller",
                icon = 'fa fa-fire',
                description = "Fouiller la personne proche",
                event = 'menu:searchpol'
            },
            {
                title = 'Retourner',
                menu = 'menupolice',
            }
        },
    })
    lib.showContext('policecitoyensactions')
    
    end)


--#######################
--###### CODE PPA #######
--#######################

RegisterNetEvent('cartearmepolice')
AddEventHandler('cartearmepolice', function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
    FreezeEntityPosition(cache.ped, true)
    ProgressBar(Config.LoadProgress.Cartepermisarmepolice.Duration, Config.LoadProgress.Cartepermisarmepolice.Label)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasks(cache.ped)
    lib.notify("success", "", locale("successcarte"))
    TriggerServerEvent('oxypolice:add', 'item', 1, Config.PoliceCartePermisArme)
end)

--############################
--###### CODE MENOTTER #######
--############################
local handcuffTimer= {}, {}, {}, {}
local isHandcuffed, hasAlreadyJoined, playerInService = false, false, false

function IsInPolCuffs()
    return IsHandcuffedControl
  end

  
  RegisterNetEvent('police:handcuff')
  AddEventHandler('police:handcuff', function()
      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
      if closestPlayer ~= -1 and closestDistance <= 3.0 then
          local target, distance = ESX.Game.GetClosestPlayer()
          playerheading = GetEntityHeading(GetPlayerPed(-1))
          playerlocation = GetEntityForwardVector(PlayerPedId())
          playerCoords = GetEntityCoords(GetPlayerPed(-1))
          local target_id = GetPlayerServerId(target)
          if distance <= 2.0 then
              TriggerServerEvent('esx_policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
          else
              lib.notify("error", "", locale("notcloser"))
          end			
      else 
          lib.notify("error", "", locale("nobody"))
      end
  end)

  RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isHandcuffed then


			if Config.EnableHandcuffTimer then
				if handcuffTimer.active then
					ESX.ClearTimeout(handcuffTimer.task)
				end

				StartHandcuffTimer()
			end
		else
			if Config.EnableHandcuffTimer and handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end


		end
	end)
end)

RegisterNetEvent('esx_policejob:getarrested')
AddEventHandler('esx_policejob:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	isHandcuffed = true
	TriggerEvent('esx_policejob:handcuff')
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)
RegisterNetEvent('esx_policejob:doarrested')
AddEventHandler('esx_policejob:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

CreateThread(function()
	local wasDragged

	while true do
		Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Wait(500)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local vehicle, distance = ESX.Game.GetClosestVehicle()

		if vehicle and distance < 5 then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

-- Handcuff
RegisterNetEvent('esx_policejob:douncuffing')
AddEventHandler('esx_policejob:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_policejob:getuncuffed')
AddEventHandler('esx_policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	isHandcuffed = false
	TriggerEvent('esx_policejob:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			--DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			-- DisableControlAction(0, 32, true) -- W
			-- DisableControlAction(0, 34, true) -- A
			-- DisableControlAction(0, 31, true) -- S
			-- DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 21, true) -- LSHFT

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			-- DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'police')
		end

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		lib.notify("info", "", locale("handcufftimer"))
		TriggerEvent('esx_policejob:unrestrain')
		handcuffTimer.active = false
	end)
end

--##############################
--###### CODE DEMENOTTER #######
--##############################

RegisterNetEvent('police:uncuff')
AddEventHandler('police:uncuff', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		if distance <= 2.0 then
			TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
		else
			lib.notify("error", "", locale("notcloser"))
		end			
	else 
		lib.notify("error", "", locale("nobody"))
	end
end)

--###########################
--###### CODE ESCORTE #######
--###########################

local enModeEscorte = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 38) then
            if enModeEscorte then
                TriggerEvent('menu:DRAG')
                lib.notify("success", "", locale("stop_dragging2"))
				lib.hideTextUI()
                enModeEscorte = false
            end
        end
    end
end)

RegisterNetEvent('menu:DRAG')
AddEventHandler('menu:DRAG', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
		enModeEscorte = true
		if Config.Text == "esx" then
			lib.notify("info", "",locale('stop_dragging'))
		elseif Config.Text == "oxlib" then
			lib.showTextUI(locale('stop_dragging'), {
				position = 'top-center',
				icon = 'hand',
				style = {
					borderRadius = 5,
					backgroundColor = '#212529',
					color = '#F8F9FA',
				},
			})
		else
            lib.notify("error", "", locale("nobody"))
        end
    end
end)

--############################
--###### CODE FOUILLER #######
--############################

RegisterNetEvent('menu:searchpol')
AddEventHandler('menu:searchpol', function()
	OpenBodySearchMenu()
end)

function OpenBodySearchMenu(player)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer then
        if closestPlayer ~= -1 and closestDistance <= 1.0 then
            local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'

            exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer))
        else
            lib.notify("error", "", locale("nobody"))
        end
    end
end


--######################################################################################################################################
--########################################################## RENFORT ###################################################################
--######################################################################################################################################

RegisterNetEvent('police:renfort')
AddEventHandler('police:renfort', function(coords)
	TriggerServerEvent('police:renfortDemande')
end)

RegisterNetEvent('police:setBlip')
AddEventHandler('police:setBlip', function(coords)
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
    ESX.ShowAdvancedNotification('Police demande de renfort', 'Un Agent du police demande une assistance supplémentaire [Voir GPS]', 1)
    Wait(1000)
    PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    local blipId = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('[Police] Demande Assistance')
    EndTextCommandSetBlipName(blipId)
    Wait(20 * 1000)
    RemoveBlip(blipId)
end)

RegisterNetEvent('oxy:renfortpolicetest')
AddEventHandler('oxy:renfortpolicetest', function(coords)
	TriggerServerEvent('oxy:renfortDemande')
end)

--######################################################################################################################################
--########################################################## MENU VEHICULES ############################################################
--######################################################################################################################################

RegisterNetEvent('police:vehicules', function(data)
    lib.registerContext({
        id = 'policevehiculesactions',
        title = 'Menu Vehicules',
        options = {
            {
                title = "Mettre dans le véhicule",
                icon = "fa-solid fa-fire",
                event = 'menu:PUTVEH',
                job = 'police'
            },
            {
                title = "Sortir du véhicule",
                icon = "fa-solid fa-fire",
                event = 'menu:OUTVEH',
                job = 'police'
            },
            {
                title = "Lockpick le véhicule",
                icon = "fa-solid fa-fire",
                event = 'menu:LOCKPICK',
                job = 'police'
            },
            {
                title = "Mettre le véhicule a la fourriere",
                icon = "fa-solid fa-fire",
                event = 'menupolice:IMPOUND',
                job = 'police'
            },
            {
                title = 'Retourner',
                menu = 'menupolice',
            }
        },
    })
    lib.showContext('policevehiculesactions')
    
    end)


    RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local vehicle, distance = ESX.Game.GetClosestVehicle()

		if vehicle and distance < 5 then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

RegisterNetEvent('menu:PUTVEH')
AddEventHandler('menu:PUTVEH', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
	else
		lib.notify("error", "", locale("nobody"))
	end
end)

RegisterNetEvent('menu:OUTVEH')
AddEventHandler('menu:OUTVEH', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
	else
		lib.notify("error", "", locale("nobody"))
	end
end)

RegisterNetEvent('menu:LOCKPICK')
AddEventHandler('menu:LOCKPICK', function()
	local playerPed = PlayerPedId()
	local coords  = GetEntityCoords(playerPed)
	vehicle = ESX.Game.GetVehicleInDirection()
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
		Citizen.Wait(20000)
		ClearPedTasksImmediately(playerPed)

		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForAllPlayers(vehicle, false)
		lib.notify("success", "", locale("vehunlocked"))
	else
		lib.notify("error", "", locale("novehcloser"))
	end
end)

--######################
--###### IMPOUND #######
--######################

local currentTask = {}, {}, {}, {}
Citizen.CreateThread(function()
    while currentTask.busy do
        Citizen.Wait(1000)

        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
        if not DoesEntityExist(vehicle) and currentTask.busy then
            lib.notify("info", "", locale("vehcancel"))
            ESX.ClearTimeout(currentTask.task)
            ClearPedTasks(playerPed)
            currentTask.busy = false
            break
        end
    end
end)

RegisterNetEvent('menupolice:cancelimp')
AddEventHandler('menupolice:cancelimp', function()
	ESX.ClearTimeout(currentTask.task)
	ClearPedTasks(PlayerPedId())

	currentTask.busy = false
end)


function ImpoundVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	lib.notify("success", "", locale("havebeenimpounded"))
	currentTask.busy = false
end

RegisterNetEvent('menupolice:IMPOUND')
AddEventHandler('menupolice:IMPOUND', function()
    local playerPed   = PlayerPedId()
    local coords      = GetEntityCoords(playerPed)
    vehicle           = ESX.Game.GetVehicleInDirection()
    local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
    if currentTask.busy then
        return
    end

    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    ProgressBar(Config.LoadProgress.Impound.Duration, Config.LoadProgress.Impound.Label)
    ClearPedTasks(playerPed)
    ImpoundVehicle(vehicle)
    Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
end)

--######################################################################################################################################
--########################################################## MENU OBJECTS ##############################################################
--######################################################################################################################################

RegisterNetEvent('police:objects', function(data)
    lib.registerContext({
        id = 'policeobjectactions',
        title = 'Menu Objects',
        options = {
            {
                title = "Herse",
                icon = "fa-solid fa-fire",
                event = 'menupolice:spikes'
            },
            {
                title = "Cone",
                icon = "fa-solid fa-fire",
                event = 'menupolice:roadcone'
            },
            {
                title = "Barriere",
                icon = "fa-solid fa-fire",
                event = 'menupolice:barrier'
            },
            {
                title = "Box Cash",
                icon = "fa-solid fa-fire",
                event = 'menupolice:boxpile'
            },
            {
                title ="Box",
                icon = "fa-solid fa-fire",
                event = 'menupolice:cash'
            },
            {
                title = "Remove Object",
                icon = "fa-solid fa-fire",
                event = 'menupolice:removeprops'
            },
            {
                title = 'Retourner',
                menu = 'menupolice',
            }
        },
    })
    lib.showContext('policeobjectactions')
    
    end)

--######################
--#### CODE OBJECTS ####
--######################

    local CurrentActionData = {}, {}, {}, {}

    RegisterNetEvent('menupolice:roadcone')
AddEventHandler('menupolice:roadcone', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local propname = 'prop_roadcone02a'

    obj = CreateObject(propname, objectCoords, true, false, true)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
end)

RegisterNetEvent('menupolice:barrier')
AddEventHandler('menupolice:barrier', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local propname = 'prop_barrier_work05'

    obj = CreateObject(propname, objectCoords, true, false, true)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
end)

RegisterNetEvent('menupolice:boxpile')
AddEventHandler('menupolice:boxpile', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local propname = 'prop_boxpile_07d'

    obj = CreateObject(propname, objectCoords, true, false, true)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
end)

RegisterNetEvent('menupolice:cash')
AddEventHandler('menupolice:cash', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local propname = 'hei_prop_cash_crate_half_full'

    obj = CreateObject(propname, objectCoords, true, false, true)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
end)

RegisterNetEvent('menupolice:spikes')
AddEventHandler('menupolice:spikes', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local propname = 'p_ld_stinger_s'

    obj = CreateObject(propname, objectCoords, true, false, true)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
end)

--######################
--### REMOVE OBJECTS ###
--######################

CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Wait(1500)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance = #(playerCoords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey("p_ld_stinger_s") then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

RegisterNetEvent('menupolice:removeprops')
AddEventHandler('menupolice:removeprops', function()
	DeleteEntity(CurrentActionData.entity)
end)

--######################################################################################################################################
--########################################################## FACTURE ###################################################################
--######################################################################################################################################

RegisterNetEvent('oxy_police:sendbill')
AddEventHandler('oxy_police:sendbill', function()
      local input = lib.inputDialog('FACTURE POLICE', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Facture Police', amount)
			end
		end
    end
end)
