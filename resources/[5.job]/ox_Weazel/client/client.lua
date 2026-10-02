ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'weazel', 'weazel', 'society_weazel', 'society_weazel', 'society_weazel', {type = 'public'})

-- 📌 Création du blip Weazel News
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local blip = AddBlipForCoord(Config.blipsweazel.x, Config.blipsweazel.y, Config.blipsweazel.z)
    SetBlipSprite(blip, Config.style.Weazel)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, Config.color.Weazel)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.nameblips.Weazel)
    EndTextCommandSetBlipName(blip)
    SetBlipPriority(blip, 5)
end)

-- 📌 Menu Weazel News
lib.registerContext({
    id = 'menu_weazel',
    title = '📺 Menu Weazel News',
    options = {
        { title = '📢 Annonces', icon = 'wifi', menu = 'annonce_menuweazel' },
        { title = '💸 Facture', icon = 'file-invoice-dollar', event = 'weazel:sendbill' },
        { title = '🎥 Outils de Travail', icon = 'toolbox', menu = 'travail_menuweazel' }
    }
})

-- 📌 Menu des annonces
lib.registerContext({
    id = 'annonce_menuweazel',
    title = '📢 Annonces Weazel News',
    menu = 'menu_weazel',
    options = {
        { title = '✅ Ouvert', icon = 'check-circle', event = 'weazel:annonce', args = 'ouvert' },
        { title = '❌ Fermé', icon = 'times-circle', event = 'weazel:annonce', args = 'fermer' },
        { title = '👥 Recrutement', icon = 'user-plus', event = 'weazel:annonce', args = 'recruter' },
        { title = '🚨 Personnalisé', icon = 'fa-comment', event = 'weazel:annoncePerso' }
    }
})

-- 📌 Menu des outils de travail
lib.registerContext({
    id = 'travail_menuweazel',
    title = '🎥 Outils de Travail',
    menu = 'menu_weazel',
    options = {
        { title = '📷 Caméra', icon = 'video', event = 'weazel:useCamera' },
        { title = '🎙️ Micro à Perche', icon = 'microphone-alt', event = 'weazel:useBoomMic' }
    }
})

-- 📌 Ouvrir le menu avec la touche F6
RegisterKeyMapping('weazelmenu', 'Menu Weazel News', 'keyboard', 'F6')
RegisterCommand('weazelmenu', function()
    local xPlayer = ESX.GetPlayerData()
    if xPlayer.job.name == 'weazel' then
        lib.showContext('menu_weazel')
    end
end, false)

-- 📢 Gestion des annonces
RegisterNetEvent('weazel:annonce')
AddEventHandler('weazel:annonce', function(type)
    local events = {
        ouvert = 'annonceOweazelserveur',
        fermer = 'annonceFweazelserveur',
        recruter = 'annonceRweazelserveur'
    }
    if events[type] then
        TriggerServerEvent(events[type])
    end
end)

RegisterNetEvent('weazel:annoncePerso')
AddEventHandler('weazel:annoncePerso', function()
    local input = lib.inputDialog('Annonce Weazel', {'Message'})
    if input and input[1] ~= "" then
        TriggerServerEvent('weazel:SendAnnonce', input[1])
    else
        lib.notify({ title = 'Erreur', description = 'Vous devez entrer un message !', type = 'error' })
    end
end)

-- 📌 Facture
RegisterNetEvent('weazel:sendbill')
AddEventHandler('weazel:sendbill', function()
    local input = lib.inputDialog('Facture Weazel', {'Montant'})
    local amount = tonumber(input[1])
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if amount and amount > 0 and closestPlayer ~= -1 and closestDistance <= 4.0 then
        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_weazel', 'Facture Weazel', amount)
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
RegisterNetEvent('weazel:useCamera')
AddEventHandler('weazel:useCamera', function()
    ToggleProp(PlayerPedId(), `prop_v_cam_01`, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 57005, 0.0, 0.0, 0.0, 0.0, 0.0, 290.0)
end)

-- 🎙️ Micro à perche (Activation/Désactivation)
RegisterNetEvent('weazel:useBoomMic')
AddEventHandler('weazel:useBoomMic', function()
    ToggleProp(PlayerPedId(), `prop_v_bmike_01`, "missfra1", "mcs2_crew_idle_m_boom", 57005, 0.0, 0.0, 0.0, 0.0, 0.0, 90.0)
end)


-- 📌 Comptoir (ox_target)
exports.ox_target:addBoxZone({
    name = "Weazel_Comptoir",
    coords = vector3(Config.comptoir.x, Config.comptoir.y, Config.comptoir.z),
    size = vec3(1.0, 1.0, 1.0),
    rotation = 0.0,
    debug = false,
    options = {
        {
            name = "appel_weazel",
            event = "weazel:clientCall",
            icon = "fas fa-bell",
            label = "Appeler un employé",
            distance = 2.5
        }
    }
})

RegisterNetEvent("weazel:clientCall")
AddEventHandler("weazel:clientCall", function()
    -- Envoie de l'événement serveur
    TriggerServerEvent("weazel:alertEmployees")
    lib.notify({ title = "Weazel", description = "Un employé a été appelé au comptoir.", type = "inform" })
end)

RegisterNetEvent("weazel:notifyEmployee")
AddEventHandler("weazel:notifyEmployee", function()
    -- Notification pour l'employé
    lib.notify({ title = "Weazel", description = "Vous avez été appelé au comptoir.", type = "success" })
end)


exports.qtarget:AddBoxZone("WeazelCoffre", vector3(Config.coffreweazel.x, Config.coffreweazel.y, Config.coffreweazel.z + 1), 1.0 , 1.5, {
	name="WeazelCoffre",
	heading=35,
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:coffreweazel",
				icon = "fas fa-university",
				label = "Coffre Weazel",
				job = "weazel",
			},
		},
	distance = 2.5
})


RegisterNetEvent('nsx:coffreweazel')
AddEventHandler('nsx:coffreweazel', function()
	OpenWeazelCoffre()
end)

function OpenWeazelCoffre()
	exports.ox_inventory:openInventory('stash', {id='Weazel Coffre', owner= false, job = 'weazel' })
end

-- PATRON 

exports.qtarget:AddBoxZone("WeazelBoss", vector3(Config.bossweazel.x, Config.bossweazel.y, Config.bossweazel.z), 1.0 , 1.5, {
	name="WeazelBoss",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:bossweazel",
				icon = "fas fa-user",
				label = "Boss Weazel",
				job = "weazel",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:bossweazel')
AddEventHandler('nsx:bossweazel', function()
	OpenWeazelBoss()
end)

function OpenWeazelBoss()
	TriggerEvent('esx_society:openBossMenu', 'weazel', function(data, menu)

	end, { wash = false })
end

-- VESTIAIRE

Citizen.CreateThread(function()
	exports['qtarget']:AddBoxZone("VestiaireWeazel", vector3(Config.vestiaireweazel.x, Config.vestiaireweazel.y, Config.vestiaireweazel.z), 1, 1, {
		name="Vestiaire Weazel",
		--debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
	  {
		  event = "nsx:vestiaireweazel", 
		  icon = "fas fa-shirt",
		  label = "Vestiaire Weazel",
          job = "weazel",
	  },
    },
  distance = 2.5
})

end)

RegisterNetEvent('nsx:vestiaireweazel')
AddEventHandler('nsx:vestiaireweazel', function()
  lib.showContext ('VestiaireWeazel')
end)
	lib.registerContext({
		id = 'VestiaireWeazel',
		title = 'Vestiaire Weazel',
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
				title = 'Vetements Weazel',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('weazel_wear', playerPed)
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
	setUniform('weazel_wear', playerPed)
end)

function setUniform(job)
  TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
          if Config.Uniformsweazel[job].male ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsweazel[job].male)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'weazel_wear' then
      SetPedArmour(playerPed, 0)
          end
      else
          if Config.Uniformsweazel[job].female ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsweazel[job].female)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'weazel_wear' then
              SetPedArmour(playerPed, 0)
          end
      end
  end)
end

-- Garage 
local Options = {}


Citizen.CreateThread(function()
  exports['qtarget']:AddBoxZone("WeazelVehicule", vector3(Config.garageweazel.x,Config.garageweazel.y,Config.garageweazel.z), 1, 1, {
    name="WeazelVehicule",
    heading=30,
    --debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
    {
      event = "weazel:vehicule", 
      icon = "fa fa-car",
      label = "Vehicule Weazel",
          job = "weazel",
    },
    },
  distance = 2.5
})
end)

RegisterNetEvent('weazel:vehicule')
AddEventHandler('weazel:vehicule', function()
  lib.showContext('weazelvehicule')
end)

for i = 1, #Config.cars.Weazel do
if i == 1 then
    Options[i] = { title = Config.cars.Weazel[i].nom, args = Config.cars.Weazel[i].modele, icon = "fa fa-car", event = 'nsx:delCars'}
else
    Options[i] = { title = Config.cars.Weazel[i].nom, args = Config.cars.Weazel[i].modele, icon = "fa fa-car", event = 'nsx:spawnCars'}
end
end
lib.registerContext({
    id = 'weazelvehicule',
    title = 'Véhicules Weazel',
    options = Options,
})

function createCarWeazel(car)
  local car = GetHashKey(car)

  RequestModel(car)
  while not HasModelLoaded(car) do
      RequestModel(car)
      Wait(0)
  end

  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
  local vehicle = CreateVehicle(car, Config.SpawnVeh.Weazel, true, false)
  SetEntityAsMissionEntity(vehicle, true, true)
  local plaque = Config.Plate.Weazel..math.random(1,9)
  SetVehicleNumberPlateText(vehicle, plaque) 
  SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('nsx:spawnCars', function(data)
createCarWeazel(data)
end)

RegisterNetEvent('nsx:delCars')
AddEventHandler('nsx:delCars',function()
  local veh = ESX.Game.GetClosestVehicle()
  DeleteEntity(veh)
end)

Citizen.CreateThread(function()
  local hash = GetHashKey(Config.pedgarageweazelped)
  while not HasModelLoaded(hash) do
  RequestModel(hash)
  Wait(1000)
  end
  ped = CreatePed(Config.pedgarageweazelped, Config.pedgarageweazelped, Config.pedweazelgarage.x,Config.pedweazelgarage.y,Config.pedweazelgarage.z,Config.pedweazelgarage.h, false, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetEntityInvincible(ped, true)
  FreezeEntityPosition(ped, true)
end)