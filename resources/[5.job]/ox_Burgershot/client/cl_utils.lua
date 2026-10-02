lib.locale()

if Config.Framework == "ESX" then 
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "ESXOLD" then
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    end)
end

Notification = function(type, title, text)
    if Config.NotificationType == "ESX" then
        ESX.ShowNotification(text)
    elseif Config.NotificationType == "ox_lib" then
        if type == "info" then
            lib.notify({
                title = title,
                description = text,
                type = "inform"
            })
        elseif type == "error" then
            lib.notify({
                title = title,
                description = text,
                type = "error"
            })
        elseif type == "success" then
            lib.notify({
                title = title,
                description = text,
                type = "success"
            })
        end
    end
end

ProgressBar = function(duration, label)
    if Config.Progress == "ox_lib_bar" then
        lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false
        })
    elseif Config.Progress == "ox_lib_circle" then
        lib.progressCircle({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false
        })
    end
end

CreateThread(function()
	for k,v in pairs(Config.BurgershotStations) do
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


------------------------------------------ Vetements --------------------------------------------

exports.qtarget:AddBoxZone("burgerVetement", vector3(-1198.8000, -903.6001, 12.8861), 0.6, 1, {
	name="burgerVetement",
	heading=35,
	debugPoly=false,
	minZ=7.04,
  maxZ=9.00,
	}, {
		options = {
			{
				event = "burger:vetement",
				icon = "fas fa-tshirt",
				label = "Vetements Burger-Shot",
				job = "burgershot",
			},
		},
		distance = 2.5
})

RegisterNetEvent('burger:vetement')
AddEventHandler('burger:vetement', function()
	lib.registerContext({
		id = 'burgerVetement',
		title = 'Vetements Burger-Shot',
		onExit = function()
		end,
		options = {
			{
				title = 'Vos Vetement',
				icon = "fas fa-tshirt",
				description = 'Prendre vos propre vetement',
				onSelect = function(args)
					lib.progressBar({
						duration = 5000,
						label = 'Entrain de ce changer',
						useWhileDead = false,
						canCancel = true,
						anim = {
							dict = 'clothingshirt',
							clip = 'try_shirt_positive_d'
						},
					})
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
					end)
				end,
			},
			{
				title = 'Vetement Patron',
				icon = "fas fa-tshirt",
				description = 'Vetement Patron',
				onSelect = function(args)
					lib.progressBar({
						duration = 5000,
						label = 'Entrain de ce changer',
						useWhileDead = false,
						canCancel = true,
						anim = {
							dict = 'clothingshirt',
							clip = 'try_shirt_positive_d'
						},
					})
					local playerPed = PlayerPedId()
					setUniform('burgerpatron_wear', playerPed)
					ESX.ShowNotification('Pret a travailler')
				end,
			},
			{
				title = 'Vetement Manager',
				icon = "fas fa-tshirt",
				description = 'Vetement Manager',
				onSelect = function(args)
					lib.progressBar({
						duration = 5000,
						label = 'Entrain de ce changer',
						useWhileDead = false,
						canCancel = true,
						anim = {
							dict = 'clothingshirt',
							clip = 'try_shirt_positive_d'
						},
					})
					local playerPed = PlayerPedId()
					setUniform('burgermanager_wear', playerPed)
					ESX.ShowNotification('Pret a travailler')
				end,
			},
			{
				title = 'Vetement Employer',
				icon = "fas fa-tshirt",
				description = 'Vetement Employer',
				onSelect = function(args)
					lib.progressBar({
						duration = 5000,
						label = 'Entrain de ce changer',
						useWhileDead = false,
						canCancel = true,
						anim = {
							dict = 'clothingshirt',
							clip = 'try_shirt_positive_d'
						},
					})
					local playerPed = PlayerPedId()
					setUniform('burgeremployer_wear', playerPed)
					ESX.ShowNotification('Pret a travailler')
				end,
			},
			{
				title = 'Vetement Interimaire',
				icon = "fas fa-tshirt",
				description = 'Vetement Interimaire',
				onSelect = function(args)
					lib.progressBar({
						duration = 5000,
						label = 'Entrain de ce changer',
						useWhileDead = false,
						canCancel = true,
						anim = {
							dict = 'clothingshirt',
							clip = 'try_shirt_positive_d'
						},
					})
					local playerPed = PlayerPedId()
					setUniform('burgerinterimaire_wear', playerPed)
					ESX.ShowNotification('Pret a travailler')
				end,
			},
		},
	})
	lib.showContext('burgerVetement')
end)


RegisterNetEvent('beancaf:vetement')
AddEventHandler('beancaf:vetement', function()
	local playerPed = PlayerPedId()
	setUniform('burgerpatron_wear', playerPed)
end)

RegisterNetEvent('beancaf:vetement')
AddEventHandler('beancaf:vetement', function()
	local playerPed = PlayerPedId()
	setUniform('burgermanager_wear', playerPed)
end)

RegisterNetEvent('beancaf:vetement')
AddEventHandler('beancaf:vetement', function()
	local playerPed = PlayerPedId()
	setUniform('burgeremployer_wear', playerPed)
end)

RegisterNetEvent('beancaf:vetement')
AddEventHandler('beancaf:vetement', function()
	local playerPed = PlayerPedId()
	setUniform('burgerinterimaire_wear', playerPed)
end)


function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgerpatron_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgerpatron_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end

function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgermanager_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgermanager_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end

function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgeremployer_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgeremployer_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end

function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgerinterimaire_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'burgerinterimaire_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end