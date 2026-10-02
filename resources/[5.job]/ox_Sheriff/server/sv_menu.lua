RegisterServerEvent('oxysheriff:add')
AddEventHandler('oxysheriff:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)

--#######################################
--################# Duty ################
--#######################################

RegisterServerEvent('oxy:sheriffduty')
AddEventHandler('oxy:sheriffduty', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    if job == 'sheriff' then
        xPlayer.setJob('off' ..job, grade)	
		--sendNotification(source, "info", "", Config.DutyOff)
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Fin de service',
            description = '' .. Config.DutyOff .. ' ',
            position = 'top',
            type = 'info'
          })	
    elseif job == 'offsheriff' then
        xPlayer.setJob('sheriff', grade)
		--sendNotification(source, "info", "", Config.DutyOn)
        TriggerClientEvent('ox_lib:notify', source, {
        title = 'Prise de service',
        description = '' .. Config.DutyOn .. ' ',
        position = 'top',
        type = 'info'
    })
	end
end)

--############################
--########## Renfort #########
--############################

RegisterServerEvent('sheriff:renfortDemande')
AddEventHandler('sheriff:renfortDemande', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'sheriff' then
        local xPlayers = ESX.GetPlayers()
        local coords = GetEntityCoords(GetPlayerPed(source))
        for i = 1, #xPlayers, 1 do
            local target = ESX.GetPlayerFromId(xPlayers[i])
            if target.job.name == 'sheriff' then
                TriggerClientEvent('sheriff:setBlip', xPlayers[i], coords)
            end
        end
    end
end)

--############################
--######## Recrutement #######
--############################

RegisterServerEvent("sheriff:Recruit")
AddEventHandler("sheriff:Recruit", function(target, job, grade)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if sourceXPlayer.job.grade_name == "boss" then
        targetXPlayer.setJob(job, grade)

        -- Utiliser la bibliothèque "ox_lib:notify" ici
        TriggerClientEvent("ox_lib:notify", sourceXPlayer.source, {
            title = "Recrutement",
            description = "Vous avez recruté " .. targetXPlayer.name .. ".",
            position = "top",
            icon = "users",
            type = "success"
        })

        TriggerClientEvent("ox_lib:notify", targetXPlayer.source, {
            title = "Recrutement",
            description = "Vous avez été embauché par " .. sourceXPlayer.name .. ".",
            position = "top",
            icon = "users",
            type = "success"
        })
    end
end)


RegisterServerEvent("sheriff:Promote")
AddEventHandler("sheriff:Promote", function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
        TriggerClientEvent("ox_lib:notify", sourceXPlayer.source, {
            title = "Promotion",
            description = "Vous devez demander une autorisation du Gouvernement.",
            position = "top",
            icon = "users",
            type = "error"
        })
    else
        if sourceXPlayer.job.grade_name == "boss" and sourceXPlayer.job.name == targetXPlayer.job.name then
            targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)

            TriggerClientEvent("ox_lib:notify", sourceXPlayer.source, {
                title = "Promotion",
                description = "Vous avez promu " .. targetXPlayer.name .. ".",
                position = "top",
                icon = "users",
                type = "success"
            })

            TriggerClientEvent("ox_lib:notify", targetXPlayer.source, {
                title = "Promotion",
                description = "Vous avez été promu par " .. sourceXPlayer.name .. ".",
                position = "top",
                icon = "users",
                type = "success"
            })
        else
            TriggerClientEvent("ox_lib:notify", sourceXPlayer.source, {
                title = "Promotion",
                description = "Vous n'avez pas l'autorisation.",
                position = "top",
                icon = "users",
                type = "error"
            })
        end
    end
end)


RegisterServerEvent('sheriff:Exclude')
AddEventHandler('sheriff:Exclude', function(target)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local job = "unemployed"
    local grade = "0"

    if (sourceXPlayer.job.name == targetXPlayer.job.name) then
        targetXPlayer.setJob(job, grade)

        TriggerClientEvent('ox_lib:notify', _source, {
            title = "Exclusion",
            description = "Vous avez viré " .. targetXPlayer.name .. ".",
            position = "top",
            icon = "users",
            type = "error"
        })

        TriggerClientEvent('ox_lib:notify', target, {
            title = "Exclusion",
            description = "Vous avez été viré par " .. sourceXPlayer.name .. ".",
            position = "top",
            icon = "users",
            type = "error"
        })
    else
        TriggerClientEvent('ox_lib:notify', _source, {
            title = "Exclusion",
            description = "Vous n'avez pas l'autorisation.",
            position = "top",
            icon = "users",
            type = "error"
        })
    end
end)


function getMaximumGrade(jobname)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @jobname ORDER BY `grade` DESC ;', {
		['@jobname'] = jobname
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	if queryResult[1] then
		return queryResult[1].grade
	end

	return nil
end


--##############################
--########### Annonces #########
--##############################

RegisterServerEvent('Sheriff:Ouvert')
AddEventHandler('Sheriff:Ouvert', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sheriff', 'Annonce', 'Le Sheriff est ouvert !', 'CHAR_TREVOR', 8)
       end
  end)


RegisterServerEvent('Sheriff:Fermer')
AddEventHandler('Sheriff:Fermer', function()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sheriff', '~p~Sheriff', 'Le Sheriff est fermer repasser plus tard !', 'CHAR_TREVOR', 8)
    end
end)

RegisterNetEvent('Sheriffperso')
AddEventHandler('Sheriffperso', function(msg)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sheriff', '~p~Annonce', msg, 'CHAR_TREVOR', 8)
    end
end)



--#############################
--########### ESCORTE #########
--#############################


RegisterNetEvent('esx_sheriffjob:handcuff')
AddEventHandler('esx_sheriffjob:handcuff', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'sheriff' then
        TriggerClientEvent('esx_sheriffjob:handcuff', target)
    else
        print(('esx_sheriffjob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
    end
end)

RegisterNetEvent('esx_sheriffjob:drag')
AddEventHandler('esx_sheriffjob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:drag', target, source)
	else
		print(('esx_sheriffjob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

--##############################
--########### MENOTTER #########
--##############################

RegisterServerEvent('esx_sheriffjob:requestarrest')
AddEventHandler('esx_sheriffjob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_sheriffjob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_sheriffjob:doarrested', _source)
end)

--################################
--########### DEMENOTTER #########
--################################

RegisterServerEvent('esx_sheriffjob:requestrelease')
AddEventHandler('esx_sheriffjob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_sheriffjob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_sheriffjob:douncuffing', _source)
end)

--#############################
--########### ESCORTE #########
--#############################

RegisterNetEvent('esx_sheriffjob:putInVehicle')
AddEventHandler('esx_sheriffjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:putInVehicle', target)
	else
		print(('esx_sheriffjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_sheriffjob:OutVehicle')
AddEventHandler('esx_sheriffjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:OutVehicle', target)
	else
		print(('esx_sheriffjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)


