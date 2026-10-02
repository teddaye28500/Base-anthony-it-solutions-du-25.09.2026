---Pause Menu Text

function SetData()
    players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert( players, player )
end

    
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~r~Anthony IT Solutions https://discord.gg/RebuJNAaEV~s~ | ID : ~p~'.. id ..'~w~ | Joueurs connectés : ~p~' .. #players .."~w~/64 " )
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        SetData()
    end
end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_LEAVE", "~r~Se déconnecter ~w~de~r~ Anthony IT Solutions")
end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_QUIT", "Quitter ~y~FiveM 🐌")
end)