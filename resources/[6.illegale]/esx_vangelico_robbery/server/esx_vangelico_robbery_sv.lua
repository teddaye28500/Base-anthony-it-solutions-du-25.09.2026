local rob = false
local robbers = {}
local CopsConnected = 0

local ESX = exports["es_extended"]:getSharedObject()

--===============================
-- COMPTE LES POLICIERS CONNECTÉS
--===============================
local function CountCops()
    local xPlayers = ESX.GetPlayers()
    CopsConnected = 0

    for i=1, #xPlayers do
        local xP = ESX.GetPlayerFromId(xPlayers[i])
        if xP and xP.job and xP.job.name == 'police' then
            CopsConnected += 1
        end
    end

    SetTimeout(120 * 1000, CountCops)
end

CountCops()

--===============================
-- ANNULATION : JOUEUR TROP LOIN
--===============================
RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
    local src = source
    if not src then return end

    if not Stores[robb] then return end

    rob = false

    for _, id in ipairs(ESX.GetPlayers()) do
        local xP = ESX.GetPlayerFromId(id)
        if xP and xP.job.name == 'police' then
            TriggerClientEvent('esx:showNotification', id, _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
            TriggerClientEvent('esx_vangelico_robbery:killblip', id)
        end
    end

    if robbers[src] then
        TriggerClientEvent('esx_vangelico_robbery:toofarlocal', src)
        robbers[src] = nil
        TriggerClientEvent('esx:showNotification', src, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
    end
end)

--===============================
-- FIN DU BRAQUAGE
--===============================
RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
    local src = source
    if not src then return end

    if not Stores[robb] then return end

    rob = false

    for _, id in ipairs(ESX.GetPlayers()) do
        local xP = ESX.GetPlayerFromId(id)
        if xP and xP.job.name == 'police' then
            TriggerClientEvent('esx:showNotification', id, _U('end'))
            TriggerClientEvent('esx_vangelico_robbery:killblip', id)
        end
    end

    if robbers[src] then
        TriggerClientEvent('esx_vangelico_robbery:robberycomplete', src)
        robbers[src] = nil
        TriggerClientEvent('esx:showNotification', src, _U('robbery_has_ended') .. Stores[robb].nameofstore)
    end
end)

--===============================
-- DÉBUT DU BRAQUAGE
--===============================
RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)
    local src = source
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        print("[Vangelico] ERREUR: xPlayer nil pour source "..tostring(src))
        return
    end

    if not Stores[robb] then
        print("[Vangelico] ERREUR: Stores["..tostring(robb).."] inexistant")
        return
    end

    local store = Stores[robb]

    -- cooldown
    if store.lastrobbed ~= 0 and (os.time() - store.lastrobbed) < Config.SecBetwNextRob then
        TriggerClientEvent('esx:showNotification', src,
            _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
        return
    end

    -- déjà un braquage en cours
    if rob then
        TriggerClientEvent('esx:showNotification', src, _U('robbery_already'))
        return
    end

    -- lancement du braquage
    rob = true
    robbers[src] = true
    store.lastrobbed = os.time()

    -- notification police
    for _, id in ipairs(ESX.GetPlayers()) do
        local xP = ESX.GetPlayerFromId(id)
        if xP and xP.job.name == 'police' then
            TriggerClientEvent('esx:showNotification', id, _U('rob_in_prog') .. store.nameofstore)
            TriggerClientEvent('esx_vangelico_robbery:setblip', id, store.position)
        end
    end

    -- notification braqueur
    TriggerClientEvent('esx:showNotification', src, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
    TriggerClientEvent('esx:showNotification', src, _U('alarm_triggered'))
    TriggerClientEvent('esx:showNotification', src, _U('hold_pos'))
    TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', src, robb)
end)

--===============================
-- RÉCUPÉRATION DES BIJOUX
--===============================
RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function()
    local src = source
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    xPlayer.addInventoryItem('jewels', math.random(Config.MinJewels, Config.MaxJewels))
end)

--===============================
-- VENTE CHEZ LESTER
--===============================
RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()
    local src = source
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local reward = Config.PriceForOneJewel * Config.MaxJewelsSell

    xPlayer.removeInventoryItem('jewels', Config.MaxJewelsSell)
    xPlayer.addAccountMoney('black_money', reward)
end)

--===============================
-- CALLBACK : NOMBRE DE POLICIERS
--===============================
ESX.RegisterServerCallback('esx_vangelico_robbery:conteggio', function(source, cb)
    cb(CopsConnected)
end)
