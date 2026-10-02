ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

local Recruit = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
            lib.notify({
                title = 'Mécano Infos',
                description = 'Aucun joueur autour',
                position = 'top',
                type = 'error'
            })
        else
            TriggerServerEvent('Ven:Recruit', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 0)
        end
    end
end

local Promote = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestDistance > 3.0 then
            lib.notify({
                title = 'Mécano Infos',
                description = 'Aucun joueur autour',
                position = 'top',
                type = 'error'
            })
        else
            TriggerServerEvent('Ven:Promote', GetPlayerServerId(closestPlayer))
        end
    end
end

local Recruit = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
            lib.notify({
                title = 'Mécano Infos',
                description = 'Aucun joueur autour',
                position = 'top',
                type = 'error'
            })
        else
            TriggerServerEvent('Ven:Recruit', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 0)
        end
    end
end

local Exclude = function()
    if ESX.PlayerData.job.grade_name == 'boss' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestDistance > 3.0 then
            lib.notify({
                title = 'Mécano Infos',
                description = 'Aucun joueur autour',
                position = 'top',
                type = 'error'
            })
        else
            TriggerServerEvent('Ven:Exclude', GetPlayerServerId(closestPlayer))
        end
    end
end

RegisterNetEvent('white:gestion', function(data)
	lib.registerContext({
		id = 'Menu Annonce',
		title = 'Menu Annonce',
		onExit = function()
			print('Hello there')
		end,
    options = {
      {
        title = 'Recruter', 
        icon = "user-plus",
        iconColor = "green",
        description = 'Recruter un membre',
        onSelect = function()
            Recruit()
        end
      },
      {
        title = 'Promouvoir',
        icon = "user-pen",
        iconColor = "blue",
        description = 'Promouvoir un membre',
        onSelect = function()
            Promote()
        end
      },
      {
        title = 'Virer',
        icon = "user-minus",
        iconColor = "red",
        description = 'Virer un membre',
        onSelect = function()
            Exclude()
        end
      },
      {
        title = 'Go Back',
        menu = 'mecanof6',
      }
    },
})

lib.showContext('Menu Annonce')

end)





