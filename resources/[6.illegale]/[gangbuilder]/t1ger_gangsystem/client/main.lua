
Core, Cfg = exports['t1ger_lib']:GetLib()
Lib = exports['t1ger_lib']:GetUtils()
plyGangId = 0
memberData = nil
t1ger_gangs = {}
marker_blips = {}

Citizen.CreateThread(function()
    if Core == nil or Core.FrameworkReady() == nil then 
        return error("please start t1ger_lib resource before you start t1ger_gangsystem")
    end
    while not Core.FrameworkReady() do Wait(1000); end
    Core.GetJob()
    if Config.Debug then
        Wait(3000)
        TriggerServerEvent('gangsystem:server:playerLoaded')
    end
end)

player, coords = nil, {}
Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        Wait(500)
    end
end)

function IsTargetZiptied(target)
    local resultas = false
    Core.TriggerCallback('gangsystem:server:isPlayerZiptied', function(result)
        resultas = result
    end, target)
    Wait(250)
    return resultas
end

RegisterNetEvent('gangsystem:client:setPlayerGangId')
AddEventHandler('gangsystem:client:setPlayerGangId', function(id)
    plyGangId = id
end)

RegisterNetEvent('gangsystem:client:setGangs')
AddEventHandler('gangsystem:client:setGangs', function(data, cfg)
    t1ger_gangs = data
end)

RegisterNetEvent('gangsystem:client:racketConfig')
AddEventHandler('gangsystem:client:racketConfig', function(cfg)
    Config.Rackets = cfg
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent('gangsystem:server:playerLoaded')
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	TriggerServerEvent('gangsystem:server:playerLoaded')
end)

RegisterNetEvent('gangsystem:client:createMarkerBlips')
AddEventHandler('gangsystem:client:createMarkerBlips', function(gangId)
	CreateMarkerBlips(gangId)
end)

function CreateMarkerBlips(gangid)
    Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
        if result ~= nil then
        end
    end)
end

RegisterNetEvent('gangsystem:client:showTextUi', function(text)
    lib.showTextUI(text, {
        position = "right-center",
        icon = 'hand',
        style = {
            borderRadius = 0,
            backgroundColor = '#48BB78',
            color = 'white'
        }
    })
end)

local ContractNPC, BlipContractNPC = nil, nil
RegisterNetEvent('gangsystem:client:createNPC')
AddEventHandler('gangsystem:client:createNPC', function(data)

    if ContractNPC ~= nil then
        DeleteEntity(ContractNPC)
        Wait(250)
    end

    Lib.LoadModel(Config.ContractNPC.Model)
    ContractNPC = CreatePed(7, GetHashKey(Config.ContractNPC.Model), Config.ContractNPC.Pos.x, Config.ContractNPC.Pos.y, Config.ContractNPC.Pos.z-0.975, Config.ContractNPC.Pos.w, 0, true, true)
    FreezeEntityPosition(ContractNPC, true)
    SetBlockingOfNonTemporaryEvents(ContractNPC, true)
    TaskStartScenarioInPlace(ContractNPC, Config.ContractNPC.Scenario, 0, false)
    SetEntityInvincible(ContractNPC, true)
    SetEntityAsMissionEntity(ContractNPC)
    
    -- Blip:
    if plyGangId > 0 then
        BlipContractNPC = CreateMapBlip(Config.ContractNPC.Blip, Config.ContractNPC.Pos)
    end

    local npc_options = {
        options = {
            {
                name = 'gangsystem:contract_npc',
                event = 'gangsystem:client:rackets',
                icon = 'fa-solid fa-person',
                label = Lang['access_rackets'],
                type = 'client',
                canInteract = nil,
                distance = Config.ContractNPC.InteractDist,
            }
        },
        distance = Config.ContractNPC.InteractDist,
        canInteract = nil
    }

    Lib.AddLocalEntity(ContractNPC, npc_options)
end)

-- Gang Admin Menu Command:
if Config.AdminMenu.Command.Enable == true then
    RegisterCommand(Config.AdminMenu.Command.String, function()
        Core.TriggerCallback('gangsystem:server:isAdmin', function(isAdmin)
            if isAdmin then
                AdminGangMenu()
            else
                if Config.Debug then
                    print("you are not an admin.")
                end
            end
        end)
    end)
end

-- Gang Admin Menu Keybind:
if Config.AdminMenu.Keybind.Enable == true then
    RegisterCommand('openAdminGangMenu', function()
        Core.TriggerCallback('gangsystem:server:isAdmin', function(isAdmin)
            if isAdmin then
                AdminGangMenu()
            else
                if Config.Debug then
                    print("you are not an admin.")
                end
            end
        end)
    end, false)
    RegisterKeyMapping('openAdminGangMenu', 'Open Admin Gang Menu', 'keyboard', Config.AdminMenu.Keybind.DefaultMapping)
end

-- Gang Main Menu [ADMIN]
AdminGangMenu = function()
    lib.registerContext({
        id = 'admin_gang_menu',
        title = Lang['gang_admin_menu'],
        options = {
            {
                title = Lang['view_gangs'],
                icon = 'list',
                description = Lang['click_to_view_gangs'],
                event = 'gangsystem:client:viewGangs',
                arrow = true,
            },
            {
                title = Lang['create_gang'],
                icon = 'plus',
                description = Lang['click_to_create gang'],
                onSelect = function(args)
                    local input = lib.inputDialog(Lang['create_gang'], {Lang['input_gang_name'], Lang['input_leader_player_id']})
    
                    if not input then
                        return AdminGangMenu()
                    end
    
                    local name = input[1]
                    local src = tonumber(input[2])
                    local player = GetPlayerFromServerId(src)
    
                    if not name then
                        Core.Notification({
                            title = '',
                            message = Lang['enter_gang_name'],
                            type = 'error'
                        })
                        return AdminGangMenu()
                    elseif not src then
                        Core.Notification({
                            title = '',
                            message = Lang['enter_player_id'],
                            type = 'error'
                        })
                        return AdminGangMenu()
                    elseif player == -1 then
                        Core.Notification({
                            title = '',
                            message = Lang['incorrect_player_id'],
                            type = 'error'
                        })
                        return AdminGangMenu()
                    end
    
                    TriggerServerEvent('gangsystem:server:createGang', name, src, player)
                end,
            },
        },
    })
    lib.showContext('admin_gang_menu')
end

-- Create Gang [ADMIN]:
RegisterNetEvent('gangsystem:client:viewGangs', function()
    local menuOptions = {}
    Core.TriggerCallback('gangsystem:server:getGangs', function(results)
        if results and next(results) then
            for id, gang in pairs(results) do 
                table.insert(menuOptions, {
                    title = gang.name,
                    icon = 'people-group',
                    args = gang,
                    description = Lang['click_to_view_selected_gang'],
                    metadata = {
                        {label = 'ID', value = gang.id},
                        {label = 'Leader', value = gang.leader},
                        {label = 'Notoriety', value = gang.notoriety},
                        {label = 'Cash', value = gang.cash},
                    },
                    event = 'gangsystem:client:manageGang',
                })
            end
            lib.registerContext({
                id = 'admin_view_gangs',
                title = Lang['view_gangs_admin'],
                menu = 'admin_gang_menu',
                onBack = function()
                    AdminGangMenu()
                end,
                options = menuOptions
            })
            lib.showContext('admin_view_gangs')
        else
            Core.Notification({
                title = '',
                message = Lang['no_gangs'],
                type = 'error'
            })
        end
    end)
end)

-- Manage Selected Gang [ADMIN]:
RegisterNetEvent('gangsystem:client:manageGang', function(data)
    lib.registerContext({
        id = 'admin_manage_gangs',
        title = Lang['manage_gang']:format(data.name),
        menu = 'admin_view_gangs',
        onBack = function()
            TriggerEvent('gangsystem:client:viewGangs')
        end,
        options = {
            {title = Lang['title_notoriety_p_m'], description = Lang['click_to_notoriety_p_m'], icon = 'star', args = data, event = 'gangsystem:client:updateGangNotoriety'},
            {title = Lang['title_cash_p_m'], description = Lang['click_to_cash_p_m'], icon = 'dollar', args = data, event = 'gangsystem:client:updateGangCash'},
            {title = Lang['title_delete_gang'], description = Lang['click_to_delete_gang'], icon = 'trash', args = data, event = 'gangsystem:client:deleteGang'},
            {title = Lang['title_change_leader'], description = Lang['click_to_change_leader'], icon = 'rotate', args = data, event = 'gangsystem:client:changeGangLeader'},
            {title = Lang['title_disable_gang'], description = Lang['click_to_enable_disable_gang'], icon = 'shield', args = data, event = 'gangsystem:client:disableGang'},
        },
    })
    lib.showContext('admin_manage_gangs')
end)

-- Update Gang Notoriety [ADMIN]:
RegisterNetEvent('gangsystem:client:updateGangNotoriety', function(data)
    lib.registerContext({
        id = 'update_gang_notoriety',
        title = Lang['gang_notoriety_x']:format(data.notoriety),
        menu = 'admin_manage_gangs',
        options = {
            {
                title = Lang['action_plus'],
                icon = 'plus',
                args = data,
                onSelect = function(args)
                    local input = lib.inputDialog(Lang['input_plus_n'], {
                        {type = "number", label = Lang['input_amount'], description = Lang['input_d_enter_n_points']},
                    })
    
                    if not input then
                        return TriggerEvent('gangsystem:client:updateGangNotoriety', data)
                    end

                    if type(input[1]) ~= 'number' or input[1] == '' or input[1] == ' ' or input[1] == nil or input[1] == false then
                        Core.Notification({
                            title = '',
                            message = Lang['input_required'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangNotoriety', data)
                    end

                    if input[1] <= 0 then
                        Core.Notification({
                            title = '',
                            message = Lang['input_amount_higher_0'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangNotoriety', data)
                    end

                    TriggerServerEvent('gangsystem:server:plusNotoriety', args.id, input[1])
                    TriggerEvent('gangsystem:client:viewGangs')
                end
            },
            {
                title = Lang['action_minus'],
                icon = 'minus',
                args = data,
                onSelect = function(args)
                    local input = lib.inputDialog(Lang['input_minus_n'], {
                        {type = "number", label = Lang['input_amount'], description = Lang['input_d_enter_n_points']},
                    })
    
                    if not input then
                        return TriggerEvent('gangsystem:client:updateGangNotoriety', data)
                    end

                    if type(input[1]) ~= 'number' or input[1] == '' or input[1] == ' ' or input[1] == nil or input[1] == false then
                        Core.Notification({
                            title = '',
                            message = Lang['input_required'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangNotoriety', data)
                    end

                    if input[1] <= 0 then
                        Core.Notification({
                            title = '',
                            message = Lang['input_amount_higher_0'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangNotoriety', data)
                    end

                    TriggerServerEvent('gangsystem:server:minusNotoriety', args.id, input[1])
                    TriggerEvent('gangsystem:client:viewGangs')
                end
            },
        },
    })
    lib.showContext('update_gang_notoriety')
end)

-- Update Gang Cash [ADMIN]:
RegisterNetEvent('gangsystem:client:updateGangCash', function(data)
    lib.registerContext({
        id = 'update_gang_cash',
        title = Lang['gang_cash_locker']:format(data.cash),
        menu = 'admin_manage_gangs',
        options = {
            {
                title = Lang['action_plus'],
                icon = 'plus',
                args = data,
                onSelect = function(args)
                    local input = lib.inputDialog(Lang['input_plus_c'], {
                        {type = 'number', label = Lang['input_amount'], description = Lang['input_d_enter_cash_add']},
                    })
    
                    if not input then
                        return TriggerEvent('gangsystem:client:updateGangCash', data)
                    end

                    if type(input[1]) ~= 'number' or input[1] == '' or input[1] == ' ' or input[1] == nil or input[1] == false then
                        Core.Notification({
                            title = '',
                            message = Lang['input_required'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangCash', data)
                    end

                    if input[1] <= 0 then
                        Core.Notification({
                            title = '',
                            message = Lang['input_amount_higher_0'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangCash', data)
                    end

                    TriggerServerEvent('gangsystem:server:plusGangCash', args.id, input[1])
                    TriggerEvent('gangsystem:client:viewGangs')
                end
            },
            {
                title = Lang['action_minus'],
                icon = 'minus',
                args = data,
                onSelect = function(args)
                    local input = lib.inputDialog(Lang['input_minus_c'], {
                        {type = 'number', label = Lang['input_amount'], description = Lang['input_d_enter_cash_remove']},
                    })
    
                    if not input then
                        return TriggerEvent('gangsystem:client:updateGangCash', data)
                    end

                    if type(input[1]) ~= 'number' or input[1] == '' or input[1] == ' ' or input[1] == nil or input[1] == false then
                        Core.Notification({
                            title = '',
                            message = Lang['input_required'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangCash', data)
                    end

                    if input[1] <= 0 then
                        Core.Notification({
                            title = '',
                            message = Lang['input_amount_higher_0'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:updateGangCash', data)
                    end

                    TriggerServerEvent('gangsystem:server:minusGangCash', args.id, input[1])
                    TriggerEvent('gangsystem:client:viewGangs')
                end
            },
        },
    })
    lib.showContext('update_gang_cash')
end)

-- Delete Gang [ADMIN]:
RegisterNetEvent('gangsystem:client:deleteGang', function(data)
    lib.registerContext({
        id = 'confirm_delete_gang',
        title = Lang['delete_gang_title'],
        canClose = false,
        menu = 'admin_manage_gangs',
        options = {
            {
                title = Lang['confirm'],
                description = Lang['click_to_delete_gang'],
                icon = "check",
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('gangsystem:server:deleteGang', args)
                end
            },
            {
                title = Lang['decline'],
                description = Lang['click_to_cancel_return'],
                icon = "ban",
                args = data,
                event = 'gangsystem:client:manageGang'
            },
        },
    })
    lib.showContext('confirm_delete_gang')
end)

-- Change Gang Leader [ADMIN]:
RegisterNetEvent('gangsystem:client:changeGangLeader', function(data)
    local players = {}
    Core.TriggerCallback('t1ger_lib:getOnlinePlayers', function(results)
        for i = 1, #results, 1 do
            table.insert(players, {
                title = results[i].name,
                icon = 'user',
                description = Lang['click_to_change_leader'],
                metadata = {
                    {label = Lang['player_id'], value = results[i].source},
                },
                args = {gang = data, player = results[i]},
                onSelect = function(args)
                    TriggerServerEvent('gangsystem:server:setLeader', args)
                end
            })
        end
        lib.registerContext({
            id = 'change_gang_leader',
            title = Lang['change_gang_leader'],
            menu = 'admin_manage_gangs',
            options = players
        })
        lib.showContext('change_gang_leader')
    end)

end)

-- Disable/Enable Gang [ADMIN]:
RegisterNetEvent('gangsystem:client:disableGang', function(data)
    lib.registerContext({
        id = 'disable_enable_gang',
        title = Lang['disable_enable_gang'],
        canClose = false,
        menu = 'admin_manage_gangs',
        options = {
            {
                title = Lang['disable_gang'],
                description = Lang['description_disable'],
                icon = "ban",
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('gangsystem:server:updateDisable', args, true)
                end
            },
            {
                title = Lang['enable_gang'],
                description = Lang['description_enable'],
                icon = "check",
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('gangsystem:server:updateDisable', args, false)
                end
            },
        },
    })
    lib.showContext('disable_enable_gang')
end)

-- Gang Player Menu Command:
if Config.PlayerMenu.Command.Enable == true then
    RegisterCommand(Config.PlayerMenu.Command.String, function()
        PlayerGangMenu()
    end)
end

-- Gang Player Menu Keybind:
if Config.PlayerMenu.Keybind.Enable == true then
    RegisterCommand('openPlayerGangMenu', function()
        PlayerGangMenu()
    end, false)
    RegisterKeyMapping('openPlayerGangMenu', 'Open Gang Menu', 'keyboard', Config.PlayerMenu.Keybind.DefaultMapping)
end

-- Gang Main Menu
PlayerGangMenu = function()
    Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
        if result ~= nil then
            plyGangId = result.id
            memberData = result.members
            if not result.disabled then
                local menuOptions = {}
                table.insert(menuOptions, {
                    title = Lang['gang_details'],
                    icon = 'circle-info',
                    description = Lang['description_g_details'],
                    args = result,
                    metadata = {
                        {label = 'Gang ID', value = result.id},
                        {label = 'Name', value = result.name},
                        {label = 'Notoriety', value = result.notoriety..' pts'},
                        {label = 'Members', value = #result.members}
                    }
                })
                if result.player.rank == 1 or result.player.rank == 2 then
                    table.insert(menuOptions, {title = Lang['gang_members'], icon = 'people-group', description = Lang['desc_view_manage_gang'], arrow = true, args = result, event = 'gangsystem:client:viewMembers'})
                    table.insert(menuOptions, {title = Lang['gang_invite'], icon = 'paper-plane', description = Lang['desc_inv_member'], arrow = true, args = result, event = 'gangsystem:client:inviteMember'})
                    table.insert(menuOptions, {title = Lang['gang_ranks'], icon = 'sitemap', description = Lang['desc_manage_ranks'], arrow = true, args = result, event = 'gangsystem:client:manageRanks'})
                    table.insert(menuOptions, {title = Lang['gang_marker_management'], icon = 'plus', description = Lang['desc_marker_manage'], arrow = true, args = result, event = 'gangsystem:client:markerManagement'})
                elseif result.player.rank == 3 then
                    table.insert(menuOptions, {title = Lang['gang_members'], icon = 'people-group', description = Lang['desc_view_manage_gang'], arrow = true, args = result, event = 'gangsystem:client:viewMembers'})
                    table.insert(menuOptions, {title = Lang['gang_invite'], icon = 'paper-plane', description = Lang['desc_inv_member'], arrow = true, args = result, event = 'gangsystem:client:inviteMember'})
                end
            
                table.insert(menuOptions, {title = Lang['gang_jobs'], icon = 'briefcase', description = Lang['desc_request_job'], arrow = true, args = result, event = 'gangsystem:client:jobMenu'})
                table.insert(menuOptions, {title = Lang['gang_actions'], icon = 'gamepad', description = Lang['desc_actions'], arrow = true, args = result, event = 'gangsystem:client:actions'})
                
                if result.player.rank ~= 1 then
                    table.insert(menuOptions, {title = Lang['gang_leave'], icon = 'ban', description = Lang['desc_leave'], args = result, event = 'gangsystem:client:leaveGang'})
                end

                if result.player.rank == 1 then
                    table.insert(menuOptions, {title = Lang['gang_dissolve'], icon = 'ban', description = Lang['desc_dissolve'], args = result, event = 'gangsystem:client:dissolveGang'})
                end

                lib.registerContext({
                    id = 'player_gang_menu',
                    title = result.name,
                    options = menuOptions,
                })
                lib.showContext('player_gang_menu')
            else
                Core.Notification({
                    title = '',
                    message = Lang['your_gang_is_disabled'],
                    type = 'inform'
                })
            end
        else
            Core.Notification({
                title = '',
                message = Lang['no_player_gang'],
                type = 'error'
            })
        end
    end)

end

-- View Gang Members:
RegisterNetEvent('gangsystem:client:viewMembers', function(data)
    local menuOptions = {}
    for k,v in pairs(data.members) do 
        table.insert(menuOptions, {
            title = v.name,
            icon = 'user',
            args = {player = v, gang = data},
            metadata = {
                {label = 'Rank', value = data.ranks[v.rank]},
                {label = 'Identifier', value = v.identifier},
            },
            arrow = true,
            event = 'gangsystem:client:manageMember',
        })
    end
    lib.registerContext({
        id = 'view_gang_members',
        title = Lang['gang_members'],
        menu = 'player_gang_menu',
        onBack = function()
            PlayerGangMenu()
        end,
        options = menuOptions
    })
    lib.showContext('view_gang_members')
end)

-- Manage Selected Gang Member:
RegisterNetEvent('gangsystem:client:manageMember', function(data)
    local menuOptions = {}
    Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
        memberData = result.player
    table.insert(menuOptions, {
        title = Lang['gang_kick_member'], icon = 'ban', description = Lang['desc_kick'], args = data,
        onSelect = function()
            if data.player.identifier == data.gang.leader then
                Core.Notification({
                    title = '',
                    message = Lang['cannot_kick_leader'],
                    type = 'error'
                })
                return TriggerEvent('gangsystem:client:manageMember', data)
            else
                for k,v in pairs(data.gang.members) do
                    if data.player.identifier == v.identifier then
                        Core.Notification({
                            title = '',
                            message = Lang['kicked_gang_member']:format(data.player.name),
                            type = 'error'
                        })
                        table.remove(data.gang.members, k)
                        break
                    end
                end
            end
            TriggerServerEvent('gangsystem:server:updateMembers', data.gang.id, data.gang.members)

            Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
                    memberData = result.player
                    TriggerEvent('gangsystem:client:viewMembers', result)
            end)
        end,
    })

    if memberData.rank == 1 or memberData.rank == 2 then
        table.insert(menuOptions, {title = Lang['gang_promote_member'], icon = 'wrench', description = Lang['desc_promote'], args = data, event = 'gangsystem:client:setMemberRank'})
    end

    lib.registerContext({
        id = 'manage_selceted_member',
        title = data.player.name,
        menu = 'view_gang_members',
        options = menuOptions,
    })
    lib.showContext('manage_selceted_member')
end)
end)

-- Manage Selected Gang Member Rank:
RegisterNetEvent('gangsystem:client:setMemberRank', function(data)
    local menuOptions = {}
    for i = 2, #data.gang.ranks do
        if data.player.rank ~= i then
            table.insert(menuOptions, {
                title = data.gang.ranks[i],
                onSelect = function()

                    if data.player.identifier == data.gang.leader then
                        Core.Notification({
                            title = '',
                            message = Lang['cannot_demote_leader'],
                            type = 'error'
                        })
                        return TriggerEvent('gangsystem:client:manageMember', data)
                    else
                        for k,v in pairs(data.gang.members) do
                            if data.player.identifier == v.identifier then
                                v.rank = i 
                                Core.Notification({
                                    title = '',
                                    message = Lang['member_rank_updated']:format(data.player.name),
                                    type = 'success'
                                })
                                break
                            end
                        end
                    end

                    TriggerServerEvent('gangsystem:server:updateMembers', data.gang.id, data.gang.members)

                    Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
                        if result ~= nil then
                            memberData = result.player
                            TriggerEvent('gangsystem:client:viewMembers', result)
                        end
                    end)
                end,
            })
        end
    end
    lib.registerContext({
        id = 'set_member_rank',
        title = data.player.name,
        menu = 'manage_selceted_member',
        options = menuOptions,
    })
    lib.showContext('set_member_rank')
end)

-- Invite Member to Gang:
RegisterNetEvent('gangsystem:client:inviteMember', function(data)
    local menuOptions = {}
    local players = Lib.GetPlayersInArea(GetEntityCoords(PlayerPedId()), Config.InviteMember.Distance)
    for i = 1, #players do
        local playerId = GetPlayerServerId(players[i])
        local fullName = Core.GetFullName(playerId)
        local menuTitle = fullName..' ['..playerId..']'
        if Config.InviteMember.ShowFullName == false then
            menuTitle = '['..playerId..']'
        end
        table.insert(menuOptions, {
            title = menuTitle,
            icon = 'user',
            description = Lang['desc_send_inv'],
            args = {name = fullName, serverId = playerId},
            onSelect = function(args)
                TriggerServerEvent('gangsystem:server:sendInvitation', data, args)
                PlayerGangMenu()
            end,
        })
    end
    if #menuOptions <= 0 then
        Core.Notification({
            title = '',
            message = Lang['no_players_nearby'],
            type = 'error'
        })
        return PlayerGangMenu()
    end
    lib.registerContext({
        id = 'invite_member',
        title = Lang['gang_invite'],
        menu = 'player_gang_menu',
        onBack = function()
            PlayerGangMenu()
        end,
        options = menuOptions,
    })
    lib.showContext('invite_member')
end)

-- Send Gang Invitation
RegisterNetEvent('gangsystem:client:sendInvitation')
AddEventHandler('gangsystem:client:sendInvitation', function(data, args, playerSrc)
    lib.registerContext({
        id = 'gang_invitation',
        title = Lang['gang_accept_inv']:format(data.name),
        canClose = false,
        options = {
            {
                title = Lang['confirm'],
                icon = "check",
                onSelect = function()
                    TriggerServerEvent('gangsystem:server:invitationRespond', data, args, true, playerSrc)
                    Core.Notification({
                        title = '',
                        message = Lang['invitation_accepted'],
                        type = 'success'
                    })
                end
            },
            {
                title = Lang['decline'],
                icon = "ban",
                onSelect = function()
                    TriggerServerEvent('gangsystem:server:invitationRespond', data, args, false, playerSrc)
                    Core.Notification({
                        title = '',
                        message = Lang['invitation_declined'],
                        type = 'inform'
                    })
                end
            },
        },
    })
    lib.showContext('gang_invitation')
end)

-- Manage Gang Ranks:
RegisterNetEvent('gangsystem:client:manageRanks', function(data)
    local menuOptions = {}
    for k,v in pairs(data.ranks)  do
    local text = nil
    if k == 2 then
        text = Lang['desc_same_perms']
    elseif k == 3 then
        text = Lang['desc_inv_and_kick']
    end

        table.insert(menuOptions, {
            title = v,
            icon = 'minus',
            description = text,
            args = data,
            
            onSelect = function(args)
                local input = lib.inputDialog(Lang['input_rename_rank']:format(v), {
                    {type = 'input', label = Lang['input_new_r_name'], placeholder = 'Enter name'},
                    {type = 'input', label = Lang['input_confirm_r_name'], placeholder = 'Re-enter name'}
                })

                if not input then
                    return TriggerEvent('gangsystem:client:manageRanks', data)
                end

                if input[1] == '' or input[1] == ' ' or input[1] == nil or input[1] == false then
                    Core.Notification({
                        title = '',
                        message = Lang['input_required'],
                        type = 'error'
                    })
                    return TriggerEvent('gangsystem:client:manageRanks', data)
                end

                local rankName = input[1]
                local rankNameMatch = input[2]

                if rankName ~= rankNameMatch then
                    Core.Notification({
                        title = '',
                        message = Lang['rank_does_not_match'],
                        type = 'error'
                    })
                    return TriggerEvent('gangsystem:client:manageRanks', data)
                end
                data.ranks[k] = rankName

                Core.Notification({
                    title = '',
                    message = Lang['rank_name_updated']:format(v),
                    type = 'success'
                })

                TriggerServerEvent('gangsystem:server:updateRanks', data.id, data.ranks)

                Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
                    if result ~= nil then
                        memberData = result.player
                        TriggerEvent('gangsystem:client:manageRanks', result)
                    end
                end)

            end,
        })
    end
    lib.registerContext({
        id = 'manage_gang_ranks',
        title = Lang['gang_ranks'],
        menu = 'player_gang_menu',
        onBack = function()
            PlayerGangMenu()
        end,
        options = menuOptions,
    })
    lib.showContext('manage_gang_ranks')
end)

-- Marker Management:
RegisterNetEvent('gangsystem:client:markerManagement', function(data)
    local menuOptions = {}

    for k,v in pairs(Config.Markers) do
        if v.enable == true then
            table.insert(menuOptions, {
                title = v.menuTitle,
                icon = v.icon,
                args = {type = k, data = data, value = v},
                event = 'gangsystem:client:manageMarker'
            })
        end
    end

    lib.registerContext({
        id = 'marker_management',
        title = Lang['gang_marker_management'],
        menu = 'player_gang_menu',
        onBack = function()
            PlayerGangMenu()
        end,
        options = menuOptions,
    })
    lib.showContext('marker_management')
end)

-- Manage Selected Marker:
RegisterNetEvent('gangsystem:client:manageMarker', function(args)
    local menuOptions = {}
    local menuTitle = (args.type:gsub("^%l", string.upper))
    if next(args.data.markers[args.type]) then
        table.insert(menuOptions, {
            title = Lang['delete_marker'],
            icon = 'trash',
            args = args,
            onSelect = function(args)
                TriggerServerEvent('gangsystem:server:deleteMarker', args)
                Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
                    if result ~= nil then
                        memberData = result.player
                        TriggerEvent('gangsystem:client:markerManagement', result)
                    end
                end)
            end,
        })
        table.insert(menuOptions, {
            title = Lang['change_pin'],
            icon = 'lock',
            args = args,
            onSelect = function(args)
                
                local input = lib.inputDialog(Lang['input_create_marker'], {
                    {type = "input", label = Lang['input_new_pin_code'], password = true, icon = 'lock', default = '0000', description = Lang['desc_set_new_pin']},
                    {type = "input", label = Lang['input_confirm_pin_code'], password = true, icon = 'lock', default = '0000', description = Lang['desc_confirm_new_pin']},
                })

                if not input then
                    return lib.showContext('marker_management')
                end

                if input[1] ~= input[2] then
                    Core.Notification({
                        title = '',
                        message = Lang['pin_code_not_match'],
                        type = 'error'
                    })
                    return lib.showContext('marker_management')
                end
                
                TriggerServerEvent('gangsystem:server:changePin', input, args)
            end,

        })
    else
        local description, metadata, cost = nil, nil, Config.Markers[args.type].cost
        if cost.notoriety ~= nil and cost.notoriety > 0 or cost.cash ~= nil and cost.cash > 0 then
            description = Lang['hover_marker_cost']
            metadata = {}
            if cost.notoriety ~= nil and cost.notoriety > 0 then
                table.insert(metadata, {label = 'Notoriety', value = cost.notoriety})
            end
            if cost.cash ~= nil and cost.cash > 0 then
                table.insert(metadata, {label = 'Cash', value = cost.cash})
            end
        end
        table.insert(menuOptions, {
            title = Lang['create_x_marker']:format(menuTitle),
            icon = 'plus',
            args = args,
            description = description,
            metadata = metadata,
            onSelect = function(args)
                local proceed, canCreate, cooldownTime = false, false, 0

                Core.TriggerCallback('gangsystem:server:getMarkerCooldown', function(hasCooldown, time)
                    canCreate = hasCooldown
                    cooldownTime = time
                    proceed = true
                end, args.data.id, args.type)
                
                while not proceed do
                    Wait(10)
                end
                
                if canCreate then
                    Core.Notification({
                        title = '',
                        message = Lang['marker_cooldown']:format(Lib.RoundNumber((cooldownTime/60/1000), 2)),
                        type = 'inform'
                    })
                    return lib.showContext('marker_management')
                end

                if args.data.notoriety ~=nil and args.data.notoriety < cost.notoriety then 
                    Core.Notification({
                        title = '',
                        message = Lang['not_enough_notoriety'],
                        type = 'error'
                    })
                    return lib.showContext('marker_management')
                end 

                if args.type ~= 'locker' then
                    if args.data.cash ~= nil and args.data.cash < cost.cash then 
                        Core.Notification({
                            title = '',
                            message = Lang['not_enough_gang_cash'],
                            type = 'error'
                        })
                        return lib.showContext('marker_management')
                    end
                end
                
                local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                local markerCoords = {Lib.RoundNumber(x,2), Lib.RoundNumber(y,2), Lib.RoundNumber(z,2)}

                local input = lib.inputDialog(Lang['input_create_marker'], {
                    {type = "input", label = "Coords:", disabled = true, default = json.encode(markerCoords), value = markerCoords, description = Lang['desc_m_coords']},
                    {type = "input", label = "PIN-Code", password = true, icon = 'lock', default = '0000', description = Lang['desc_m_pincode']},
                    {type = "number", label = "Type", default = 20, description = Lang['desc_m_type'], min = 0, max = 255},
                    {type = "number", label = "RGBA [RED]", default = 240, description = 'RGBA - Color RED [R]', min = 0, max = 255},
                    {type = "number", label = "RGBA [GREEN]", default = 52, description = 'RGBA - Color GREEN [G]', min = 0, max = 255},
                    {type = "number", label = "RGBA [BLUE]", default = 52, description = 'RGBA - Color BLUE [B]', min = 0, max = 255},
                    {type = "number", label = "RGBA [ALPHA]", default = 100, description = 'RGBA - Color ALPHA [A]', min = 0, max = 255},
                    {type = "checkbox", label = "Bob Up And Down", description = Lang['desc_m_bob_up_down']},
                    {type = "checkbox", label = "Face Camera", checked = true, description = Lang['desc_m_face_cam']},
                })

                if not input then
                    return lib.showContext('marker_management')
                end

                input[1] = json.decode(input[1])
                if input[8] == nil then
                    input[8] = false
                end
                if input[9] == nil then
                    input[9] = false
                end
                
                TriggerServerEvent('gangsystem:server:createMarker', input, args, cost)

            end,
        })
    end

    lib.registerContext({
        id = 'manage_marker',
        title = Lang['manage_x_marker']:format(menuTitle),
        menu = 'marker_management',
        options = menuOptions
    })
    lib.showContext('manage_marker')
end)

RegisterNetEvent('gangsystem:client:leaveGang', function(data)
    lib.registerContext({
        id = 'confirm_leave_gang',
        title = Lang['gang_leave'],
        canClose = false,
        options = {
            {
                title = Lang['confirm'],
                description = Lang['desc_leave'],
                icon = "check",
                args = data,
                onSelect = function(args)
                    for k,v in pairs(data.members) do
                        if v.identifier == data.player.identifier then 
                            Core.Notification({
                                title = '',
                                message = Lang['leave_gang'],
                                type = 'error'
                            })
                            table.remove(data.members, k)
                            break
                        end
                    end
                    TriggerServerEvent('gangsystem:server:updateMembers', data.id, data.members)
                end
            },
            {
                title = Lang['decline'],
                description = Lang['click_to_cancel_return'],
                icon = "ban",
                args = data,
                onSelect = function(args)
                    PlayerGangMenu()
                end
            },
        },
    })
    lib.showContext('confirm_leave_gang')
end)

RegisterNetEvent('gangsystem:client:dissolveGang', function(data)
    lib.registerContext({
        id = 'confirm_dissolve_gang',
        title = Lang['gang_dissolve'],
        canClose = false,
        options = {
            {
                title = Lang['confirm'],
                description = Lang['desc_dissolve'],
                icon = "check",
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('gangsystem:server:deleteGang', args)
                end
            },
            {
                title = Lang['decline'],
                description = Lang['click_to_cancel_return'],
                icon = "ban",
                args = data,
                onSelect = function(args)
                    PlayerGangMenu()
                end
            },
        },
    })
    lib.showContext('confirm_dissolve_gang')
end)

local usingMenu, markerTextUi = false, false
Citizen.CreateThread(function()
    while true do
        Wait(1)
		local sleep = true
        if t1ger_gangs ~= nil and next(t1ger_gangs) then
            for id,gang in pairs(t1ger_gangs) do
                if not gang.disabled then 
                    if gang.markers ~= nil and next(gang.markers) then
                        for k,marker in pairs(gang.markers) do
                            if marker ~= nil and next(marker) then
                                local distance = #(coords - vector3(marker.coords.x, marker.coords.y, marker.coords.z))
                                if distance < Config.Markers[k].renderDist and not usingMenu then
                                    sleep = false
                                    if Config.Markers[k].showMarker and distance > Config.Markers[k].interactDist then
                                        DrawMarker(marker.type, marker.coords.x, marker.coords.y, marker.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 2)
                                    end
                                    if distance <= Config.Markers[k].interactDist then
                                        if not markerTextUi then
                                            TriggerEvent('gangsystem:client:showTextUi', '['..Lib.KeybindToString(Config.Markers[k].keybind)..'] Gang '..(k:gsub("^%l", string.upper)))
                                            markerTextUi = true
                                        end
                                        if IsControlJustPressed(0, Config.Markers[k].keybind) then
                                            lib.hideTextUI()
                                            AccessMarker(gang, k, marker)
                                        end
                                    end
                                    if distance > Config.Markers[k].interactDist and markerTextUi == true then
                                        lib.hideTextUI()
                                        markerTextUi = false
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
		if sleep then
            Wait(1000)
            if markerTextUi == true then
                lib.hideTextUI() 
                markerTextUi = false
            end
        end
	end
end)

AccessMarker = function(gang, type, marker)
    local input, requirePin = nil, true
    if marker.pin == nil or marker.pin == '' or marker.pin == ' ' then
        requirePin = false
    end

    if requirePin then
        Core.TriggerCallback('gangsystem:server:getPinAttempts', function(attempts, cooldown)

            if attempts ~= nil and attempts >= 3 then
                markerTextUi = false
                return Core.Notification({
                    title = '',
                    message = Lang['pin_code_attempts']:format(attempts, Lib.RoundNumber((cooldown/60/1000), 2)),
                    type = 'inform'
                })
            end
            
            input = lib.inputDialog((type:gsub("^%l", string.upper)..' Marker'), {
                { type = "input", label = "PIN-Code", password = true, icon = 'lock'},
            })
        
            if not input then
                markerTextUi = false
                return Core.Notification({
                    title = '',
                    message = Lang['pin_code_required'],
                    type = 'inform'
                })
            end

            if (input ~= nil and input[1] == marker.pin) then
                if requirePin == true then
                    Core.Notification({
                        title = '',
                        message = Lang['pin_code_correct'],
                        type = 'success'
                    })
                    TriggerServerEvent('gangsystem:server:resetPinAttempts', gang.id, type)
                end
                if type == 'garage' then 
                    OpenGarage(gang, type, marker)
                elseif type == 'stash' then
                    OpenStash(gang, type, marker)
                elseif type == 'locker' then
                    OpenLocker(gang, type, marker)
                end
            else
                if requirePin then
                    markerTextUi = false
                    Core.Notification({
                        title = '',
                        message = Lang['pin_code_incorrect'],
                        type = 'error'
                    })
                    return TriggerServerEvent('gangsystem:server:addPinAttempts', gang.id, type)
                end
            end

        end, gang.id, type)
    else
        if type == 'garage' then 
            OpenGarage(gang, type, marker)
        elseif type == 'stash' then
            OpenStash(gang, type, marker)
        elseif type == 'locker' then
            OpenLocker(gang, type, marker)
        end
    end
end

function OpenStash(gang, type, marker)
    exports.ox_inventory:openInventory('stash', gang.markers["stash"].id)
end

OpenGarage = function(gang, type, marker)
    -- gang.id (id of the gang)
    -- marker.id (use this ID if u want or dont.)

    if Config.Markers[type].useBuiltInGarage == true then
        lib.registerContext({
            id = 'garage_menu',
            title = Lang['gang_garage'],
            onExit = function()
                usingMenu = false
                markerTextUi = false
            end,
            options = {
                {
                    title = Lang['garage_get_veh'],
                    icon = 'car',
                    args = {gang = gang, type = type, marker = marker},
                    event = 'gangsystem:client:getPlayerVehicles'
                },
                {
                    title = Lang['garage_store_veh'],
                    icon = 'square-parking',
                    onSelect = function()
                        local vehicle = GetVehiclePedIsIn(player, false)
                        local props = Core.GetVehicleProperties(vehicle)
                        Core.DeleteVehicle(vehicle)
                        TriggerServerEvent('t1ger_lib:server:updateOwnedVehicle', true, marker.id, props)
                        usingMenu = false
                        markerTextUi = false
                    end,
                },
            },
        })
        lib.showContext('garage_menu')
    else
        -- add function for your garage here:
    end

end

RegisterNetEvent('gangsystem:client:getPlayerVehicles', function(data)
    local menuOptions = {}

    Core.TriggerCallback('gangsystem:server:getPlayerVehicles', function(results)
        if results and next(results) then
            for k, vehicle in pairs(results) do
                -- plate, props, type, job, stored, garage, impound, fuel, engine, body, model
                if vehicle.garage == nil or data.marker.id == vehicle.garage then
                    if vehicle.stored  == nil or (vehicle.stored == true or vehicle.stored == 1) then 
                        local props = json.decode(vehicle.props)
                        local name = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
                        local make = GetLabelText(GetMakeNameFromVehicleModel(props.model))
                        local metaOptions = {
                            {label = 'Make', value = make},
                            {label = 'Model', value = name},
                            {label = 'Plate', value = vehicle.plate},
                        }
                        if props.engineHealth ~= nil or vehicle.engine ~= nil then
                            table.insert(metaOptions, {label = 'Engine', value = (props.engineHealth/10)..'%' or (props.engine/10)..'%'})
                        end
                        if props.bodyHealth ~= nil or vehicle.body ~= nil then
                            table.insert(metaOptions, {label = 'Body', value = (props.bodyHealth/10)..'%' or (props.body/10)..'%'})
                        end
                        if props.fuelLevel ~= nil or vehicle.fuel ~= nil then
                            table.insert(metaOptions, {label = 'Fuel', value = props.fuelLevel..'%' or vehicle.fuel..'%'})
                        end
                        table.insert(menuOptions, {
                            title = make..' '..name..' ['..vehicle.plate..']',
                            icon = 'car',
                            metadata = metaOptions,
                            args = {data, vehicle},
                            onSelect = function()
                                Core.SpawnVehicle(props.model, coords, GetEntityHeading(player), function(vehicle)
                                    Core.SetVehicleProperties(vehicle, props)
                                    SetPedIntoVehicle(player, vehicle, -1)
                                    TriggerServerEvent('t1ger_lib:server:updateOwnedVehicle', false, data.marker.id, props)
                                end, true)
                                usingMenu = false
                                markerTextUi = false
                            end,
                        })
                    end
                end
            end
            if #menuOptions <= 0 then
                return Core.Notification({
                    title = '',
                    message = Lang['no_owned_vehicles'],
                    type = 'inform'
                })
            end
            lib.registerContext({
                id = 'get_vehicles',
                title = Lang['garage_vehicles'],
                menu = 'garage_menu',
                options = menuOptions,
            })
            lib.showContext('get_vehicles')
        else
            Core.Notification({
                title = '',
                message = Lang['no_owned_vehicles'],
                type = 'inform'
            })
        end
    end)
end)

OpenLocker = function(gang, type, marker)
    usingMenu = true
    lib.registerContext({
        id = 'locker_menu',
        title = Lang['cash_locker'],
        onExit = function()
            usingMenu = false
            markerTextUi = false
        end,
        options = {
            {
                title = Lang['cash_balance'],
                icon = "sack-dollar",
                description = '$'..gang.cash,
            },
            {
                title = Lang['cash_deposit'],
                icon = "money-bill-trend-up",
                onSelect = function()
                    local input = lib.inputDialog(Lang['cash_locker'], {
                        {type = "input", label = Lang['cash_cur_balance'], icon = 'sack-dollar', disabled = true, default = gang.cash},
                        {type = "number", label = Lang['cash_deposit_amount'], icon = 'money-bill-trend-up', placeholder = 100}
                    })

                    if not input then
                        usingMenu = false
                        markerTextUi = false
                        return
                    end

                    if input[2] == nil or input[2] == '' or input[2] == ' ' then
                        Core.Notification({
                            title = '',
                            message = Lang['input_required'],
                            type = 'error'
                        })
                        return OpenLocker(gang, type, marker)
                    end

                    if input[2] <= 0 then 
                        usingMenu = false
                        markerTextUi = false
                        Core.Notification({
                            title = '',
                            message = Lang['input_amount_higher_0'],
                            type = 'error'
                        })
                        return OpenLocker(gang, type, marker)
                    end

                    TriggerServerEvent('gangsystem:server:updateCash', true, gang.id, gang.cash, input[2])

                    usingMenu = false
                    markerTextUi = false
                end,
            },
            {
                title = Lang['cash_withdraw'],
                icon = "money-bill-transfer",
                onSelect = function()
                    local input = lib.inputDialog(Lang['cash_locker'], {
                        {type = "input", label = Lang['cash_cur_balance'], icon = 'sack-dollar', disabled = true, default = gang.cash},
                        {type = "number", label = Lang['cash_withdraw_amount'], icon = 'money-bill-transfer', placeholder = 50}
                    })

                    if not input then
                        usingMenu = false
                        markerTextUi = false
                        return
                    end

                    if input[2] == nil or input[2] == '' or input[2] == ' ' then
                        Core.Notification({
                            title = '',
                            message = Lang['input_required'],
                            type = 'error'
                        })
                        return OpenLocker(gang, type, marker)
                    end

                    if input[2] <= 0 then 
                        Core.Notification({
                            title = '',
                            message = Lang['input_amount_higher_0'],
                            type = 'error'
                        })
                        return OpenLocker(gang, type, marker)
                    end

                    if input[2] > gang.cash then
                        Core.Notification({
                            title = '',
                            message = Lang['cash_withdraw_max'],
                            type = 'error'
                        })
                        return OpenLocker(gang, type, marker)
                    end

                    TriggerServerEvent('gangsystem:server:updateCash', false, gang.id, gang.cash, input[2])

                    usingMenu = false
                    markerTextUi = false
                end,
            },
        },
    })
    lib.showContext('locker_menu')
end

-- Gang Job Menu:
local jobCache = {}
RegisterNetEvent('gangsystem:client:jobMenu', function(data)
    lib.registerContext({
        id = 'job_menu',
        title = Lang['gang_jobs'],
        menu = 'player_gang_menu',
        onBack = function()
            PlayerGangMenu()
        end,
        options = {
            {
                title = Lang['gang_request_job'],
                icon = 'pen-to-square',
                args = data,
                onSelect = function()
                    if next(jobCache) ~= nil then
                        Core.Notification({
                            title = '',
                            message = Lang['already_has_job'],
                            type = 'inform'
                        })
                        return PlayerGangMenu()
                    end
                    local menuOptions = {}
                    Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
                        if result ~= nil then
                            plyGangId = result.id
                            for k,v in pairs(t1ger_gangs[plyGangId].rackets) do
                                if v ~= 'protection' then
                                    table.insert(menuOptions, {
                                        title = (v:gsub("^%l", string.upper)),
                                        icon = 'download',
                                        onSelect = function()
                                            local cfg = Config.Rackets[v]
                                            math.randomseed(GetGameTimer())
                                            local id = math.random(1, #cfg.data.jobs)
                                            local job = cfg.data.jobs[id]
                                            TriggerServerEvent('gangsystem:server:startRacketJob', v, id)
                                        end,
                                    })
                                end
                            end

                            if #menuOptions > 0 then 
                                lib.registerContext({
                                    id = 'select_racket_job',
                                    title = Lang['gang_select_racket'],
                                    menu = 'job_menu',
                                    options = menuOptions,
                                })
                                lib.showContext('select_racket_job')
                            else
                                Core.Notification({
                                    title = '',
                                    message = Lang['no_jobs_available'],
                                    type = 'inform'
                                })
                                PlayerGangMenu()
                            end
                        end
                    end)

                end,
            },
            {
                title = Lang['gang_cancel_job'],
                icon = 'xmark',
                onSelect = function()
                    if next(jobCache) ~= nil and jobCache.pickupMessage ~= nil then
                        jobCache.abortJob = true
                        Core.Notification({
                            title = '',
                            message = Lang['job_cancelled'],
                            type = 'error'
                        })
                    else
                        Core.Notification({
                            title = '',
                            message = Lang['no_ongoing_job'],
                            type = 'error'
                        })
                    end
                    PlayerGangMenu()
                end,
            }
        }
    })
    lib.showContext('job_menu')
end)

RegisterNetEvent('gangsystem:client:prostitutionJob')
AddEventHandler('gangsystem:client:prostitutionJob', function(type, id)
    local cfg = Config.Rackets['prostitution'].data.jobs[id]
    local done = false
    jobCache = {}

    while not done do
        Wait(1)
        local sleep = true
        
        local pickupDistance = #(coords - vector3(cfg.pickup.x, cfg.pickup.y, cfg.pickup.z))
        local dropoffDistance = #(coords - vector3(cfg.dropoff.x, cfg.dropoff.y, cfg.dropoff.z))
        local playerVehicle = GetVehiclePedIsUsing(player)

        -- create blip:
        if jobCache.pickupBlip == nil then
            jobCache.pickupBlip = AddBlipForCoord(cfg.pickup.x, cfg.pickup.y, cfg.pickup.z)
            SetBlipSprite(jobCache.pickupBlip, 279)
            SetBlipColour(jobCache.pickupBlip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Hooker Pick-Up')
            EndTextCommandSetBlipName(jobCache.pickupBlip)
            SetBlipRoute(jobCache.pickupBlip, true)
            SetBlipRouteColour(jobCache.pickupBlip, 1)
        end

        -- send messsage:
        if jobCache.pickupMessage == nil then
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(cfg.pickup.x, cfg.pickup.y, cfg.pickup.z))
            Core.Notification({
                title = '',
                message = Lang['pickup_hooker_at']:format(streetName),
                type = 'inform'
            })
            jobCache.pickupMessage = true
        end

        -- create ped:
        if pickupDistance <= 100.0 and jobCache.pedCreated == nil then
            SetPedRelationshipGroupHash(player, GetHashKey("PLAYER"))
            AddRelationshipGroup('HOOKER')
            math.randomseed(GetGameTimer())
            local id = math.random(1, #Config.Rackets['prostitution'].data.peds)
            local model = Config.Rackets['prostitution'].data.peds[id]
            Lib.LoadModel(model)
            jobCache.hooker = CreatePed(4, GetHashKey(model), cfg.pickup.x, cfg.pickup.y, cfg.pickup.z-0.97, cfg.pickup.w, 0, true, true)
            NetworkRegisterEntityAsNetworked(jobCache.hooker)
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(jobCache.hooker), true)
            SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(jobCache.hooker), true)
            SetPedKeepTask(jobCache.hooker, true)
            SetPedDropsWeaponsWhenDead(jobCache.hooker, false)
            SetEntityInvincible(jobCache.hooker, false)
            SetEntityVisible(jobCache.hooker, true)
            TaskStartScenarioInPlace(jobCache.hooker, 'WORLD_HUMAN_STAND_IMPATIENT', 0, false)
            FreezeEntityPosition(jobCache.hooker, true)
            SetPedRelationshipGroupHash(jobCache.hooker, GetHashKey("HOOKER"))	
            SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("HOOKER"))
            SetRelationshipBetweenGroups(0, GetHashKey("HOOKER"), GetHashKey("PLAYER"))
            jobCache.pedCreated = true
        end

        if jobCache.hooker ~= nil and DoesEntityExist(jobCache.hooker) then
            jobCache.hookerCoords = GetEntityCoords(jobCache.hooker)
            jobCache.hookerDist = #(coords - jobCache.hookerCoords)
            if IsPedDeadOrDying(jobCache.hooker, true) then
                jobCache.abortJob = true
                Core.Notification({
                    title = '',
                    message = Lang['hooker_died'],
                    type = 'inform'
                })
            end
        end

        if jobCache.driveMessage == true and jobCache.hookerVehHealth ~= nil then
            local currentHealth = GetVehicleEngineHealth(playerVehicle)
            local startValue = (jobCache.hookerVehHealth - currentHealth)
            local newValue = (startValue/jobCache.hookerVehHealth)
            local percentage = (newValue * 100)

            if percentage > Config.Rackets['prostitution'].data.damagePercentage then
                jobCache.abortJob = true
                Core.Notification({
                    title = '',
                    message = Lang['hooker_engine_dmg'],
                    type = 'inform'
                })
            end
        end

        -- pickup hooker:
        if pickupDistance <= 10.0 and jobCache.hooker ~= nil then
            sleep = false 

            -- honk/horn message:
            if jobCache.hornMessage == nil then
                Core.Notification({
                    title = '',
                    message = Lang['hooker_honk_to_call'],
                    type = 'inform'
                })
                jobCache.hornMessage = true
            end

            if jobCache.honked == nil and IsControlJustPressed(1, 86) then
                if IsVehicleSeatFree(playerVehicle, 0) then 
                    jobCache.honked = true
                    SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("HOOKER"))
                    SetRelationshipBetweenGroups(0, GetHashKey("HOOKER"), GetHashKey("PLAYER"))
                    ClearPedTasksImmediately(jobCache.hooker)
                    FreezeEntityPosition(jobCache.hooker, false)
                    TaskEnterVehicle(jobCache.hooker, playerVehicle, 20000, 0, 1.0, 1, 0)
                    jobCache.hookerVehHealth = GetVehicleEngineHealth(playerVehicle)
                    RemoveBlip(jobCache.pickupBlip)

                    -- wait for ped to enter vehicle:
                    while not IsPedInAnyVehicle(jobCache.hooker, true) do
                        Wait(500)
                    end

                    -- create new blip and route:
                    if jobCache.dropoffBlip == nil then
                        jobCache.dropoffBlip = AddBlipForCoord(cfg.dropoff.x, cfg.dropoff.y, cfg.dropoff.z)
                        SetBlipSprite(jobCache.dropoffBlip, 279)
                        SetBlipColour(jobCache.dropoffBlip, 1)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString('Hooker Drop-Off')
                        EndTextCommandSetBlipName(jobCache.dropoffBlip)
                        SetBlipRoute(jobCache.dropoffBlip, true)
                        SetBlipRouteColour(jobCache.dropoffBlip, 1)
                    end
                    
                    -- drive message:
                    if jobCache.driveMessage == nil then
                        local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(cfg.dropoff.x, cfg.dropoff.y, cfg.dropoff.z))
                        Core.Notification({
                            title = '',
                            message = Lang['hooker_drop_me_at']:format(streetName),
                            type = 'inform'
                        })
                        jobCache.driveMessage = true
                    end
                else
                    Core.Notification({
                        title = '',
                        message = Lang['hooker_seat_occupied'],
                        type = 'inform'
                    })
                end
            end
        end

        if dropoffDistance <= 10.0 and jobCache.hooker ~= nil and jobCache.hookerDist <= 5.0 then
            sleep = false
            if jobCache.dropped == nil and IsControlJustPressed(1, 86) then
                jobCache.dropped = true
                TaskLeaveVehicle(jobCache.hooker, playerVehicle, 0)
                Wait(2000)
                RemoveBlip(jobCache.dropoffBlip)
                TaskWanderStandard(jobCache.hooker, 10.0, 10)
                Core.Notification({
                    title = '',
                    message = Lang['hooker_drop_off'],
                    type = 'success'
                })
                TriggerServerEvent('gangsystem:server:prostitutionReward', plyGangId, id)
                Wait(10000)
                done = true 
                jobCache = {}
            end
        end

        if jobCache.abortJob then
            if DoesBlipExist(jobCache.pickupBlip) then
                RemoveBlip(jobCache.pickupBlip)
            elseif DoesBlipExist(jobCache.dropoffBlip) then 
                RemoveBlip(jobCache.dropoffBlip)
            end
            DeleteEntity(jobCache.hooker)
            done = true
            jobCache = {}
        end

		if sleep then
            Wait(2000)
        end
    end
end)

RegisterNetEvent('gangsystem:client:rackets', function()
    Core.TriggerCallback('gangsystem:server:getPlayerGang', function(result)
        if result ~= nil then
            memberData = result.player
            if result.disabled == false then
                if memberData.rank == 1 or memberData.rank == 2 then

                    local menuOptions = {}
                    for racket, data in pairs(Config.Rackets) do
                        local disabled = true
                        if data.claimed == false then
                            disabled = false
                        end
                        table.insert(menuOptions, {
                            title = data.label,
                            icon = data.icon,
                            args = {type = racket, data = data, gang = result},
                            disabled = disabled,
                            event = 'gangsystem:client:viewRacket'
                        })
                    end
                    lib.registerContext({
                        id = 'racket_list',
                        title = Lang['npc_rackets'],
                        options = menuOptions
                    })
                    lib.showContext('racket_list')
                else
                    return Core.Notification({
                        title = '',
                        message = Lang['no_gang_permission'],
                        type = 'error'
                    })
                end
            else
                return Core.Notification({
                    title = '',
                    message = Lang['your_gang_is_disabled'],
                    type = 'error'
                })
            end
        else
            return Core.Notification({
                title = '',
                message = Lang['no_player_gang'],
                type = 'error'
            })
        end
    end)
end)

RegisterNetEvent('gangsystem:client:viewRacket', function(args)
    local menuOptions = {}

    local state = Config.Rackets[args.type].claimed
    lib.registerContext({
        id = 'view_racket',
        menu = 'racket_list',
        title = Config.Rackets[args.type].label,
        options = {
            {
                title = Lang['npc_claim_racket']:format(Config.Rackets[args.type].cost),
                icon = 'pen-to-square',
                disabled = state,
                args = args,
                onSelect = function()
                    if args.gang.notoriety >= Config.Rackets[args.type].cost then
                        Config.Rackets[args.type].claimed = true
                        Config.Rackets[args.type].gang = args.gang.id
                        TriggerServerEvent('gangsystem:server:claimRacket', args.type, args.data, args.gang)
                        Core.Notification({
                            title = '',
                            message = Lang['racket_paid']:format(Config.Rackets[args.type].cost),
                            type = 'error'
                        })
                    else
                        Core.Notification({
                            title = '',
                            message = Lang['racket_cost']:format(Config.Rackets[args.type].cost, args.gang.notoriety),
                            type = 'error'
                        })
                    end
                end,
            },
            {
                title = Lang['npc_racket_withdraw'],
                icon = 'xmark',
                disabled = not state,
                args = args,
                onSelect = function()
                    Config.Rackets[args.type].claimed = false
                    Config.Rackets[args.type].gang = nil
                    TriggerServerEvent('gangsystem:server:withdrawRacket', args.type, args.data, args.gang)
                    Core.Notification({
                        title = '',
                        message = Lang['racket_withdraw'],
                        type = 'error'
                    })
                end,
            },
        }
    })
    lib.showContext('view_racket')
end)

local protectionTextUi = false
Citizen.CreateThread(function()
    while true do
        Wait(1)
		local sleep = true
        local cfg = Config.Rackets['protection']
        if cfg.claimed == true then
            if cfg.gang ~= nil then
                if plyGangId ~= 0 and t1ger_gangs[plyGangId].disabled == false and t1ger_gangs[plyGangId].id == cfg.gang then
                    for k,v in pairs(cfg.data.shops) do
                        local distance = #(coords - v.coords)
                        if distance < 10.0 then
                            sleep = false 
                            local mk = cfg.data.marker
                            DrawMarker(mk.type, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.size.x, mk.size.y, mk.size.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, mk.bobUpAndDown, mk.faceCamera, 2)
                            if distance <= 1.0 then
                                local text, collect = Lang['request_collection'], false
                                if next(v.cache) ~= nil then
                                    text = Lang['collect_protection_money']
                                    collect = true
                                end
                                if not protectionTextUi then
                                    TriggerEvent('gangsystem:client:showTextUi', '['..Lib.KeybindToString(cfg.data.keybind)..'] '..text)
                                    protectionTextUi = true
                                end
                                if IsControlJustPressed(0, cfg.data.keybind) then
                                    lib.hideTextUI()
                                    TriggerServerEvent('gangsystem:server:protectionCollect', k, v, cfg, plyGangId)
                                end
                            end
                            if distance > 1.0 and protectionTextUi == true then
                                lib.hideTextUI()
                                protectionTextUi = false
                            end
                        end
                    end
                end
            end
        end
		if sleep then
            Wait(1000)
        end
	end
end)

local ziptied, ziptieAnim, ziptieEntity = false, {}, nil
local escorted, escorting, beingEscorted = false, false, false
local inVehicle, vehDoorIndex, inTrunk, trunkVehicle, trunkIndex = false, nil, false, nil, nil
local canHostage, hostaging, isHostage, hostageWeapon, hostageSrc = false, false, false, nil, 0
local headbagged, headbagEntity = false, nil

function ZiptieAdd(target)
    TriggerServerEvent("gangsystem:server:ziptie", target)
end

function HeadbagPlayer(target)
    TriggerServerEvent("gangsystem:server:headbag", target)
end

function ZiptieRemove(target)
    TriggerServerEvent("gangsystem:server:removeZipties", target)
end

function EscortPlayer(target)
    TriggerServerEvent("gangsystem:server:escort", target)
end

function VehicleIn(target)
    TriggerServerEvent("gangsystem:server:vehicleIn", target)
end

function VehicleOut(target)
    TriggerServerEvent("gangsystem:server:vehicleOut", target)
end

function TrunkIn(target)
    TriggerServerEvent("gangsystem:server:trunkIn", target)
end

function TrunkOut(target)
    TriggerServerEvent("gangsystem:server:trunkOut", target)
end

function TakeHostage(target)
    TriggerServerEvent("gangsystem:server:hostage", target)
end

function ReleaseHostage(target)
    TriggerServerEvent("gangsystem:server:hostageRelease", target)
end

function KillHostage(target)
    TriggerServerEvent("gangsystem:server:hostageKill", target)
end

RegisterNetEvent('gangsystem:client:actions', function(args)
    if ziptied then
        return Core.Notification({
            title = '',
            message = Lang['you_are_ziptied'],
            type = 'error'
        })
    end
    print(args.notoriety)
    local closestId, target, dist = Lib.GetClosestPlayer2(coords, 3.0, false)
	if (closestId ~= nil and closestId ~= -1) and #(coords - dist) <= 3.0 then

        local targetId = GetPlayerServerId(closestId)
        local playerZiptied = IsTargetZiptied(targetId)

        local menuOptions = {}
        if escorting == false then
            if playerZiptied == false then
                if Config.Actions.Menu['ziptie'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['ziptie'].notoriety then
                    table.insert(menuOptions, { title = Lang['zip_tie_hands'], icon = Config.Actions.Menu['ziptie'].icon, onSelect = function() ZiptieAdd(targetId) end })
                end
            elseif playerZiptied == true then
                if hostaging == false then                        
                    if Config.Actions.Menu['remove_zipties'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['remove_zipties'].notoriety then
                        table.insert(menuOptions, {title = Lang['remove_zip_ties'], icon = Config.Actions.Menu['remove_zipties'].icon, onSelect = function() ZiptieRemove(targetId) end })
                    end
                    if Config.Actions.Menu['escort'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['escort'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_escort'], icon = Config.Actions.Menu['escort'].icon, onSelect = function() EscortPlayer(targetId) end })
                    end
                    if Config.Actions.Menu['vehicle_in'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['vehicle_in'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_vehicle_in'], icon = Config.Actions.Menu['vehicle_in'].icon, onSelect = function() VehicleIn(targetId) end })
                    end
                    if Config.Actions.Menu['vehicle_out'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['vehicle_out'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_vehicle_out'], icon = Config.Actions.Menu['vehicle_out'].icon, onSelect = function() VehicleOut(targetId) end })
                    end
                    if Config.Actions.Menu['robar'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['robar'].notoriety then
                        table.insert(menuOptions, { title = 'Robar', icon = Config.Actions.Menu['robar'].icon, onSelect = function() exports.ox_inventory:openNearbyInventory()
                        end })
                    end
                    if Config.Actions.Menu['trunk_in'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['trunk_in'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_trunk_in'], icon = Config.Actions.Menu['trunk_in'].icon, onSelect = function() TrunkIn(targetId) end })
                    end
                    if Config.Actions.Menu['trunk_out'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['trunk_out'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_trunk_out'], icon = Config.Actions.Menu['trunk_out'].icon, onSelect = function() TrunkOut(targetId) end })
                    end
                    if Config.Actions.Menu['headbag'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['headbag'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_headbag'], icon = Config.Actions.Menu['headbag'].icon, onSelect = function() HeadbagPlayer(targetId) end })
                    end
                    if Config.Actions.Menu['hostage'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['hostage'].notoriety then
                        table.insert(menuOptions, { title = Lang['action_hostage'], icon = Config.Actions.Menu['hostage'].icon, onSelect = function() TakeHostage(targetId) end })
                    end
                end
            end
        else
            if Config.Actions.Menu['escort'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['escort'].notoriety then
                table.insert(menuOptions, { title = Lang['action_escort'], icon = Config.Actions.Menu['escort'].icon, onSelect = function() EscortPlayer(targetId) end })
            end
            if Config.Actions.Menu['vehicle_in'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['vehicle_in'].notoriety then
                table.insert(menuOptions, { title = Lang['action_vehicle_in'], icon = Config.Actions.Menu['vehicle_in'].icon, onSelect = function() VehicleIn(targetId) end })
            end
            if Config.Actions.Menu['trunk_in'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['trunk_in'].notoriety then
                table.insert(menuOptions, { title = Lang['action_trunk_in'], icon = Config.Actions.Menu['trunk_in'].icon, onSelect = function() TrunkIn(targetId) end })
            end
        end

        if hostaging == true then 
            table.insert(menuOptions, { title = Lang['action_release_hostage'], icon = 'person-walking', onSelect = function() ReleaseHostage(targetId) end })
            if Config.Actions.Menu['hostage'].notoriety ~= nil and args.notoriety >= Config.Actions.Menu['hostage'].notoriety then
                table.insert(menuOptions, { title = Lang['action_kill_hostage'], icon = 'gun', onSelect = function() KillHostage(targetId) end })
            end
        end

        if next(menuOptions) == nil then
            Core.Notification({
                title = '',
                message = 'Not enough notoriety points',
                type = 'error'
            })
            return PlayerGangMenu()
        end

        lib.registerContext({
            id = 'action_menu',
            title = Lang['action_menu'],
            menu = 'player_gang_menu',
            onBack = function()
                PlayerGangMenu()
            end,
            options = menuOptions,
        })
        lib.showContext('action_menu')
	else
        Core.Notification({
            title = '',
            message = Lang['no_players_nearby'],
            type = 'error'
        })
		PlayerGangMenu()
	end
end)

RegisterNetEvent('gangsystem:client:headbag')
AddEventHandler('gangsystem:client:headbag', function(playerSrc)
    if headbagged then
        DeleteEntity(headbagEntity)
        SetEntityAsNoLongerNeeded(headbagEntity)
        TriggerServerEvent('t1ger_lib:server:addItem', Config.Items[2], 1, playerSrc)
        SendNUIMessage({
            ['task'] = 'removeHeadbag'
        })
        headbagEntity = nil
        headbagged = false
    else
        Core.TriggerCallback('t1ger_lib:hasItem', function(hasItem)
            if hasItem then 
                TriggerServerEvent('t1ger_lib:server:removeItem', Config.Items[2], 1, playerSrc)
                Lib.LoadModel(GetHashKey(Config.Actions.Menu['headbag'].prop))
                headbagEntity = CreateObject(GetHashKey(Config.Actions.Menu['headbag'].prop), 0.0, 0.0, 0.0, true, true, true)
                local networkId = ObjToNet(headbagEntity)
                SetNetworkIdExistsOnAllMachines(networkId, true)
                SetNetworkIdCanMigrate(networkId, false)
                NetworkSetNetworkIdDynamic(networkId, true)
                AttachEntityToEntity(headbagEntity, player, GetPedBoneIndex(player, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
                SetEntityCompletelyDisableCollision(headbagEntity, false, true)
                SendNUIMessage({
                    ['task'] = 'showHeadbag'
                })
                headbagged = true
            else
                TriggerServerEvent('t1ger_lib:server:srcNotification', {title = '', message = Lang['inv_need_headbag'], type = 'error'}, playerSrc)
            end
        end, Config.Items[2], 1, playerSrc)
    end
end)

RegisterNetEvent('gangsystem:client:headbagAnim')
AddEventHandler('gangsystem:client:headbagAnim', function()
    Lib.LoadAnim('weapons@first_person@aim_idle@p_m_zero@melee@unarmed@aimtrans@idle_to_relaxed')
    TaskPlayAnim(player, 'weapons@first_person@aim_idle@p_m_zero@melee@unarmed@aimtrans@idle_to_relaxed', 'aim_trans_high', 8.0, -8.0, 1000, 49, 0, false, false, false)
end)

RegisterNetEvent('gangsystem:client:hostage')
AddEventHandler('gangsystem:client:hostage', function(targetSrc)
	ClearPedSecondaryTask(player)
	DetachEntity(player, true, false)

    -- check weapons:
    for i = 1, #Config.Actions.Menu['hostage'].weapons do
        if HasPedGotWeapon(player, GetHashKey(Config.Actions.Menu['hostage'].weapons[i]), false) then
            hostageWeapon = GetHashKey(Config.Actions.Menu['hostage'].weapons[i])
            canHostage = true
            break
        end
    end

    if not canHostage then
        return Core.Notification({
            title = '',
            message = Lang['hostage_weapon'],
            type = 'inform'
        })
    end

    if not hostaging and canHostage then
        SetCurrentPedWeapon(player, hostageWeapon, true)
        hostaging = true
        hostageSrc = targetSrc
        TriggerServerEvent('gangsystem:server:hostageSync', targetSrc, 'takeHostage')
    end

end)

RegisterNetEvent('gangsystem:client:hostageSync')
AddEventHandler('gangsystem:client:hostageSync', function(srcPlayer, action)
	local srcPed = GetPlayerPed(GetPlayerFromServerId(srcPlayer))
    local cfg = Config.Actions.Menu['hostage']
    local anim = {lib = nil, name = nil, flag = nil}

	isHostage = true

    if action == 'takeHostage' then
        anim.lib = cfg.anim[1].lib
        anim.name = cfg.anim[1].name[2]
        anim.flag = 49
    elseif action == 'releaseHostage' then 
        anim.lib = cfg.anim[2].lib
        anim.name = cfg.anim[2].name[2]
        anim.flag = 0
    elseif action == 'killHostage' then
        anim.lib = cfg.anim[1].lib
        anim.name = cfg.anim[1].name[4]
        anim.flag = 168
    end

    Lib.LoadAnim(anim.lib)

    AttachEntityToEntity(player, srcPed, 0, cfg.pos.x, cfg.pos.y, cfg.pos.z, cfg.rot.x, cfg.rot.y, cfg.rot.z, false, false, false, false, 2, false)

    if action == 'releaseHostage' or action == 'killHostage' then
        DetachEntity(player, true, false)
        isHostage = false
        if action == 'killHostage' then 
            SetEntityHealth(player, 0)
        end
    end

    TaskPlayAnim(player, anim.lib, anim.name, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
end)

RegisterNetEvent('gangsystem:client:hostageSyncSrc')
AddEventHandler('gangsystem:client:hostageSyncSrc', function(targetSrc, action)
	local srcPed = GetPlayerPed(GetPlayerFromServerId(srcPlayer))
    local cfg = Config.Actions.Menu['hostage']
    local anim = {lib = nil, name = nil, flag = nil}

	ClearPedSecondaryTask(player)

    if action == 'takeHostage' then
        anim.lib = cfg.anim[1].lib
        anim.name = cfg.anim[1].name[1]
        anim.flag = 49
    elseif action == 'releaseHostage' then 
        anim.lib = cfg.anim[2].lib
        anim.name = cfg.anim[2].name[1]
        anim.flag = 168
    elseif action == 'killHostage' then
        anim.lib = cfg.anim[1].lib
        anim.name = cfg.anim[1].name[3]
        anim.flag = 168
    end

    Lib.LoadAnim(anim.lib)

	TaskPlayAnim(player, anim.lib, anim.name, 8.0, -8.0, -1, anim.flag, 0, false, false, false)

    if action == 'releaseHostage' then 
        Wait(900)
        ClearPedSecondaryTask(player)
        hostaging = false
    elseif action == 'killHostage' then
		SetPedShootsAtCoord(player, 0.0, 0.0, 0.0, 0)
        hostaging = false
    end

end)

RegisterNetEvent('gangsystem:client:trunkIn')
AddEventHandler('gangsystem:client:trunkIn', function(srcPlayer)
    
    local trunk = {bone = 'boot', doorIndex = 5}

    if escorted or ziptied then
		if not IsPedInAnyVehicle(player, true) then
            local closestVehicle, closestDist = Lib.GetClosestVehicle(coords, 3.0, false)
            if closestVehicle ~= nil and DoesEntityExist(closestVehicle) and IsEntityAVehicle(closestVehicle) then
                
                local trunkPos = GetWorldPositionOfEntityBone(closestVehicle, GetEntityBoneIndexByName(closestVehicle, trunk.bone))
                local trunkDist = #(coords - trunkPos)

                if trunkDist <= 2.0 then
                    if escorted then
                        TriggerServerEvent('gangsystem:server:unEscort', srcPlayer)
                    end
                    Wait(500)
                    if GetVehicleDoorAngleRatio(closestVehicle, trunk.doorIndex) > 0.0 then
                        local d1 = GetModelDimensions(GetEntityModel(closestVehicle))
                        Lib.LoadAnim('veh@low@front_ps@idle_duck')
                        AttachEntityToEntity(player, closestVehicle, 0, 0.0, d1.y+0.85, 0.0, 50.0, 100.0, 300.0, true, true, false, true, 0, true)
                        trunkVehicle = closestVehicle
                        trunkIndex = trunk.doorIndex
                        TaskPlayAnim(player, 'veh@low@front_ps@idle_duck', 'sit', 8.0, -8.0, -1, 1, 0, false, false, false)
                        inTrunk = true
                        InTrunkHandle()
                    end
                end

            end
        end
    end

end)

InTrunkHandle = function()
    while inTrunk do
        if not IsEntityAttachedToEntity(player, trunkVehicle) then
            inTrunk = false
        else
            if not IsEntityPlayingAnim(player, 'veh@low@front_ps@idle_duck', 'sit', 1) then 
                TaskPlayAnim(player, 'veh@low@front_ps@idle_duck', 'sit', 8.0, -8.0, -1, 1, 0, false, false, false)
            end
        end
        if GetVehicleDoorAngleRatio(trunkVehicle, 5) > 0.0 then
            if IsScreenFadedOut() or not IsScreenFadedIn() then
                DoScreenFadeIn(1000)
            end
        else
            if IsScreenFadedIn() or not IsScreenFadedOut() then 
                DoScreenFadeOut(1000)
            end
        end
        Wait(500)
    end
    trunkVehicle = nil
    if IsScreenFadedOut() or not IsScreenFadedIn() then
        DoScreenFadeIn(1000)
    end
end

RegisterNetEvent('gangsystem:client:trunkOut')
AddEventHandler('gangsystem:client:trunkOut', function(srcPlayer)

    local vehicle = GetEntityAttachedTo(player)
    if Lib.IsVehicleLocked(vehicle) then
        return
    end
    if GetVehicleDoorAngleRatio(vehicle, trunkIndex) > 0.0 then
        inTrunk = false
        DetachEntity(player, true, true)
        local sourceCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(srcPlayer)))
        SetEntityCoords(player, sourceCoords.x, sourceCoords.y, sourceCoords.z-0.975, 0.0, 0.0, 0.0, false)
        if IsEntityPlayingAnim(player, 'veh@low@front_ps@idle_duck', 'sit', 1) then 
            StopAnimTask(player, 'veh@low@front_ps@idle_duck', 'sit', 1.0)
        end
        trunkIndex = nil
    end
end)

RegisterNetEvent('gangsystem:client:vehicleIn')
AddEventHandler('gangsystem:client:vehicleIn', function(srcPlayer)
    inVehicle = false

    local carDoors = {
        [1] = {bones = {[1] = 'door_pside_f', [2] = 'seat_pside_f'}, doorIndex = 1, seatIndex = 0},
        [2] = {bones = {[1] = 'door_dside_r', [2] = 'seat_dside_r'}, doorIndex = 2, seatIndex = 1},
        [3] = {bones = {[1] = 'door_pside_r', [2] = 'seat_pside_r'}, doorIndex = 3, seatIndex = 2}
    }

    if escorted or ziptied then
		if not IsPedInAnyVehicle(player, true) then
            local closestVehicle, closestDist = Lib.GetClosestVehicle(coords, 3.0, false)
            if closestVehicle ~= nil and DoesEntityExist(closestVehicle) and IsEntityAVehicle(closestVehicle) then
                
                for i = 1, #carDoors do
                    local doorPos = GetWorldPositionOfEntityBone(closestVehicle, GetEntityBoneIndexByName(closestVehicle, carDoors[i].bones[1])) or GetWorldPositionOfEntityBone(closestVehicle, GetEntityBoneIndexByName(closestVehicle, carDoors[i].bones[2]))
                    local doorDist = #(coords - doorPos)
                    if doorDist <= 1.5 then
                        if IsVehicleSeatFree(closestVehicle, carDoors[i].seatIndex) then
                            if escorted then
                                TriggerServerEvent('gangsystem:server:unEscort', srcPlayer)
                            end
                            Wait(1000)
                            if GetVehicleDoorAngleRatio(closestVehicle, carDoors[i].doorIndex) > 0.0 then
                                inVehicle = true
                                TaskWarpPedIntoVehicle(player, closestVehicle, carDoors[i].seatIndex)
                                vehDoorIndex = carDoors[i].doorIndex
                            end
                            break
                        end
                    end
                end

            end
        end
    end

end)

RegisterNetEvent('gangsystem:client:vehicleOut')
AddEventHandler('gangsystem:client:vehicleOut', function(srcPlayer)
    if IsPedSittingInAnyVehicle(player) then
		local vehicle = GetVehiclePedIsIn(player, false)
        if Lib.IsVehicleLocked(vehicle) then
            return
        end
        if GetVehicleDoorAngleRatio(vehicle, vehDoorIndex) > 0.0 then
            TaskLeaveVehicle(player, vehicle, 256)
            inVehicle = false
            vehDoorIndex = nil
        end
	end
end)

RegisterNetEvent('gangsystem:client:escort')
AddEventHandler('gangsystem:client:escort', function(srcPlayer)
    escorted = not escorted
    if escorted then
        EscortHandle(srcPlayer)
    end

end)

RegisterNetEvent('gangsystem:client:escortAnimation')
AddEventHandler('gangsystem:client:escortAnimation', function(targetPly)
    local anim = {dict = 'amb@code_human_wander_drinking@beer@male@base', name = 'static', flags = 49}
    Lib.LoadAnim(anim.dict)
    escorting = not escorting
    if escorting then
        TaskPlayAnim(player, anim.dict, anim.name, 8.0, -8.0, -1, anim.flags, 0, false, false, false)
        EscortAnimHandle(anim)
    else
        ClearPedTasks(player)
    end
end)

RegisterNetEvent('gangsystem:client:setZiptied')
AddEventHandler('gangsystem:client:setZiptied', function(result)
    ziptied = result
end)

RegisterNetEvent('gangsystem:client:ziptieTarget')
AddEventHandler('gangsystem:client:ziptieTarget', function(srcPlayer, useZipties)
    if useZipties then
        ZiptieHandle(srcPlayer)
    else
        local sourcePed = GetPlayerPed(GetPlayerFromServerId(srcPlayer))
        AttachEntityToEntity(player, sourcePed, 11816, 0.18, 0.58, 0.0, 0.0, 0.0, -10.0, false, false, false, false, 20, false)
        Wait(2000)
        DetachEntity(player)
        Wait(100)
        ziptied = false
    end
end)

RegisterNetEvent('gangsystem:client:ziptieSource')
AddEventHandler('gangsystem:client:ziptieSource', function(srcTarget, useZipties)
    local anims = {
        [1] = {dict = 'mp_arrest_paired', lib = 'cop_p2_back_right', flag = 48},
        [2] = {dict = 'mp_arresting', lib = 'a_uncuff', flag = 16},
    }
    if useZipties then
        Wait(200)
        Lib.LoadAnim(anims[1].dict)
        FreezeEntityPosition(player, true)
        TaskPlayAnim(player, anims[1].dict, anims[1].lib, 5.0, -8.0, 3800, anims[1].flag, 0, false, false, false)
        Wait(3800) 
        FreezeEntityPosition(player, false)
    else
        Lib.LoadAnim(anims[2].dict)
        TaskPlayAnim(player, anims[2].dict, anims[2].lib, 8.0, -8, -1, anims[2].flag, 0, false, false, false)
        Wait(2600)
        ClearPedTasks(player)
    end
end)

RegisterNetEvent('gangsystem:client:cutZipties')
AddEventHandler('gangsystem:client:cutZipties', function(item)
    local closestId, target, dist = Lib.GetClosestPlayer2(coords, 2.0, false)
	if (closestId ~= nil and closestId ~= -1) and #(coords - dist) <= 2.0 then
        local targetId = GetPlayerServerId(closestId)
        local playerZiptied = IsTargetZiptied(targetId)
        if playerZiptied then
            TriggerServerEvent('gangsystem:server:cutZipties', targetId)
        else
            Core.Notification({
                title = '',
                message = Lang['target_not_ziptied'],
                type = 'inform'
            })
        end
	else
        Core.Notification({
            title = '',
            message = Lang['no_players_nearby'],
            type = 'inform'
        })
	end
end)

Citizen.CreateThread(function()
	while true do
        Wait(1)
        local sleep = true

        if hostaging then
            sleep = false
			DisableControlAction(0, 24,true)
			DisableControlAction(0, 25,true)
			DisableControlAction(0, 47,true)
			DisableControlAction(0, 58,true)
			DisableControlAction(0, 21,true)
			DisablePlayerFiring(player, true)

            if IsEntityDead(PlayerPedId()) then	
                hostaging = false
                TriggerServerEvent('gangsystem:server:hostageRelease', {target = hostageSrc})
			end
        end 

        if isHostage then
            sleep = false
			DisableControlAction(0, 21,true) 
			DisableControlAction(0, 24,true) 
			DisableControlAction(0, 25,true) 
			DisableControlAction(0, 47,true) 
			DisableControlAction(0, 58,true) 
			DisableControlAction(0, 263,true)
			DisableControlAction(0, 264,true)
			DisableControlAction(0, 257,true)
			DisableControlAction(0, 140,true)
			DisableControlAction(0, 141,true)
			DisableControlAction(0, 142,true)
			DisableControlAction(0, 143,true)
			DisableControlAction(0, 75,true) 
			DisableControlAction(27, 75,true)  
			DisableControlAction(0, 22,true) 
			DisableControlAction(0, 32,true) 
			DisableControlAction(0, 268,true)
			DisableControlAction(0, 33,true) 
			DisableControlAction(0, 269,true)
			DisableControlAction(0, 34,true) 
			DisableControlAction(0, 270,true)
			DisableControlAction(0, 35,true) 
			DisableControlAction(0, 271,true)
        end

        if sleep then
            Wait(1000)
        end
    end
end)

EscortHandle = function(srcPlayer)
    beingEscorted = true
    local sourcePed = GetPlayerPed(GetPlayerFromServerId(srcPlayer))
    AttachEntityToEntity(player, sourcePed, 11816, 0.30, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, false)

    SetPedCanRagdoll(player, false)
    SetEnableHandcuffs(player, true)
    SetPedCanPlayGestureAnims(player, false)
    SetPedPathCanUseLadders(player, false)
    SetCurrentPedWeapon(player, 'WEAPON_UNARMED', true)

    while escorted == true do
        local sourcePed = GetPlayerPed(GetPlayerFromServerId(srcPlayer))
        if IsPedWalking(sourcePed) then
            if not GetIsTaskActive(player, 224) then 
                TaskGoToCoordAnyMeans(player, coords.x + 10.0, coords.y + 10.0, coords.z, 1.0, 0, 0, 786603, 0xbf800000)
            end
        elseif IsPedSprinting(sourcePed) or IsPedRunning(sourcePed) then
            if not GetIsTaskActive(player, 218) then
                TaskSmartFleeCoord(player, coords.x + 100.0, coords.y + 100.0, coords.z, 100000.0, -1, false, false)
                --TaskSmartFleePed(player, sourcePed, 100000.0, -1)
            end
        else
            TaskStandStill(player, -1)
        end
        Wait(1)
    end

    ClearPedTasks(player)
    SetPedCanRagdoll(player, true)
    SetEnableHandcuffs(player, false)
    SetPedCanPlayGestureAnims(player, true)
    SetPedPathCanUseLadders(player, true)
    DetachEntity(player, true, false)
    beingEscorted = false
end

EscortAnimHandle = function(anim)
    Citizen.CreateThread(function()
        while escorting do
            if not IsEntityPlayingAnim(player, anim.dict, anim.name, anim.flags) then 
                TaskPlayAnim(player, anim.dict, anim.name, 1.0, -1.0, -1, anim.flags, 0, false, false, false)
            end
            Wait(500)
        end
    end)
end

ZiptieHandle = function(srcPlayer)
    local anims = {
        [1] = {dict = 'mp_arresting', lib = 'idle', flag = 49},
        [2] = {dict = 'mp_arrest_paired', lib = 'crook_p2_back_right', flag = 48},
    }

    Lib.LoadAnim(anims[1].dict)
    Lib.LoadAnim(anims[2].dict)
    
    local sourcePed = GetPlayerPed(GetPlayerFromServerId(srcPlayer))
    AttachEntityToEntity(player, sourcePed, 11816, 0.18, 0.52, 0.0, 0.0, 0.0, -10.0, false, false, false, false, 20, false)
    TaskPlayAnim(player, anims[2].dict, anims[2].lib, 5.0, -8.0, -1, anims[2].flag, 0, false, false, false)
    Wait(2000)
    DetachEntity(player, true, false)
    Wait(1500)
    TaskPlayAnim(player, anims[1].dict, anims[1].lib, 8.0, -8.0, -1, anims[1].flag, 0, false, false, false)
    
    ziptied = true

    SetPedCanRagdoll(player, false)
    SetEnableHandcuffs(player, true)
    SetPedCanPlayGestureAnims(player, false)
    SetPedPathCanUseLadders(player, false)
    DisableControls()
    
    ZiptieObjHandle(true)

    while ziptied == true do
        Wait(1000)
    end

    ClearPedTasks(player)
    SetPedCanPlayGestureAnims(player, true)
    SetPedPathCanUseLadders(player, true)
    SetPedCanRagdoll(player, true)
    SetEnableHandcuffs(player, false)
    UncuffPed(player)
    ZiptieObjHandle(false)
end

Citizen.CreateThread(function()
    local anim = {dict = 'mp_arresting', name = 'idle', flag = 49}
    Lib.LoadAnim(anim.dict)
    while true do
        local ped = GetPlayerPed(-1)
        if ziptied == true then
            if not IsEntityPlayingAnim(ped, anim.dict, anim.name, anim.flag) then
                TaskPlayAnim(ped,anim.dict,anim.name, 8.0, -8, -1, anim.flag, 0, 0, 0, 0)
            end
        end
        Citizen.Wait(500)
    end
end)

ZiptieObjHandle = function(add)
    Lib.LoadModel(Config.Actions.Menu['ziptie'].prop)
    if add then
        if ziptieEntity ~= nil and DoesEntityExist(ziptieEntity) then
            AttachEntityToEntity(ziptieEntity, player, GetPedBoneIndex(player, 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        else
            ziptieEntity = CreateObject(GetHashKey(Config.Actions.Menu['ziptie'].prop), coords.x, coords.y, coords.z, true, true, true)
            local networkId = ObjToNet(ziptieEntity)
            SetNetworkIdExistsOnAllMachines(networkId, true)
            SetNetworkIdCanMigrate(networkId, false)
            NetworkSetNetworkIdDynamic(networkId, true)
            AttachEntityToEntity(ziptieEntity, player, GetPedBoneIndex(player, 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        end
    else
        DetachEntity(ziptieEntity, true, true)
        DeleteEntity(ziptieEntity)
        SetModelAsNoLongerNeeded(ziptieEntity)
        ziptieEntity = nil
    end
end

DisableControls = function()
    Citizen.CreateThread(function()
        while ziptied do
            DisableControlAction(1, 23, true)  -- INPUT_ENTER
            DisableControlAction(1, 24, true) -- INPUT_ATTACK
            DisableControlAction(1, 25, true)  -- INPUT_AIM
            DisableControlAction(0, 25, true)  -- INPUT_AIM
            DisableControlAction(1, 37, true) -- INPUT_SELECT_WEAPON
            DisableControlAction(1, 50, true) -- INPUT_ACCURATE_AIM
            DisableControlAction(1, 68, true) -- INPUT_VEH_AIM
            DisableControlAction(1, 69, true) -- INPUT_VEH_ATTACK
            DisableControlAction(1, 75, true)  -- INPUT_VEH_EXIT
            DisableControlAction(1, 91, true) -- INPUT_VEH_PASSENGER_AIM
            DisableControlAction(1, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(1, 106, true) -- INPUT_VEH_MOUSE_CONTROL_OVERRIDE
            DisableControlAction(1, 114, true) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(1, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
            DisableControlAction(1, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
            DisableControlAction(1, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
            DisableControlAction(1, 257, true) -- INPUT_ATTACK2
            Wait(1)
        end
    end)
end

CreateMapBlip = function(value, pos)
	if value.enable == true then
        local blipCoords = value.pos or nil
        if pos ~= nil then
            blipCoords = pos
        end
		local blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
		SetBlipSprite(blip, value.sprite)
		SetBlipDisplay(blip, value.display)
		SetBlipScale(blip, value.scale)
		SetBlipColour(blip, value.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(value.name)
		EndTextCommandSetBlipName(blip)
        return blip
    else
        return nil
	end
end

-- ## DRUG SALE ## --

old_ped = nil
local selling_drugs = false

local ox_target = exports.ox_target
--[[
ox_target:addGlobalPed({
    {
        name = 'drugSelling',
        icon = 'fa-solid fa-person',
        distance = 3,
        label = 'Vender Droga',
        event = "gangsystem:server:getDrugInventory",
        canInteract = function(entity, coords, distance)
            if not IsPedDeadOrDying(entity, 1) and not selling_drugs then
                return true
            end
        end
    }
})
]]
local targetParameters = {
    options = {
        {
            name = 'gangsystem:drugSelling',
            event = 'gangsystem:client:sellDrugs',
            icon = 'fa-solid fa-person',
            label = Lang['target_sell_drugs'],
            type = 'client',
            canInteract = targetInteract,
        }
    },
    distance = Config.DrugSale.Distance,
    canInteract = targetInteract
}


if Config.DrugSale.Enable == true then  
    Lib.AddGlobalPed(targetParameters)
end

RegisterNetEvent('gangsystem:client:sellDrugs', function(args)

    if plyGangId <= 0 then
        local done = false
        Core.TriggerCallback('gangsystem:server:getPlayerGangId', function(result)
            plyGangId = result
            done = true
        end)
        while not done do 
            Wait(100)
        end
    end

    if Config.DrugSale.AllowGangsOnly == true and plyGangId <= 0 then
        return Core.Notification({
            title = '',
            message = Lang['only_gang_members'],
            type = 'error',
        })
    end

    if Core.GetPoliceCount() < Config.DrugSale.RequiredPolice then
        return Core.Notification({
            title = '',
            message = Lang['not_enough_police'],
            type = 'error'
        })
    end

    selling_drugs = true

    local cfg = Config.DrugSale
    old_ped = args.entity

    local pedCoords = GetEntityCoords(old_ped)

    TaskStandStill(old_ped, 5000.0)
    SetEntityAsMissionEntity(old_ped)
    FreezeEntityPosition(old_ped, true)
    FreezeEntityPosition(player, true)
    ClearPedTasksImmediately(old_ped)
    SetEntityHeading(old_ped, GetHeadingFromVector_2d(pedCoords.x-coords.x,pedCoords.y-coords.y)+180)
    SetEntityHeading(player, GetHeadingFromVector_2d(pedCoords.x-coords.x,pedCoords.y-coords.y))

    local menuOptions = {}

    Core.TriggerCallback('gangsystem:server:getDrugInventory', function(drugInventory)
        if #drugInventory == 0 then 
            selling_drugs = false
            FreezeEntityPosition(old_ped, false)
            FreezeEntityPosition(player, false)
            SetPedAsNoLongerNeeded(old_ped)
            return Core.Notification({
                title = '',
                message = Lang['no_drugs_to_sell'],
                type = 'error'
            })
        end
        for k,v in pairs(drugInventory) do
            table.insert(menuOptions, {
                title = v.label..' ['..v.count..'x]',
                icon = 'pills',
                args = v,
                onSelect = function()
                    lib.hideContext(false)
                    math.randomseed(GetGameTimer())
                    if math.random(0,100) <= v.cfg.value.sell.chance then

                        -- animation:
                        Lib.LoadAnim(cfg.Anims['sale'].dict)
                        TaskPlayAnim(player, cfg.Anims['sale'].dict, cfg.Anims['sale'].name, 8.0, 8.0, 2000, 0, 0, false, false, false)
                        TaskPlayAnim(old_ped, cfg.Anims['sale'].dict, cfg.Anims['sale'].name, 8.0, 8.0, 2000, 0, 0, false, false, false)

                        -- sell amount:
                        math.randomseed(GetGameTimer())
                        local amount = math.random(v.cfg.value.sell.amount.min, v.cfg.value.sell.amount.max)
                        if amount > v.count then 
                            amount = v.count
                        end

                        -- unit base sell price:
                        math.randomseed(GetGameTimer())
                        local price = math.random(v.cfg.value.sell.price.min, v.cfg.value.sell.price.max)

                        -- police bonus:
                        local policeBonus = 0
                        if v.cfg.value.policeBonus.enable and Core.GetPoliceCount() >= v.cfg.value.policeBonus.required then
                            policeBonus = (v.cfg.value.policeBonus.percentage/100 + 1.0)
                        end

                        -- street bonus:
                        local streetBonus = 0
                        if v.cfg.value.streetBonus.enable then
                            streetBonus = GetStreetBonus(coords, v.cfg.value.streetBonus.streets)
                        end
                        
                        -- server event:
                        TriggerServerEvent('gangsystem:server:sellDrugs', v, amount, price, policeBonus, streetBonus)
                    else
                        FreezeEntityPosition(player, false)
                        FreezeEntityPosition(old_ped, false)

                        -- report chance:
                        math.randomseed(GetGameTimer())
                        if math.random(0,100) <= v.cfg.value.report.chance then
                            -- minus notoriety:
                            TriggerServerEvent('gangsystem:server:minusNotoriety', plyGangId, Config.DrugSale.Notoriety.rejected)
                            
                            -- animation:
                            Lib.LoadAnim(cfg.Anims['report'].dict)
                            TaskPlayAnim(old_ped, cfg.Anims['report'].dict, cfg.Anims['report'].name, 1.0, -1.0, -1, 49, 0, false, false, false)

                            -- call police thread:
                            local tick, calling, callPolice = (v.cfg.value.report.timer * 1000), true, true
                            while calling and tick > 0 do
                                if IsPedDeadOrDying(old_ped, 1) then
                                    callPolice = false
                                    calling = false
                                end
                                Wait(1000)
                                tick = tick - 1000
                            end

                            -- stop anim:
                            StopAnimTask(old_ped, cfg.Anims['report'].dict, cfg.Anims['report'].name, 1.0)

                            -- call police?
                            if callPolice then
                                local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                                local data = {
                                    title = '911 DISPATCH',
                                    description = Lang['possible_drug_sale_at']:format(streetName),
                                    blipText = '911 - Drug Sale',
                                    duration = 10000,
                                    position = 'top',
                                    type = 'inform',
                                    icon = 'handcuffs',
                                }
                                Lib.TriggerPoliceNotification(coords, streetName, data)
                            end
                        else
                            Core.Notification({
                                title = 'Drug Sale',
                                message = Lang['drug_sale_rejected'],
                                type = 'inform'
                            })
                        end 
                    end
                    FreezeEntityPosition(old_ped, false)
                    FreezeEntityPosition(player, false)
                    SetPedAsNoLongerNeeded(old_ped)
                    Wait(Config.DrugSale.Cooldown * 1000)
                    selling_drugs = false
                end,
            })
        end

        lib.registerContext({
            id = 'drug_inventory',
            title = 'Drug Inventory',
            onExit = function()
                selling_drugs = false
                FreezeEntityPosition(old_ped, false)
                FreezeEntityPosition(player, false)
                SetPedAsNoLongerNeeded(old_ped)
            end,
            options = menuOptions,
        })
        lib.showContext('drug_inventory')
    end)
end)


if Config.Debug == true then
    RegisterCommand('street', function()
        print(GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)))
    end)
end

AddEventHandler('playerSpawned', function()
    -- checks for headbag:
    DeleteEntity(headbagEntity)
    SetEntityAsNoLongerNeeded(headbagEntity)
    SendNUIMessage({
        ['task'] = 'removeHeadbag'
    })
    headbagged = false
    headbagEntity = nil
    -- checks for cuffs:
    ClearPedTasks(player)
    SetPedCanPlayGestureAnims(player, true)
    SetPedPathCanUseLadders(player, true)
    SetPedCanRagdoll(player, true)
    SetEnableHandcuffs(player, false)
    UncuffPed(player)
    ZiptieObjHandle(false)
    TriggerServerEvent('gangsystem:server:setPlayerZiptied')
end)

