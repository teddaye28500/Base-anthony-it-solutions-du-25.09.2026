ESX = nil



ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'exotic', 'exotic', 'society_exotic', 'society_exotic', 'society_exotic', {type = 'public'})

RegisterNetEvent('WLTD:RemoveItem')
AddEventHandler('WLTD:RemoveItem', function(Nom, Item)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.removeInventoryItem(Item, 1)
end)


RegisterServerEvent('Mechanic:Ouvert')
AddEventHandler('Mechanic:Ouvert', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mecano', '~p~Annonce', 'Le Bennys ouvres c\'est porte ~g~ouvert ~s~!', 'CHAR_CARSITE3', 8)
    end
end)

RegisterServerEvent('Mechanic:Fermer')
AddEventHandler('Mechanic:Fermer', function()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mecano', '~p~Annonce', 'Le Bennys Est Fermer Repasser plus ~g~ouvert ~s~!', 'CHAR_CARSITE3', 8)
    end
end)

RegisterNetEvent('Mecaperso')
AddEventHandler('Mecaperso', function(msg)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mécano', '~p~Annonce', msg, 'CHAR_CARSITE3', 8)
    end
end)


local function itemCount(source, item)
	local ok, count = pcall(function()
		return exports.ox_inventory:Search(source, 'count', item)
	end)
	if ok and type(count) == 'number' then
		return count
	end

	local xPlayer = ESX.GetPlayerFromId(source)
	local data = xPlayer and xPlayer.getInventoryItem(item)
	return (data and data.count) or 0
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	cb(itemCount(source, item))
end)

RegisterNetEvent('exotic:removeChiffon')
AddEventHandler('exotic:removeChiffon', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer or not xPlayer.job or xPlayer.job.name ~= 'exotic' then
		return
	end
	if itemCount(source, 'chiffon') < 1 then
		return
	end

	local removed = exports.ox_inventory:RemoveItem(source, 'chiffon', 1)
	if not removed then
		xPlayer.removeInventoryItem('chiffon', 1)
	end
end)

----gestion


RegisterServerEvent("Ven:Recruit")
AddEventHandler("Ven:Recruit", function(target, job, grade)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.grade_name == "boss" then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent("esx:showNotification", sourceXPlayer.source, "Vous avez ~g~recruté " .. targetXPlayer.name .. ".")
		TriggerClientEvent("esx:showNotification", target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. ".")
	end
end)

RegisterServerEvent("Ven:Promote")
AddEventHandler("Ven:Promote", function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
		TriggerClientEvent("esx:showNotification", sourceXPlayer.source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if sourceXPlayer.job.grade_name == "boss" and sourceXPlayer.job.name == targetXPlayer.job.name then
			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)

			TriggerClientEvent("esx:showNotification", sourceXPlayer.source, "Vous avez ~g~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent("esx:showNotification", target, "Vous avez été ~g~promu par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent("esx:showNotification", sourceXPlayer.source, "Vous navez pas ~r~ autorisation~w~.")
		end
	end
end)

RegisterServerEvent('Ven:Exclude')
AddEventHandler('Ven:Exclude', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"
	if (sourceXPlayer.job.name == targetXPlayer.job.name) then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
	else
		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
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

exports.ox_inventory:RegisterShop('TestShop', {
    name = 'Magasin Exotic',
	id = 1,
    inventory = {
        { name = 'chiffon', price = 10 },
        { name = 'scanner', price = 50 },
        { name = 'oil', price = 10 },
        { name = 'tires', price = 10 },
        { name = 'brake_pads', price = 10 },
        { name = 'brake_discs', price = 15 },
        { name = 'brake_caliper', price = 20 },
        { name = 'transmission_oil', price = 10 },
        { name = 'shock_absorber', price = 15 },
        { name = 'shocks', price = 15 },
        { name = 'springs', price = 15 },
        { name = 'clutch', price = 20 },
        { name = 'air_filter', price = 10 },
        { name = 'fuel_filter', price = 10 },
        { name = 'spark_plugs', price = 10 },
        { name = 'serpentine_belt', price = 10 },
        { name = 'piston', price = 20 },
        { name = 'rod', price = 20 },
        { name = 'gear', price = 20 },
        { name = 'iron', price = 5 },
        { name = 'aluminum', price = 5 },
        { name = 'susp', price = 50 },
        { name = 'susp1', price = 50 },
        { name = 'susp2', price = 50 },
        { name = 'susp3', price = 50 },
        { name = 'susp4', price = 50 },
        { name = 'turbo', price = 80 },
        { name = 'garett', price = 80 },
        { name = 'engine1', price = 120 },
        { name = 'engine2', price = 180 },
        { name = 'engine3', price = 250 },
        { name = 'engine4', price = 350 },
        { name = 'trans1', price = 100 },
        { name = 'trans2', price = 150 },
        { name = 'trans3', price = 220 },
        { name = 'trans4', price = 300 },
        { name = 'brake1', price = 90 },
        { name = 'brake2', price = 140 },
        { name = 'brake3', price = 200 },
        { name = 'brake4', price = 280 },
        { name = 'nitrous', price = 80 },
        { name = 'rwd', price = 60 },
        { name = 'awd', price = 60 },
        { name = 'fwd', price = 60 },
        { name = 'semislick', price = 40 },
        { name = 'slick', price = 40 },
        { name = 'race_brakes', price = 70 },
    },
    locations = {
        vec3(558.87805175781, -171.54510498047, 54.20853729248),
    },
    groups = {
        exotic = 0
    },

	 
})



