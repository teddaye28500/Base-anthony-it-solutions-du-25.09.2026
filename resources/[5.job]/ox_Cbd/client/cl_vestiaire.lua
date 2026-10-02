
exports.qtarget:AddBoxZone("CbdCloakroom", vector3(184.36138916016, -241.71385192871, 54.069774627686), 2.4, 1, {
	name="CbdCloakroom",
	heading=214.5,
	debugPoly=false,
	minZ=12.98,                    
	maxZ=15.98,
	}, {
		options = {
			{
				event = "cbdclothes",
				icon = "fa-solid fa-shirt",
				label = "Vestiaire",
				job = "cbd",
			},
		},
		distance = 2.5
})

RegisterNetEvent('cbdclothes')
AddEventHandler('cbdclothes', function()
	lib.registerContext({
		id = 'cbdclothes',
		title = 'Vestiaire | Cbd',
		onExit = function()
		end,
		options = {
			{
				title = 'Mes vêtements',
				icon = "fa-solid fa-shirt",
				description = 'Reprendre vos vêtements',
				onSelect = function(args)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						ExecuteCommand('e adjust')
						Wait(4200)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
				end,
			},
			{
				title = 'Tenue de travail',
				icon = "fa-solid fa-shirt",
				onSelect = function(args)
					local playerPed = PlayerPedId()
					ExecuteCommand('e adjust')
					Wait(4200)
					setbahaform('cbd_wear', playerPed)
				end,
			},
		},
	})
	lib.showContext('cbdclothes')
end)

function setbahaform(job, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'cbd_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'cbd_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end