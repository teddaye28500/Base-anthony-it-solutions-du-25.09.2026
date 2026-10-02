if Config.Version == "esxold" then
    ESX = nil
    CreateThread(function()
        while ESX == nil do
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
            Wait(100)
        end
    end)
elseif Config.Version == "esxnew" then
    ESX = exports['es_extended']:getSharedObject()
end

RegisterNetEvent('menupatrontaxi')
AddEventHandler('menupatrontaxi', function()
    TriggerEvent('esx_society:openBossMenu', 'taxi', function(data)
	end, { wash = false })
end)

RegisterNetEvent('coffretaxi')
AddEventHandler('coffretaxi', function()
    exports.ox_inventory:openInventory('stash', {id='taxicoffre'})
end)

CreateThread(function()
	for k,v in pairs(Config.TaxiStation) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.Blip.Name)
		EndTextCommandSetBlipName(blip)
	end
end)


---------------Menu F6

RegisterNetEvent('taxi:annonce')
AddEventHandler('taxi:annonce', function(data)
    lib.registerContext({
        id = 'Menu Annonce',
        title = '📢 Menu Annonce',
        onExit = function()
        end,
        options = {
            {
                title = '🚨 Annonce Ouverture',
                description = 'Faire l\'annonce d\'ouverture',
                arrow = true,
                event = "taxi:annonce",
                args = 'ouvert',
            },
            {
                title = '🚨 Annonce Fermeture',
                description = 'Faire l\'annonce de la fermeture',
                arrow = true,
                event = 'taxi:annonce',
                args = 'fermer',
            },
            {
                title = '🚨 Annonce Recrutement',
                description = 'Faire l\'annonce du Recrutement',
                arrow = true,
                event = 'taxi:annonce',
                args = 'recruter',
            },
            {
                title = '🚨 Annonce Perso',
                description = 'Faire l\'annonce personnalisée',
                arrow = true,
                event = 'taxi:annoncePerso',
            },
			{
				title = 'Back',
				icon = 'arrow-left',
				onSelect = function()
					lib.showContext('taxif6')
				end
                }
            }
    })

    lib.showContext('Menu Annonce')
end)


function menuf6taxi()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
        local contextOptions = {
            {
                title = '💻 Annonce',
                description = 'Envoyer une annonce',
                event = 'taxi:annonce'
            },
            {
                title = '💸 Factures',
                description = 'Crée une facture a un client',
                event = 'taxi:sendbill'
            },
			{
                title = '🏁 Commencer à Travailler',
                description = 'Récuperer des clients',
                event = 'startpnj'
            },
			{
                title = '🏁 Arreter de Travailler',
                description = 'Rentrer au depot',
                event = 'stoppnj'
            }
        }

        lib.registerContext({
            id = 'taxif6',
            title = '🚕 Menu taxi 🚕',
			options = contextOptions
        })

        lib.showContext('taxif6')
    end
end



RegisterCommand("taxi", function()
    menuf6taxi()
end)

RegisterKeyMapping("taxi", "Menu F6 taxi", "keyboard", "F6")

Citizen.CreateThread(function()
    while true do
      local sleep = 0
      if IsControlJustReleased(0, 167) and  not insidee  and ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then  
        lib.showContext('taxif6')
      elseif IsControlJustReleased(0, 177) then      
      end  
      Citizen.Wait(sleep)
    end      
  end) 

-----Facture
RegisterNetEvent('taxi:sendbill')
AddEventHandler('taxi:sendbill', function()
      local input = lib.inputDialog('Facture taxi', {'Amount'})

           if input then
                local amount = tonumber(input[1])

                if amount == nil or amount < 0 then
					lib.notify({
						title = 'taxi',
						description = 'Montant Invalide!',
						type = 'erorr',
						position = 'top'
					})
                else
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 4.0 then
					lib.notify({
						title = 'taxi',
						description = 'Personne proche!',
						type = 'erorr',
						position = 'top'
					})
                else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_taxi', 'Facture taxi', amount)
            end
        end
    end
end)

RegisterCommand("taxi", function()
    menuf6taxi()
end)

RegisterKeyMapping("taxi", "Menu F6 taxi", "keyboard", "F6")

-- 📌 Événement client pour envoyer une annonce standard
RegisterNetEvent('taxi:annonce')
AddEventHandler('taxi:annonce', function(type)
    if type == 'ouvert' then
        TriggerServerEvent('taxi:ouvert')
    elseif type == 'fermer' then
        TriggerServerEvent('taxi:fermer')
    elseif type == 'recruter' then
        TriggerServerEvent('taxi:recruter')
    end
end)

-- 📌 Événement client pour une annonce personnalisée
RegisterNetEvent('taxi:annoncePerso')
AddEventHandler('taxi:annoncePerso', function()
    local input = lib.inputDialog('Annonce Taxi', {'Message'})
    if input and input[1] ~= "" then
        TriggerServerEvent('taxiperso', input[1])
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez entrer un message !',
            type = 'error'
        })
    end
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


-- 📌 Comptoir (ox_target)
exports.ox_target:addBoxZone({
    name = "Taxi_Comptoir",
    coords = vector3(Config.comptoir.x, Config.comptoir.y, Config.comptoir.z),
    size = vec3(1.0, 1.0, 1.0),
    rotation = 0.0,
    debug = false,
    options = {
        {
            name = "appel_taxi",
            event = "taxi:clientCall",
            icon = "fas fa-bell",
            label = "Appeler un employé",
            distance = 2.5
        }
    }
})

RegisterNetEvent("taxi:clientCall")
AddEventHandler("taxi:clientCall", function()
    -- Envoie de l'événement serveur
    TriggerServerEvent("taxi:alertEmployees")
    lib.notify({ title = "Taxi", description = "Un employé a été appelé au comptoir.", type = "inform" })
end)

RegisterNetEvent("taxi:notifyEmployee")
AddEventHandler("taxi:notifyEmployee", function()
    -- Notification pour l'employé
    lib.notify({ title = "Taxi", description = "Vous avez été appelé au comptoir.", type = "success" })
end)
