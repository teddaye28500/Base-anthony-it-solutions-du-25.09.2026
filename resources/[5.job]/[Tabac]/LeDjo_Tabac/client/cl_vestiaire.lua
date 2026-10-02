exports.qtarget:AddBoxZone("TabacVetement", vector3(2899.029541, 4412.943359, 50.285557), 1.0 , 1.5, {
	name="TabacVetement",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "ledjo_tabac:vetement",
				icon = "fas fa-tshirt",
				label = "Vetements Tabac",
				job = "tabac",
			},
		},
		distance = 2.5
})

RegisterNetEvent('ledjo_tabac:vetement')
AddEventHandler('ledjo_tabac:vetement', function()
	lib.registerContext({
		id = 'TabacVetement',
		title = 'Vetements Tabac',
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
				title = 'Tabac Vetement',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('tabac_wear', playerPed)
					ESX.ShowNotification('Pret a travailler')
				end,
			},
		},
	})
	lib.showContext('TabacVetement')
end)


RegisterNetEvent('tabac:vetement')
AddEventHandler('tabac:vetement', function()
	local playerPed = PlayerPedId()
	setUniform('tabac_wear', playerPed)
end)


function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'tabac_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification("Pas de vetement")
            end

            if job == 'tabac_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end
