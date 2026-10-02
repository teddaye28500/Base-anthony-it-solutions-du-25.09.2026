ESX = exports['es_extended']:getSharedObject()

_ShowNotification = function(msg)
    lib.notify({
        title = msg,
    })
end

_ShowHelpNotification = function(msg)
    lib.showTextUI(msg)
end

_GetClosestVehicle = function(location)
    return ESX.Game.GetClosestVehicle(location)
end

_GetPlayerJobName = function()
    local data = ESX.GetPlayerData()
    if not data or not data.job then return nil end
    return data.job.name
end