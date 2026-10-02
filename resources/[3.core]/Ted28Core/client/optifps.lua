---OPTIMISATION FPS | Ces quelques lignes permettent un nettoyage du serveur toutes les heures pour eviter des lags

Citizen.CreateThread(function()
    Citizen.Wait(600000)
    while true do
        ClearAllBrokenGlass()
        ClearAllHelpMessages()
        LeaderboardsReadClearAll()
        ClearBrief()
        ClearGpsFlags()
        ClearPrints()
        ClearSmallPrints()
        ClearReplayStats()
        LeaderboardsClearCacheData()
        ClearFocus()
        ClearHdArea()
        Citizen.Wait(600000)
    end
end)