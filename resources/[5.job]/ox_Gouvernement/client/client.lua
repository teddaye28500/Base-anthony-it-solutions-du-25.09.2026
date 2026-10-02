ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'gouv', 'gouvernement', 'society_gouv', 'society_gouv', 'society_gouv', {type = 'public'})

-- 📌 Création du blip gouvernement
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local blip = AddBlipForCoord(Config.blipsgouv.x, Config.blipsgouv.y, Config.blipsgouv.z)
    SetBlipSprite(blip, Config.style.Gouv)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, Config.color.Gouv)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.nameblips.Gouv)
    EndTextCommandSetBlipName(blip)
    SetBlipPriority(blip, 5)
end)

lib.registerContext({
    id = 'menu_gouv',
    title = '🧑‍🎓 Menu Gouvernement',
    options = {
        { title = '📢 Annonces', icon = 'wifi', menu = 'annonce_menugouv' },
        { title = '👨‍✈️ Interaction Citoyen', icon = 'user', menu = 'interaction_citoyen' },
        { title = '💸 Facture', icon = 'file-invoice-dollar', event = 'gouv:sendbill' },
        { title = '🚨 Demande de Renfort', icon = 'shield-alt', menu = 'demande_renfort' } -- Ajout de l'option
    }
})

lib.registerContext({
    id = 'demande_renfort',
    title = '🚨 Demande de Renfort',
    menu = 'menu_gouv',
    options = {
        { title = '🔵 Petit Renfort', icon = 'user', event = 'renfort_request', args = 'petit' },
        { title = '🟠 Renfort Moyen', icon = 'users', event = 'renfort_request', args = 'importante' },
        { title = '🔴 Gros Renfort', icon = 'exclamation-triangle', event = 'renfort_request', args = 'omgad' }
    }
})

lib.registerContext({
    id = 'interaction_citoyen',
    title = '👮 Interaction Citoyen',
    menu = 'menu_gouv',
    options = {
        { title = '🔒 Menotter/Démenotter', icon = 'user-lock', event = 'gouv:toggleCuff' },
        { title = '🦺 Escorter', icon = 'walking', event = 'gouv:escort' },
        { title = '🚗 Mettre dans un véhicule', icon = 'car', event = 'gouv:putInVehicle' },
        { title = '🚪 Sortir du véhicule', icon = 'door-open', event = 'gouv:outVehicle' },
        { title = '🔍 Fouiller', icon = 'user-secret', event = 'gouv:search' },
        { title = '🆔 Vérifier Identité', icon = 'id-card', event = 'gouv:checkID' }
    }
})


-- Vérifier le job et afficher le menu
RegisterCommand("interaction_citoyen", function()
    local PlayerData = ESX.GetPlayerData() -- Si tu es sur QB-Core, adapte avec QBCore.Functions.GetPlayerData()
    if PlayerData.job and PlayerData.job.name == 'government' then
        lib.showContext("interaction_citoyen")
    else
        lib.notify({ type = 'error', description = 'Vous n\'avez pas accès à cette action.' })
    end
end, false)


-- Vérifier si le joueur est bien dans le gouvernement avant d'afficher le menu
RegisterCommand("interaction_citoyen", function()
    local PlayerData = ESX.GetPlayerData() -- Si tu es sur QB-Core, remplace par QBCore.Functions.GetPlayerData()
    if PlayerData.job and PlayerData.job.name == jobGouv then
        lib.showContext("interaction_citoyen")
    else
        lib.notify({ type = 'error', description = 'Vous n\'avez pas accès à cette action.' })
    end
end, false)

RegisterNetEvent('renfort_request')
AddEventHandler('renfort_request', function(raison)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    TriggerServerEvent('renfort', coords, raison)
end)


-- 📌 Menu des annonces
lib.registerContext({
    id = 'annonce_menugouv',
    title = '📢 Annonces Gouvernement',
    menu = 'menu_gouv',
    options = {
        { title = '✅ Ouvert', icon = 'check-circle', event = 'gouv:annonce', args = 'ouvert' },
        { title = '❌ Fermé', icon = 'times-circle', event = 'gouv:annonce', args = 'fermer' },
        { title = '👥 Recrutement', icon = 'user-plus', event = 'gouv:annonce', args = 'recruter' },
        { title = '🚨 Personnalisé', icon = 'fa-comment', event = 'gouv:annoncePerso' }
    }
})

-- 📌 Ouvrir le menu avec la touche F6
RegisterKeyMapping('gouvmenu', 'Menu Gouv News', 'keyboard', 'F6')
RegisterCommand('gouvmenu', function()
    local xPlayer = ESX.GetPlayerData()
    if xPlayer.job.name == 'gouv' then
        lib.showContext('menu_gouv')
    end
end, false)

-- 📢 Gestion des annonces
RegisterNetEvent('gouv:annonce')
AddEventHandler('gouv:annonce', function(type)
    local events = {
        ouvert = 'annonceOgouvserveur',
        fermer = 'annonceFgouvserveur',
        recruter = 'annonceRgouvserveur'
    }
    if events[type] then
        TriggerServerEvent(events[type])
    end
end)

RegisterNetEvent('gouv:annoncePerso')
AddEventHandler('gouv:annoncePerso', function()
    local input = lib.inputDialog('Annonce Gouvernement', {'Message'})
    if input and input[1] ~= "" then
        TriggerServerEvent('gouv:SendAnnonce', input[1])
    else
        lib.notify({ title = 'Erreur', description = 'Vous devez entrer un message !', type = 'error' })
    end
end)

-- 📌 Facture
RegisterNetEvent('gouv:sendbill')
AddEventHandler('gouv:sendbill', function()
    local input = lib.inputDialog('Facture Gouvernement', {'Montant'})
    local amount = tonumber(input[1])
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if amount and amount > 0 and closestPlayer ~= -1 and closestDistance <= 4.0 then
        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_gouv', 'Facture Gouvernement', amount)
        lib.notify({ title = 'Succès', description = 'Facture envoyée', type = 'success' })
    else
        lib.notify({ title = 'Erreur', description = 'Aucun joueur proche ou montant invalide', type = 'error' })
    end
end)

local props = {} -- Stocker les objets attachés

-- 📌 Charger une animation
local function LoadAnimation(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(100) end
end

-- 📌 Attacher un objet à la main (Gestion ON/OFF)
local function ToggleProp(playerPed, model, animDict, animName, bone, x, y, z, xR, yR, zR)
    -- Vérifier si un objet est déjà attaché
    if props[playerPed] then
        DeleteEntity(props[playerPed])
        props[playerPed] = nil
        ClearPedTasks(playerPed) -- Arrêter l'animation
        return
    end

    -- Charger l'animation
    LoadAnimation(animDict)
    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

    -- Charger l'objet
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(100) end

    local prop = CreateObject(model, GetEntityCoords(playerPed), true, true, false)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, bone), x, y, z, xR, yR, zR, true, true, false, true, 1, true)

    props[playerPed] = prop
end

-- 📷 Caméra (Activation/Désactivation)
RegisterNetEvent('gouv:useCamera')
AddEventHandler('gouv:useCamera', function()
    ToggleProp(PlayerPedId(), `prop_v_cam_01`, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 57005, 0.0, 0.0, 0.0, 0.0, 0.0, 290.0)
end)

-- 🎙️ Micro à perche (Activation/Désactivation)
RegisterNetEvent('gouv:useBoomMic')
AddEventHandler('gouv:useBoomMic', function()
    ToggleProp(PlayerPedId(), `prop_v_bmike_01`, "missfra1", "mcs2_crew_idle_m_boom", 57005, 0.0, 0.0, 0.0, 0.0, 0.0, 90.0)
end)


-- 📌 Comptoir (ox_target)
exports.ox_target:addBoxZone({
    name = "Gouv_Comptoir",
    coords = vector3(Config.comptoir.x, Config.comptoir.y, Config.comptoir.z),
    size = vec3(1.0, 1.0, 1.0),
    rotation = 0.0,
    debug = false,
    options = {
        {
            name = "appel_gouv",
            event = "gouv:clientCall",
            icon = "fas fa-bell",
            label = "Appeler un employé",
            distance = 2.5
        }
    }
})

RegisterNetEvent("gouv:clientCall")
AddEventHandler("gouv:clientCall", function()
    -- Envoie de l'événement serveur
    TriggerServerEvent("gouv:alertEmployees")
    lib.notify({ title = "Gouv", description = "Un employé a été appelé au comptoir.", type = "inform" })
end)

RegisterNetEvent("gouv:notifyEmployee")
AddEventHandler("gouv:notifyEmployee", function()
    -- Notification pour l'employé
    lib.notify({ title = "Gouv", description = "Vous avez été appelé au comptoir.", type = "success" })
end)


exports.qtarget:AddBoxZone("GouvCoffre", vector3(Config.coffregouv.x, Config.coffregouv.y, Config.coffregouv.z + 1), 1.0 , 1.5, {
	name="GouvCoffre",
	heading=35,
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:coffregouv",
				icon = "fas fa-university",
				label = "Coffre Gouvernement",
				job = "gouv",
			},
		},
	distance = 2.5
})


RegisterNetEvent('nsx:coffregouv')
AddEventHandler('nsx:coffregouv', function()
	OpenGouvCoffre()
end)

function OpenGouvCoffre()
	exports.ox_inventory:openInventory('stash', {id='Gouv Coffre', owner= false, job = 'gouv' })
end

-- PATRON 

exports.qtarget:AddBoxZone("GouvBoss", vector3(Config.bossgouv.x, Config.bossgouv.y, Config.bossgouv.z), 1.0 , 1.5, {
	name="GouvBoss",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:bossgouv",
				icon = "fas fa-user",
				label = "Boss Gouvernement",
				job = "gouv",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:bossgouv')
AddEventHandler('nsx:bossgouv', function()
	OpenGouvBoss()
end)

function OpenGouvBoss()
	TriggerEvent('esx_society:openBossMenu', 'gouv', function(data, menu)

	end, { wash = false })
end

-- VESTIAIRE

Citizen.CreateThread(function()
	exports['qtarget']:AddBoxZone("VestiaireGouv", vector3(Config.vestiairegouv.x, Config.vestiairegouv.y, Config.vestiairegouv.z), 1, 1, {
		name="Vestiaire Gouv",
		--debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
	  {
		  event = "nsx:vestiairegouv", 
		  icon = "fas fa-shirt",
		  label = "Vestiaire Gouvernement",
          job = "gouv",
	  },
    },
  distance = 2.5
})

end)

RegisterNetEvent('nsx:vestiairegouv')
AddEventHandler('nsx:vestiairegouv', function()
  lib.showContext ('VestiaireGouv')
end)
	lib.registerContext({
		id = 'VestiaireGouv',
		title = 'Vestiaire Gouv',
		onExit = function()
		end,
		options = {
			{
				title = 'Vos Vetement',
				icon = "fas fa-tshirt",
				description = 'Prendre vos propre vetement',
				onSelect = function(args)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
					end)
				end,
			},
			{
				title = 'Vetements Gouv',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('gouv_wear', playerPed)
					lib.notify({
            title = 'Notification',
            description = 'Pret a travailler',
            type = 'inform' -- Types possibles : success, error, inform, warning
        })
				end,
			},
		},
	})


RegisterNetEvent('nsx:vetement')
AddEventHandler('nsx:vetement', function()
	local playerPed = PlayerPedId()
	setUniform('gouv_wear', playerPed)
end)

function setUniform(job)
  TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
          if Config.Uniformsgouv[job].male ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsgouv[job].male)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'gouv_wear' then
      SetPedArmour(playerPed, 0)
          end
      else
          if Config.Uniformsgouv[job].female ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsgouv[job].female)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'gouv_wear' then
              SetPedArmour(playerPed, 0)
          end
      end
  end)
end

-- Garage 
local Options = {}


Citizen.CreateThread(function()
  exports['qtarget']:AddBoxZone("GouvVehicule", vector3(Config.garagegouv.x,Config.garagegouv.y,Config.garagegouv.z), 1, 1, {
    name="GouvVehicule",
    heading=30,
    --debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
    {
      event = "gouv:vehicule", 
      icon = "fa fa-car",
      label = "Vehicule Gouv",
          job = "gouv",
    },
    },
  distance = 2.5
})
end)

RegisterNetEvent('gouv:vehicule')
AddEventHandler('gouv:vehicule', function()
  lib.showContext('gouvvehicule')
end)

for i = 1, #Config.cars.Gouv do
if i == 1 then
    Options[i] = { title = Config.cars.Gouv[i].nom, args = Config.cars.Gouv[i].modele, icon = "fa fa-car", event = 'nsx:gouvdelCars'}
else
    Options[i] = { title = Config.cars.Gouv[i].nom, args = Config.cars.Gouv[i].modele, icon = "fa fa-car", event = 'nsx:gouvspawnCars'}
end
end
lib.registerContext({
    id = 'gouvvehicule',
    title = 'Véhicules Gouv',
    options = Options,
})

function createCarGouv(car)
  local car = GetHashKey(car)

  RequestModel(car)
  while not HasModelLoaded(car) do
      RequestModel(car)
      Wait(0)
  end

  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
  local vehicle = CreateVehicle(car, Config.SpawnVeh.Gouv, true, false)
  SetEntityAsMissionEntity(vehicle, true, true)
  local plaque = Config.Plate.Gouv..math.random(1,9)
  SetVehicleNumberPlateText(vehicle, plaque) 
  SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('nsx:gouvspawnCars', function(data)
createCarGouv(data)
end)

RegisterNetEvent('nsx:gouvdelCars')
AddEventHandler('nsx:gouvdelCars',function()
  local veh = ESX.Game.GetClosestVehicle()
  DeleteEntity(veh)
end)

Citizen.CreateThread(function()
  local hash = GetHashKey(Config.pedgaragegouvped)
  while not HasModelLoaded(hash) do
  RequestModel(hash)
  Wait(1000)
  end
  ped = CreatePed(Config.pedgaragegouvped, Config.pedgaragegouvped, Config.pedgouvgarage.x,Config.pedgouvgarage.y,Config.pedgouvgarage.z,Config.pedgouvgarage.h, false, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetEntityInvincible(ped, true)
  FreezeEntityPosition(ped, true)
end)

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison)

    local color
    if raison == 'petit' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('~y~Contact Gouvernement', '~y~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère.', 'CHAR_CHAT_CALL', 8)
        color = 2
    elseif raison == 'importante' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('~y~Contact Gouvernement', '~y~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante.', 'CHAR_CHAT_CALL', 8)
        color = 47
    elseif raison == 'omgad' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('~y~Contact Gouvernement', '~y~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CHAT_CALL', 8)
        color = 1
    end
    
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Demande renfort')
    EndTextCommandSetBlipName(blipId)

    Wait(80 * 1000)
    RemoveBlip(blipId)
end)

exports.ox_target:addBoxZone({
    coords = vector3(-564.8813, -209.3802, 42.8271), -- 🛠️ Change ces coordonnées 
    size = vec3(1, 1, 1),
    rotation = 0,
    debug = false, -- Passe à true pour voir la zone
    options = {
        {
            name = 'check_society_funds',
            label = '💰 Consulter les comptes',
            icon = 'fas fa-money-bill',
            onSelect = function()
                TriggerServerEvent('getAllSocietyFunds')
            end
        }
    }
})

RegisterNetEvent('openSocietyFundsMenu')
AddEventHandler('openSocietyFundsMenu', function(accounts)
    local options = {}

    for name, money in pairs(accounts) do
        table.insert(options, {
            title = "💵 " .. name,
            description = "Solde : ~g~" .. money .. "$",
            icon = "fas fa-university"
        })
    end

    lib.registerContext({
        id = 'society_funds_menu',
        title = '💰 Comptes des Entreprises',
        options = options
    })

    lib.showContext('society_funds_menu')
end)

-- 📌 Menotter/Démenotter un joueur
RegisterNetEvent('gouv:toggleCuff', function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and distance < 3.0 then
        TriggerServerEvent('fw_interact:handcuff', GetPlayerServerId(closestPlayer))
    else
        lib.notify({ type = 'error', description = '❌ Aucun joueur à proximité !' })
    end
end)

local isHandcuffed, dragStatus = false, { isDragged = false, dragger = 0 }

RegisterNetEvent('fw_interact:handcuff')
AddEventHandler('fw_interact:handcuff', function()
    isHandcuffed = not isHandcuffed
    local playerPed = cache.ped

    if isHandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do Wait(100) end
        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        RemoveAnimDict('mp_arresting')
        SetEnableHandcuffs(playerPed, true)
        DisablePlayerFiring(playerPed, true)
        DisplayRadar(false)
    else
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        DisplayRadar(true)
    end
end)

-- 📌 Escorter un joueur
RegisterNetEvent('gouv:escort', function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()
    
    if closestPlayer ~= -1 and distance < 3.0 then
        TriggerServerEvent('fw_interact:escort', GetPlayerServerId(closestPlayer))
    else
        lib.notify({ type = 'error', description = '❌ Aucun joueur à proximité !' })
    end
end)

RegisterNetEvent('fw_interact:escort')
AddEventHandler('fw_interact:escort', function(dragger)
    if isHandcuffed or IsPedDeadOrDying(cache.ped, true) then
        dragStatus.isDragged = not dragStatus.isDragged
        dragStatus.dragger = dragger
    end
end)

-- 📌 Mettre un joueur dans un véhicule
RegisterNetEvent('gouv:putInVehicle', function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and distance < 3.0 then
        TriggerServerEvent('fw_interact:putInVehicle', GetPlayerServerId(closestPlayer))
    else
        lib.notify({ type = 'error', description = '❌ Aucun joueur à proximité !' })
    end
end)

RegisterNetEvent('fw_interact:putInVehicle')
AddEventHandler('fw_interact:putInVehicle', function()
    if isHandcuffed then
        local vehicle = GetClosestVehicle()
        if vehicle then
            local freeSeat = nil
            for i = GetVehicleMaxNumberOfPassengers(vehicle) - 1, 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    freeSeat = i
                    break
                end
            end
            if freeSeat then
                TaskWarpPedIntoVehicle(cache.ped, vehicle, freeSeat)
            end
        end
    end
end)

-- 📌 Sortir un joueur du véhicule
RegisterNetEvent('gouv:outVehicle', function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()
    
    if closestPlayer ~= -1 and distance < 3.0 then
        TriggerServerEvent('fw_interact:OutVehicle', GetPlayerServerId(closestPlayer))
    else
        lib.notify({ type = 'error', description = '❌ Aucun joueur à proximité !' })
    end
end)

RegisterNetEvent('fw_interact:OutVehicle')
AddEventHandler('fw_interact:OutVehicle', function()
    if IsPedSittingInAnyVehicle(cache.ped) then
        local vehicle = GetVehiclePedIsIn(cache.ped, false)
        TaskLeaveVehicle(cache.ped, vehicle, 64)
    end
end)

-- 📌 Fouiller un joueur
RegisterNetEvent('gouv:search', function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()
    
    if closestPlayer ~= -1 and distance < 3.0 then
        exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer))
    else
        lib.notify({ type = 'error', description = '❌ Aucun joueur à proximité !' })
    end
end)

-- 📌 Vérifier Identité
RegisterNetEvent('gouv:checkID', function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and distance < 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(closestPlayer), GetPlayerServerId(PlayerId()))
    else
        lib.notify({ type = 'error', description = '❌ Aucun joueur à proximité !' })
    end
end)

