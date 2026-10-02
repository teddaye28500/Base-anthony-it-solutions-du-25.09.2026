--local ESX = exports['es_extended']:getSharedObject()

local marketOpen = false

local function closeMarket()
    if not marketOpen then
        SetNuiFocus(false, false)
        return
    end
    marketOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeMarket' })
end

local function openMarket()
    marketOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'openMarket' })
end

-- Ouvre / ferme le market (F3 ou commande)
RegisterKeyMapping('openlbc', 'Marché Dynamique (LBC)', 'keyboard', 'F3')

RegisterCommand('openlbc', function()
    if marketOpen then
        closeMarket()
    else
        openMarket()
    end
end, false)

-- FERMER LA PAGE --
RegisterNUICallback('closeMarket', function(_, cb)
    marketOpen = false
    SetNuiFocus(false, false)
    cb({ ok = true })
end)

-- Ancien nom, au cas où l'UI en cache l'appelle encore
RegisterNUICallback('lbc:close', function(_, cb)
    marketOpen = false
    SetNuiFocus(false, false)
    cb({ ok = true })
end)

-- Notification native (utilise ox_lib)
RegisterNetEvent('lbc:notify', function(data)
    if lib and lib.notify then
        lib.notify(data)
    else
        -- fallback vanilla
        SetNotificationTextEntry("STRING")
        AddTextComponentString(data.title and (data.title.."\n") or "" .. (data.description or data.msg or ""))
        DrawNotification(false, false)
    end
end)
--------------------

RegisterNUICallback('createAnnonce', function(data, cb)
    TriggerServerEvent('market:createAnnonce', data)
    cb({})
end)
RegisterNetEvent('market:createAnnonceResult', function(res)
    SendNUIMessage({ action = 'createAnnonceResult', result = res })
end)

---------------------------------
-- En tout début du fichier client.lua :

local historiqueCallback = nil
local annoncesCallback = nil

RegisterNUICallback('getHistorique', function(_, cb)
    historiqueCallback = cb
    TriggerServerEvent('market:getHistorique')
end)

RegisterNetEvent('market:returnHistorique', function(list)
    if historiqueCallback then
        historiqueCallback(list)
        historiqueCallback = nil
    end
end)

RegisterNUICallback('getAnnonces', function(_, cb)
    annoncesCallback = cb
    TriggerServerEvent('market:getAnnonces')
end)

RegisterNetEvent('market:returnAnnonces', function(list)
    if annoncesCallback then
        annoncesCallback(list)
        annoncesCallback = nil
    end
end)


--Debug01
--RegisterNUICallback('getAnnonces', function(_, cb)
--    TriggerServerEvent('market:getAnnonces')
--    RegisterNetEvent('market:returnAnnonces', function(list)
--        cb(list)
--    end)
--end)




--Debug01
--RegisterNUICallback('getHistorique', function(_, cb)
--    TriggerServerEvent('market:getHistorique')
--    RegisterNetEvent('market:returnHistorique', function(list)
--        cb(list)
--    end)
--end)

local buyCallback = nil

RegisterNUICallback('buyAnnonce', function(data, cb)
    buyCallback = cb
    TriggerServerEvent('market:buyAnnonce', data)
end)

RegisterNetEvent('market:buyAnnonceResult', function(res)
    if buyCallback then
        buyCallback(res)
        buyCallback = nil
    end
end)

local userBadgesCallback = nil
local allBadgesCallback = nil
local badgesForIdCallback = nil
local activeAnnoncesCallback = nil

RegisterNUICallback('getUserBadges', function(_, cb)
    userBadgesCallback = cb
    TriggerServerEvent('market:getUserBadges')
end)

RegisterNetEvent('market:returnUserBadges', function(badges)
    if userBadgesCallback then
        userBadgesCallback(badges or {})
        userBadgesCallback = nil
    end
end)

RegisterNUICallback('getAllBadges', function(_, cb)
    allBadgesCallback = cb
    TriggerServerEvent('market:getAllBadges')
end)

RegisterNetEvent('market:returnAllBadges', function(badges)
    if allBadgesCallback then
        allBadgesCallback(badges or {})
        allBadgesCallback = nil
    end
end)

RegisterNUICallback('getBadgesForIdentifier', function(data, cb)
    badgesForIdCallback = cb
    TriggerServerEvent('market:getBadgesForIdentifier', data.identifier)
end)

RegisterNetEvent('market:returnBadgesForIdentifier', function(badges)
    if badgesForIdCallback then
        badgesForIdCallback(badges or {})
        badgesForIdCallback = nil
    end
end)

RegisterNUICallback('getActiveAnnonces', function(_, cb)
    activeAnnoncesCallback = cb
    TriggerServerEvent('market:getActiveAnnonces')
end)

RegisterNetEvent('market:returnActiveAnnonces', function(list)
    if activeAnnoncesCallback then
        activeAnnoncesCallback(list or {})
        activeAnnoncesCallback = nil
    end
end)

-- Côté client.lua
RegisterNetEvent('market:returnPlayerIdentifier', function(identifier)
    -- Transmet au JS/NUI
    SendNUIMessage({ action = 'setPlayerIdentifier', identifier = identifier })
end)

RegisterNUICallback('getPlayerIdentifier', function(_, cb)
    TriggerServerEvent('market:getPlayerIdentifier')
    -- Le retour se fait côté JS via NUIMessage (voir plus bas)
    cb({})
end)


RegisterNUICallback('deleteAnnonce', function(data, cb)
    TriggerServerEvent('market:deleteAnnonce', data.annonce_id)
    cb(true)
end)
