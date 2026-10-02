local staffModeStates = {}

RegisterServerEvent('menu_admin:enableStaffMode')
AddEventHandler('menu_admin:enableStaffMode', function()
    local source = source
    staffModeStates[source] = true
end)

RegisterServerEvent('menu_admin:disableStaffMode')
AddEventHandler('menu_admin:disableStaffMode', function()
    local source = source
    staffModeStates[source] = false
end)

RegisterServerEvent('getStaffModeState')
AddEventHandler('getStaffModeState', function()
    local source = source
    local isStaffModeEnabled = staffModeStates[source] or false
    TriggerClientEvent('receiveStaffModeState', source, isStaffModeEnabled)
end)

ESX.RegisterServerCallback('getPlayerGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    cb(playerGroup)
end)

ESX.RegisterServerCallback('esx_adminmenu:getPlayerData', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        local data = {
            job = xPlayer.job.name,
            jobGrade = xPlayer.job.grade_label,
            group = xPlayer.getGroup(),
        }
        cb(data)
    else
        cb(nil)
    end
end)

RegisterNetEvent('menu_admin:manageUsers')
AddEventHandler('menu_admin:manageUsers', function()
    local source = source
    local players = GetPlayers()
    local playerInfo = {}

    for _, playerID in ipairs(players) do
        local playerName = GetPlayerName(playerID)
        
        local esxPlayer = ESX.GetPlayerFromId(playerID)
        local playerGroup, job, job_grade, job_label, grade_label, firstname, lastname, identifier
        if esxPlayer then
            playerGroup = esxPlayer.getGroup()
            job = esxPlayer.job.name
            job_grade = esxPlayer.job.grade
            identifier = esxPlayer.identifier
            
            local jobResult = MySQL.Sync.fetchAll("SELECT label FROM jobs WHERE name = @name", {['@name'] = job})
            if jobResult[1] then
                job_label = jobResult[1].label
            end

            local gradeResult = MySQL.Sync.fetchAll("SELECT label FROM job_grades WHERE job_name = @job_name AND grade = @grade", {['@job_name'] = job, ['@grade'] = job_grade})
            if gradeResult[1] then
                grade_label = gradeResult[1].label
            end

            local nameResult = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
            if nameResult[1] then
                firstname = nameResult[1].firstname
                lastname = nameResult[1].lastname
            end
        else
            playerGroup = "unknown"
            job = "unknown"
            job_label = "unknown"
            job_grade = "unknown"
            grade_label = "unknown"
            firstname = "unknown"
            lastname = "unknown"
            identifier = "unknown"
        end

        table.insert(playerInfo, {id = playerID, name = playerName, group = playerGroup, job = job, job_label = job_label, job_grade = job_grade, grade_label = grade_label, firstname = firstname, lastname = lastname, identifier = identifier})
    end

    TriggerClientEvent('menu_admin:showUserManager', source, playerInfo)
end)

RegisterNetEvent('menu_admin:teleportToPosition')
AddEventHandler('menu_admin:teleportToPosition', function(playerID, position)
    local xPlayer = ESX.GetPlayerFromId(playerID)

    if xPlayer then
        xPlayer.setCoords(position)
    else
        print('Player not found: ', playerID)
    end
end)

RegisterNetEvent('menu_admin:getPlayerPosition')
AddEventHandler('menu_admin:getPlayerPosition', function(targetPlayerID)
    local xPlayer = ESX.GetPlayerFromId(targetPlayerID)

    if xPlayer then
        local targetPlayerPosition = xPlayer.getCoords(true)
        local sourcePlayerID = source

        TriggerClientEvent('menu_admin:teleportToPosition', sourcePlayerID, targetPlayerPosition)
    else
        print('Player not found: ', targetPlayerID)
    end
end)

function isValidJobAndGrade(job, grade)
    local jobResult = MySQL.Sync.fetchAll("SELECT * FROM jobs WHERE name = @name", {['@name'] = job})
    local gradeResult = MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name = @job_name AND grade = @grade", {['@job_name'] = job, ['@grade'] = grade})

    if jobResult[1] and gradeResult[1] then
        return true
    else
        return false
    end
end

RegisterServerEvent('menu_admin:validateAndSetJobAndGrade')
AddEventHandler('menu_admin:validateAndSetJobAndGrade', function(playerId, job, grade)
    if isValidJobAndGrade(job, grade) then
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if not ESX.DoesJobExist(job, tonumber(grade)) then
            print("Job or grade is invalid")
            return
        end

        xPlayer.setJob(job, tonumber(grade))
        print("Successfully set job and grade for player")
    else
        print("Job or grade is invalid")
    end
end)

RegisterServerEvent('menu_admin:giveMoney')
AddEventHandler('menu_admin:giveMoney', function(targetId, account, amount)
    local xPlayer = ESX.GetPlayerFromId(targetId)
    if xPlayer then
        if not xPlayer.getAccount(account) then
            print('Invalid account')
            return
        end
        xPlayer.addAccountMoney(account, amount, "Government Grant")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Give Account Money /giveaccountmoney Triggered!", "pink", {
                { name = "Player",  value = xPlayer.name,       inline = true },
                { name = "ID",      value = xPlayer.source,     inline = true },
                { name = "Target",  value = xPlayer.name, inline = true },
                { name = "Account", value = account,       inline = true },
                { name = "Amount",  value = amount,        inline = true },
            })
        end
    else
        print('Player not found')
    end
end)

RegisterServerEvent('menu_admin:openWeaponsShopAdmin')
AddEventHandler('menu_admin:openWeaponsShopAdmin', function()
    local source = source
    Config.Shops.WeaponsShopAdmin(source) 
end)

ESX.RegisterServerCallback('menu_admin:giveWeaponItem', function(source, cb, targetPlayerId, itemType, itemName, itemCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetPlayerId)

    if itemType == 'item_weapon' and targetPlayer then
        targetPlayer.addInventoryItem(itemName, itemCount)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('menu_admin:openAmmoShopAdmin')
AddEventHandler('menu_admin:openAmmoShopAdmin', function()
    local source = source
    Config.Shops.AmmoShopAdmin(source)
end)

ESX.RegisterServerCallback('menu_admin:giveAmmoItem', function(source, cb, targetPlayerId, itemType, itemName, itemCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetPlayerId)

    if itemType == 'item_ammo' and targetPlayer then
        targetPlayer.addInventoryItem(itemName, itemCount)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('menu_admin:openItemShopAdmin')
AddEventHandler('menu_admin:openItemShopAdmin', function()
    local source = source
    Config.Shops.ItemShopAdmin(source)
end)

ESX.RegisterServerCallback('menu_admin:giveItem', function(source, cb, targetPlayerId, itemType, itemName, itemCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetPlayerId)

    if itemType == 'item' and targetPlayer then
        targetPlayer.addInventoryItem(itemName, itemCount)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('menu_admin:validateAndSetGroup')
AddEventHandler('menu_admin:validateAndSetGroup', function(targetId, groupName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if isInList(Config.Groups.CanChangeGroups, xPlayer.getGroup()) then
        if targetPlayer then
            targetPlayer.setGroup(groupName)
            xPlayer.showNotification('Vous avez défini le groupe de ' .. targetPlayer.getName() .. ' à ' .. groupName)
        else
            xPlayer.showNotification('Aucun joueur avec cet ID trouvé')
        end
    else
        xPlayer.showNotification('Vous n\'avez pas la permission pour faire ça')
    end
end)

local jailedPlayers = {}

local function jailPlayer(source, targetId, jailTime, reason, position)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    local targetName = GetPlayerName(targetId)
    local jailerName = GetPlayerName(source)

    MySQL.Async.execute('INSERT INTO jail (identifier, name, jailTime, reason, jailer) VALUES (@identifier, @name, @jailTime, @reason, @jailer)', {
        ['@identifier'] = targetPlayer.getIdentifier(),
        ['@name'] = targetName,
        ['@jailTime'] = jailTime,
        ['@reason'] = reason,
        ['@jailer'] = jailerName
    })

    targetPlayer.setCoords(position)

    jailedPlayers[targetId] = {releaseTime = os.time() + jailTime * 60, isJailed = true, manualUnjail = false}

    xPlayer.showNotification('Vous avez emprisonné ' .. targetName .. ' pour ' .. jailTime .. ' minutes pour la raison suivante : ' .. reason)
    
    TriggerClientEvent('showJailMessage', targetId, jailerName, jailTime, reason)
end

local function unjailPlayer(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        if jailedPlayers[xPlayer.source] then
            jailedPlayers[xPlayer.source].manualUnjail = true
        end

        local position = {
            x = 1847.9,
            y = 2586.2,
            z = 45.7
        }

        xPlayer.setCoords(position)

        MySQL.Async.execute('DELETE FROM jail WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        })

        TriggerClientEvent('unjailPlayer', xPlayer.source)
        
        TriggerClientEvent('showReleaseMessage', xPlayer.source)
    end
end

RegisterServerEvent('menu_admin:jailPlayer')
AddEventHandler('menu_admin:jailPlayer', function(playerID, jailTime, reason, position)
    local source = source
    local targetPlayer = ESX.GetPlayerFromId(playerID)

    if targetPlayer and jailTime and reason then
        jailPlayer(source, playerID, jailTime, reason, position)
    else
        print("Erreur: ID de joueur, Temps ou raison invalide")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        for playerId, data in pairs(jailedPlayers) do
            if data.manualUnjail == false and os.time() >= data.releaseTime then
                local xPlayer = ESX.GetPlayerFromId(playerId)

                if xPlayer then
                    MySQL.Async.fetchScalar('SELECT identifier FROM jail WHERE identifier = @identifier', {
                        ['@identifier'] = xPlayer.getIdentifier()
                    }, function(result)
                        if result then
                            local position = {
                                x = 1847.9,
                                y = 2586.2,
                                z = 45.7
                            }

                            xPlayer.setCoords(position)

                            MySQL.Async.execute('DELETE FROM jail WHERE identifier = @identifier', {
                                ['@identifier'] = xPlayer.getIdentifier()
                            })

                            jailedPlayers[playerId] = nil

                            TriggerClientEvent('showReleaseMessage', playerId)
                        end
                    end)
                end
            end
        end
    end
end)

RegisterNetEvent('requestJailLog')
AddEventHandler('requestJailLog', function()
  local source = source 
  MySQL.Async.fetchAll('SELECT * FROM jail', {}, function(result)
    TriggerClientEvent('showJailLogMenu', source, result)
  end)
end)

RegisterNetEvent('unjailPlayer')
AddEventHandler('unjailPlayer', function(identifier)
    unjailPlayer(identifier)
end)

RegisterServerEvent('menu_admin:kickPlayer')
AddEventHandler('menu_admin:kickPlayer', function(playerIdToKick)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and isInList(Config.Groups.CanKickPlayers, xPlayer.getGroup()) then
        local adminName = GetPlayerName(source)
        DropPlayer(playerIdToKick, "Vous avez été kické par " .. adminName .. ".")
    else
        print("Tentative de kick sans permission de : " .. GetPlayerName(source))
    end
end)

RegisterServerEvent('menu_admin:banPlayer')
AddEventHandler('menu_admin:banPlayer', function(playerIdToBan, reason, hours, permanent)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and isInList(Config.Groups.CanBanPlayers, xPlayer.getGroup()) then
        local identifier, char1, ip = '', '', GetPlayerEP(playerIdToBan)
        local playerName = GetPlayerName(playerIdToBan)
        local adminName = GetPlayerName(source)
        local banTime = os.time()
        local expireTime = permanent and -1 or (banTime + hours * 60 * 60)
        local guid = GetPlayerGuid(playerIdToBan)
        local xbl, discord, live, fivem = '', '', '', ''

        for k, v in pairs(GetPlayerIdentifiers(playerIdToBan)) do
            if string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
                xbl = v
            elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
                discord = v
            elseif string.sub(v, 1, string.len('live:')) == 'live:' then
                live = v
            elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
                fivem = v
            elseif string.sub(v, 1, string.len('license:')) == 'license:' then
                char1 = string.gsub(v, 'license:', '')
            elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
                identifier = string.gsub(v, 'steam:', '')
            end
        end

        local banId = identifier ~= '' and identifier or (char1 ~= '' and char1 or ip)

        MySQL.Async.execute('INSERT INTO banlist (identifier, playerName, reason, banTime, expireTime, adminName, xbl, discord, live, fivem, char1, ip, guid) VALUES (@identifier, @playerName, @reason, @banTime, @expireTime, @adminName, @xbl, @discord, @live, @fivem, @char1, @ip, @guid)', {
            ['@identifier'] = banId,
            ['@playerName'] = playerName,
            ['@reason'] = reason,
            ['@banTime'] = banTime,
            ['@expireTime'] = expireTime,
            ['@adminName'] = adminName,
            ['@xbl'] = xbl,
            ['@discord'] = discord,
            ['@live'] = live,
            ['@fivem'] = fivem,
            ['@char1'] = char1,
            ['@ip'] = ip,
            ['@guid'] = guid
        }, function(rowsChanged)
            if permanent then
                DropPlayer(playerIdToBan, "Vous avez été banni par " .. adminName .. " pour la raison : " .. reason .. ". Le bannissement est permanent.")
            else
                DropPlayer(playerIdToBan, "Vous avez été banni par " .. adminName .. " pour la raison : " .. reason .. ". Le bannissement expirera dans " .. hours .. " heures.")
            end
        end)
    else
        print("Tentative de ban sans permission de : " .. GetPlayerName(source))
    end
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    deferrals.defer()

    local identifier, xbl, discord, live, fivem, ip, guid, char1 = '', '', '', '', '', '', '', ''

    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len('steam:')) == 'steam:' then
            identifier = v
        elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
            xbl = v
        elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
            discord = v
        elseif string.sub(v, 1, string.len('live:')) == 'live:' then
            live = v
        elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
            fivem = v
        elseif string.sub(v, 1, string.len('license:')) == 'license:' then
            char1 = string.gsub(v, 'license:', '')
        end
    end

    ip = GetPlayerEP(source)
    guid = GetPlayerGuid(source)

    MySQL.Async.fetchAll('SELECT * FROM banlist WHERE identifier = @identifier OR xbl = @xbl OR discord = @discord OR live = @live OR fivem = @fivem OR char1 = @char1 OR ip = @ip OR guid = @guid', {
        ['@identifier'] = identifier,
        ['@xbl'] = xbl,
        ['@discord'] = discord,
        ['@live'] = live,
        ['@fivem'] = fivem,
        ['@char1'] = char1,
        ['@ip'] = ip,
        ['@guid'] = guid
    }, function(result)
        if result[1] then
            if result[1].expireTime == -1 then
                deferrals.done("Vous avez été banni pour la raison : " .. result[1].reason .. ". Le bannissement est permanent.")
            elseif result[1].expireTime > os.time() then
                local timeLeft = os.difftime(result[1].expireTime, os.time())
                local hoursLeft = math.floor(timeLeft / 3600)
                local minutesLeft = math.floor((timeLeft % 3600) / 60)
                deferrals.done("Vous avez été banni pour la raison : " .. result[1].reason .. ". Le bannissement expirera dans " .. hoursLeft .. " heures et " .. minutesLeft .. " minutes.")
            else
                MySQL.Async.execute('DELETE FROM banlist WHERE identifier = @identifier', {
                    ['@identifier'] = identifier
                }, function(rowsChanged)
                    deferrals.done()
                end)
            end
        else
            deferrals.done()
        end
    end)
end)

RegisterServerEvent('requestBanList')
AddEventHandler('requestBanList', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer and isInList(Config.Groups.BanList, xPlayer.getGroup()) then
        MySQL.Async.fetchAll('SELECT * FROM banlist', {}, function(result)
            if result then
                for i=1, #result, 1 do
                    result[i].banTime = os.date('%Y-%m-%d %H:%M:%S', result[i].banTime)
                    result[i].expireTime = result[i].expireTime == -1 and "Permanent" or os.date('%Y-%m-%d %H:%M:%S', result[i].expireTime)
                end

                TriggerClientEvent('showBanLogMenu', _source, result)
            else
                print("Aucun ban enregistré.")
            end
        end)
    else
        print("Tentative de consultation de la liste des bans sans permission de : " .. GetPlayerName(_source))
    end
end)

RegisterServerEvent('unbanPlayer')
AddEventHandler('unbanPlayer', function(identifier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer and isInList(Config.Groups.BanList, xPlayer.getGroup()) then
        MySQL.Async.execute('DELETE FROM banlist WHERE identifier = @identifier OR discord = @identifier OR char1 = @identifier', 
            { ['@identifier'] = identifier }, 
            function(rowsChanged)
                if rowsChanged > 0 then
                    print("Le joueur a été débanni.")
                else
                    print("Erreur lors du débanissement du joueur.")
                end
            end
        )
    else
        print("Tentative de débanissement sans permission de : " .. GetPlayerName(_source))
    end
end)

RegisterCommand('report', function(source, args, rawCommand)
    local reason = table.concat(args, ' ')

    local identifiers = GetPlayerIdentifiers(source)
    
    local license = nil
    for i = 1, #identifiers do
        if string.sub(identifiers[i], 1, 8) == 'license:' then
            license = identifiers[i]
            break
        end
    end

    local playerName = GetPlayerName(source)

    MySQL.Async.execute('INSERT INTO reports (player_id, player_name, license, reason) VALUES (@player_id, @player_name, @license, @reason)', {
        ['@player_id'] = source,
        ['@player_name'] = playerName,
        ['@license'] = license,
        ['@reason'] = reason
    }, function(rowsChanged)
        TriggerClientEvent('menuAdmin:showReportNotification', -1, playerName, source, reason)
    end)
end, false)

RegisterServerEvent('menu_admin:requestReports')
AddEventHandler('menu_admin:requestReports', function()
    local source = source

    MySQL.Async.fetchAll('SELECT * FROM reports', {}, function(reports)
        TriggerClientEvent('menu_admin:receiveReports', source, reports)
    end)
end)

RegisterServerEvent('menu_admin:takeReport')
AddEventHandler('menu_admin:takeReport', function(reportId, adminName)
    MySQL.Async.execute('UPDATE reports SET admin_name = @admin_name WHERE id = @id', {
        ['@id'] = reportId,
        ['@admin_name'] = adminName
    }, function(rowsChanged)
        if rowsChanged > 0 then
            print("Report #" .. reportId .. " has been taken by " .. adminName)
            TriggerClientEvent('menu_admin:reportUpdated', -1, reportId, adminName)
        else
            print("No report found with id: " .. reportId)
        end
    end)
end)

RegisterServerEvent('menu_admin:closeReport')
AddEventHandler('menu_admin:closeReport', function(reportId)
    MySQL.Async.execute('DELETE FROM reports WHERE id = @id', {
        ['@id'] = reportId
    }, function(rowsChanged)
        if rowsChanged > 0 then
            print("Report #" .. reportId .. " has been closed.")
        else
            print("No report found with id: " .. reportId)
        end
    end)
end)

RegisterServerEvent('menu_admin:getResources')
AddEventHandler('menu_admin:getResources', function()
    local source = source

    local resources = {}

    local numResources = GetNumResources()

    for i = 0, numResources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        table.insert(resources, resourceName)
    end

    TriggerClientEvent('menu_admin:showResources', source, resources)
end)

RegisterServerEvent('menu_admin:banPlayerOffline')
AddEventHandler('menu_admin:banPlayerOffline', function(playerNameToBan, reason, hours, permanent)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and isInList(Config.Groups.SettingsMenu, xPlayer.getGroup()) then
        local identifiers = searchForPlayerIdentifiers(playerNameToBan)
        if identifiers then
            local identifier, char1, ip, xbl, discord, live, fivem = identifiers.identifier, identifiers.char1, identifiers.ip, identifiers.xbl, identifiers.discord, identifiers.live, identifiers.fivem
            local adminName = GetPlayerName(source)
            local banTime = os.time()
            local expireTime = permanent and -1 or (banTime + hours * 60 * 60)
            local guid = identifiers.guid

            local banId = identifier ~= '' and identifier or (char1 ~= '' and char1 or ip)

            MySQL.Async.execute('INSERT INTO banlist (identifier, playerName, reason, banTime, expireTime, adminName, xbl, discord, live, fivem, char1, ip, guid) VALUES (@identifier, @playerName, @reason, @banTime, @expireTime, @adminName, @xbl, @discord, @live, @fivem, @char1, @ip, @guid)', {
                ['@identifier'] = banId,
                ['@playerName'] = identifiers.name, 
                ['@reason'] = reason,
                ['@banTime'] = banTime,
                ['@expireTime'] = expireTime,
                ['@adminName'] = adminName,
                ['@xbl'] = xbl,
                ['@discord'] = discord,
                ['@live'] = live,
                ['@fivem'] = fivem,
                ['@char1'] = char1,
                ['@ip'] = ip,
                ['@guid'] = guid
            }, function(rowsChanged)
                print(playerNameToBan .. " a été banni hors ligne par " .. adminName .. " pour " .. reason .. ". Temps " .. (permanent and "permanent." or "expirer dans " .. hours .. " heures."))
            end)
        else
            print("Failed to ban player offline: " .. playerNameToBan .. " not found.")
        end
    else
        print("Attempt to ban without permission from: " .. GetPlayerName(source))
    end
end)

function searchForPlayerIdentifiers(license)
    local identifiers = nil

    MySQL.Async.fetchAll('SELECT * FROM account_info WHERE license = @license', {
        ['@license'] = license
    }, function(users)
        if #users > 0 then
            identifiers = {
                identifier = users[1].license:gsub("license:", ""),
                steam = users[1].steam,
                xbl = users[1].xbl,
                discord = users[1].discord,
                live = users[1].live,
                fivem = users[1].fivem,
                name = users[1].name,
                ip = users[1].ip,
                guid = users[1].guid
            }
        end
    end)
    
    while identifiers == nil do
        Citizen.Wait(0)
    end

    return identifiers
end

RegisterServerEvent('menu_admin:getAllUsers')
AddEventHandler('menu_admin:getAllUsers', function()
    local source = source

    MySQL.Async.fetchAll('SELECT * FROM account_info', {}, function(users)
        TriggerClientEvent('menu_admin:showAllUsers', source, users)
    end)
end)

RegisterServerEvent('menu_admin:partialWipePlayer')
AddEventHandler('menu_admin:partialWipePlayer', function(playerId, license, reason)
    local identifier = string.gsub(license, "license:", "char1:")
    MySQL.Async.execute('DELETE FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(rowsChanged)
        print("L'utilisateur avec l'identifiant " .. identifier .. " a été partiellement wipe pour la raison suivante : " .. reason)
        
        DropPlayer(playerId, "Vous avez été déconnecté du serveur pour la raison suivante : " .. reason)
    end)
end)

RegisterServerEvent('menu_admin:fullWipePlayer')
AddEventHandler('menu_admin:fullWipePlayer', function(playerId, license, reason)
    
    local char1Identifier = string.gsub(license, "license:", "char1:")
    local rawIdentifier = string.gsub(license, "license:", "")

    MySQL.Async.execute('DELETE FROM users WHERE identifier IN (@char1Identifier, @license, @rawIdentifier)', {
        ['@char1Identifier'] = char1Identifier,
        ['@license'] = license,
        ['@rawIdentifier'] = rawIdentifier
    }, function(rowsChanged)
        print("L'utilisateur avec l'identifiant " .. char1Identifier .. " a été partiellement wipe pour la raison suivante : " .. reason)
    end)

    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner IN (@char1Identifier, @license, @rawIdentifier)', {
        ['@char1Identifier'] = char1Identifier,
        ['@license'] = license,
        ['@rawIdentifier'] = rawIdentifier
    }, function(rowsChanged)
        print("L'utilisateur avec la license " .. license .. " a été wipe de la table `owned_vehicles` pour la raison suivante : " .. reason)
    end)

    MySQL.Async.execute('DELETE FROM user_licenses WHERE owner IN (@char1Identifier, @license, @rawIdentifier)', {
        ['@char1Identifier'] = char1Identifier,
        ['@license'] = license,
        ['@rawIdentifier'] = rawIdentifier
    }, function(rowsChanged)
        print("L'utilisateur avec la license " .. license .. " a été wipe de la table `user_licenses` pour la raison suivante : " .. reason)

        DropPlayer(playerId, "Vous avez été déconnecté du serveur pour la raison suivante : " .. reason)
    end)
end)

sqlReady = false

MySQL.ready(function()
	sqlReady = true
end)

AddEventHandler('playerConnecting', function()
	local _source = source
	local license, steam, xbl, discord, live, fivem = '', '', '', '', '', ''
	local name, ip, guid = GetPlayerName(_source), GetPlayerEP(_source), GetPlayerGuid(_source)

	while not sqlReady do
		Citizen.Wait(100)
	end

	for k, v in pairs(GetPlayerIdentifiers(_source)) do
		if string.sub(v, 1, string.len('license:')) == 'license:' then
			license = v
		elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
			steam = v
		elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
			xbl = v
		elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
			discord = v
		elseif string.sub(v, 1, string.len('live:')) == 'live:' then
			live = v
		elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
			fivem = v
		end
	end

	if license ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM account_info WHERE license = @license', {
			['@license'] = license
		}, function(result)
			if result[1] ~= nil then
				MySQL.Async.execute('UPDATE account_info SET steam = @steam, xbl = @xbl, discord = @discord, live = @live, fivem = @fivem, `name` = @name, ip = @ip, guid = @guid WHERE license = @license', {
					['@license'] = license,
					['@steam'] = steam,
					['@xbl'] = xbl,
					['@discord'] = discord,
					['@live'] = live,
					['@fivem'] = fivem,
					['@name'] = name,
					['@ip'] = ip,
					['@guid'] = guid
				})
			else
				MySQL.Async.execute('INSERT INTO account_info (license, steam, xbl, discord, live, fivem, `name`, ip, guid) VALUES (@license, @steam, @xbl, @discord, @live, @fivem, @name, @ip, @guid)', {
					['@license'] = license,
					['@steam'] = steam,
					['@xbl'] = xbl,
					['@discord'] = discord,
					['@live'] = live,
					['@fivem'] = fivem,
					['@name'] = name,
					['@ip'] = ip,
					['@guid'] = guid
				})
			end
		end)
	end
end)

RegisterNetEvent('menu_admin:sendAnnouncement')
AddEventHandler('menu_admin:sendAnnouncement', function(title, message)
    TriggerClientEvent('menu_admin:receiveAnnouncement', -1, title, message)
end)

local adminLicenses = Config.License

RegisterNetEvent('menu_admin:restartServer')
AddEventHandler('menu_admin:restartServer', function()
    local identifiers = GetPlayerIdentifiers(source)
    
    local license
    for i=1, #identifiers, 1 do
        if string.sub(identifiers[i], 1, 8) == 'license:' then
            license = identifiers[i]
            break
        end
    end

    if license and adminLicenses[license] then
        TriggerClientEvent('chatMessage', -1, "^1Le serveur est en train de redémarrer...")
        
        os.exit()
    else
        TriggerClientEvent('chatMessage', source, "^1Vous n'avez pas la permission de redémarrer le serveur.")
    end
end)

function isInList(list, item)
    for _, v in ipairs(list) do
        if v == item then
            return true
        end
    end
    return false
end

RegisterServerEvent('menu_admin:sendMessage')
AddEventHandler('menu_admin:sendMessage', function(targetId, message)
    local target = ESX.GetPlayerFromId(targetId)
    if target then
        TriggerClientEvent('menuAdmin:showNotification', target.source, "Message privé de l'admin : " .. message, 'warning')
    else
        TriggerClientEvent('menuAdmin:showNotification', source, "Erreur : Le joueur avec l'ID " .. targetId .. " n'est pas valide.", 'error')
    end
end)

--[[RegisterServerEvent('insertCoords')
AddEventHandler('insertCoords', function(coords, heading, model)
    local coordX, coordY, coordZ = table.unpack(coords)
    MySQL.Async.execute('INSERT INTO PedTable (model, coordX, coordY, coordZ, heading) VALUES (@model, @coordX, @coordY, @coordZ, @heading)', {
        ['@model'] = model,
        ['@coordX'] = coordX,
        ['@coordY'] = coordY,
        ['@coordZ'] = coordZ,
        ['@heading'] = heading
    }, function(rowsChanged)
        print('Coordonnées, heading et modèle de ped insérés dans la base de données.')
    end)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        print("Resource names do not match, exiting.")
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM PedTable', {}, function(peds)
        print("Fetched " .. #peds .. " peds from the database.")
        for i=1, #peds, 1 do
            local ped = peds[i]
            print("Creating ped with model: " .. ped.model .. ", coords: (" .. ped.coordX .. ", " .. ped.coordY .. ", " .. ped.coordZ .. "), heading: " .. ped.heading)
            TriggerClientEvent('createPedAgain', -1, ped.model, {x = ped.coordX, y = ped.coordY, z = ped.coordZ}, ped.heading)
        end
    end)
end)]]