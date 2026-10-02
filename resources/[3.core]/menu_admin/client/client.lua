lib.locale()

local isStaffModeEnabled = false
local isDisplayingCoords = false
local pedModel = nil
local playerCoords = nil
local blipsActive = false
local isNoClip = false
local NoClipSpeed = 0.8

function ApplyModel(model)
    local playerPed = PlayerPedId() 
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model) 
        while not HasModelLoaded(model) do
            Wait(1) 
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        if model == originalModel then
            originalModel = nil
        end
    end
end

function openStaffModeMenu()
    lib.registerContext({
        id = 'staff_mode_menu',
        title = locale('titlestaff'),
        onExit = function()
        end,
        options = {
            {
                title = locale('activestaff'),
                description = locale('activestaff_desc'),
                icon = 'fas fa-user-shield',
                iconColor = '#ff0008',
                onSelect = function(args)
                    local playerID = PlayerId()
                    local playerName = GetPlayerName(playerID)
            
                    isStaffModeEnabled = true
                    blipsActive = false
                    showNames(true)
                    openAdminMenu()
                    TriggerServerEvent('menu_admin:enableStaffMode')
                    ShowNotification(playerName .. " vient d'activer le mode staff", 'info')
            
                    TriggerEvent('esx_adminmenu:toggleIdsAndNames')
                end,
            },
        },
    })
    lib.showContext('staff_mode_menu')
end

function openAdminMenu()
    if not isStaffModeEnabled then
        openStaffModeMenu()
        return
    end

    lib.registerContext({
        id = 'admin_menu',
        title = locale('titleactivestaff'),
        onExit = function()
        end,
        options = {
            {
                title = locale('activatedstaff'),
                description = locale('activatedstaff_desc'),
                icon = 'fas fa-user-shield',
                iconColor = '#00ff3c',
                onSelect = function(args)
                    local playerID = PlayerId()
                    local playerName = GetPlayerName(playerID)
            
                    isStaffModeEnabled = false
                    blipsActive = false
                    showNames(false)
                    openStaffModeMenu()
                    TriggerServerEvent('menu_admin:disableStaffMode')
                    ShowNotification(playerName .. " vient de désactiver le mode staff", 'info')
            
                    TriggerEvent('esx_adminmenu:toggleIdsAndNames')
                end,
            },
            {
                title = locale('playergestion'),
                description = locale('playergestion_desc'),
                icon = 'fas fa-user-cog',
                iconColor = '#ffaa00',
                onSelect = function(args)
                    TriggerServerEvent('menu_admin:manageUsers')
                end,
            },
            {
                title = locale('logactivity'),
                description = locale('logactivity_desc'),
                icon = 'fas fa-history',
                onSelect = function(args)
                    lib.registerContext({
                        id = 'activity_log_submenu',
                        title = locale('titlelogactivity'),
                        menu = 'menu_menu',
                        onBack = function(args)
                            lib.showContext('admin_menu')
                        end,
                        options = {
                            {
                                title = locale('titlejailoption'),
                                description = locale('titlejailoption_desc'),
                                icon = 'fa-gavel',
                                onSelect = function(args)
                                    local input = lib.inputDialog('Entrer l\'ID, le temps et la raison du jail', {'ID du Joueur', 'Temps en minutes', 'Raison'})
                            
                                    if not input then return end
                            
                                    local playerID = tonumber(input[1])
                                    local jailTime = tonumber(input[2])
                                    local reason = input[3]
                            
                                    if playerID and jailTime and reason then
                                        local position = {
                                            x = 1642.28,
                                            y = 2570.56,
                                            z = 45.56
                                        }
                                        TriggerServerEvent('menu_admin:jailPlayer', playerID, jailTime, reason, position)
                                    else
                                        print("Erreur: ID, Temps ou raison invalide")
                                    end
                                    lib.showContext('activity_log_submenu')
                                end,
                            },
                            {
                                title = locale('titlebanplayer'),
                                description = locale('titlebanplayer_desc'),
                                icon = 'fa-ban',
                                onSelect = function(args)
                                    local input = lib.inputDialog('Details du Ban', {
                                        {type = 'input', label = 'Player ID', description = 'Enter the ID of the player', required = true, icon = 'fa-id-card'},
                                        {type = 'input', label = 'Raison du Ban', description = 'Entrez la raison du bannissement', required = true},
                                        {type = 'number', label = 'Durée en heures', description = 'Entrez la durée du bannissement en heures', icon = 'hashtag'},
                                        {type = 'checkbox', label = 'Ban permanent', description = 'Cocher pour un ban permanent'}
                                    })
                                    
                                    if not input then return end
                                    
                                    local playerID = tonumber(input[1])  
                                    local reason = input[2]
                                    local hours = tonumber(input[3])
                                    local permanent = input[4]
                                    
                                    if playerID and reason and (hours or permanent) then
                                        TriggerServerEvent('menu_admin:banPlayer', playerID, reason, hours, permanent)
                                    else
                                        print("Erreur: ID de joueur, raison ou durée de ban invalide")
                                    end
                                    lib.showContext('activity_log_submenu')
                                end,
                            },
                            {
                                title = locale('titlejaillist'),
                                description = locale('titlejaillist_desc'),
                                icon = 'fas fa-user-lock',
                                onSelect = function(args)
                                    TriggerServerEvent('requestJailLog')
                                end,
                            },
                            {
                                title = locale('titlebanlist'),
                                description = locale('titlebanlist_desc'),
                                icon = 'fas fa-user-slash',
                                onSelect = function(args)
                                    TriggerServerEvent('requestBanList')
                                end,
                            },
                        }
                    })
            
                    lib.showContext('activity_log_submenu')
                end,
            },
            {
                title = locale('titlegestionsoit'),
                description = locale('titlegestionsoit_desc'),
                icon = 'fas fa-user',
                onSelect = function(args)
                    openGestionSoitMenu()
                end,
            },
            {
                title = locale('titlegestionveh'),
                description = locale('titlegestionveh_desc'),
                icon = 'fas fa-car',
                onSelect = function(args)
                    openVehicleManagerMenu()
                end,
            },
            {
                title = locale('titleserversetting'),
                description = locale('titleserversetting_desc'),
                icon = 'fas fa-cogs',
                onSelect = function()
                    TriggerEvent('tsettings_menu')
                end,
            },
            {
                title = locale('titlereport'),
                description = locale('titlereport_desc'),
                icon = 'fas fa-exclamation-triangle',
                iconColor = '#b50000',
                onSelect = function(args)
                    openReportManagerMenu()
                end,
            },
            {
                title = locale('titledeveloper'),
                description = locale('titledeveloper_desc'),
                icon = 'fas fa-laptop-code',
                iconColor = '#b7ffff',
                onSelect = function(args)
                    openDeveloperMenu()
                end,
            },
        },
    })
    lib.showContext('admin_menu')
end

function openGestionSoitMenu()
    lib.registerContext({
        id = 'give_options_menu',
        title = "Options de Don",
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('gestion_soit_menu')
        end,
        options = {
            {
                title = locale('titlegivemoney'),
                description = locale('titlegivemoney_desc'),
                icon = 'fas fa-wallet',
                onSelect = function(args)
                    getGroup(function(userGroup)
                        local allowedGroups = Config.Groups.CanGiveMoney
                        if not isInList(allowedGroups, userGroup) then
                            ShowNotification("Vous n'avez pas la permission de donner de l'argent.", "error")
                            return
                        end
                        
                        local input = lib.inputDialog('Give Money', {
                            {
                                type = 'number', 
                                label = 'Amount', 
                                description = 'Enter the amount of money', 
                                required = true, 
                                min = 1,
                                placeholder = '0',
                                icon = 'fa-money-bill-wave',
                            },
                            {
                                type = 'select', 
                                label = 'Type of Money', 
                                options = {
                                    {value = 'money', label = 'Money'},
                                    {value = 'bank', label = 'Bank'},
                                    {value = 'black_money', label = 'Black Money'},
                                },
                                description = 'Select type of money',
                                required = true,
                                placeholder = 'Select type of money',
                                icon = 'fa-money-check',
                            },
                        })
                    
                        if input then
                            local amount = input[1]
                            local typeOfMoney = input[2]
                            
                            local playerId = GetPlayerServerId(PlayerId())
                        
                            TriggerServerEvent('menu_admin:giveMoney', playerId, typeOfMoney, amount)
                            ShowNotification("Vous avez give à : " .. GetPlayerName(PlayerId()) .. " | Type : " .. typeOfMoney .. " | Montant : " .. amount, 'warning')
                            
                            lib.showContext('give_options_menu')
                        end
                    end)
                end,
            },
            {
                title = locale('titlegiveitem'),
                description = locale('titlegiveitem_desc'),
                icon = 'fa-box-open', 
                onSelect = function(args)
                    getGroup(function(userGroup)
                        local allowedGroups = Config.Groups.CanGiveItem
                        if not isInList(allowedGroups, userGroup) then
                            ShowNotification("Vous n'avez pas la permission de donner de l'argent.", "error")
                            return
                        end
                        TriggerServerEvent('menu_admin:openItemShopAdmin')
                    end)
                end,
            },
            {
                title = locale('titlegiveweapon'),
                description = locale('titlegiveweapon_desc'),
                icon = 'fa-gun',
                onSelect = function(args)
                    getGroup(function(userGroup)
                        local allowedGroups = Config.Groups.CanGiveWeapon
                        if not isInList(allowedGroups, userGroup) then
                            ShowNotification("Vous n'avez pas la permission de donner de l'argent.", "error")
                            return
                        end
                        TriggerServerEvent('menu_admin:openWeaponsShopAdmin')
                    end)
                end,
            },
            {
                title = locale('titlegiveammo'),
                description = locale('titlegiveammo_desc'),
                icon = 'fa-box',
                onSelect = function(args)
                    getGroup(function(userGroup)
                        local allowedGroups = Config.Groups.CanGiveAmmo
                        if not isInList(allowedGroups, userGroup) then
                            ShowNotification("Vous n'avez pas la permission de donner de l'argent.", "error")
                            return
                        end
                    TriggerServerEvent('menu_admin:openAmmoShopAdmin')
                    end)
                end,
            },
        }
    })

    lib.registerContext({
        id = 'gestion_soit_menu',
        title = "Gestion Joueur",
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('admin_menu')
        end,
        options = {
            {
                title = locale("titleoptiongive"),
                description = locale("titleoptiongive_desc"),
                icon = 'fas fa-wrench',
                onSelect = function(args)
                    lib.showContext('give_options_menu')
                end,
            },
            {
                title = "Options ped",
                description = "Accédez aux options ped",
                icon = 'fas fa-user-cog',
                onSelect = function(args)
                    getGroup(function(userGroup)
                        local allowedGroups = Config.Groups.OptionMenuPed
                        if not isInList(allowedGroups, userGroup) then
                            ShowNotification("Vous n'avez pas la permission d'ouvrir ce menu.", "error")
                            return
                        end
                    lib.showContext('ped_options_menu')
                    end)
                end,
            },
        }
    })
    lib.showContext('gestion_soit_menu')
end

function GeneratePedOptions()
    local options = {}

    for _, ped in ipairs(Config.PedList) do
        table.insert(options, {
            title = ped,
            description = "Appliquer le modèle " .. ped,
            icon = 'fas fa-user-alt',
            onSelect = function(args)
                ApplyModel(ped)
                lib.showContext('ped_selection_menu')
            end,
        })
    end

    return options
end

lib.registerContext({
    id = 'ped_selection_menu',
    title = "Sélection du ped",
    menu = 'menu_menu',
    onBack = function(args)
        lib.showContext('ped_options_menu')
    end,
    options = GeneratePedOptions() 
})


lib.registerContext({
    id = 'ped_options_menu',
    title = "Options ped",
    menu = 'menu_menu',
    onBack = function(args)
        lib.showContext('gestion_soit_menu')
    end,
    options = {
        {
            title = "Choix du ped",
            description = "Sélectionnez un modèle de personnage spécifique",
            icon = 'fas fa-user-alt',
            onSelect = function(args)
                lib.showContext('ped_selection_menu')
            end,
        },
        {
            title = "Reprendre son personnage",
            description = "Reprendre le contrôle de votre personnage actuel",
            icon = 'fas fa-user-check',
            onSelect = function(args)
                ApplyModel("mp_m_freemode_01")   
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                    lib.showContext('ped_options_menu')
                end)
            end,
        },
    }
})

function openVehicleManagerMenu()
    getGroup(function(userGroup)
        local allowedGroups = Config.Groups.Cancar
        if not isInList(allowedGroups, userGroup) then
            ShowNotification("Vous n'avez pas la permission d'ouvrir ce menu.", "error")
            return
        end
    
    lib.registerContext({
        id = 'vehicle_management_menu',
        title = locale('titlegestionveh'),
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('admin_menu')
        end,
        options = {
            {
                title = locale('vehfix'),
                description = locale('vehfix_desc'),
                icon = 'fas fa-wrench',
                onSelect = function(args)
                    TriggerEvent('menu_admin:repairVehicle')
                    ShowNotification("Vous avez réparé le véhicule", 'warning')
                    lib.showContext('vehicle_management_menu')
                end,
            },
            {
                title = locale('spawnveh'),
                description = locale('spawnveh_desc'),
                icon = 'fas fa-car-side',
                onSelect = function(args)
                    local options = {}
                    
                    for k,v in pairs(Config.Vehicles) do
                        table.insert(options, {label = v.label, value = v.name})
                    end
                    
                    local input = lib.inputDialog('Nom du Véhicule', {
                        {
                            type = 'select',
                            label = 'Nom du Véhicule',
                            options = options,
                            required = true,
                        },
                    })
                    
                    if input then
                        local vehicleName = input[1]
                        
                        if vehicleName then
                            ExecuteCommand('car ' .. vehicleName)
                        else
                            print("Erreur: Nom de véhicule invalide")
                        end
                    end
                    
                    lib.showContext('vehicle_management_menu')
                end,
            },
            {
                title = locale('dvveh'),
                description = locale('dvveh_desc'),
                icon = 'fas fa-paint-roller',
                onSelect = function(args)
                    local input = lib.inputDialog('Nombre de véhicules à supprimer', {
                        {
                            type = 'select',
                            label = 'Nombre de véhicules',
                            options = {
                                {label = '1', value = '1'},
                                {label = '10', value = '10'},
                                {label = '50', value = '50'},
                            },
                        },
                    })
                    
                    if input then
                        local numVehicles = input[1]
                        
                        if numVehicles then
                            for i=1, tonumber(numVehicles) do
                                ExecuteCommand('dv ' .. numVehicles )
                            end
                        else
                            print("Erreur: Nombre de véhicules invalide")
                        end
                    end
                    lib.showContext('vehicle_management_menu')
                end,
            },
        }
    })
    lib.showContext('vehicle_management_menu')
    end)
end

RegisterNetEvent('menu_admin:repairVehicle')
AddEventHandler('menu_admin:repairVehicle', function()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
    if vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
        ShowNotification("Le véhicule a été réparé.", 'success')
    else
        ShowNotification("Aucun véhicule à réparer.", 'error')
    end
end)

function openReportManagerMenu()
    TriggerServerEvent('menu_admin:requestReports')

    RegisterNetEvent('menu_admin:receiveReports')
    AddEventHandler('menu_admin:receiveReports', function(reports)
        lib.registerContext({
            id = 'report_manager_submenu',
            title = locale('titlegestionreports'),
            menu = 'menu_menu',
            onBack = function(args)
                lib.showContext('admin_menu')
            end,
            options = buildReportOptions(reports),
        })

        lib.showContext('report_manager_submenu')
    end)
end

RegisterNetEvent('menuAdmin:showReportNotification')
AddEventHandler('menuAdmin:showReportNotification', function(playerName, playerID, reason)
    if isStaffModeEnabled then
        ShowNotification("Nouveau report de " .. playerName .. " (ID: " .. playerID .. "): " .. reason, 'warning')

        PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 1)
    end
end)

function buildReportOptions(reports)
    local options = {}

    for i, report in ipairs(reports) do
        local description = "Nom : " .. report.player_name .. "\n" .. "ID : " .. report.player_id .. "\n" .. "Raison : " .. report.reason

        local iconColor = report.admin_name and '#00b500' or '#b50000'

        table.insert(options, {
            title = locale('titlereports') .. report.id,
            description = description,
            icon = 'fas fa-exclamation-triangle',
            iconColor = iconColor,
            onSelect = function(args)
                local adminName = GetPlayerName(PlayerId())
                TriggerServerEvent('menu_admin:takeReport', report.id, adminName)
                buildReportSubMenu(report, adminName)
            end,
            onBack = function(args)
                lib.showContext('admin_menu')
            end,
        })
    end

    return options
end

function buildReportSubMenu(report, adminName)
    lib.registerContext({
        id = 'report_submenu' .. report.id,
        title = locale('titlegestionreportreception') .. report.id,
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('admin_menu')
        end,
        options = {
            {
                title = locale('titleinforeport'),
                description = "Nom : " .. report.player_name .. "\n" .. "ID : " .. report.player_id .. "\n" .. "Raison : " .. report.reason .. "\n" .. "Pris en charge par : " .. (adminName or "Personne"),
                onSelect = function()
                end
            },
            {
                title = locale('titleteleport'),
                description = locale('titleteleport_desc'),
                icon = 'fa-location-arrow',
                onSelect = function(args)
                    lib.registerContext({
                        id = 'teleport_report' .. report.player_id,
                        title = locale('titleteleportof') .. report.player_name,
                        menu = 'menu_menu',
                        onBack = function(args)
                            lib.showContext('report_submenu' .. report.id)
                        end,
                        options = {
                            {
                                title = locale('titleteleporttoplayer'),
                                description = locale('titleteleporttoplayer_desc') .. report.player_name,
                                icon = 'fa-user',
                                onSelect = function(args)
                                    TriggerServerEvent('menu_admin:getPlayerPosition', report.player_id)
                                    ShowNotification("Vous vous êtes téléporter à " .. report.player_name, 'info')
                                    lib.showContext('teleport_report' .. report.player_id)
                                end,
                            },
                            {
                                title = locale('titleteleportplayertome'),
                                description = locale('titleteleportplayertome_desc') .. report.player_name .. locale('titleteleportplayertome_desc2'),
                                icon = 'fa-user',
                                onSelect = function(args)
                                    ExecuteCommand('bring ' .. report.player_id)
                                    ShowNotification("Vous avez téléporté " .. report.player_name .. " sur vous", 'info')
                                    lib.showContext('teleport_report' .. report.player_id)
                                end,
                            },
                            {
                                title = locale('titleteleportplayertocentral'),
                                description = locale('titleteleportplatertocentral_desc') .. report.player_name .. locale('titleteleportplatertocentral_desc2'),
                                icon = 'fa-car',
                                onSelect = function(args)
                                    local position = {
                                        x = 221.85,
                                        y = -809.17,
                                        z = 30.64
                                    }
                            
                                    if report.player_id == nil then
                                        print("Error: info.id is nil")
                                        return
                                    end
                            
                                    TriggerServerEvent('menu_admin:teleportToPosition', report.player_id, position)
                                    ShowNotification("Vous avez téléporté " .. report.player_name .. " au parking central", 'info')
                                    lib.showContext('teleport_report' .. report.player_id)
                                end,
                            },
                            {
                                title = locale('titleteleportplayertoimpound'),
                                description = locale('titleteleportplayertoimpound_desc') .. report.player_name .. locale('titleteleportplayertoimpound_desc2'),
                                icon = 'fa-truck',
                                onSelect = function(args)
                                    local position = {
                                        x = 403.20,
                                        y = -1627.61,
                                        z = 29.29
                                    }
                            
                                    if report.player_id == nil then
                                        print("Error: info.id is nil")
                                        return
                                    end
                            
                                    TriggerServerEvent('menu_admin:teleportToPosition', report.player_id, position)
                                    ShowNotification("Vous avez téléporté " .. report.player_name .. " à la fourrière", 'info')
                                    lib.showContext('teleport_report' .. report.player_id)
                                end,
                            },
                            {
                                title = locale('titleteleportplayertohospital'),
                                description = locale('titleteleportplayertohospital_desc') .. report.player_name .. locale('titleteleportplayertohospital_desc2'),
                                icon = 'fa-hospital',
                                onSelect = function(args)
                                    local position = {
                                        x = -446.88,
                                        y = -362.27,
                                        z = 33.56
                                    }
                            
                                    if report.player_id == nil then
                                        print("Error: info.id is nil")
                                        return
                                    end
                            
                                    TriggerServerEvent('menu_admin:teleportToPosition', report.player_id, position)
                                    ShowNotification("Vous avez téléporté " .. report.player_name .. " à l'hopital", 'info')
                                    lib.showContext('teleport_report' .. report.player_id)
                                end,
                            },
                            {
                                title = locale('titleteleportplayertoclothing'),
                                description = locale('titleteleportplayertoclothing_desc') .. report.player_name .. locale('titleteleportplayertoclothing_desc2'),
                                icon = 'fa-tshirt',
                                onSelect = function(args)
                                    local position = {
                                        x = -154.04,
                                        y = -306.00,
                                        z = 37.70
                                    }
                            
                                    if report.player_id == nil then
                                        print("Error: report.player_id is nil")
                                        return
                                    end
                            
                                    TriggerServerEvent('menu_admin:teleportToPosition', report.player_id, position)
                                    ShowNotification("Vous avez téléporté " .. report.player_name .. " au magasin de vêtement", 'info')
                                    lib.showContext('teleport_report' .. report.player_id)
                                end,
                            },
                        },
                    })
            
                    lib.showContext('teleport_report' .. report.player_id)
                end,
            },
            {
                title = locale('titlehealplayer'),
                description = locale('titlehealplayer_desc') .. report.player_name,
                onSelect = function()
                    ExecuteCommand('heal ' .. report.player_id)
                    lib.showContext('report_submenu' .. report.id)
                end
            },
            {
                title = locale('titlereviveplayer'),
                description = locale('titlereviveplayer_desc') .. report.player_name,
                onSelect = function()
                    ExecuteCommand('revive ' .. report.player_id)
                    lib.showContext('report_submenu' .. report.id)
                end
            },
            {
                title = locale('closereport'),
                description = locale('closereport_desc'),
                onSelect = function()
                    TriggerServerEvent('menu_admin:closeReport', report.id)
                    lib.showContext('admin_menu')
                end
            }
        },
    })

    lib.showContext('report_submenu' .. report.id)
end

RegisterNetEvent('menu_admin:showUserManager')
AddEventHandler('menu_admin:showUserManager', function(playerInfo)
    local options = {}

    for _, info in ipairs(playerInfo) do
        table.insert(options, {
            title = info.name,
            description = "ID : "..info.id..", Groupe : "..info.group,
            icon = 'fa-user',
        })
    end

    lib.registerContext({
        id = 'user_manager_menu',
        title = locale('titlegestionplayer'),
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('admin_menu')
        end,
        options = options,
    })

    lib.showContext('user_manager_menu')
end)

RegisterNetEvent('menu_admin:showUserManager')
AddEventHandler('menu_admin:showUserManager', function(playerInfo)
    local options = {}

    for _, info in ipairs(playerInfo) do
        table.insert(options, {
            title = info.name,
            description = "ID : "..info.id..", Groupe : "..info.group,
            icon = 'fa-user',
            onSelect = function()
                lib.registerContext({
                    id = 'manage_user_'..info.id,
                    title = locale('titlegestplayer') .. info.name,
                    menu = 'menu_menu',
                    onBack = function(args)
                        lib.showContext('user_manager_menu') 
                    end,
                    options = {
                        {
                            title = locale('titleplayerinfo'),
                            description = locale('titleplayerinfo_desc'),
                            icon = 'fa-info',
                            onSelect = function(args)
                                lib.registerContext({
                                    id = 'user_info_' .. info.id,
                                    title = locale('titleinformationof') .. info.name,
                                    menu = 'menu_menu',
                                    onBack = function(args)
                                        lib.showContext('manage_user_' .. info.id)
                                    end,
                                    options = {
                                        {
                                            title = locale('titlejob'),
                                            description = info.job_label or "Aucun",
                                            icon = 'fa-briefcase',
                                            onSelect = function(args)
                                                ShowNotification("ID : " .. info.id .. " | Joueur : " .. info.name .. " | Group : " .. info.group, 'warning')
                                                lib.showContext('user_info_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titlerank'),
                                            description = info.grade_label or "Aucun",
                                            icon = 'fa-graduation-cap',
                                            onSelect = function(args)
                                                ShowNotification("ID : " .. info.id .. " | Joueur : " .. info.name .. " | Group : " .. info.group, 'warning')
                                                lib.showContext('user_info_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titlename'),
                                            description = info.firstname or "Inconnu",
                                            icon = 'fa-user',
                                            onSelect = function(args)
                                                ShowNotification("ID : " .. info.id .. " | Joueur : " .. info.name .. " | Group : " .. info.group, 'warning')
                                                lib.showContext('user_info_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleothername'),
                                            description = info.lastname or "Inconnu",
                                            icon = 'fa-user',
                                            onSelect = function(args)
                                                ShowNotification("ID : " .. info.id .. " | Joueur : " .. info.name .. " | Group : " .. info.group, 'warning')
                                                lib.showContext('user_info_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titlefivemlicense'),
                                            description = info.identifier or "Non disponible",
                                            icon = 'fa-id-card',
                                            onSelect = function(args)
                                                ShowNotification("ID : " .. info.id .. " | Joueur : " .. info.name .. " | Group : " .. info.group, 'warning')
                                                lib.showContext('user_info_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleopeninvplayer'),
                                            description = locale('titleopeninvplayer_desc'),
                                            icon = 'fa-box-open',
                                            onSelect = function(args)
                                                local targetPlayerId = info.id
                                                ExecuteCommand('viewinv ' .. targetPlayerId)
                                            end,
                                        },
                                    },
                                })
                        
                                lib.showContext('user_info_' .. info.id)
                            end,
                        },
                        {
                            title = "Envoyer un message",
                            description = "Envoyer un message privé",
                            icon = 'fa-envelope',
                            onSelect = function(args)
                                local input = lib.inputDialog('Entrez votre message', {'Message'})
                                
                                if not input then return end
                        
                                local message = input[1]
                        
                                TriggerServerEvent('menu_admin:sendMessage', info.id, message)
                                ShowNotification("Vous avez envoyé un message à " .. info.name .. ". Message : " .. message, 'info')
                                lib.showContext('manage_user_' .. info.id)
                            end,
                        },
                        {
                            title = locale('titleteleport'),
                            description = locale('titleteleport_desc'),
                            icon = 'fa-location-arrow',
                            onSelect = function(args)
                                lib.registerContext({
                                    id = 'teleport_' .. info.id,
                                    title = locale('titleteleportof') .. info.name,
                                    menu = 'menu_menu',
                                    onBack = function(args)
                                        lib.showContext('manage_user_' .. info.id)
                                    end,
                                    options = {
                                        {
                                            title = locale('titleteleporttoplayer'),
                                            description = locale('titleteleporttoplayer_desc') .. info.name,
                                            icon = 'fa-user',
                                            onSelect = function(args)
                                                TriggerServerEvent('menu_admin:getPlayerPosition', info.id)
                                                ShowNotification("Vous vous êtes téléporter à " .. info.name, 'info')
                                                lib.showContext('teleport_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleteleportplayertome'),
                                            description = locale('titleteleportplayertome_desc') .. info.name .. locale('titleteleportplayertome_desc2'),
                                            icon = 'fa-user',
                                            onSelect = function(args)
                                                ExecuteCommand('bring ' .. info.id)
                                                ShowNotification("Vous avez téléporté " .. info.name .. " sur vous", 'info')
                                                lib.showContext('teleport_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleteleportplayertocentral'),
                                            description = locale('titleteleportplatertocentral_desc') .. info.name .. locale('titleteleportplatertocentral_desc2'),
                                            icon = 'fa-car',
                                            onSelect = function(args)
                                                local position = {
                                                    x = 221.85,
                                                    y = -809.17,
                                                    z = 30.64
                                                }
                                        
                                                if info.id == nil then
                                                    print("Error: info.id is nil")
                                                    return
                                                end
                                        
                                                TriggerServerEvent('menu_admin:teleportToPosition', info.id, position)
                                                ShowNotification("Vous avez téléporté " .. info.name .. " au parking central", 'info')
                                                lib.showContext('teleport_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleteleportplayertoimpound'),
                                            description = locale('titleteleportplayertoimpound_desc') .. info.name .. locale('titleteleportplayertoimpound_desc2'),
                                            icon = 'fa-truck',
                                            onSelect = function(args)
                                                local position = {
                                                    x = 403.20,
                                                    y = -1627.61,
                                                    z = 29.29
                                                }
                                        
                                                if info.id == nil then
                                                    print("Error: info.id is nil")
                                                    return
                                                end
                                        
                                                TriggerServerEvent('menu_admin:teleportToPosition', info.id, position)
                                                ShowNotification("Vous avez téléporté " .. info.name .. " à la fourrière", 'info')
                                                lib.showContext('teleport_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleteleportplayertohospital'),
                                            description = locale('titleteleportplayertohospital_desc') .. info.name .. locale('titleteleportplayertohospital_desc2'),
                                            icon = 'fa-hospital',
                                            onSelect = function(args)
                                                local position = {
                                                    x = -446.88,
                                                    y = -362.27,
                                                    z = 33.56
                                                }
                                        
                                                if info.id == nil then
                                                    print("Error: info.id is nil")
                                                    return
                                                end
                                        
                                                TriggerServerEvent('menu_admin:teleportToPosition', info.id, position)
                                                ShowNotification("Vous avez téléporté " .. info.name .. " à l'hopital", 'info')
                                                lib.showContext('teleport_' .. info.id)
                                            end,
                                        },
                                        {
                                            title = locale('titleteleportplayertoclothing'),
                                            description = locale('titleteleportplayertoclothing_desc') .. info.name .. locale('titleteleportplayertoclothing_desc2'),
                                            icon = 'fa-tshirt',
                                            onSelect = function(args)
                                                local position = {
                                                    x = -154.04,
                                                    y = -306.00,
                                                    z = 37.70
                                                }
                                        
                                                if info.id == nil then
                                                    print("Error: info.id is nil")
                                                    return
                                                end
                                        
                                                TriggerServerEvent('menu_admin:teleportToPosition', info.id, position)
                                                ShowNotification("Vous avez téléporté " .. info.name .. " au magasin de vêtement", 'info')
                                                lib.showContext('teleport_' .. info.id)
                                            end,
                                        },
                                    },
                                })
                        
                                lib.showContext('teleport_' .. info.id)
                            end,
                        },
                        {
                            title = locale('titlesetjob'),
                            description = locale('titlesetjob_desc'),
                            icon = 'fa-briefcase',
                            onSelect = function(args)
                                local input = lib.inputDialog('Définir le travail et le grade', {'Job', 'Grade'})
                        
                                if not input then return end
                        
                                local job = input[1]
                                local grade = input[2]
                        
                                TriggerServerEvent('menu_admin:validateAndSetJobAndGrade', info.id, job, grade)
                                ShowNotification("Vous avez setjob " .. info.name .. ". Job : " .. job .. " Grade :" .. grade, 'warning')
                                lib.showContext('manage_user_' .. info.id)
                            end,
                        },
                        {
                            title = locale('titlesetgroup'),
                            description = locale('titlesetgroup_desc'),
                            icon = 'fa-users',
                            onSelect = function(args)
                                local input = lib.inputDialog('Définir le groupe', {'Group'})
                        
                                if not input then return end
                        
                                local group = input[1]
                        
                                TriggerServerEvent('menu_admin:validateAndSetGroup', info.id, group)
                                ShowNotification("Vous avez mis à : " .. info.name .. " | Le Group : " .. group, 'warning')
                                lib.showContext('manage_user_' .. info.id)
                            end,
                        },
                        {
                            title = locale('titleoptiongive'),
                            description = locale('titleoptiongive_desc'),
                            icon = 'fa-gift', 
                            onSelect = function(args)
                                lib.registerContext({
                                    id = 'give_' .. info.id,
                                    title = locale('titlegiveoption') .. info.name,
                                    menu = 'menu_menu',
                                    onBack = function(args)
                                        lib.showContext('manage_user_' .. info.id)
                                    end,
                                    options = {
                                        {
                                            title = locale('titlegivemoney'),
                                            description = locale('titlegivemoney_desc'),
                                            icon = 'fa-money-bill-wave', 
                                            onSelect = function(args)
                                                getGroup(function(userGroup)
                                                    local allowedGroups = Config.Groups.CanGiveMoney
                                                    if not isInList(allowedGroups, userGroup) then
                                                        ShowNotification("Vous n'avez pas la permission de donner de l'argent.", "error")
                                                        return
                                                    end
                                                    
                                                    local input = lib.inputDialog('Give Money', {
                                                        {
                                                            type = 'number', 
                                                            label = 'Amount', 
                                                            description = 'Enter the amount of money', 
                                                            required = true, 
                                                            min = 1,
                                                            placeholder = '0',
                                                            icon = 'fa-money-bill-wave',
                                                        },
                                                        {
                                                            type = 'select', 
                                                            label = 'Type of Money', 
                                                            options = {
                                                                {value = 'money', label = 'Money'},
                                                                {value = 'bank', label = 'Bank'},
                                                                {value = 'black_money', label = 'Black Money'},
                                                            },
                                                            description = 'Select type of money',
                                                            required = true,
                                                            placeholder = 'Select type of money',
                                                            icon = 'fa-money-check',
                                                        },
                                                    })
                                                
                                                    if input then
                                                        local amount = input[1]
                                                        local typeOfMoney = input[2]
                                                        
                                                        TriggerServerEvent('menu_admin:giveMoney', info.id, typeOfMoney, amount)
                                                        ShowNotification("Vous avez give à : " .. info.name .. " | Type : " .. typeOfMoney .. " | Montant : " .. amount, 'warning')
                                                        lib.showContext('give_' .. info.id)
                                                    end
                                                end)
                                            end,
                                        },
                                        {
                                            title = locale('titlegiveweapon'),
                                            description = locale('titlegiveweapon_desc'),
                                            icon = 'fa-gun', 
                                            onSelect = function(args)
                                                getGroup(function(userGroup)
                                                    local allowedGroups = Config.Groups.CanGiveWeapon
                                                    if not isInList(allowedGroups, userGroup) then
                                                        ShowNotification("Vous n'avez pas la permission de donner des armes.", "error")
                                                        return
                                                    end
                                        
                                                    local weaponOptions = {}
                                                    for _, weapon in ipairs(Config.Weapons) do
                                                        table.insert(weaponOptions, {value = weapon.name, label = weapon.label})
                                                    end
                                        
                                                    local input = lib.inputDialog('Give Weapon', {
                                                        {
                                                            type = 'select', 
                                                            label = 'Weapon', 
                                                            options = weaponOptions,
                                                            description = 'Sélectionner une arme',
                                                            required = true,
                                                            placeholder = 'Sélectionner une arme',
                                                            icon = 'fa-gun',
                                                        },
                                                        {
                                                            type = 'number', 
                                                            label = 'Combien ?', 
                                                            description = 'Entrer la quantité d\'arme', 
                                                            required = true, 
                                                            min = 1,
                                                            placeholder = '0',
                                                            icon = 'fa-bullet',
                                                        },
                                                    })
                                                    if input then
                                                        local weaponName = input[1]
                                                        local ammo = input[2]
                                                        ESX.TriggerServerCallback('menu_admin:giveWeaponItem', function(success)
                                                            if not success then
                                                                ShowNotification("L'arme n'a pas pu être ajoutée.", "error")
                                                            else
                                                                ShowNotification("L'arme a été ajoutée avec succès.", "success")
                                                                lib.showContext('give_' .. info.id)
                                                            end
                                                        end, info.id, 'item_weapon', weaponName, ammo)
                                                    end
                                                end)
                                            end,
                                        },
                                        {
                                            title = locale('titlegiveammo'),
                                            description = locale('titlegiveammo_desc'),
                                            icon = 'fa-box', 
                                            onSelect = function(args)
                                                getGroup(function(userGroup)
                                                    local allowedGroups = Config.Groups.CanGiveAmmo
                                                    if not isInList(allowedGroups, userGroup) then
                                                        ShowNotification("Vous n'avez pas la permission de donner des munitions.", "error")
                                                        return
                                                    end
                                        
                                                    local ammoOptions = {}
                                                    for _, ammo in ipairs(Config.Ammo) do
                                                        table.insert(ammoOptions, {value = ammo.name, label = ammo.label})
                                                    end
                                        
                                                    local input = lib.inputDialog('Give Ammo', {
                                                        {
                                                            type = 'select', 
                                                            label = 'Munitions', 
                                                            options = ammoOptions,
                                                            description = 'Sélectionner une munitions',
                                                            required = true,
                                                            placeholder = 'Sélectionner une munitions',
                                                            icon = 'fa-gun',
                                                        },
                                                        {
                                                            type = 'number', 
                                                            label = 'Combien ?', 
                                                            description = 'Entrer la quantité de munitions', 
                                                            required = true, 
                                                            min = 1,
                                                            placeholder = '0',
                                                            icon = 'fa-bullet',
                                                        },
                                                    })
                                                    if input then
                                                        local ammoName = input[1]
                                                        local ammoCount = tonumber(input[2]) 
                                                        ESX.TriggerServerCallback('menu_admin:giveAmmoItem', function(success)
                                                            if not success then
                                                                ShowNotification("Les munitions n'ont pas pu être ajoutées.", "error")
                                                            else
                                                                ShowNotification("Les munitions ont été ajoutées avec succès.", "success")
                                                                lib.showContext('give_' .. info.id)
                                                            end
                                                        end, info.id, 'item_ammo', ammoName, ammoCount)
                                                    end
                                                end)
                                            end,
                                        },
                                        {
                                            title = locale('titlegiveitem'),
                                            description = locale('titlegiveitem_desc'),
                                            icon = 'fa-box-open', 
                                            onSelect = function(args)
                                                getGroup(function(userGroup)
                                                    local allowedGroups = Config.Groups.CanGiveItem
                                                    if not isInList(allowedGroups, userGroup) then
                                                        ShowNotification("Vous n'avez pas la permission de donner des objets.", "error")
                                                        return
                                                    end
                                                    local itemOptions = {}
                                                    for _, item in ipairs(Config.Items) do
                                                        table.insert(itemOptions, {value = item.name, label = item.label})
                                                    end

                                                    local input = lib.inputDialog('Give Item', {
                                                        {
                                                            type = 'select', 
                                                            label = 'Item', 
                                                            options = itemOptions,
                                                            description = 'Sélectionner l\'item',
                                                            required = true,
                                                            placeholder = 'Sélectionner l\'item',
                                                            icon = 'fa-box-open',
                                                        },
                                                        {
                                                            type = 'number', 
                                                            label = 'Combien ?', 
                                                            description = 'Entrer la quantité d\'item', 
                                                            required = true, 
                                                            min = 1,
                                                            placeholder = '0',
                                                            icon = 'fa-plus',
                                                        },
                                                    })
                                                    if input then
                                                        local itemName = input[1]
                                                        local itemCount = tonumber(input[2]) 
                                                        ESX.TriggerServerCallback('menu_admin:giveItem', function(success)
                                                            if not success then
                                                                ShowNotification("L'objet n'a pas pu être ajouté.", "error")
                                                            else
                                                                ShowNotification("L'objet a été ajouté avec succès.", "success")
                                                                lib.showContext('give_' .. info.id)
                                                            end
                                                        end, info.id, 'item', itemName, itemCount)
                                                    end
                                                end)
                                            end,
                                        },
                                    },
                                })
                        
                                lib.showContext('give_' .. info.id)
                            end,
                        },
                        {
                            title = locale('titlejailoption'),
                            description = locale('titlejailoption_desc'),
                            icon = 'fa-gavel',
                            onSelect = function(args)
                                local input = lib.inputDialog('Entrer le temps et la raison du jail', {'Temps en minutes', 'Raison'})
                        
                                if not input then return end
                        
                                local jailTime = tonumber(input[1])
                                local reason = input[2]
                        
                                if jailTime and reason then
                                    local position = {
                                        x = 1642.28,
                                        y = 2570.56,
                                        z = 45.56
                                    }
                                    TriggerServerEvent('menu_admin:jailPlayer', info.id, jailTime, reason, position)
                                else
                                    print("Erreur: Temps ou raison invalide")
                                end
                                lib.showContext('manage_user_' .. info.id)
                            end,
                        },
                        {
                            title = locale('titlekickplayer'),
                            description = locale('titlekickplayer_desc'),
                            icon = 'fa-door-open',
                            onSelect = function()
                                TriggerServerEvent('menu_admin:kickPlayer', info.id)
                            end,
                        },
                        {
                            title = locale('titlebanplayer'),
                            description = locale('titlebanplayer_desc'),
                            icon = 'fa-ban',
                            onSelect = function(args)
                                local input = lib.inputDialog('Details du Ban', {
                                    {type = 'input', label = 'Raison du Ban', description = 'Entrez la raison du bannissement', required = true},
                                    {type = 'number', label = 'Durée en heures', description = 'Entrez la durée du bannissement en heures', icon = 'hashtag'},
                                    {type = 'checkbox', label = 'Ban permanent', description = 'Cocher pour un ban permanent'}
                                })
                                
                                if not input then return end
                                
                                local reason = input[1]
                                local hours = tonumber(input[2])
                                local permanent = input[3]
                                
                                if reason and (hours or permanent) then
                                    TriggerServerEvent('menu_admin:banPlayer', info.id, reason, hours, permanent)
                                else
                                    print("Erreur: Raison ou durée de ban invalide")
                                end
                                lib.showContext('manage_user_' .. info.id)
                            end,
                        },
                    },
                })
                lib.showContext('manage_user_'..info.id) 
            end,
        })
    end

    lib.registerContext({
        id = 'user_manager_menu',
        title = locale('titlegestionplayer'),
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('admin_menu')
        end,
        options = options,
    })

    lib.showContext('user_manager_menu')
end)

RegisterNetEvent('showJailLogMenu')
AddEventHandler('showJailLogMenu', function(jailData)
  local options = {}

  for i=1, #jailData, 1 do
    local row = jailData[i]

    table.insert(options, {
        title = row.name,
        description = locale('jaildatatime_desc') .. row.jailTime .. locale('jaildatatime_desc2') .. row.reason .. locale('jaildatatime_desc3') .. row.jailer,
        icon = 'fas fa-user-lock',
        onSelect = function(args)
            lib.registerContext({
                id = 'unjail_confirmation_menu',
                title = locale('titlejailconfirmation'),
                menu = 'menu_menu',
                onBack = function(args)
                    lib.showContext('jail_log_menu')
                end,
                options = {
                    {
                        title = locale('titlejailconfirmation2'),
                        description = locale('titlejailconfirmation2_desc'),
                        icon = 'fas fa-check',
                        onSelect = function(args)
                            TriggerServerEvent('unjailPlayer', row.identifier)
                            lib.showContext('activity_log_submenu')
                        end
                    },
                    {
                        title = locale('titlejailconfirmation3'),
                        description = locale('titlejailconfirmation3_desc'),
                        icon = 'fas fa-times',
                        onSelect = function(args)
                            lib.showContext('jail_log_menu')
                        end
                    }
                },
            })

            lib.showContext('unjail_confirmation_menu') 
        end
    })
  end

  lib.registerContext({
    id = 'jail_log_menu',
    title = locale('titlelogjail'),
    menu = 'menu_menu',
    onBack = function(args)
      lib.showContext('activity_log_submenu')
    end,
    options = options,
  })

  lib.showContext('jail_log_menu')
end)

RegisterNetEvent('showBanLogMenu')
AddEventHandler('showBanLogMenu', function(banData)

    getGroup(function(userGroup)
        local allowedGroups = Config.Groups.BanList
        if not isInList(allowedGroups, userGroup) then
            ShowNotification("Vous n'avez pas la permission d'ouvrir ce menu.", "error")
            return
        end

        local options = {}

        for i=1, #banData, 1 do
            local row = banData[i]
            local description = string.format(
                "Raison: %s. Par: %s. Date du ban: %s. Date d'expiration: %s.",
                row.reason,
                row.adminName,
                row.banTime,
                row.expireTime
            )

            table.insert(options, {
                title = row.playerName,
                description = description,
                icon = 'fas fa-user-slash',
                onSelect = function(args)
                    lib.registerContext({
                        id = 'confirmation_menu',
                        title = locale('titlejailconfirmation'),
                        menu = 'menu_menu',
                        onBack = function(args)
                            lib.showContext('ban_log_menu')
                        end,
                        options = {
                            {
                                title = locale('titlejailconfirmation2'),
                                description = locale('deban_desc'),
                                icon = 'fas fa-check',
                                onSelect = function(args)
                                    TriggerServerEvent('unbanPlayer', row.identifier)
                                    lib.showContext('activity_log_submenu')
                                end
                            },
                            {
                                title = locale('titlejailconfirmation3'),
                                description = locale('deban_desc2'),
                                icon = 'fas fa-times',
                                onSelect = function(args)
                                    lib.showContext('ban_log_menu')
                                end
                            }
                        },
                    })

                    lib.showContext('confirmation_menu')
                end
            })
        end

        lib.registerContext({
            id = 'ban_log_menu',
            title = locale('titlelistofban'),
            menu = 'menu_menu',
            onBack = function(args)
                lib.showContext('activity_log_submenu')
            end,
            options = options,
        })

        lib.showContext('ban_log_menu')
    end)
end)

RegisterNetEvent('tsettings_menu', function()

    getGroup(function(userGroup)
        local allowedGroups = Config.Groups.SettingsMenu
        if not isInList(allowedGroups, userGroup) then
            ShowNotification("Vous n'avez pas la permission d'ouvrir ce menu.", "error")
            return
        end

    lib.registerContext({
        id = 'server_maintenance_menu',
        title = locale('titlemaintenanceserver'),
        menu = 'menu_menu',
        onBack = function(args) 
            lib.showContext('settings_menu')
        end,
        options = {
            {
                title = locale('titlerestartserver'),
                description = locale('titlerestartserver_desc'),
                icon = 'fas fa-sync',
                onSelect = function()
                    lib.registerContext({
                        id = 'confirmation_menu',
                        title = locale('titlejailconfirmation'),
                        menu = 'menu_menu',
                        onBack = function(args)
                            lib.showContext('server_maintenance_menu')
                        end,
                        options = {
                            {
                                title = locale('titlejailconfirmation2'),
                                description = locale('confirmerrestart_desc'),
                                icon = 'fas fa-check',
                                onSelect = function(args)
                                    TriggerServerEvent('menu_admin:restartServer')
                                    lib.showContext('server_maintenance_menu')
                                end
                            },
                            {
                                title = locale('titlejailconfirmation3'),
                                description = locale('cancelrestart_desc'),
                                icon = 'fas fa-times',
                                onSelect = function(args)
                                    lib.showContext('server_maintenance_menu')
                                end
                            }
                        },
                    })
            
                    lib.showContext('confirmation_menu')
                end,
            },
            {
                title = locale('titleannonce'),
                description = locale('titleannonce_desc'),
                icon = 'fas fa-tools',
                onSelect = function()
                    local input = lib.inputDialog('Ecrire une annonce', {'Titre de l\'annonce', 'Texte de l\'annonce'})
            
                    if not input then return end
                --    print(json.encode(input), input[1], input[2])
                    TriggerServerEvent('menu_admin:sendAnnouncement', input[1], input[2])
                end,
            }
        },
    })

    lib.registerContext({
        id = 'settings_menu',
        title = locale('titleparametreserver'),
        menu = 'menu_menu',
        onBack = function(args) 
            lib.showContext('admin_menu')
        end,
            options = {
                {
                    title = locale('titlegestionplayer'),
                    description = locale('titlegestionplayer'),
                    icon = 'fas fa-users-cog',
                    onSelect = function()
                        TriggerServerEvent('menu_admin:getAllUsers')
                    end,
                },
                {
                    title = locale('titlegestionresource'),
                    description = locale('titlegestionresource_desc'),
                    icon = 'fas fa-boxes',
                    onSelect = function()
                        TriggerServerEvent('menu_admin:getResources')
                    end,
                },
                {
                    title = locale('titlemaintenanceserver'),
                    description = locale('titlemaintenanceserver'),
                    icon = 'fas fa-tools',
                    onSelect = function()
                        lib.showContext('server_maintenance_menu')
                    end,
                },
            },
        })

        lib.showContext('settings_menu')
    end)
end)

function showAllUsers(users)
    local options = {}

    for _, user in ipairs(users) do
        table.insert(options, {
            title = user.name, 
            description = locale('license_desc').. user.license,
            icon = 'fa-user',
            onSelect = function()
                showUserOptions(user)
            end,
        })
    end

    lib.registerContext({
        id = 'all_users_menu',
        title = locale('titleallplayer'),
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('settings_menu')
        end,
        options = options,
    })

    lib.showContext('all_users_menu')
end

function showUserOptions(user)
    local options = {
        {
            title = locale('titleofflineban'),
            description = locale('titleofflineban_desc'),
            icon = 'fa-ban',
            onSelect = function()
                local input = lib.inputDialog('Details du Ban', {
                    {type = 'input', label = 'Raison du Ban', description = 'Entrez la raison du bannissement', required = true},
                    {type = 'number', label = 'Durée en heures', description = 'Entrez la durée du bannissement en heures', icon = 'hashtag'},
                    {type = 'checkbox', label = 'Ban permanent', description = 'Cocher pour un ban permanent'}
                })
        
                if not input then return end
        
                local reason = input[1]
                local hours = tonumber(input[2])
                local permanent = input[3]
        
                if reason and (hours or permanent) then
                    TriggerServerEvent('menu_admin:banPlayerOffline', user.license, reason, hours, permanent)
                else
                    print("Erreur: Raison ou durée de ban invalide")
                end
            end,
        },
        {
            title = locale('titlewipeplayer'),
            description = locale('titlewipeplayer_desc'),
            icon = 'fa-eraser',
            onSelect = function()
                local input = lib.inputDialog('Details du Wipe', {
                    {type = 'input', label = 'Raison du Wipe', description = 'Entrez la raison du wipe', required = true},
                    {type = 'checkbox', label = 'Wipe Complet', description = 'Cocher pour un wipe complet'}
                })
        
                if not input then return end
        
                local reason = input[1]
                local fullWipe = input[2]
        
                if reason then
                    if fullWipe then
                        TriggerServerEvent('menu_admin:fullWipePlayer', user.license, reason)
                    else
                        TriggerServerEvent('menu_admin:partialWipePlayer', user.license, reason)
                    end
                else
                    print("Erreur: Raison de wipe invalide")
                end
            end,
        }
    }

    lib.registerContext({
        id = 'user_options_menu',
        title = locale('titleoptionfor') .. user.name,
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('all_users_menu')
        end,
        options = options,
    })

    lib.showContext('user_options_menu')
end

RegisterNetEvent('menu_admin:showAllUsers')
AddEventHandler('menu_admin:showAllUsers', function(users)
    showAllUsers(users)
end)

RegisterNetEvent('menu_admin:showResources')
AddEventHandler('menu_admin:showResources', function(resources)
    local options = {}

    for i, resource in ipairs(resources) do
        table.insert(options, {
            title = resource,
            description = locale('titlegestionsource'),
            onSelect = function()
                lib.registerContext({
                    id = 'resource_management_' .. resource,
                    title = locale('titlegestionof') .. resource,
                    menu = 'menu_menu',
                    onBack = function(args)
                        lib.showContext('resources_menu')
                    end,
                    options = {
                        {
                            title = locale('titlerestartsource'),
                            description = locale('titlerestartsource_desc') .. resource,
                            icon = 'fa-redo',
                            onSelect = function()
                                ExecuteCommand('restart ' .. resource)
                                lib.showContext('resource_management_' .. resource)
                            end,
                        },
                        {
                            title = locale('titlestartsource'),
                            description = locale('titlestartsource_desc') .. resource,
                            icon = 'fa-play',
                            onSelect = function()
                                ExecuteCommand('start ' .. resource)
                                lib.showContext('resource_management_' .. resource)
                            end,
                        },
                        {
                            title = locale('titlestopsource'),
                            description = locale('titlestopsource_desc') .. resource,
                            icon = 'fa-stop', 
                            onSelect = function()
                                ExecuteCommand('stop ' .. resource)
                                lib.showContext('resource_management_' .. resource)
                            end,
                        },
                    },
                })

                lib.showContext('resource_management_' .. resource)
            end,
        })
    end

    lib.registerContext({
        id = 'resources_menu',
        title = locale('titlesource'),
        menu = 'menu_menu',
        onBack = function(args)
            lib.showContext('settings_menu')
        end,
        options = options,
    })

    lib.showContext('resources_menu')
end)

function openDeveloperMenu()
    getGroup(function(userGroup)
        local allowedGroups = Config.Groups.DeveloperMenu
        if not isInList(allowedGroups, userGroup) then
            ShowNotification("Vous n'avez pas la permission d'ouvrir ce menu.", "error")
            return
        end

        local coordsSubMenuOptions = {
            {
                title = locale('titleaffichecoords'),
                description = locale('titleaffichecoords_desc'),
                icon = 'fas fa-map-marker-alt',
                onSelect = function()
                    TriggerEvent('toggleCoordsDisplay')
                    lib.showContext('coords_sub_menu')
                end,
            },
            {
                title = locale('titlevector3'),
                description = locale('titlevector3_desc'),
                icon = 'fas fa-code',
                onSelect = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    SendNUIMessage({
                        coords = ""..coords.x..", "..coords.y..", "..coords.z
                    })
                    lib.showContext('coords_sub_menu')
                end,
            },
            {
                title = locale('titlevector4'),
                description = locale('titlevector4_desc'),
                icon = 'fas fa-code',
                onSelect = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    local heading = GetEntityHeading(PlayerPedId())
                    SendNUIMessage({
                        coords = ""..coords.x..", "..coords.y..", "..coords.z..", "..heading
                    })
                    lib.showContext('coords_sub_menu')
                end,
            },
            {
                title = locale('setcoords'),
                description = locale('setcoords_desc'),
                icon = 'fas fa-code',
                onSelect = function()
                    local input = lib.inputDialog(locale('entercoords'), {
                        {type = 'input', label = locale('entercoordslabel')},
                    })

                    if not input then return end

                    local GetEntityCoords = input[1]

                    ExecuteCommand('setcoords ' .. GetEntityCoords)
                    lib.showContext('coords_sub_menu')
                end,
            },
        }

        lib.registerContext({
            id = 'coords_sub_menu',
            title = locale('titleoptioncoord'),
            menu = 'developer_menu',
            onBack = function(args)
                lib.showContext('developer_menu')
            end,
            options = coordsSubMenuOptions,
        })

        local pedSubMenuOptions = {
            {
                title = locale('titlecreeped'),
                description = locale('titlecreeped_desc'),
                icon = 'fas fa-user-plus',
                onSelect = function()
                    local pedDetailsSubMenuOptions = {
                        {
                            title = locale('titlenameped'),
                            description = locale('titlenameped_desc'),
                            icon = 'fas fa-user',
                            onSelect = function()
                                local input = lib.inputDialog(locale('titlenameped'), {locale('titlenameped_desc')})
                                
                                if not input then return end
                                pedModel = input[1]
                                print("Model du ped: " .. pedModel)
                                lib.showContext('ped_details_sub_menu')
                            end
                        }, 
                        {
                            title = locale('coordsduped'),
                            description = locale('coordsduped_desc'),
                            icon = 'fas fa-map-marker-alt',
                            onSelect = function()
                                local coordsSelected = false
                        
                                lib.showTextUI('[E] - Select to coords', {
                                    position = "top-center",
                                    icon = 'hand',
                                    style = {
                                        borderRadius = 0,
                                        backgroundColor = '#48BB78',
                                        color = 'white'
                                    }
                                })
                        
                                RegisterKeyMapping('e', 'Select to coords', 'keyboard', 'e')
                                RegisterCommand('e', function()
                                    if not coordsSelected then
                                        local playerPed = PlayerPedId()
                                        playerCoords = GetEntityCoords(playerPed)
                                        playerHeading = GetEntityHeading(playerPed)
                                        print(('Selected Coords: %s, Heading: %s'):format(playerCoords, playerHeading))
                                        coordsSelected = true
                                        lib.hideTextUI()
                                        lib.showContext('ped_details_sub_menu')
                                    end
                                end, false)
                            end
                        },
                        {
                            title = locale('titleconfirmped'),
                            description = locale('titleconfirmped_desc'),
                            icon = 'fas fa-check',
                            onSelect = function()
                                lib.registerContext({
                                    id = 'confirmation_menu',
                                    title = locale('titleconfirmped'),
                                    menu = 'ped_details_sub_menu',
                                    onBack = function(args)
                                        lib.showContext('ped_details_sub_menu')
                                    end,
                                    options = {
                                        {
                                            title = locale('titleconfirmationyesped'),
                                            description = locale('confirmyesped_desc'),
                                            icon = 'fas fa-check',
                                            onSelect = function(args)
                                                TriggerServerEvent('insertCoords', playerCoords, playerHeading, pedModel)
                                                Citizen.CreateThread(function()
                                                    Wait(5000)
                                                    TriggerEvent('createPed', pedModel, playerCoords, playerHeading)
                                                end)
                                            end
                                        },
                                        {
                                            title = locale('titleconfirmationnoped'),
                                            description = locale('confirmnoped_desc'),
                                            icon = 'fas fa-times',
                                            onSelect = function(args)
                                            end
                                        }
                                    },
                                })
                        
                                lib.showContext('confirmation_menu')
                            end
                        },
                    }
            
                    lib.registerContext({
                        id = 'ped_details_sub_menu',
                        title = locale('titleoptionped'),
                        menu = 'ped_sub_menu',
                        onBack = function(args)
                            lib.showContext('ped_sub_menu')
                        end,
                        options = pedDetailsSubMenuOptions,
                    })
                    
                    lib.showContext('ped_details_sub_menu')
                end,
            },
            {
                title = locale('titlemodifped'),
                description = locale('titlemodifped_desc'),
                icon = 'fas fa-user-edit',
                onSelect = function()
                    TriggerServerEvent('menu_admin:requestPedList')
                end,
            },
        }

        lib.registerContext({
            id = 'ped_sub_menu',
            title = locale('titleoptionped'),
            menu = 'developer_menu',
            onBack = function(args)
                lib.showContext('developer_menu')
            end,
            options = pedSubMenuOptions,
        })

        local options = {
            {
                title = locale('titlecoord'),
                description = locale('titlecoord_desc'),
                icon = 'fas fa-map-marker-alt',
                onSelect = function()
                    lib.showContext('coords_sub_menu')
                end,
            },
        }

        --[[
                        {
                title = locale('titleped'),
                description = locale('titleped_desc'),
                icon = 'fas fa-user',
                onSelect = function()
                    lib.showContext('ped_sub_menu') 
                end,
            }
        ]]

        lib.registerContext({
            id = 'developer_menu',
            title = locale('titlemenudev'),
            menu = 'main_menu',
            onBack = function(args)
                lib.showContext('admin_menu')
            end,
            options = options,
        })

        lib.showContext('developer_menu')
    end)
end

RegisterNetEvent('menu_admin:receivePedList')
AddEventHandler('menu_admin:receivePedList', function(peds)
    local menu = {
        title = 'Liste des Peds',
        items = {}
    }

    for i, ped in ipairs(peds) do
        table.insert(menu.items, {
            title = 'Ped model: ' .. ped.model,
            description = 'Coordonnées: (' .. ped.coordX .. ', ' .. ped.coordY .. ', ' .. ped.coordZ .. ') Heading: ' .. ped.heading,
            onSelect = function()
            end,
        })
    end

    lib.showMenu(menu)
end)

RegisterNetEvent('openStaffModeMenu')
AddEventHandler('openStaffModeMenu', openStaffModeMenu)

RegisterNetEvent('openAdminMenu')
AddEventHandler('openAdminMenu', openAdminMenu)

RegisterNetEvent('menu_admin:teleportToPosition')
AddEventHandler('menu_admin:teleportToPosition', function(position)
    local ped = PlayerPedId()
    SetEntityCoords(ped, position.x, position.y, position.z)
end)

RegisterCommand('menuadmin', function()
    ESX.TriggerServerCallback('getPlayerGroup', function(group)
        if isInList(Config.Groups.OpenMenu, group) then
            TriggerServerEvent('getStaffModeState')
        else
            ShowNotification('Vous n\'avez pas les droits nécessaires pour ouvrir ce menu.', 'error')
        end
    end)
end, false)

RegisterNetEvent('receiveStaffModeState')
AddEventHandler('receiveStaffModeState', function(isStaffModeEnabled)
    if isStaffModeEnabled then
        openAdminMenu()
    else
        openStaffModeMenu()
    end
end)

RegisterKeyMapping('menuadmin', 'Ouvrir le menu admin', 'keyboard', 'F10')

function isInList(list, value)
    for i=1, #list do
        if list[i] == value then
            return true
        end
    end

    return false
end

function getGroup(cb)
    ESX.TriggerServerCallback('getPlayerGroup', function(group)
        cb(group)
    end)
end

RegisterNetEvent('menu_admin:menuRestart')
AddEventHandler('menu_admin:menuRestart', function()
    TriggerServerEvent('menu_admin:requestPedsToRecreate')
end)

-- Fonction Jail

local jailedPlayers = {}

RegisterNetEvent('showJailMessage')
AddEventHandler('showJailMessage', function(jailerName, jailTime, reason)
  local playerId = source
  jailedPlayers[playerId] = true
  local endTime = GetGameTimer() + jailTime * 60000
  local timerId = 'jailTimer'..playerId

  Citizen.CreateThread(function()
    while GetGameTimer() < endTime and jailedPlayers[playerId] do
      Citizen.Wait(1000)

      local remainingTime = (endTime - GetGameTimer()) / 1000
      local remainingMinutes = math.floor(remainingTime / 60)
      local remainingSeconds = math.floor(remainingTime % 60)
      local message = "Vous avez été jail par : " .. jailerName .. ".\nRaison : " .. reason .. "\nTemps restant : " .. remainingMinutes .. " minutes et " .. remainingSeconds .. " secondes."

      DisplayHelpTextThisFrame(timerId, message)
    end
    if not jailedPlayers[playerId] then
      ClearHelp(timerId, false)
    end
  end)
end)

RegisterNetEvent('unjailPlayer')
AddEventHandler('unjailPlayer', function()
  local playerId = source
  Citizen.SetTimeout(1000, function()
    jailedPlayers[playerId] = nil
  end)
end)

function DisplayHelpTextThisFrame(id, text)
  AddTextEntry(id, text)
  BeginTextCommandDisplayHelp(id)
  EndTextCommandDisplayHelp(0, false, true, -1)
end

RegisterNetEvent('showReleaseMessage')
AddEventHandler('showReleaseMessage', function()
    local message = 'Vous avez été libéré de prison. Faites attention à votre comportement la prochaine fois.'

    ESX.ShowNotification(message)
end)

-- Blips

local blips = {}

Citizen.CreateThread(function()
    while true do
        local Time = 5000

        if blipsActive then
            Time = 0
            local players = GetActivePlayers()

            for i=1, #players do
                local player = players[i]

                if player ~= PlayerId() then
                    local ped = GetPlayerPed(player)
                    local blip = blips[player]

                    if not (blip and DoesBlipExist(blip)) then
                        blip = AddBlipForEntity(ped)
                        SetBlipCategory(blip, 7)
                        SetBlipScale(blip, 0.85)
                        ShowHeadingIndicatorOnBlip(blip, true)
                        SetBlipSprite(blip, 1)
                        SetBlipColour(blip, 0)
                        SetBlipNameToPlayerName(blip, player)
                        blips[player] = blip
                    end

                    local veh = GetVehiclePedIsIn(ped, false)
                    local blipSprite = GetBlipSprite(blip)

                        if IsEntityDead(ped) then
                            if blipSprite ~= 303 then
                                SetBlipSprite( blip, 303 )
                                SetBlipColour(blip, 3)
                                ShowHeadingIndicatorOnBlip( blip, false )
                            end
                        elseif veh ~= nil then
                            if IsPedInAnyBoat( ped ) then
                                if blipSprite ~= 427 then
                                    SetBlipSprite( blip, 427 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyHeli( ped ) then
                                if blipSprite ~= 43 then
                                    SetBlipSprite( blip, 43 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyPlane( ped ) then
                                if blipSprite ~= 423 then
                                    SetBlipSprite( blip, 423 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyPoliceVehicle( ped ) then
                                if blipSprite ~= 137 then
                                    SetBlipSprite( blip, 137 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnySub( ped ) then
                                if blipSprite ~= 308 then
                                    SetBlipSprite( blip, 308 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyVehicle( ped ) then
                                if blipSprite ~= 225 then
                                    SetBlipSprite( blip, 225 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            else
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, true )
                                end
                            end
                        else
                            if blipSprite ~= 1 then
                                SetBlipSprite( blip, 1 )
                                SetBlipColour(blip, 0)
                                ShowHeadingIndicatorOnBlip( blip, true )
                            end
                        end
                        if veh then
                            SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                        else
                            SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
                        end
                    end
                end
            else
                for player, blip in pairs(blips) do
                    if DoesBlipExist(blip) then
                        RemoveBlip(blip)
                    end
                end
                blips = {}
            end
    
            Wait(Time)
        end
    end)

-- Fonction Afficher Nom Joueur + ID

local mpDebugMode = false
RegisterCommand("adminDebug", function()
    mpDebugMode = not mpDebugMode
    if mpDebugMode then
        ESX.ShowNotification("Debug activé")
    else
        ESX.ShowNotification("Debug désactivé")
    end
end)

local gamerTags = {}

function showNames(bool)
    isNameShown = bool
    if isNameShown then
        Citizen.CreateThread(function()
            while isNameShown do
                local plyPed = PlayerPedId()
                for _, player in pairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    if ped ~= plyPed then
                        if #(GetEntityCoords(plyPed, false) - GetEntityCoords(ped, false)) < 5000.0 then
                            gamerTags[player] = CreateFakeMpGamerTag(ped, ('[%s] %s'):format(GetPlayerServerId(player), GetPlayerName(player)), false, false, '', 0)
                            SetMpGamerTagAlpha(gamerTags[player], 0, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 2, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 4, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 7, 255)
                            SetMpGamerTagVisibility(gamerTags[player], 0, true)
                            SetMpGamerTagVisibility(gamerTags[player], 2, true)
                            SetMpGamerTagVisibility(gamerTags[player], 4, NetworkIsPlayerTalking(player))
                            SetMpGamerTagVisibility(gamerTags[player], 7, DecorExistOn(ped, "staffl") and DecorGetInt(ped, "staffl") > 0)
                            SetMpGamerTagColour(gamerTags[player], 7, 55)
                            if NetworkIsPlayerTalking(player) then
                                SetMpGamerTagHealthBarColour(gamerTags[player], 211)
                                SetMpGamerTagColour(gamerTags[player], 4, 211)
                                SetMpGamerTagColour(gamerTags[player], 0, 211)
                            else
                                SetMpGamerTagHealthBarColour(gamerTags[player], 0)
                                SetMpGamerTagColour(gamerTags[player], 4, 0)
                                SetMpGamerTagColour(gamerTags[player], 0, 0)
                            end
                            if DecorExistOn(ped, "staffl") then
                                SetMpGamerTagWantedLevel(ped, DecorGetInt(ped, "staffl"))
                            end
                            if mpDebugMode then
                                print(json.encode(DecorExistOn(ped, "staffl")).." - "..json.encode(DecorGetInt(ped, "staffl")))
                            end
                        else
                            RemoveMpGamerTag(gamerTags[player])
                            gamerTags[player] = nil
                        end
                    end
                end
                Wait(100)
            end
            for k,v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
        end)
    end
end

RegisterNetEvent('esx_adminmenu:toggleIdsAndNames')
AddEventHandler('esx_adminmenu:toggleIdsAndNames', function()
    showIdsAndNames = not showIdsAndNames
end)

function GetPlayers()
    local players = {}

    local activePlayers = GetActivePlayers()
    for _, playerId in ipairs(activePlayers) do
        local playerName = GetPlayerName(playerId)
        local serverId = GetPlayerServerId(playerId)
        table.insert(players, {name = playerName, id = serverId})
    end

    return players
end

-- Fonction NoClip

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
    local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

    if len ~= 0 then
        coords = coords / len
    end

    return coords
end

function NoClip(bool)
    if permLevel == "user" then
        return
    end
    if not isStaffModeEnabled then
        ESX.ShowNotification("~r~[Staff] ~s~Vous devez avoir le staff mode activé pour faire cela !")
        return
    end
    isNoClip = bool
    if isNoClip then
        SetEntityInvincible(PlayerPedId(), true)
        Citizen.CreateThread(function()
            while isNoClip do
                Wait(1)
                local pCoords = GetEntityCoords(PlayerPedId(), false)
                local camCoords = getCamDirection()
                SetEntityVelocity(PlayerPedId(), 0.01, 0.01, 0.01)
                SetEntityCollision(PlayerPedId(), 0, 1)
                FreezeEntityPosition(PlayerPedId(), true)

                if IsControlPressed(0, 32) then
                    pCoords = pCoords + (NoClipSpeed * camCoords)
                end

                if IsControlPressed(0, 269) then
                    pCoords = pCoords - (NoClipSpeed * camCoords)
                end

                if IsDisabledControlJustPressed(1, 15) then
                    NoClipSpeed = NoClipSpeed + 0.3
                end
                if IsDisabledControlJustPressed(1, 14) then
                    NoClipSpeed = NoClipSpeed - 0.3
                    if NoClipSpeed < 0 then
                        NoClipSpeed = 0
                    end
                end
                SetEntityCoordsNoOffset(PlayerPedId(), pCoords, true, true, true)
                SetEntityVisible(PlayerPedId(), 0, 0)

            end
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(PlayerPedId(), 1, 0)
            SetEntityCollision(PlayerPedId(), 1, 1)
        end)
    else
        SetEntityInvincible(PlayerPedId(), false)
    end
end

RegisterCommand("+noclip-admin", function()
    if GetEntityHealth(PlayerPedId()) > 0 then
        if ESX.GetPlayerData()['group'] ~= 'user' and isStaffModeEnabled then
            NoClip(not isNoClip)
        else
            ESX.ShowNotification("Vous n'êtes pas en mode staff !")
        end
    end
end, false)
RegisterKeyMapping('+noclip-admin', 'Raccourci Noclip', 'keyboard', 'F4')

-- annonce

local annonceState = false
local texteAnnonce = ""
local annonceTitle = ""

RegisterNetEvent('menu_admin:receiveAnnouncement')
AddEventHandler('menu_admin:receiveAnnouncement', function(title, message)
    annonceState = true
    texteAnnonce = message
    annonceTitle = title

    PlaySoundFrontend(-1, "5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset", 1)

    Citizen.CreateThread(function()
        Citizen.Wait(10000)
        annonceState = false
    end)
end)

Citizen.CreateThread(function()
    while true do    
        if annonceState then
            DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
            DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, '~r~ ' .. annonceTitle .. ' ~d~', 255, 255, 255, 255, 1, 0)
            DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteAnnonce, 255, 255, 255, 255, 7, 0)
            DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end
    end
end)

function DrawAdvancedTextCNN(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

-- Afficher les coordonées

RegisterNetEvent('toggleCoordsDisplay')
AddEventHandler('toggleCoordsDisplay', function()
    isDisplayingCoords = not isDisplayingCoords
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(1) 
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(1, 1, 1, 1, 255) 
        SetTextOutline() 
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    while true do
        if isDisplayingCoords then
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed, false)
            local heading = GetEntityHeading(pPed)
            local text = string.format("~r~X: %.2f~w~, ~g~Y: %.2f~w~, ~b~Z: %.2f~w~, ~y~Heading: %.2f", pCoords.x, pCoords.y, pCoords.z, heading)
            DrawText3D(pCoords.x, pCoords.y, pCoords.z, text)
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end
    end
end)

-- Création ped

RegisterNetEvent('createPed', function(pedModel, coords, heading)
    local vectorCoords = vector3(coords.x, coords.y, coords.z -1)
    
    Citizen.CreateThread(function()
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(500)
        end
        
        local ped = CreatePed(1, pedModel, vectorCoords, heading, false, false)
        SetEntityInvincible(ped, true)
        SetPedCanRagdoll(ped, false) 
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskSetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetPedCanBeKnockedOffVehicle(ped, false) 
        SetPedFleeAttributes(ped, 0, 0)

        TaskStandStill(ped, -1)

        PlaceObjectOnGroundProperly(ped)
        SetModelAsNoLongerNeeded(pedModel)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    end)
end)

RegisterNetEvent('createPedAgain')
AddEventHandler('createPedAgain', function(pedModel, coords, heading)
    print("Received createPedAgain event.")
    Citizen.CreateThread(function()
        local hash = GetHashKey(pedModel)

        RequestModel(hash)

        local counter = 0
        while not HasModelLoaded(hash) do
            Wait(1)

            counter = counter + 1
            if counter > 5000 then
                print("Failed to load model.")
                return
            end
        end

        if not IsModelValid(hash) then
            print("Model is not valid: " .. pedModel)
            return
        end

        print("Creating ped with model: " .. pedModel .. ", coords: (" .. coords.x .. ", " .. coords.y .. ", " .. coords.z .. "), heading: " .. heading)
        local createdPed = CreatePed(1, hash, coords.x, coords.y, coords.z, heading, false, true)

        if not DoesEntityExist(createdPed) then
            print("Ped does not exist: " .. tostring(createdPed))
            return
        end

        print("Ped created: " .. tostring(createdPed))

        SetEntityInvincible(createdPed, true)
        SetPedCanRagdoll(createdPed, false) 
        SetBlockingOfNonTemporaryEvents(createdPed, true)
        TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
        FreezeEntityPosition(createdPed, true)
        SetPedCanBeKnockedOffVehicle(createdPed, false) 
        SetPedFleeAttributes(createdPed, 0, 0)
        TaskStandStill(createdPed, -1)
        TaskStartScenarioInPlace(createdPed, "WORLD_HUMAN_CLIPBOARD", 0, true)

        SetModelAsNoLongerNeeded(hash)
    end)
end)