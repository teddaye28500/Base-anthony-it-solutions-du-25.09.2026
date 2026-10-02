local esx = GetResourceState('es_extended'):find('start')
if not esx then return end

local ESX = exports.es_extended:getSharedObject()

function hasAccess(job)
    if not job then return true end

    local playerData = ESX.GetPlayerData()
    if not playerData or not playerData.job then return false end

    return playerData.job.name == job
end