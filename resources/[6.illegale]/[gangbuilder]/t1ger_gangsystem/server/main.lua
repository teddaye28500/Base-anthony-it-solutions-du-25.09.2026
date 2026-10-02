Core, Cfg = exports['t1ger_lib']:GetLib()
t1ger_gangs = {}
ziptied = {}
marker_cooldown = {}
pin_attempts = {}

-- ## THREADS ## --

Citizen.CreateThread(function ()
    while GetResourceState('t1ger_lib') ~= 'started' do Citizen.Wait(0) end
    if GetResourceState('t1ger_lib') == 'started' then
        InitializeGangSystem()
    end
end)

-- ## EVENTS ## --

function GetPlayerGangId(idplayer)

    local id
    local identifier = Core.Player.GetIdentifier(idplayer)
            for k,v in pairs(t1ger_gangs) do
                for d,g in pairs(v.members) do
                    if g.identifier == identifier then
                        id = v.id
                    end
                end
            end

            if id == nil then
                return 0
            else
                return id
            end              
        end


function InitializeGangSystem()
    local src = Core.Player.GetSource(source)
    GetGangsFromDatabase()
    local playerGangId = GetPlayerGangId(src)
    TriggerClientEvent('gangsystem:client:setPlayerGangId', src, playerGangId)
    TriggerClientEvent('gangsystem:client:createNPC', src)
    TriggerClientEvent('gangsystem:client:setGangs', src, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:createMarkerBlips', src, playerGangId)
    local identifier = Core.Player.GetIdentifier(src)
    if ziptied[identifier] ~= nil then
		TriggerClientEvent('gangsystem:client:setZiptied', src, ziptied[identifier])
    end
    Core.UseableItem(Config.Items[3], function(src, item)
        if item == nil then
            RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items[3]..') does not exists in your items.\n')
        else
            TriggerClientEvent('gangsystem:client:cutZipties', src, item)
        end
    end)
end

RegisterServerEvent('gangsystem:server:playerLoaded')
AddEventHandler('gangsystem:server:playerLoaded', function()
    local src = Core.Player.GetSource(source)
    GetGangsFromDatabase()
    local playerGangId = GetPlayerGangId(src)
    TriggerClientEvent('gangsystem:client:setPlayerGangId', src, playerGangId)
    TriggerClientEvent('gangsystem:client:createNPC', src)
    TriggerClientEvent('gangsystem:client:setGangs', src, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:createMarkerBlips', src, playerGangId)
    local identifier = Core.Player.GetIdentifier(src)
    if ziptied[identifier] ~= nil then
		TriggerClientEvent('gangsystem:client:setZiptied', src, ziptied[identifier])
    end
    Core.UseableItem(Config.Items[3], function(src, item)
        if item == nil then
            RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items[3]..') does not exists in your items.\n')
        else
            TriggerClientEvent('gangsystem:client:cutZipties', src, item)
        end
    end)
end)

RegisterServerEvent('gangsystem:server:createGang')
AddEventHandler('gangsystem:server:createGang', function(name, target)
    local src = Core.Player.GetSource(source)
    local srcTarget = Core.Player.GetSource(target)
    local leader = Core.Player.GetIdentifier(srcTarget)
    local leaderName = Core.Player.GetName(srcTarget)

    local ranks = Config.DefaultRanks

    local members = {}
    table.insert(members, {identifier = leader, name = leaderName, rank = 1})

    local markers = {
        ['garage'] = {},
        ['stash'] = {},
        ['locker'] = {},
    }

    local rackets = {}

    MySQL.Async.execute('INSERT INTO t1ger_gangs (name, leader, ranks, members, markers, rackets) VALUES (@name, @leader, @ranks, @members, @markers, @rackets)', {
        ['@name'] = name,
        ['@leader'] = leader,
        ['@ranks'] = json.encode(ranks),
        ['@members'] = json.encode(members),
        ['@markers'] = json.encode(markers),
        ['@rackets'] = json.encode(rackets),
    }, function(affectedRows)
        GetGangsFromDatabase()
        TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
        Core.Notification(src, {
            title = '',
            message = Lang['gang_created']:format(name),
            type = 'success'
        })
    end)

end)

RegisterServerEvent('gangsystem:server:deleteGang')
AddEventHandler('gangsystem:server:deleteGang', function(data)
    local src = source

    data.markers['garage'] = {}
    data.markers['stash'] = {}
    data.markers['locker'] = {}
    t1ger_gangs[data.id].markers = data.markers
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:createMarkerBlips', -1, data.id)

    t1ger_gangs[data.id] = nil

    MySQL.Async.execute('DELETE FROM t1ger_gangs WHERE id = @id', {
        ['@id'] = data.id
    }, function(affectedRows)
        GetGangsFromDatabase()
        TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
        Core.Notification(src, {
            title = '',
            message = Lang['gang_deleted']:format(data.name),
            type = 'inform'
        })
    end)
end)

RegisterServerEvent('gangsystem:server:setLeader')
AddEventHandler('gangsystem:server:setLeader', function(data)
    local src = source

    -- update rank ID on old leader
    for k,v in pairs(data.gang.members) do
        if v.rank == 1 then
            v.rank = tonumber(#data.gang.ranks)
            break
        end
    end

    -- set new leader
    local match = false
    for k,v in pairs(data.gang.members) do
        if v.identifier == data.player.identifier then
            match = true
            v.rank = 1
            break
        end
    end

    if match == false then
        table.insert(data.gang.members, {identifier = data.player.identifier, name = Core.Player.GetName(data.player.source), rank = 1})
        TriggerClientEvent('gangsystem:client:setPlayerGangId', data.player.source, data.gang.id)
    end

    t1ger_gangs[data.gang.id].leader = Core.Player.GetIdentifier(data.player.source)
    t1ger_gangs[data.gang.id].members = data.gang.members
    
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    Core.Notification(src, {
        title = '',
        message = Lang['gang_leader_updated']:format(data.gang.name, Core.Player.GetName(data.player.source)),
        type = 'inform'
    })

end)

RegisterServerEvent('gangsystem:server:updateDisable')
AddEventHandler('gangsystem:server:updateDisable', function(data, state)
    local src = source
    t1ger_gangs[data.id].disabled = state
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    if state == true then
        Core.Notification(src, {
            title = '',
            message = Lang['gang_disabled']:format(t1ger_gangs[data.id].name),
            type = 'inform'
        })
    elseif state == false then 
        Core.Notification(src, {
            title = '',
            message = Lang['gang_enabled']:format(t1ger_gangs[data.id].name),
            type = 'inform'
        })
    end
end)

RegisterServerEvent('gangsystem:server:updateMembers')
AddEventHandler('gangsystem:server:updateMembers', function(id, members)
    t1ger_gangs[id].members = members
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    UpdateGangsTable()
end)

RegisterServerEvent('gangsystem:server:sendInvitation')
AddEventHandler('gangsystem:server:sendInvitation', function(data, args)
    local src = Core.Player.GetSource(source)
    local targetSrc = Core.Player.GetSource(args.serverId)
    local targetIdentifier = Core.Player.GetIdentifier(targetSrc)

    -- check if already in another gang:
    local playerGangId = GetPlayerGangId(targetSrc)
    if (playerGangId ~= nil and playerGangId > 0) then 
        return Core.Notification(src, {
            title = '',
            message = Lang['member_already_in_gang'],
            type = 'error'
        })
    end
    local foundPlayer = false
    for k,v in pairs(data.members) do
        if v.identifier == targetIdentifier then
            foundPlayer = true
            break
        end
    end
    if foundPlayer == true then
        return Core.Notification(src, {
            title = '',
            message = Lang['member_already_in_gang'],
            type = 'error'
        })
    else
        TriggerClientEvent('gangsystem:client:sendInvitation', targetSrc, data, args, src)
        Core.Notification(src, {
            title = '',
            message = Lang['gang_invitation_sent']:format(Core.Player.GetName(targetSrc)),
            type = 'inform'
        })
    end
end)

RegisterServerEvent('gangsystem:server:invitationRespond')
AddEventHandler('gangsystem:server:invitationRespond', function(data, args, bool, playerSrc)
    local src = Core.Player.GetSource(playerSrc)
    local targetSrc = Core.Player.GetSource(source)
    local targetIdentifier = Core.Player.GetIdentifier(targetSrc)

    if bool == true then 
        Core.Notification(src, {
            title = '',
            message = Lang['invitation_accepted2'],
            type = 'success'
        })
        table.insert(data.members, {identifier = targetIdentifier, name = Core.Player.GetName(targetSrc), rank = tonumber(#data.ranks)})

        t1ger_gangs[data.id].members = data.members
        TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
        TriggerClientEvent('gangsystem:client:setPlayerGangId', targetSrc, data.id)
        UpdateGangsTable()
    else 
        Core.Notification(src, {
            title = '',
            message = Lang['invitation_declined2'],
            type = 'inform'
        })
    end
end)

RegisterServerEvent('gangsystem:server:updateRanks')
AddEventHandler('gangsystem:server:updateRanks', function(id, rankas)
    t1ger_gangs[id].ranks = rankas
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    UpdateGangsTable()
end)

RegisterServerEvent('gangsystem:server:createMarker')
AddEventHandler('gangsystem:server:createMarker', function(input, args, cost)
    local src = Core.Player.GetSource(source)
    local x,y,z = table.unpack(input[1])

    local marker = {
        coords = {x = x, y = y, z = z},
        pin = input[2],
        type = input[3],
        color = {r = input[4], g = input[5], b = input[6], a = input[7]},
        bobUpAndDown = input[8],
        faceCamera = input[9]
    }

    if args.type == 'stash' then
        marker.id = 'gangstash'..args.data.id
        marker.stash = {
            id = 'gangstash'..args.data.id,
            label = args.data.name..' Stash',
            slots = Config.Markers['stash'].stash.slots,
            weight = Config.Markers['stash'].stash.weight,
            owner = nil -- make sure its accessable by everyone!!
        }
    elseif args.type == 'garage' then 
        marker.id = 'ganggarage'..args.data.id
    elseif args.type == 'locker' then 
        marker.id = 'ganglocker'..args.data.id
    end
    args.data.markers[args.type] = marker
    t1ger_gangs[args.data.id].markers = args.data.markers
    
    if args.type == 'stash' then
        CreateStash(t1ger_gangs[args.data.id])
    end

    if cost.notoriety ~= nil and cost.notoriety > 0 then
        MinusGangNotoriety(args.data.id, cost.notoriety)
    end

    if cost.cash ~= nil and cost.cash > 0 then
        if args.type ~= 'locker' then 
            MinusGangCash(args.data.id, cost.cash)
        end
    end

    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:createMarkerBlips', -1, args.data.id)
    
    Core.Notification(src, {
        title = '',
        message = Lang['marker_created'],
        type = 'success'
    })
    UpdateGangsTable()
end)

function CreateStash(kaskas)
    exports.ox_inventory:RegisterStash("gangstash"..kaskas.id, kaskas.name, Config.Markers["stash"].stash.slots, Config.Markers["stash"].stash.weight)
end

RegisterServerEvent('gangsystem:server:deleteMarker')
AddEventHandler('gangsystem:server:deleteMarker', function(args)
    local src = Core.Player.GetSource(source)
    args.data.markers[args.type] = {}

    AddMarkerCooldown(args.data.id, args.type)

    t1ger_gangs[args.data.id].markers = args.data.markers
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:createMarkerBlips', -1, args.data.id)
    Core.Notification(src, {
        title = '',
        message = Lang['marker_deleted'],
        type = 'inform'
    })
end)

RegisterServerEvent('gangsystem:server:addPinAttempts')
AddEventHandler('gangsystem:server:addPinAttempts', function(gangId, type)
    local src = Core.Player.GetSource(source)
    AddPinAttempts(src, gangId, type)
end)

RegisterServerEvent('gangsystem:server:resetPinAttempts')
AddEventHandler('gangsystem:server:resetPinAttempts', function(gangId, type)
    local src = Core.Player.GetSource(source)
    local identifier = Core.Player.GetIdentifier(src)
    
    if pin_attempts[identifier] ~= nil then
        for k,v in pairs(pin_attempts[identifier]) do
            if v.type == type and v.id == gangId then
                return RemovePinAttempts(v.id, identifier, k)
            end
        end
    end
end)

AddPinAttempts = function(src, gangId, type)
    local identifier = Core.Player.GetIdentifier(src)
    if Config.Markers[type].pincode.enable then
        if pin_attempts[identifier] == nil then
            pin_attempts[identifier] = {}
            table.insert(pin_attempts[identifier], {id = gangId, type = type, attempts = 1})
        else
            for k,v in pairs(pin_attempts[identifier]) do
                if v.type == type and v.id == gangId then
                    v.attempts = v.attempts + 1
                    if v.attempts >= Config.Markers[type].pincode.attempts then
                        v.cooldown = (Config.Markers[type].pincode.cooldown * 60 * 1000)
                    end
                    return
                end
            end
            table.insert(pin_attempts[identifier], {id = gangId, type = type, attempts = 1})
        end
    end
end

GetPinAttempts = function(src, gangId, type)
    local identifier = Core.Player.GetIdentifier(src)
    if pin_attempts[identifier] ~= nil then
        for k,v in pairs(pin_attempts[identifier]) do
            if v.id == gangId and v.type == type then
                return v.attempts, (v.cooldown or nil)
            end
        end
    end
    return nil
end

RemovePinAttempts = function(gangId, identifier, index)
    table.remove(pin_attempts[identifier], index)
end

AddMarkerCooldown = function(gangId, type)
    if Config.Markers[type].cooldown.enable then
        if marker_cooldown[gangId] == nil then 
            marker_cooldown[gangId] = {}
        end
        table.insert(marker_cooldown[gangId], {type = type, time = (Config.Markers[type].cooldown.time * 60 * 1000)})
    end
end

GetMarkerCooldown = function(gangId, type)
    if marker_cooldown[gangId] ~= nil then
        for index, v in pairs(marker_cooldown[gangId]) do
            if v.type == type then
                return true, v.time
            end
        end
    end
    return false
end

RemoveMarkerCooldown = function(gangId, index)
    table.remove(marker_cooldown[gangId], index)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if next(marker_cooldown) then 
            for gangId, marker in pairs(marker_cooldown) do
                for index, v in pairs(marker) do
                    if v.time <= 0 then
                        RemoveMarkerCooldown(gangId, index)
                    else
                        v.time = v.time - 1000
                        if Config.Debug then
                            print("marker cooldown time left: ", v.time)
                        end
                    end
                end
            end
        end
        if next(pin_attempts) then
            for identifier, tables in pairs(pin_attempts) do
                if pin_attempts[identifier] ~= nil then
                    for k,v in pairs(pin_attempts[identifier]) do
                        if v.cooldown ~= nil then
                            if v.cooldown <= 0 then
                                RemovePinAttempts(v.id, identifier, k)
                            else
                                v.cooldown = v.cooldown - 1000
                                if Config.Debug then
                                    print("pin-code ["..v.id.." | "..v.type.."] cooldown time left: ", v.cooldown)
                                end
                            end
                        end
                    end
                end
            end
        end
	end
end)

RegisterServerEvent('gangsystem:server:changePin')
AddEventHandler('gangsystem:server:changePin', function(input, args)
    local src = Core.Player.GetSource(source)
    args.data.markers[args.type].pin = input[1]

    t1ger_gangs[args.data.id].markers = args.data.markers
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    Core.Notification(src, {
        title = '',
        message = Lang['pin_code_changed'],
        type = 'inform'
    })
end)

RegisterServerEvent('gangsystem:server:updateCash')
AddEventHandler('gangsystem:server:updateCash', function(add, id, cash, amount)
    local src = Core.Player.GetSource(source)
    --local balance = 0
    local execute = false

    if add == true then
        local playerMoney = Core.Player.GetMoney(src)
        if playerMoney >= amount then
            Core.Player.RemoveMoney(src, amount)
            PlusGangCash(id, amount)
            --balance = cash + amount
            execute = true
            Core.Notification(src, {
                title = '',
                message = Lang['cash_deposited']:format(amount),
                type = 'success'
            })
            UpdateGangsTable()
        else
            execute = false
            return Core.Notification(src, {
                title = '',
                message = Lang['not_enough_moeny'],
                type = 'error'
            })
        end
    else
        Core.Player.AddMoney(src, amount)
        MinusGangCash(id, amount)
        --balance = cash - amount
        execute = true
        Core.Notification(src, {
            title = '',
            message = Lang['cash_withdrawn']:format(amount),
            type = 'success'
        })
        UpdateGangsTable()
    end

    if execute then 
        --t1ger_gangs[id].cash = balance
        TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    end

end)

RegisterServerEvent('gangsystem:server:claimRacket')
AddEventHandler('gangsystem:server:claimRacket', function(type, data, gang)
    Config.Rackets[type].claimed = true
    Config.Rackets[type].gang = gang.id

    local curRackets = t1ger_gangs[gang.id].rackets
    
    table.insert(curRackets, type)

    t1ger_gangs[gang.id].rackets = curRackets
    MinusGangNotoriety(gang.id, Config.Rackets[type].cost)
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:racketConfig', -1, Config.Rackets)
end)

RegisterServerEvent('gangsystem:server:withdrawRacket')
AddEventHandler('gangsystem:server:withdrawRacket', function(type, data, gang)
    Config.Rackets[type].claimed = false
    Config.Rackets[type].gang = nil

    local curRackets = t1ger_gangs[gang.id].rackets
    
    for k,v in pairs(curRackets) do
        if v == type then
            table.remove(curRackets, k)
            break
        end
    end

    t1ger_gangs[gang.id].rackets = curRackets
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
    TriggerClientEvent('gangsystem:client:racketConfig', -1, Config.Rackets)
end)

RegisterServerEvent('gangsystem:server:protectionCollect')
AddEventHandler('gangsystem:server:protectionCollect', function(shopId, shopData, cfg, gangId)
    local src = Core.Player.GetSource(source)

    if next(Config.Rackets['protection'].data.shops[shopId].cache) == nil then

		local cache = {
			id = shopId,
			identifier = Core.Player.GetIdentifier(src),
			reward = math.random(Config.Rackets['protection'].data.cash.min, Config.Rackets['protection'].data.cash.max),
			time = (Config.Rackets['protection'].data.timer * 1000 * 60),
			done = false,
			collected = false
		}
		Config.Rackets['protection'].data.shops[shopId].cache = cache
        TriggerClientEvent('gangsystem:client:racketConfig', -1, Config.Rackets)

        Core.Notification(src, {
            title = '',
            message = Lang['collected_requested'],
            type = 'success'
        })

    else

        if Config.Rackets['protection'].data.shops[shopId].cache.done == false then
            return Core.Notification(src, {
                title = '',
                message = Lang['collection_not_ready'],
                type = 'inform'
            })
        end

        if not Config.Rackets['protection'].data.shops[shopId].cache.collected then
            Config.Rackets['protection'].data.shops[shopId].cache.collected = true
            local amount = Config.Rackets['protection'].data.shops[shopId].cache.reward
            Core.Notification(src, {
                title = '',
                message = Lang['cash_collected']:format(amount),
                type = 'success'
            })
            --t1ger_gangs[gangId].cash = (t1ger_gangs[gangId].cash + amount)
            PlusGangCash(gangId, amount)
            PlusGangNotoriety(gangId, Config.Rackets['protection'].data.notoriety)
            Config.Rackets['protection'].data.shops[shopId].cache = {}
            TriggerClientEvent('gangsystem:client:racketConfig', -1, Config.Rackets)
            TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
        end

	end
end)

Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
        Citizen.Wait(1000)
		for i = 1, #Config.Rackets['protection'].data.shops do
            if next(Config.Rackets['protection'].data.shops[i].cache) ~= nil then
                if not Config.Rackets['protection'].data.shops[i].cache.done then
                    if Config.Rackets['protection'].data.shops[i].cache.time <= 0 then
                        local src = Core.Player.GetSrcFromIdentifier(Config.Rackets['protection'].data.shops[i].cache.identifier)
						if src then
                            Core.Notification(src, {
                                title = '',
                                message = Lang['shop_has_collection'],
                                type = 'inform'
                            })
						end
                        Config.Rackets['protection'].data.shops[i].cache.done = true
                    else
                        Config.Rackets['protection'].data.shops[i].cache.time = Config.Rackets['protection'].data.shops[i].cache.time - 1000
                    end
                end
            end
		end
	end
end)


RegisterServerEvent('gangsystem:server:startRacketJob')
AddEventHandler('gangsystem:server:startRacketJob', function(type, id)
    local src = Core.Player.GetSource(source)
    TriggerClientEvent('gangsystem:client:prostitutionJob', src, type, id)
end)

RegisterServerEvent('gangsystem:server:prostitutionReward')
AddEventHandler('gangsystem:server:prostitutionReward', function(gangId, id)
    local src = Core.Player.GetSource(source)

    math.randomseed(GetGameTimer())
    local amount = math.random(Config.Rackets['prostitution'].data.jobs[id].cash.min, Config.Rackets['prostitution'].data.jobs[id].cash.max)
    Core.Notification(src, {
        title = '',
        message = Lang['hooker_reward']:format(amount),
        type = 'success'
    })

    PlusGangCash(gangId, amount)
    PlusGangNotoriety(gangId, Config.Rackets['prostitution'].data.notoriety)

    TriggerClientEvent('gangsystem:client:racketConfig', -1, Config.Rackets)
    TriggerClientEvent('gangsystem:client:setGangs', -1, t1ger_gangs)
end)

local saleCount = 0
RegisterServerEvent('gangsystem:server:sellDrugs')
AddEventHandler('gangsystem:server:sellDrugs', function(item, amount, price, policeBonus, streetBonus)
    local src = Core.Player.GetSource(source)
    local gangId = GetPlayerGangId(src)
    local unitPrice = price

    -- remove drug items:
    Core.Player.RemoveItem(src, item.name, amount)

    -- unit max sell price bonus:
    if unitPrice == item.cfg.value.sell.price.max and Config.DrugSale.Notoriety.maxSellPriceBonus == true then
        PlusGangNotoriety(gangId, 1)
    end

    -- police bonus:
    if policeBonus > 0 then
        unitPrice = math.floor(unitPrice * policeBonus)
    end

    -- street bonus:
    if streetBonus > 0 then
        unitPrice = math.floor(unitPrice * streetBonus)
    end

    -- total price:
    local totalPrice = (amount * unitPrice)
    if Config.DrugSale.BlackMoney.enable then
        Core.Player.AddMoney(src, totalPrice, Config.DrugSale.BlackMoney.account)
    else
        Core.Player.AddMoney(src, totalPrice, nil)
    end

    -- notoriety:
    saleCount = (saleCount + 1)
    if saleCount >= Config.DrugSale.Notoriety.requiredSales then
        PlusGangNotoriety(gangId, Config.DrugSale.Notoriety.accepted)
        saleCount = 0
    end

    Core.Notification(src, {
        title = '',
        message = Lang['drug_sale_reward']:format(totalPrice, amount, item.label),
        type = 'success'
    })
end)

RegisterServerEvent('gangsystem:server:ziptie')
AddEventHandler('gangsystem:server:ziptie', function(targetId)
    local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    local targetIdentifier = Core.Player.GetIdentifier(target)

    local reqItem = Config.Items[1]

    if not Core.Player.HasItem(src, reqItem, 1) then
        return Core.Notification(src, {
            title = '',
            message = Lang['inv_need_zipties'],
            type = 'error'
        })
    end

    Core.Player.RemoveItem(src, reqItem, 1)

    ziptied[targetIdentifier] = true
    print(ziptied[targetIdentifier])
    TriggerClientEvent('gangsystem:client:ziptieTarget', target, src, true)
    TriggerClientEvent('gangsystem:client:ziptieSource', src, target, true)
end)

RegisterServerEvent('gangsystem:server:removeZipties')
AddEventHandler('gangsystem:server:removeZipties', function(targetId)
    local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    local targetIdentifier = Core.Player.GetIdentifier(target)

    local reqItem = Config.Items[1]
    
    Core.Player.AddItem(src, reqItem, 1)

    ziptied[targetIdentifier] = false
    TriggerClientEvent('gangsystem:client:ziptieTarget', target, src, false)
    TriggerClientEvent('gangsystem:client:ziptieSource', src, target, false)
end)

RegisterServerEvent('gangsystem:server:cutZipties')
AddEventHandler('gangsystem:server:cutZipties', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    local targetIdentifier = Core.Player.GetIdentifier(target)

    ziptied[targetIdentifier] = false
    TriggerClientEvent('gangsystem:client:ziptieTarget', target, src, false)
    TriggerClientEvent('gangsystem:client:ziptieSource', src, target, false)
end)

RegisterServerEvent('gangsystem:server:setPlayerZiptied')
AddEventHandler('gangsystem:server:setPlayerZiptied', function()
	local src = Core.Player.GetSource(source)
	local xPlayer = Core.Player.GetFromId(src)
    while xPlayer == nil do
        Wait(500)
        xPlayer = Core.Player.GetFromId(src)
    end
    SetPlayerZiptied(src, false)
end)

function SetPlayerZiptied(id, status)
    ziptied[id] = status
end


RegisterServerEvent('gangsystem:server:escort')
AddEventHandler('gangsystem:server:escort', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    local targetIdentifier = Core.Player.GetIdentifier(target)

    if ziptied[targetIdentifier] == nil or (ziptied[targetIdentifier] ~= nil and ziptied[targetIdentifier] == false) then 
		return Core.Notification(src, {
            title = '',
            message = Lang['target_not_ziptied'],
            type = 'inform'
        })
	end

    TriggerClientEvent('gangsystem:client:escort', target, src)
    TriggerClientEvent('gangsystem:client:escortAnimation', src, target)
end)

RegisterServerEvent('gangsystem:server:unEscort')
AddEventHandler('gangsystem:server:unEscort', function(srcPlayer)
	local targetSrc = Core.Player.GetSource(source)
	local playerSrc = Core.Player.GetSource(srcPlayer)
    TriggerClientEvent('gangsystem:client:escort', targetSrc, playerSrc)
    TriggerClientEvent('gangsystem:client:escortAnimation', playerSrc, targetSrc)
end)

RegisterServerEvent('gangsystem:server:vehicleIn')
AddEventHandler('gangsystem:server:vehicleIn', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    TriggerClientEvent('gangsystem:client:vehicleIn', target, src)
end)

RegisterServerEvent('gangsystem:server:vehicleOut')
AddEventHandler('gangsystem:server:vehicleOut', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    TriggerClientEvent('gangsystem:client:vehicleOut', target, src)
end)

RegisterServerEvent('gangsystem:server:trunkIn')
AddEventHandler('gangsystem:server:trunkIn', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    TriggerClientEvent('gangsystem:client:trunkIn', target, src)
end)

RegisterServerEvent('gangsystem:server:trunkOut')
AddEventHandler('gangsystem:server:trunkOut', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    TriggerClientEvent('gangsystem:client:trunkOut', target, src)
end)

RegisterServerEvent('gangsystem:server:hostage')
AddEventHandler('gangsystem:server:hostage', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
    TriggerClientEvent('gangsystem:client:hostage', src, target)
end)

RegisterServerEvent('gangsystem:server:hostageSync')
AddEventHandler('gangsystem:server:hostageSync', function(targetSrc, action)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetSrc)
	TriggerClientEvent('gangsystem:client:hostageSync', target, src, action)
	TriggerClientEvent('gangsystem:client:hostageSyncSrc', src, target, action)
end)

RegisterServerEvent('gangsystem:server:hostageRelease')
AddEventHandler('gangsystem:server:hostageRelease', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
	TriggerClientEvent('gangsystem:client:hostageSync', target, src, 'releaseHostage')
	TriggerClientEvent('gangsystem:client:hostageSyncSrc', src, target, 'releaseHostage')
end)

RegisterServerEvent('gangsystem:server:hostageKill')
AddEventHandler('gangsystem:server:hostageKill', function(targetId)
	local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
	TriggerClientEvent('gangsystem:client:hostageSync', target, src, 'killHostage')
	TriggerClientEvent('gangsystem:client:hostageSyncSrc', src, target, 'killHostage')
end)

RegisterServerEvent('gangsystem:server:headbag')
AddEventHandler('gangsystem:server:headbag', function(targetId)
    local src = Core.Player.GetSource(source)
	local target = Core.Player.GetSource(targetId)
	TriggerClientEvent('gangsystem:client:headbag', target, src)
	TriggerClientEvent('gangsystem:client:headbagAnim', src)
end)

RegisterServerEvent('gangsystem:server:minusNotoriety')
AddEventHandler('gangsystem:server:minusNotoriety', function(id, amount)
	local src = Core.Player.GetSource(source)
    local gangId = id
    if gangId == nil or gangId == 0 then
        gangId = GetPlayerGangId(src)
    end
	MinusGangNotoriety(gangId, amount)
end)

RegisterServerEvent('gangsystem:server:plusNotoriety')
AddEventHandler('gangsystem:server:plusNotoriety', function(id, amount)
	local src = Core.Player.GetSource(source)
    local gangId = id
    if gangId == nil or gangId == 0 then
        gangId = GetPlayerGangId(src)
    end
	PlusGangNotoriety(gangId, amount)
end)

RegisterServerEvent('gangsystem:server:minusGangCash')
AddEventHandler('gangsystem:server:minusGangCash', function(id, amount)
	local src = Core.Player.GetSource(source)
    local gangId = id
    if gangId == nil or gangId == 0 then
        gangId = GetPlayerGangId(src)
    end
    MinusGangCash(gangId, amount)
end)

RegisterServerEvent('gangsystem:server:plusGangCash')
AddEventHandler('gangsystem:server:plusGangCash', function(id, amount)
	local src = Core.Player.GetSource(source)
    local gangId = id
    if gangId == nil or gangId == 0 then
        gangId = GetPlayerGangId(src)
    end
    PlusGangCash(gangId, amount)
end)

-- ## CALLBACKS ## --

Core.RegisterCallback('gangsystem:server:getMarkerCooldown', function(src, cb, gangId, type)
    cb(GetMarkerCooldown(gangId, type))
end)

Core.RegisterCallback('gangsystem:server:getPinAttempts', function(src, cb, gangId, type)
    cb(GetPinAttempts(src, gangId, type))
end)

Core.RegisterCallback('gangsystem:server:getGangs', function(src, cb)
    GetGangsFromDatabase()
    cb(t1ger_gangs)
end)

Core.RegisterCallback('gangsystem:server:GetGangData', function(src, cb)
    local result = GetGangData(src)
    cb(result)
end)

Core.RegisterCallback('gangsystem:server:getPlayerGang', function(src, cb)
    local info = GetPlayerGang(src)
    cb(info)
end)

function GetPlayerGang(idplayer)
        local id = GetPlayerGangId(idplayer)
        if id > 0 then
            local rank, name = GetPlayerGangRank(idplayer)
            t1ger_gangs[id].player = {
                rank = rank,
                name = name,
            }
        return t1ger_gangs[id]
        end
end

function GetGangData(idplayer)
    local identifier = Core.Player.GetIdentifier(idplayer)
            for k,v in pairs(t1ger_gangs) do
                for d,g in pairs(v.members) do
                    if g.identifier == identifier then
                        return v
                    end
                end
            end
end

Core.RegisterCallback('gangsystem:server:getPlayerGangId', function(src, cb)
    local gangid = GetPlayerGangId(src)
    cb(gangid)
end)

Core.RegisterCallback('gangsystem:server:getPlayerGangRank', function(src, cb)
    local rank, rankName = GetPlayerGangRank(src)
    cb(rank, rankName)
end)

function GetPlayerGangRank(idplayer)
    local identifier = Core.Player.GetIdentifier(idplayer)
    local rank = nil
    local name = nil
            for k,v in pairs(t1ger_gangs) do
                for d,g in pairs(v.members) do
                    if g.identifier == identifier then
                        rank = g.rank
                        name = g.name
                    end
                end
            end
        return rank, name
end


Core.RegisterCallback('gangsystem:server:getPlayerVehicles', function(src, cb)
	local playerSrc = Core.Player.GetSource(src)
    local vehicles = Core.Player.GetAllVehicles(playerSrc)
    cb(vehicles)
end)

Core.RegisterCallback('gangsystem:server:getDrugInventory', function(src, cb)
    local playerSrc = Core.Player.GetSource(src)
	local drugItems = {}
    for k,v in pairs(Config.DrugSale.Items) do
        if Config.Items[v.itemKey] == nil then
            error('[^1ERROR #7983^0 (See Docs)] The itemKey in DrugSale Config: '..v.itemKey..' does not exist inside Config.Items.\n')
        else
            local itemName = Config.Items[v.itemKey]
            local invItem = Core.Player.GetItem(playerSrc, itemName)
            if invItem ~= nil then
                if invItem.count > 0 then
                    invItem.cfg = {key = k, value = v}
                    table.insert(drugItems, invItem)
                end
            end
        end
    end
    cb(drugItems)
end)

Core.RegisterCallback('gangsystem:server:isPlayerZiptied', function(src, cb, targetSrc)
    cb(IsPlayerZiptied(targetSrc))
end)

function IsPlayerZiptied(target)
    local identifier = Core.Player.GetIdentifier(target)
    if ziptied[identifier] then
        return true
    else
        return false
    end
end

Core.RegisterCallback('gangsystem:server:isAdmin', function(src, cb)
    cb(Core.Player.IsAdmin(src))
end)

-- ## FUNCTIONS ## --

PlusGangCash = function(id, amount)
    local src = source
    if id == nil or id == 0 then 
        return 
    end
    local cash = t1ger_gangs[id].cash
    cash = (cash + amount)
    t1ger_gangs[id].cash = cash
    if src ~= nil then
        Core.Notification(src, {
            title = '',
            message = Lang['gang_cash_plus']:format(amount),
            type = 'success'
        })
    end
end

MinusGangCash = function(id, amount)
    local src = source
    if id == nil or id == 0 then 
        return 
    end
    local cash = t1ger_gangs[id].cash
    cash = (cash - amount)
    if cash <= 0 then
        cash = 0
    end
    t1ger_gangs[id].cash = cash
    if src ~= nil then
        Core.Notification(src, {
            title = '',
            message = Lang['gang_cash_minus']:format(amount),
            type = 'inform'
        })
    end
end


PlusGangNotoriety = function(id, amount)
    local src = source
    if id == nil or id == 0 then 
        return 
    end
    local points = t1ger_gangs[id].notoriety
    points = (points + amount)
    t1ger_gangs[id].notoriety = points
    if src ~= nil then
        Core.Notification(src, {
            title = '',
            message = Lang['notoriety_plus']:format(amount),
            type = 'success'
        })
    end
end

MinusGangNotoriety = function(id, amount)
    local src = source
    if id == nil or id == 0 then 
        return 
    end
    local points = t1ger_gangs[id].notoriety
    points = (points - amount)
    if points <= 0 then
        points = 0
    end
    t1ger_gangs[id].notoriety = points
    if src ~= nil then
        Core.Notification(src, {
            title = '',
            message = Lang['notoriety_minus']:format(amount),
            type = 'inform'
        })
    end
end

GetGangsFromDatabase = function()
    local done = false
    MySQL.Async.fetchAll('SELECT * FROM t1ger_gangs', {}, function(results)
        if results and next(results) then
            for i = 1, #results do
                local data = {
                    id = results[i].id,
                    name = results[i].name,
                    notoriety = results[i].notoriety,
                    cash = results[i].cash,
                    leader = results[i].leader, 
                    ranks = json.decode(results[i].ranks),
                    members = json.decode(results[i].members),
                    markers = json.decode(results[i].markers),
                    disabled = results[i].disabled,
                    rackets = json.decode(results[i].rackets),
                }
                t1ger_gangs[results[i].id] = data
            end
            done = true
        else
            done = true
        end
    end)

    while not done do 
        Citizen.Wait(100)
    end

end

UpdateGangsTable = function()
    if Config.Debug == true then 
        RconPrint('[SAVED] T1GER GANGS\n')
    end
    --print("1 => ", json.encode(t1ger_gangs))
    if t1ger_gangs and next(t1ger_gangs) then
        for k,v in pairs(t1ger_gangs) do
            MySQL.Async.execute('UPDATE t1ger_gangs SET name = @name, notoriety = @notoriety, cash = @cash, leader = @leader, ranks = @ranks, members = @members, markers = @markers, disabled = @disabled, rackets = @rackets WHERE id = @id', {
                ['@id'] = v.id,
                ['@name'] = v.name,
                ['@notoriety'] = json.encode(v.notoriety),
                ['@cash'] = v.cash,
                ['@leader'] = v.leader,
                ['@ranks'] = json.encode(v.ranks),
                ['@members'] = json.encode(v.members),
                ['@markers'] = json.encode(v.markers),
                ['@disabled'] = v.disabled,
                ['@rackets'] = json.encode(v.rackets),
            })
        end
    end

end


StartDatabaseSync = function()
    function SaveData()
            UpdateGangsTable()
        SetTimeout(Config.SyncToDatabase * 60 * 1000, SaveData)
    end
    SetTimeout(Config.SyncToDatabase * 60 * 1000, SaveData)
end
StartDatabaseSync()

-- next work DB sync of t1ger_gangs table ..

