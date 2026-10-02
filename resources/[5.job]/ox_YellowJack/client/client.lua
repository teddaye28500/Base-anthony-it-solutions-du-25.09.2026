ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'yellowjack', 'yellowjack', 'society_yellowjack', 'society_yellowjack', 'society_yellowjack', {type = 'public'})

-- Blip yellowjack
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local blip = AddBlipForCoord(Config.blipsyellowjack.x, Config.blipsyellowjack.y, Config.blipsyellowjack.z)
    SetBlipSprite(blip, Config.style.Yellowjack)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, Config.color.Yellowjack)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.nameblips.Yellowjack)
    EndTextCommandSetBlipName(blip)
    SetBlipPriority(blip, 5)
end)

-- Keybind F6 pour ouvrir le menu
lib.addKeybind({
    name = 'yellowjack_menu',
    description = 'Ouvrir le menu Yellowjack',
    defaultKey = 'F6',
    onPressed = function()
        local xPlayer = ESX.GetPlayerData()
        if xPlayer.job.name == 'yellowjack' then
            lib.showContext('menu_yellowjack')
        end
    end
})

-- 📌 Menu F6 - Annonces
lib.registerContext({
  id = 'menu_yellowjack',
  title = '🍺 Menu Yellowjack 🍺',
  options = {
      { title = '📢 Annonces', icon = 'wifi', menu = 'annonce_menuyellowjack' },
      { title = '💸 Facture', icon = 'file-lines', event = 'yellowjack:sendbill' }
  }
})

lib.registerContext({
  id = 'annonce_menuyellowjack',
  title = '📢 Annonces',
  menu = 'menu_yellowjack',
  options = {
      { title = '✅ Ouvert', event = 'yellowjack:annonce', args = 'ouvert', icon = 'fa fa-check-circle' },
      { title = '❌ Fermer', event = 'yellowjack:annonce', args = 'fermer', icon = 'fa fa-times-circle' },
      { title = '👥 Recruter', event = 'yellowjack:annonce', args = 'recruter', icon = 'fa fa-circle-info' },
      { title = '🚨 Personnaliser', event = 'yellowjack:annoncePerso', icon = 'fa-solid fa-comment' }
  }
})

-- 📌 Événement client pour envoyer une annonce standard
RegisterNetEvent('yellowjack:annonce')
AddEventHandler('yellowjack:annonce', function(type)
    if type == 'ouvert' then
        TriggerServerEvent('annonceOyellowjackserveur')
    elseif type == 'fermer' then
        TriggerServerEvent('annonceFyellowjackserveur')
    elseif type == 'recruter' then
        TriggerServerEvent('annonceRyellowjackserveur')
    end
end)

-- 📌 Événement client pour une annonce personnalisée
RegisterNetEvent('yellowjack:annoncePerso')
AddEventHandler('yellowjack:annoncePerso', function()
    local input = lib.inputDialog('Annonce Yellowjack', {'Message'})
    if input and input[1] ~= "" then
        TriggerServerEvent('yellowjack:SendAnnonce', input[1])
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez entrer un message !',
            type = 'error'
        })
    end
end)

-- Facture
RegisterNetEvent('yellowjack:sendbill')
AddEventHandler('yellowjack:sendbill', function()
    local input = lib.inputDialog('Facture Yellowjack', {'Montant'})

    if input then
        local amount = tonumber(input[1])
        if amount and amount > 0 then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 4.0 then
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_yellowjack', 'Facture Yellowjack', amount)
                lib.notify({
                  title = 'Success',
                  description = 'Facture envoyé',
                  type = 'success' -- Types possibles : success, error, inform, warning
              })
            else
              lib.notify({
                title = 'Pas De Joueur Proche',
                description = 'Personne de Proche',
                type = 'error' -- Types possibles : success, error, inform, warning
            })
            end
        else
          lib.notify({
            title = 'Montant Invalide',
            description = 'Montant Invalide',
            type = 'error' -- Types possibles : success, error, inform, warning
        })
        end
    end
end)


exports.qtarget:AddBoxZone("YellowjackCoffre", vector3(Config.coffreyellowjack.x, Config.coffreyellowjack.y, Config.coffreyellowjack.z + 1), 1.0 , 1.5, {
	name="YellowjackCoffre",
	heading=35,
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:coffreyellowjack",
				icon = "fas fa-university",
				label = "Coffre Yellowjack",
				job = "yellowjack",
			},
		},
	distance = 2.5
})


RegisterNetEvent('nsx:coffreyellowjack')
AddEventHandler('nsx:coffreyellowjack', function()
	OpenYellowjackCoffre()
end)

function OpenYellowjackCoffre()
	exports.ox_inventory:openInventory('stash', {id='Yellowjack Coffre', owner= false, job = 'yellowjack' })
end

exports.qtarget:AddBoxZone("YellowjackFrigo", vector3(Config.frigoyellowjack.x, Config.frigoyellowjack.y, Config.frigoyellowjack.z + 1), 1.0 , 1.5, {
	name="YellowjackFrigo",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:frigoyellowjack",
				icon = "fas fa-inbox",
				label = "Frigo Yellow jack",
				job = "yellowjack",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:frigoyellowjack')
AddEventHandler('nsx:frigoyellowjack', function()
	OpenYellowjackFrigo()
end)

function OpenYellowjackFrigo()
	exports.ox_inventory:openInventory('stash', {id='Yellowjack Frigo', owner= false, job = 'yellowjack' })
end

-- PATRON 

exports.qtarget:AddBoxZone("YellowjackBoss", vector3(Config.bossyellowjack.x, Config.bossyellowjack.y, Config.bossyellowjack.z), 1.0 , 1.5, {
	name="YellowjackBoss",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:bossyellowjack",
				icon = "fas fa-user",
				label = "Boss Yellowjack",
				job = "yellowjack",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:bossyellowjack')
AddEventHandler('nsx:bossyellowjack', function()
	OpenYellowjackBoss()
end)

function OpenYellowjackBoss()
	TriggerEvent('esx_society:openBossMenu', 'yellowjack', function(data, menu)

	end, { wash = false })
end

-- VESTIAIRE

Citizen.CreateThread(function()
	exports['qtarget']:AddBoxZone("VestiaireYellowjack", vector3(Config.vestiaireyellowjack.x, Config.vestiaireyellowjack.y, Config.vestiaireyellowjack.z), 1, 1, {
		name="Vestiaire Yellowjack",
		--debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
	  {
		  event = "nsx:vestiaireyellowjack", 
		  icon = "fas fa-shirt",
		  label = "Vestiaire Yellowjack",
          job = "yellowjack",
	  },
    },
  distance = 2.5
})

end)

RegisterNetEvent('nsx:vestiaireyellowjack')
AddEventHandler('nsx:vestiaireyellowjack', function()
  lib.showContext ('VestiaireYellowjack')
end)
	lib.registerContext({
		id = 'VestiaireYellowjack',
		title = 'Vestiaire Yellowjack',
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
				title = 'Vetements Yellowjack',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('yellowjack_wear', playerPed)
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
	setUniform('yellowjack_wear', playerPed)
end)

function setUniform(job)
  TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
          if Config.Uniformsyellowjack[job].male ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsyellowjack[job].male)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'yellowjack_wear' then
      SetPedArmour(playerPed, 0)
          end
      else
          if Config.Uniformsyellowjack[job].female ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsyellowjack[job].female)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'yellowjack_wear' then
              SetPedArmour(playerPed, 0)
          end
      end
  end)
end

-- ACHAT 

exports.qtarget:AddBoxZone("YellowjackAchat", vector3(Config.achatyellowjack.x, Config.achatyellowjack.y, Config.achatyellowjack.z), 1.0 , 1.5, {
	name="YellowjackAchat",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:achatyellowjack",
				icon = "fas fa-martini-glass",
				label = "Achat Yellowjack",
				job = "yellowjack",
			},
		},
	distance = 2.5
})

  RegisterNetEvent('nsx:achatyellowjack')
AddEventHandler('nsx:achatyellowjack', function()
    lib.showContext('boissonyellowjack')
end)

lib.registerContext({
    id = 'boissonyellowjack',
    title = 'Boisson',
    options = {
      {
        title = 'EAU',
        description = 'prix : '   .. Config.prix.eau .. '$' ,
        icon = 'fa-solid fa-glass-water',
        event = 'adds:water'
        },
        {
          title = 'COLA',
          description = 'prix : '   .. Config.prix.cola .. '$' ,
          icon = 'fa-solid fa-glass-water',
           event = 'adds:cola'
              },
        {
          title = 'REDBULL',
          description = 'prix : '   .. Config.prix.redbull .. '$' ,
          icon = 'fa-solid fa-glass-water',
           event = 'adds:redbull'
              },
        {
          title = 'biere',
          description = 'prix : '   .. Config.prix.biere .. '$' ,
          icon = 'fa-solid fa-whiskey-glass',
          event = 'adds:biere'
          },
          {
            title = 'caprisun',
            description = 'prix : '   .. Config.prix.caprisun .. '$' ,
            icon = 'fa-solid fa-glass-water',
            event = 'adds:caprisun'
            },
            {
              title = 'sangria',
              description = 'prix : '   .. Config.prix.sangria .. '$' ,
              icon = 'fa-solid fa-glass-water',
              event = 'adds:sangria'
              },
              {
                title = 'jagerbomb',
                description = 'prix : '   .. Config.prix.jagerbomb .. '$' ,
                icon = 'fa-solid fa-glass-water',
                event = 'adds:jagerbomb'
                },
          {
          title = 'whisky',
          description = 'prix : '   .. Config.prix.whisky .. '$' ,
          icon = 'fa-solid fa-wine-glass',
           event = 'adds:whisky'
              },
      }
    })
  
    RegisterNetEvent('adds:water')
    AddEventHandler('adds:water', function()
      TriggerServerEvent('adds:waterserveur')
    end)
  
    RegisterNetEvent('adds:cola')
    AddEventHandler('adds:cola', function()
      TriggerServerEvent('adds:colaserveur')
    end)
  
    RegisterNetEvent('adds:redbull')
    AddEventHandler('adds:redbull', function()
      TriggerServerEvent('adds:redbullserveur')
    end)
  
    RegisterNetEvent('adds:biere')
    AddEventHandler('adds:biere', function()
      TriggerServerEvent('adds:biereserveur')
    end)
  
    RegisterNetEvent('adds:whisky')
    AddEventHandler('adds:whisky', function()
      TriggerServerEvent('adds:whiskyserveur')
    end)
  
    RegisterNetEvent('adds:caprisun')
    AddEventHandler('adds:caprisun', function()
      TriggerServerEvent('adds:caprisunserveur')
    end)
  
    RegisterNetEvent('adds:sangria')
    AddEventHandler('adds:sangria', function()
      TriggerServerEvent('adds:sangriaserveur')
    end)
  
    RegisterNetEvent('adds:jagerbomb')
    AddEventHandler('adds:jagerbomb', function()
      TriggerServerEvent('adds:jagerbombserveur')
    end)

  -- Garage 
  local Options = {}


  Citizen.CreateThread(function()
    exports['qtarget']:AddBoxZone("YellowjackVehicule", vector3(Config.garageyellowjack.x,Config.garageyellowjack.y,Config.garageyellowjack.z), 1, 1, {
      name="YellowjackVehicule",
      heading=30,
      --debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
          minZ=33.90,
          maxZ=35.00
  }, {
    options = {
      {
        event = "yellowjack:vehicule", 
        icon = "fa fa-car",
        label = "Vehicule Yellowjack",
            job = "yellowjack",
      },
      },
    distance = 2.5
  })
end)

RegisterNetEvent('yellowjack:vehicule')
AddEventHandler('yellowjack:vehicule', function()
    lib.showContext('yellowjackvehicule')
end)

for i = 1, #Config.cars.Yellowjack do
  if i == 1 then
      Options[i] = { title = Config.cars.Yellowjack[i].nom, args = Config.cars.Yellowjack[i].modele, icon = "fa fa-car", event = 'nsx:delCaryellow'}
  else
      Options[i] = { title = Config.cars.Yellowjack[i].nom, args = Config.cars.Yellowjack[i].modele, icon = "fa fa-car", event = 'nsx:spawnCaryellow'}
  end
end
  lib.registerContext({
      id = 'yellowjackvehicule',
      title = 'Véhicules Yellow Jack',
      options = Options,
  })

  function createCarYellowjack(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.SpawnVeh.Yellowjack, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate.Yellowjack..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('nsx:spawnCaryellow', function(data)
  createCarYellowjack(data)
end)

RegisterNetEvent('nsx:delCaryellow')
AddEventHandler('nsx:delCaryellow',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

Citizen.CreateThread(function()
	local hash = GetHashKey(Config.pedgarageyellowjackped)
	while not HasModelLoaded(hash) do
	RequestModel(hash)
	Wait(1000)
	end
	ped = CreatePed(Config.pedgarageyellowjackped, Config.pedgarageyellowjackped, Config.pedyellowjackgarage.x,Config.pedyellowjackgarage.y,Config.pedyellowjackgarage.z,Config.pedyellowjackgarage.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
end)