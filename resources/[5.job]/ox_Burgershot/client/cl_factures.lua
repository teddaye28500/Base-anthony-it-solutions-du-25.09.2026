RegisterNetEvent('burgershot:sendbill')
AddEventHandler('burgershot:sendbill', function()
	local input = lib.inputDialog(locale("dialogfacture"), { 'Amount' })

	if input then
		local amount = tonumber(input[1])

		if amount == nil or amount < 0 then
			Notification("error", "", locale("montantinvalide"))
		else
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 4.0 then
				Notification("error", "", locale("nobody"))
			else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burgershot', locale("facture"), amount)
			end
		end
	end
end)

---------------Menu F6

RegisterNetEvent('burgershot:annonce')
AddEventHandler('burgershot:annonce', function(data)
    lib.registerContext({
        id = 'Menu Annonce',
        title = 'Menu Annonce',
        onExit = function()
        end,
        options = {
            {
                title = 'Annonce Ouverture',
                description = 'Faire l\'annonce d\'ouverture',
                arrow = true,
                event = "burgershot:ouvert",
            },
            {
                title = 'Annonce Fermeture',
                description = 'Faire l\'annonce de la fermeture',
                arrow = true,
                event = 'burgershot:fermer',
            },
            {
                title = 'Annonce Recrutement',
                description = 'Faire l\'annonce de la fermeture',
                arrow = true,
                event = 'burgershot:recrutement',
            },
            {
                title = 'Annonce Perso',
                description = 'Faire l\'annonce personnalisée',
                arrow = true,
                event = 'burgershot:Annonce',
            },
			{
				title = 'Back',
				icon = 'arrow-left',
				onSelect = function()
					lib.showContext('burgershotf6')
				end
                }
            }
    })

    lib.showContext('Menu Annonce')
end)


function menuf6burgershot()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
        local contextOptions = {
            {
                title = '💻 Annonce',
                description = 'Envoyer une annonce',
                event = 'burgershot:annonce'
            },
            {
                title = '💸 Factures',
                description = 'Crée une facture a un client',
                event = 'burgershot:sendbill'
            }
        }

        lib.registerContext({
            id = 'burgershotf6',
            title = 'Menu BurgerShot',
			options = contextOptions
        })

        lib.showContext('burgershotf6')
    end
end



RegisterCommand("burgershot", function()
    menuf6burgershot()
end)

RegisterKeyMapping("burgershot", "Menu F6 BurgerShot", "keyboard", "F6")

Citizen.CreateThread(function()
    while true do
      local sleep = 0
      if IsControlJustReleased(0, 167) and  not insidee  and ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then  
        lib.showContext('burgershotf6')
      elseif IsControlJustReleased(0, 177) then      
      end  
      Citizen.Wait(sleep)
    end      
  end) 

-----Facture
RegisterNetEvent('burgershot:sendbill')
AddEventHandler('burgershot:sendbill', function()
      local input = lib.inputDialog('Facture BurgerShot', {'Amount'})

           if input then
                local amount = tonumber(input[1])

                if amount == nil or amount < 0 then
					lib.notify({
						title = 'BurgerShot',
						description = 'Montant Invalide!',
						type = 'erorr',
						position = 'top'
					})
                else
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 4.0 then
					lib.notify({
						title = 'BurgerShot',
						description = 'Personne proche!',
						type = 'erorr',
						position = 'top'
					})
                else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burgershot', 'Facture BurgerShot', amount)
            end
        end
    end
end)

RegisterCommand("burgershot", function()
    menuf6burgershot()
end)

RegisterKeyMapping("burgershot", "Menu F6 BurgerShot", "keyboard", "F6")

RegisterNetEvent('burgershot:ouvert')
AddEventHandler('burgershot:ouvert', function()
    TriggerServerEvent('burgershot:Ouvert')
end)

RegisterNetEvent('burgershot:fermer')
AddEventHandler('burgershot:fermer', function()
    TriggerServerEvent('burgershot:Fermer')
end)

RegisterNetEvent('burgershot:recrutement')
AddEventHandler('burgershot:recrutement', function()
    TriggerServerEvent('burgershot:Recrutement')
end)

RegisterNetEvent('burgershot:Annonce')
AddEventHandler('burgershot:Annonce', function()
    local input = lib.inputDialog('Annonce BurgerShot', {'Message'})
    
    if input and input[1] then
        TriggerServerEvent('burgershot:SendAnnonce', input[1])
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