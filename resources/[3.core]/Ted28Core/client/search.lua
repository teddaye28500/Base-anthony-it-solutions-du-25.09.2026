function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(plyCoords - targetCoords)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if target ~= ply then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(plyCoords - targetCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end
    local title = "News Light"
    local icon = "https://cdn.discordapp.com/attachments/1251633749351858187/1263820866198835222/Char_blank_entry.jpg?ex=669ba067&is=669a4ee7&hm=8f24f39d560405fe131561d92eea88eff110feb0fdd6112e5c9d216f2171d907&"
    local content =  "Le joueur ne leve pas les main"
    local duration = 10000
    local subtitle = "Notification"
    local sticky = true



exports.ox_target:addGlobalPlayer({
    {
        name = "search",
        icon = 'fa-solid fa-magnifying-glass',
        label = "fouiller un joueur",
        onSelect = function(data)
        Wait(0)
            local closestPlayer, distance = GetClosestPlayer()
            if closestPlayer ~= -1 then
                local closestPlayerName = GetPlayerName(closestPlayer)
                if IsEntityPlayingAnim(data.entity, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(data.entity, "mp_arresting", "idle", 3) or IsPedDeadOrDying(data.entity) then
                    exports.ox_inventory:openInventory('player', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
                    ExecuteCommand('me ' .. GetPlayerName(PlayerId()) .. ' fouille le joueur ' .. closestPlayerName)
                else
                    exports['fb_hud']:addNotification(icon, nil, title, subtitle, content, duration, sticky)
                end
            end
        end
    }
})
