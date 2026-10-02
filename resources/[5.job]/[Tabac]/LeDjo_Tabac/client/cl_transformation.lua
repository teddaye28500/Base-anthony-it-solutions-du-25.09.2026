----------------------------------- Vrac Tabac -----------------------------------

exports.qtarget:AddBoxZone("TabacTransformation", vector3(2913.0015, 4475.9683, 47.9749), 1.0 , 1.5, {
	name="TabacTransformation",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "ledjo_tabac:transformation",
				icon = "fa fa-fire",
				label = "Fabrication De Tabac",
				job = "tabac",
			},
		},
	distance = 2.5
})

----------------------------------- Vrac Tabac -----------------------------------

RegisterNetEvent('ledjo_tabac:transformation')
AddEventHandler('ledjo_tabac:transformation', function()
	lib.registerContext({
		id = 'ledjo_tabac:transformation',
		title = 'Tabac',
		onExit = function()
		end,
		options = {
			{
				title = 'Faire Du tabac',
				icon = "fa fa-fire",
				image = "https://cdn.discordapp.com/attachments/1090026904326783039/1125100816404074547/tabac_emiette.png",
				description = Config.Description,
				onSelect = function(args)
                    ESX.TriggerServerCallback('ledjo_tabac:getItemAmount', function(quantity)
                        if quantity >= Config.Quantity then
                    loadDict("mini@repair")
					TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							ESX.ShowNotification('Ah non! Tu a fait tomber la cigarette')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ledjo_tabac:remove', 'item', Config.Quantity, Config.Items)
					TriggerServerEvent('ledjo_tabac:add', 'item', Config.NombreRecu, Config.Recoit)
					ESX.ShowNotification('Sa ce fume comme de l\'air!')
            else
                ESX.ShowNotification('Tu as pas asser d\'ingrédient')
            end
        end, Config.Items)
				end,
			},
		},
	})
	lib.showContext('ledjo_tabac:transformation')
end)

----------------------------------- Cigarettes -----------------------------------

exports.qtarget:AddBoxZone("TabacTransformation2", vector3(2924.5969, 4474.8589, 47.8487), 1.0 , 1.5, {
	name="TabacTransformation2",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "ledjo_tabac:transformation2",
				icon = "fa fa-fire",
				label = "Tuber les cigarettes",
				job = "tabac",
			},
		},
	distance = 2.5
})

----------------------------------- Cigarettes -----------------------------------

RegisterNetEvent('ledjo_tabac:transformation2')
AddEventHandler('ledjo_tabac:transformation2', function()
	lib.registerContext({
		id = 'ledjo_tabac:transformation2',
		title = 'Cigarette',
		onExit = function()
		end,
		options = {
			{
				title = 'Faire Des Cigarette',
				icon = "fa fa-fire",
				image = "https://cdn.discordapp.com/attachments/1055259237816741930/1074460909117919282/CIGARETTE.png",
				description = Config.Description,
				onSelect = function(args)
                    ESX.TriggerServerCallback('ledjo_tabac:getItemAmount', function(quantity)
                        if quantity >= Config.Quantity2 then
                    loadDict("mini@repair")
					TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							ESX.ShowNotification('Ah non! Tu a fait tomber la cigarette')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ledjo_tabac:remove', 'item', Config.Quantity2, Config.Items2)
					TriggerServerEvent('ledjo_tabac:add', 'item', Config.NombreRecu2, Config.Recoit2)
					ESX.ShowNotification('Sa ce fume comme de l\'air!')
            else
                ESX.ShowNotification('Tu as pas asser d\'ingrédient')
            end
        end, Config.Items2)
				end,
			},
		},
	})
	lib.showContext('ledjo_tabac:transformation2')
end)

----------------------------------- Packet de Clope -----------------------------------

exports.qtarget:AddBoxZone("TabacTransformation3", vector3(2922.7349, 4473.2271, 47.8618), 1.0 , 1.5, {
	name="TabacTransformation3",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "ledjo_tabac:transformation3",
				icon = "fa fa-fire",
				label = "Packet de Cigarettes",
				job = "tabac",
			},
		},
	distance = 2.5
})

----------------------------------- Packet de Clope -----------------------------------

RegisterNetEvent('ledjo_tabac:transformation3')
AddEventHandler('ledjo_tabac:transformation3', function()
	lib.registerContext({
		id = 'ledjo_tabac:transformation3',
		title = 'Packet de Cigarettes',
		onExit = function()
		end,
		options = {
			{
				title = 'Faire Des Packet de Cigarettes',
				icon = "fa fa-fire",
				image = "https://cdn.discordapp.com/attachments/1090026904326783039/1125100817628790794/pacquet.png",
				description = Config.Description,
				onSelect = function(args)
                    ESX.TriggerServerCallback('ledjo_tabac:getItemAmount', function(quantity)
                        if quantity >= Config.Quantity3 then
                    loadDict("mini@repair")
					TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							ESX.ShowNotification('Ah non! Tu a fait tomber la cigarette')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ledjo_tabac:remove', 'item', Config.Quantity3, Config.Items3)
					TriggerServerEvent('ledjo_tabac:add', 'item', Config.NombreRecu3, Config.Recoit3)
					ESX.ShowNotification('Sa ce fume comme de l\'air!')
            else
                ESX.ShowNotification('Tu as pas asser d\'ingrédient')
            end
        end, Config.Items3)
				end,
			},
		},
	})
	lib.showContext('ledjo_tabac:transformation3')
end)

----------------------------------- Cartouche de Clope -----------------------------------

exports.qtarget:AddBoxZone("TabacTransformation4", vector3(2919.0103, 4470.1982, 48.0887), 1.0 , 1.5, {
	name="TabacTransformation4",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "ledjo_tabac:transformation4",
				icon = "fa fa-fire",
				label = "Cartouche de Cigarettes",
				job = "tabac",
			},
		},
	distance = 2.5
})

----------------------------------- Cartouche de Clope -----------------------------------

RegisterNetEvent('ledjo_tabac:transformation4')
AddEventHandler('ledjo_tabac:transformation4', function()
	lib.registerContext({
		id = 'ledjo_tabac:transformation4',
		title = 'Cartouche de Cigarettes',
		onExit = function()
		end,
		options = {
			{
				title = 'Faire une Cartouche de Cigarettes',
				icon = "fa fa-fire",
				image = "https://cdn.discordapp.com/attachments/1090026904326783039/1125100817226158080/cigarette_cartouche.png",
				description = Config.Description,
				onSelect = function(args)
                    ESX.TriggerServerCallback('ledjo_tabac:getItemAmount', function(quantity)
                        if quantity >= Config.Quantity4 then
                    loadDict("mini@repair")
					TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							ESX.ShowNotification('Ah non! Tu a fait tomber la cigarette')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ledjo_tabac:remove', 'item', Config.Quantity4, Config.Items4)
					TriggerServerEvent('ledjo_tabac:add', 'item', Config.NombreRecu4, Config.Recoit4)
					ESX.ShowNotification('Sa ce fume comme de l\'air!')
            else
                ESX.ShowNotification('Tu as pas asser d\'ingrédient')
            end
        end, Config.Items4)
				end,
			},
		},
	})
	lib.showContext('ledjo_tabac:transformation4')
end)
