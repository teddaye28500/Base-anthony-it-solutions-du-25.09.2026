ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})

if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.CoffreMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerCoffre = lib.marker.new(markerOptions)

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            
            markerCoffre:draw()

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.CoffreMarker.x, Config.PositionMarker.CoffreMarker.y, Config.PositionMarker.CoffreMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir le coffre")
                end

                if IsControlJustPressed(0, 51) then -- Si le joueur appuie sur la touche E
                    lib.notify({ description = "Vous avez ouvert le Coffre de stockage!" }) -- Afficher une notification
                    TriggerEvent('vigneron:coffre') -- Déclencher l'événement pour commencer le braquage Brinks
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI() -- Cacher l'interface texte si le joueur n'est pas à proximité
                end
            end
        end
    end)
else    
    exports.qtarget:AddBoxZone("vigneronCoffre", (Config.PositionTarget.Coffre), 1.0 , 1.5, {
	name="vigneronCoffre",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "vigneron:coffre",
				icon = "fa fa-university",
				label = "Coffre",
				job = "vigneron",
			},
		},
	distance = 2.5
})
end

RegisterNetEvent('vigneron:coffre')
AddEventHandler('vigneron:coffre', function()
	exports.ox_inventory:openInventory('stash', {id='vigneronCoffre', owner= false, job = vigneron})
end)

--- Blips Location Job Vigneron
function CreateBlipCircle(coords, text, color, sprite)
	blip = AddBlipForCoord(coords)

	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	CreateBlipCircle(vector3(Config.vigneronLocation.x, Config.vigneronLocation.y, Config.vigneronLocation.z), Config.vigneronBlipText, Config.vigneronBlipColor, Config.vigneronBlipSprite)
end)

--- Menu F6

lib.registerContext({
  id = 'NSX_vigneron',
  title = '🍇 Menu Vigneron',
  options = {
      {
          title = '📢 Annonces', -- Fait
          icon = 'wifi',
          menu = 'NSX:annonce_menuvigneron',
      },
      { -- Fait
          title = '🗺️ Demande Point Farm',
          icon = 'fa fa-fire',
          menu = 'NSX:pointfarm_menuvigneron',
      },
      { -- Fait
          title = '💸 Facture',
          icon = 'file-lines',
          event = 'NSX:vigneron:sendbill'
      },
  },
  { -- Fait
      id = 'NSX:annonce_menuvigneron',
      title = '📢 Annonces',
      menu = 'NSX_vigneron',
      options = {
          ['✅ Ouvert'] = {event = 'NSX:annonceOvigneron', icon = 'fa fa-check-circle'},
          ['❌ Fermer'] = {event = 'NSX:annonceFvigneron', icon = 'fa fa-times-circle'}
      }
  },
  { -- Fait
      id = 'NSX:pointfarm_menuvigneron',
      title = '🗺️ Point Farm',
      menu = 'NSX_vigneron',
      options = {
        ['🍇 Recolte'] = {event = 'NSX:Recolteblip', icon = 'fa fa-check-circle'},
        ['🍷 Pressage de raisin'] = {event = 'NSX:Traitementblip', icon = 'fa fa-check-circle'},
        ['🍾 Mise en bouteille'] = {event = 'NSX:Traitementblip2', icon = 'fa fa-check-circle'},
        ['💵 Vente'] = {event = 'NSX:Venteblip', icon = 'fa fa-times-circle'},
      }
  }
})

-- Blips recolte traitement vente ect ...

RegisterNetEvent('NSX:Recolteblip')
AddEventHandler('NSX:Recolteblip', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(-1878.8734, 2096.2300, 140.3414) 
		SetNewWaypoint(-1878.8734, 2096.2300, 140.3414)
		SetBlipSprite (blip, 85) 
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Recolte Vigneron') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de Recolte de raisin')
end)

RegisterNetEvent('NSX:Traitementblip')
AddEventHandler('NSX:Traitementblip', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(-1874.485, 2059.276, 135.9151) 
		SetNewWaypoint(-1874.485, 2059.276, 135.9151)
		SetBlipSprite (blip, 85)
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Traitement') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de pressage de raisin')
end)

RegisterNetEvent('NSX:Traitementblip2')
AddEventHandler('NSX:Traitementblip2', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(-1891.648, 2064.104, 145.5738) 
		SetNewWaypoint(-1891.648, 2064.104, 145.5738)
		SetBlipSprite (blip, 85)
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Traitement') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de Mise en bouteille')
end)

RegisterNetEvent('NSX:Venteblip')
AddEventHandler('NSX:Venteblip', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(91.4010, -1603.8853, 30.8950) 
		SetNewWaypoint(91.4010, -1603.8853, 30.8950)
		SetBlipSprite (blip, 85) 
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Vente Grosiste') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de Vente')

end)

-- Création de la keybind pour ouvrir le menu sans utiliser /vigneron
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if IsControlJustPressed(0, 167) then -- Touche F6
          local xPlayer = ESX.GetPlayerData()
          if xPlayer.job.name == 'vigneron' then
              lib.showContext('NSX_vigneron')
          end
      end
  end
end)

--- Annonce Vigneron
RegisterNetEvent('NSX:annonceOvigneron')
AddEventHandler('NSX:annonceOvigneron', function()
    TriggerServerEvent('NSX:vigneron:AnnonceOuvert')
end)

RegisterNetEvent('NSX:annonceFvigneron')
AddEventHandler('NSX:annonceFvigneron', function()
    TriggerServerEvent('NSX:vigneron:AnnonceFermer')
end)

--- Vigneron Facture
RegisterNetEvent('NSX:vigneron:sendbill')
AddEventHandler('NSX:vigneron:sendbill', function()
      local input = lib.inputDialog('FACTURE vigneron', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('~r~Personne proche !')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_vigneron', 'Facture vigneron', amount)
			end
		end
    end
end)

-- Menu boss vigneron
if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.BossMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerBoss = lib.marker.new(markerOptions)

    -- Fonction pour vérifier si le joueur est à proximité du marker
    Citizen.CreateThread(function()
        while true do
            Wait(0) -- Attendre une frame pour ne pas surcharger le CPU
            
            markerBoss:draw() -- Dessiner le marker

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.BossMarker.x, Config.PositionMarker.BossMarker.y, Config.PositionMarker.BossMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir l'ordinateur") -- Afficher une instruction
                end

                if IsControlJustPressed(0, 51) then -- Si le joueur appuie sur la touche E
                    lib.notify({ description = "Vous avez ouvert l'ordinateur!" }) -- Afficher une notification
                    TriggerEvent('NSX:MenuBoss') -- Déclencher l'événement pour commencer le braquage Brinks
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI() -- Cacher l'interface texte si le joueur n'est pas à proximité
                end
            end
        end
    end)
else
    -- Target menu boss
    exports.ox_target:addBoxZone({
        coords = Config.PositionTarget.Boss,
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'box',
                event = 'nsx:MenuBoss',
                icon = 'fa-regular fa-user',
                label = "Menu Boss",
                job = "vigneron",
            }
        }
    })
end

RegisterNetEvent('nsx:MenuBoss')
AddEventHandler('nsx:MenuBoss', function()
	Openbox()
end)

function Openbox()
	TriggerEvent('esx_society:openBossMenu', 'vigneron', function(data, menu)

	end, { wash = false })
end



--- Menu Vestiaire
if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.ClothesMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerVestiaire = lib.marker.new(markerOptions)

    -- Fonction pour vérifier si le joueur est à proximité du marker
    Citizen.CreateThread(function()
        while true do
            Wait(0) -- Attendre une frame pour ne pas surcharger le CPU
            
            markerVestiaire:draw() -- Dessiner le marker

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.ClothesMarker.x, Config.PositionMarker.ClothesMarker.y, Config.PositionMarker.ClothesMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir votre cassier") -- Afficher une instruction
                end

                if IsControlJustPressed(0, 51) then -- Si le joueur appuie sur la touche E
                    lib.notify({ description = "Vous avez ouvert votre cassier!" }) -- Afficher une notification
                    TriggerEvent('NSX:vigneron:vetement') -- Déclencher l'événement pour commencer le braquage Brinks
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI() -- Cacher l'interface texte si le joueur n'est pas à proximité
                end
            end
        end
    end)
else
exports.qtarget:AddBoxZone("vigneronVetement", Config.PositionTarget.Clothes, 1.0 , 1.5, {
	name="vigneronVetement",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "NSX:vigneron:vetement",
				icon = "fas fa-tshirt",
				label = "Vetements",
				job = "vigneron",
			},
		},
	distance = 2.5
})
end

RegisterNetEvent('NSX:vigneron:vetement')
AddEventHandler('NSX:vigneron:vetement', function()
	lib.registerContext({
		id = 'VetementVigneron',
		title = 'Vetements',
		onExit = function()
		end,
		options = {
			{
				title = 'Vos Vetement',
				icon = "fas fa-tshirt",
				description = 'Prendre vos propre vetement',
				onSelect = function(args)				
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)		
                        TriggerEvent('NSX:VettementChangerRemet')
                        Citizen.Wait(3500)
						TriggerEvent('skinchanger:loadSkin', skin)											
						ESX.ShowNotification('~r~Fin de service')
					end)
				end,
			},
			{
				title = 'Vetement Vigneron',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
                    TriggerEvent('NSX:VettementChanger')
                    Citizen.Wait(4500)
					setUniform('Vigneron_wear', playerPed)
					ESX.ShowNotification('~g~Pret à travailler')
				end,
			},		
		},
	})
	lib.showContext('VetementVigneron')
end)

function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            end

            if job == 'Vigneron_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            end

            if job == 'Vigneron_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end

-- Cet événement démarre la barre de compétences côté client
RegisterNetEvent('NSX:VettementChanger')
AddEventHandler('NSX:VettementChanger', function()
    TriggerEvent('NSX:Animation:vettements')

    lib.progressCircle({
        duration = 4500,
        label = "S'habille",
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    })

    TriggerEvent('NSX:stopvettement:Animation')
end)

RegisterNetEvent("NSX:Animation:vettements")
AddEventHandler("NSX:Animation:vettements", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Freeze le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STRIP_WATCH_STAND", 0, true)
end)


RegisterNetEvent("NSX:stopvettement:Animation")
AddEventHandler("NSX:stopvettement:Animation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)


-- Cet événement démarre la barre de compétences côté client
RegisterNetEvent('NSX:VettementChangerRemet')
AddEventHandler('NSX:VettementChangerRemet', function()
    TriggerEvent('NSX:Animation:deshabille')

    lib.progressCircle({
        duration = 3500,
        label = "Remet ses vettement",
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    })

    TriggerEvent('NSX:deshabillevettement:Animation')
end)

RegisterNetEvent("NSX:Animation:deshabille")
AddEventHandler("NSX:Animation:deshabille", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Freeze le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STRIP_WATCH_STAND", 0, true)
end)

RegisterNetEvent("NSX:deshabillevettement:Animation")
AddEventHandler("NSX:deshabillevettement:Animation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)