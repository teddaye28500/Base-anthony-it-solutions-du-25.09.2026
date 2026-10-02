ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'unicorn', 'unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'public'})

-- Blip Unicorn
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local blip = AddBlipForCoord(Config.blipsunicorn.x, Config.blipsunicorn.y, Config.blipsunicorn.z)
    SetBlipSprite(blip, Config.style.Unicorn)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, Config.color.Unicorn)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.nameblips.Unicorn)
    EndTextCommandSetBlipName(blip)
    SetBlipPriority(blip, 5)
end)

-- Keybind F6 pour ouvrir le menu
lib.addKeybind({
    name = 'unicorn_menu',
    description = 'Ouvrir le menu Unicorn',
    defaultKey = 'F6',
    onPressed = function()
        local xPlayer = ESX.GetPlayerData()
        if xPlayer.job.name == 'unicorn' then
            lib.showContext('menu_unicorn')
        end
    end
})

-- 📌 Menu F6 - Annonces
lib.registerContext({
  id = 'menu_unicorn',
  title = '🦄 Menu Unicorn',
  options = {
      { title = '📢 Annonces', icon = 'wifi', menu = 'annonce_menuunicorn' },
      { title = '💸 Facture', icon = 'file-lines', event = 'unicorn:sendbill' }
  }
})

lib.registerContext({
  id = 'annonce_menuunicorn',
  title = '📢 Annonces',
  menu = 'menu_unicorn',
  options = {
      { title = '✅ Ouvert', event = 'unicorn:annonce', args = 'ouvert', icon = 'fa fa-check-circle' },
      { title = '❌ Fermer', event = 'unicorn:annonce', args = 'fermer', icon = 'fa fa-times-circle' },
      { title = '👥 Recruter', event = 'unicorn:annonce', args = 'recruter', icon = 'fa fa-circle-info' },
      { title = '🚨 Personnaliser', event = 'unicorn:annoncePerso', icon = 'fa-solid fa-comment' }
  }
})

-- 📌 Événement client pour envoyer une annonce standard
RegisterNetEvent('unicorn:annonce')
AddEventHandler('unicorn:annonce', function(type)
    if type == 'ouvert' then
        TriggerServerEvent('annonceOunicornserveur')
    elseif type == 'fermer' then
        TriggerServerEvent('annonceFunicornserveur')
    elseif type == 'recruter' then
        TriggerServerEvent('annonceRunicornserveur')
    end
end)

-- 📌 Événement client pour une annonce personnalisée
RegisterNetEvent('unicorn:annoncePerso')
AddEventHandler('unicorn:annoncePerso', function()
    local input = lib.inputDialog('Annonce Unicorn', {'Message'})
    if input and input[1] ~= "" then
        TriggerServerEvent('unicorn:SendAnnonce', input[1])
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez entrer un message !',
            type = 'error'
        })
    end
end)

-- Facture
RegisterNetEvent('unicorn:sendbill')
AddEventHandler('unicorn:sendbill', function()
    local input = lib.inputDialog('Facture Unicorn', {'Montant'})

    if input then
        local amount = tonumber(input[1])
        if amount and amount > 0 then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 4.0 then
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_unicorn', 'Facture Unicorn', amount)
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

exports.qtarget:AddBoxZone("UnicornCoffre", vector3(Config.coffreunicorn.x, Config.coffreunicorn.y, Config.coffreunicorn.z + 1), 1.0 , 1.5, {
	name="UnicornCoffre",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:coffreunicorn",
				icon = "fas fa-inbox",
				label = "Coffre Unicorn",
				job = "unicorn",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:coffreunicorn')
AddEventHandler('nsx:coffreunicorn', function()
	OpenUnicornCoffre()
end)

function OpenUnicornCoffre()
	exports.ox_inventory:openInventory('stash', {id='Unicorn Coffre', owner= false, job = 'unicorn' })
end

exports.qtarget:AddBoxZone("UnicornFrigo", vector3(Config.frigounicorn.x, Config.frigounicorn.y, Config.frigounicorn.z + 1), 1.0 , 1.5, {
	name="UnicornFrigo",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:frigounicorn",
				icon = "fas fa-inbox",
				label = "Frigo Unicorn",
				job = "unicorn",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:frigounicorn')
AddEventHandler('nsx:frigounicorn', function()
	OpenUnicornFrigo()
end)

function OpenUnicornFrigo()
	exports.ox_inventory:openInventory('stash', {id='Unicorn Frigo', owner= false, job = 'unicorn' })
end

-- PATRON 

exports.qtarget:AddBoxZone("UnicornBoss", vector3(Config.bossunicorn.x, Config.bossunicorn.y, Config.bossunicorn.z), 1.0 , 1.5, {
	name="UnicornBoss",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:bossunicorn",
				icon = "fas fa-user",
				label = "Boss Unicorn",
				job = "unicorn",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:bossunicorn')
AddEventHandler('nsx:bossunicorn', function()
	OpenUnicornBoss()
end)

function OpenUnicornBoss()
	TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)

	end, { wash = true })
end

-- VESTIAIRE

Citizen.CreateThread(function()
	exports['qtarget']:AddBoxZone("VestiaireUnicorn", vector3(Config.vestiaireunicorn.x, Config.vestiaireunicorn.y, Config.vestiaireunicorn.z), 1, 1, {
		name="Vestiaire Unicorn",
		--debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
        minZ=33.90,
        maxZ=35.00
}, {
  options = {
	  {
		  event = "nsx:vestiaireunicorn", 
		  icon = "fas fa-shirt",
		  label = "Vestiaire Unicorn",
          job = "unicorn",
	  },
    },
  distance = 2.5
})

end)

RegisterNetEvent('nsx:vestiaireunicorn')
AddEventHandler('nsx:vestiaireunicorn', function()
  lib.showContext ('VestiaireUnicorn')
end)
	lib.registerContext({
		id = 'VestiaireUnicorn',
		title = 'Vestiaire Unicorn',
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
				title = 'Vetements Unicorn',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('unicorn_wear', playerPed)
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
	setUniform('unicorn_wear', playerPed)
end)

function setUniform(job)
  TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
          if Config.Uniformsunicorn[job].male ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsunicorn[job].male)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'unicorn_wear' then
      SetPedArmour(playerPed, 0)
          end
      else
          if Config.Uniformsunicorn[job].female ~= nil then
              TriggerEvent('skinchanger:loadClothes', skin, Config.Uniformsunicorn[job].female)
          else
              ESX.ShowNotification("Pas de vetement")
          end

          if job == 'unicorn_wear' then
              SetPedArmour(playerPed, 0)
          end
      end
  end)
end

-- ACHAT 

exports.qtarget:AddBoxZone("UnicornAchat", vector3(Config.achatunicorn.x, Config.achatunicorn.y, Config.achatunicorn.z), 1.0 , 1.5, {
	name="UnicornAchat",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:achatunicorn",
				icon = "fas fa-martini-glass",
				label = "Achat Unicorn",
				job = "unicorn",
			},
		},
	distance = 2.5
})

  RegisterNetEvent('nsx:achatunicorn')
AddEventHandler('nsx:achatunicorn', function()
    lib.showContext('boissonunicorn')
end)

lib.registerContext({
    id = 'boissonunicorn',
    title = 'Boisson',
    options = {
      {
      title = 'EAU',
      description = 'prix : '   .. Config.prix.eau .. '$' ,
      icon = 'fa-solid fa-glass-water',
      event = 'add:water'
      },
      {
        title = 'COLA',
        description = 'prix : '   .. Config.prix.cola .. '$' ,
        icon = 'fa-solid fa-glass-water',
         event = 'add:cola'
            },
      {
        title = 'REDBULL',
        description = 'prix : '   .. Config.prix.redbull .. '$' ,
        icon = 'fa-solid fa-glass-water',
         event = 'add:redbull'
            },
      {
        title = 'VODKA',
        description = 'prix : '   .. Config.prix.vodka .. '$' ,
        icon = 'fa-solid fa-whiskey-glass',
        event = 'add:vodka'
        },
        {
          title = 'TEQUILLA',
          description = 'prix : '   .. Config.prix.tequilla .. '$' ,
          icon = 'fa-solid fa-glass-water',
          event = 'add:tequilla'
          },
          {
            title = 'cocktail',
            description = 'prix : '   .. Config.prix.cocktail .. '$' ,
            icon = 'fa-solid fa-glass-water',
            event = 'add:cocktail'
            },
            {
              title = 'jagerbomb',
              description = 'prix : '   .. Config.prix.jagerbomb .. '$' ,
              icon = 'fa-solid fa-glass-water',
              event = 'add:jagerbomb'
              },
        {
        title = 'CHAMPAGNE',
        description = 'prix : '   .. Config.prix.champagne .. '$' ,
        icon = 'fa-solid fa-wine-glass',
         event = 'add:champagne'
            },
    }
  })

  RegisterNetEvent('add:water')
  AddEventHandler('add:water', function()
    TriggerServerEvent('add:waterserveur')
  end)

  RegisterNetEvent('add:cola')
  AddEventHandler('add:cola', function()
    TriggerServerEvent('add:colaserveur')
  end)

  RegisterNetEvent('add:redbull')
  AddEventHandler('add:redbull', function()
    TriggerServerEvent('add:redbullserveur')
  end)

  RegisterNetEvent('add:vodka')
  AddEventHandler('add:vodka', function()
    TriggerServerEvent('add:vodkaserveur')
  end)

  RegisterNetEvent('add:champagne')
  AddEventHandler('add:champagne', function()
    TriggerServerEvent('add:champagneserveur')
  end)

  RegisterNetEvent('add:tequilla')
  AddEventHandler('add:tequilla', function()
    TriggerServerEvent('add:tequillaserveur')
  end)

  RegisterNetEvent('add:cocktail')
  AddEventHandler('add:cocktail', function()
    TriggerServerEvent('add:cocktailserveur')
  end)

  RegisterNetEvent('add:jagerbomb')
  AddEventHandler('add:jagerbomb', function()
    TriggerServerEvent('add:jagerbombserveur')
  end)

  -- Garage 
  local Options = {}


  Citizen.CreateThread(function()
    exports['qtarget']:AddBoxZone("UnicornVehicule", vector3(Config.garageunicorn.x,Config.garageunicorn.y,Config.garageunicorn.z), 1, 1, {
      name="UnicornVehicule",
      heading=30,
      --debugPoly=true,vec4(2899.197510, 4399.423828, 50.234802, 199.278992)
          minZ=33.90,
          maxZ=35.00
  }, {
    options = {
      {
        event = "unicorn:vehicule", 
        icon = "fa fa-car",
        label = "Vehicule Unicorn",
            job = "unicorn",
      },
      },
    distance = 2.5
  })
end)

RegisterNetEvent('unicorn:vehicule')
AddEventHandler('unicorn:vehicule', function()
    lib.showContext('unicornvehicule')
end)

for i = 1, #Config.cars.Unicorn do
  if i == 1 then
      Options[i] = { title = Config.cars.Unicorn[i].nom, args = Config.cars.Unicorn[i].modele, icon = "fa fa-car", event = 'nsx:delCar'}
  else
      Options[i] = { title = Config.cars.Unicorn[i].nom, args = Config.cars.Unicorn[i].modele, icon = "fa fa-car", event = 'nsx:spawnCar'}
  end
end
  lib.registerContext({
      id = 'unicornvehicule',
      title = 'Véhicules Unicorn',
      options = Options,
  })

  function createCarUnicorn(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.SpawnVeh.Unicorn, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate.Unicorn..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('nsx:spawnCar', function(data)
  createCarUnicorn(data)
end)

RegisterNetEvent('nsx:delCar')
AddEventHandler('nsx:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

Citizen.CreateThread(function()
	local hash = GetHashKey(Config.pedgarageunicornped)
	while not HasModelLoaded(hash) do
	RequestModel(hash)
	Wait(1000)
	end
	ped = CreatePed(Config.pedgarageunicornped, Config.pedgarageunicornped, Config.pedunicorngarage.x,Config.pedunicorngarage.y,Config.pedunicorngarage.z,Config.pedunicorngarage.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
end)