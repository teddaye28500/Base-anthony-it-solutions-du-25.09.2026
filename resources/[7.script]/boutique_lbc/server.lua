local ESX = exports['es_extended']:getSharedObject()


-- ==== CHECK SI LE VENDEUR A VENDU HORS LIGNE ====
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    -- On vérifie toutes les annonces vendues de ce joueur avec pending_money > 0
    local annonces = MySQL.query.await('SELECT id, pending_money FROM lbc_annonces WHERE seller_identifier = ? AND pending_money > 0', { xPlayer.identifier })
    local total = 0
    for _, ann in ipairs(annonces or {}) do
        if ann.pending_money and ann.pending_money > 0 then
            -- Versement
            exports.ox_inventory:AddItem(playerId, 'money', ann.pending_money)
            -- Reset en DB
            MySQL.update.await('UPDATE lbc_annonces SET pending_money = 0 WHERE id = ?', { ann.id })
            total = total + ann.pending_money
        end
    end
    -- Notif s'il a touché un versement global
    if total > 0 then
        TriggerClientEvent('lbc:notify', playerId, {
            title = "💸 Vente(s) automatique(s)",
            description = ("Tu as reçu %s $ pour des ventes réalisées pendant ton absence."):format(total),
            type = "success"
        })
    end
end)


-- ==== SUPPRIMER UNE ANNONCE ACTIF ==== --
RegisterNetEvent('market:deleteAnnonce', function(annonceId)
    local src = source
    local id = tonumber(annonceId)
    if not id then return end

    local annonce = MySQL.single.await('SELECT * FROM lbc_annonces WHERE id = ?', {id})
    if not annonce or annonce.status ~= "en_vente" then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or xPlayer.identifier ~= annonce.seller_identifier then return end

    -- Suppression (ou soft delete)
    MySQL.update.await('UPDATE lbc_annonces SET status="supprimee" WHERE id = ?', {id})

    -- Donne l’item au joueur
    xPlayer.addInventoryItem(annonce.item_name, annonce.amount)
end)



-- ===== INVENTAIRE OX (pour market) =====
lib.callback.register('lbc:getPlayerInventory', function(source, _, cb)
    local items = exports.ox_inventory:GetInventory(source)
    cb(items and items.items or {})
end)


------------------PATCH PLUS BAS---------------------------------
-- Récupérer les annonces actives (page d'accueil)
--RegisterNetEvent('market:getAnnonces')
--AddEventHandler('market:getAnnonces', function()
--    local src = source
--    local annonces = MySQL.query.await('SELECT * FROM lbc_annonces WHERE status="en_vente" ORDER BY created_at DESC')
--    TriggerClientEvent('market:returnAnnonces', src, annonces or {})
--end)

--RegisterNetEvent('market:getAnnonces')
--AddEventHandler('market:getAnnonces', function(identifier)
--    local src = source
--    local annonces
--    if identifier then
--        annonces = MySQL.query.await('SELECT * FROM lbc_annonces WHERE status="en_vente" AND seller_identifier = ? ORDER BY created_at DESC', {identifier})
--    else
--        annonces = MySQL.query.await('SELECT * FROM lbc_annonces WHERE status="en_vente" ORDER BY created_at DESC')
--    end
--    TriggerClientEvent('market:returnAnnonces', src, annonces or {})
--end)



-- ===== Créer une annonce =====

RegisterNetEvent('market:createAnnonce')
AddEventHandler('market:createAnnonce', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then 
        TriggerClientEvent('market:createAnnonceResult', src, {success = false, message = "Erreur joueur"})
        return
    end

    local item_name = data.item_name
    local item_label = data.item_label
    local amount = tonumber(data.amount)
    local price = tonumber(data.price)
    if not item_name or not item_label or not amount or amount < 1 or not price or price < 1 then
        TriggerClientEvent('market:createAnnonceResult', src, {success = false, message = "Champs invalides"})
        return
    end

    local inv = exports.ox_inventory:GetInventory(src)
    local foundItem
    for _, v in ipairs(inv.items or {}) do
        if v.name == item_name and v.count >= amount then
            foundItem = v
            break
        end
    end
    if not foundItem then 
        TriggerClientEvent('market:createAnnonceResult', src, {success = false, message = "Tu n'as pas assez de cet item"})
        return
    end

    local hasMoney = exports.ox_inventory:Search(src, 'count', 'money')
    if not hasMoney or hasMoney < 1000 then 
        TriggerClientEvent('market:createAnnonceResult', src, {success = false, message = "Pas assez d'argent"})
        return
    end

    exports.ox_inventory:RemoveItem(src, item_name, amount)
    exports.ox_inventory:RemoveItem(src, 'money', 1000)

    MySQL.insert('INSERT INTO lbc_annonces (seller_identifier, seller_name, item_name, item_label, amount, price, image_url, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
        xPlayer.identifier, xPlayer.getName(), item_name, item_label, amount, price, data.image_url or '', data.description or ''
    })
    TriggerClientEvent('market:createAnnonceResult', src, {success = true})
end)




-- ===== Acheter une annonce =====
RegisterNetEvent('market:buyAnnonce')
AddEventHandler('market:buyAnnonce', function(data)
    local src = source
    local annonceId = tonumber(data.id)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or not annonceId then
        TriggerClientEvent('market:buyAnnonceResult', src, { success = false, message = "Erreur interne" })
        return
    end

    local annonce = MySQL.single.await('SELECT * FROM lbc_annonces WHERE id=? AND status="en_vente"', { annonceId })
    if not annonce then
        TriggerClientEvent('market:buyAnnonceResult', src, { success = false, message = "Annonce introuvable" })
        return
    end

    if annonce.seller_identifier == xPlayer.identifier then
        TriggerClientEvent('market:buyAnnonceResult', src, { success = false, message = "Tu ne peux pas acheter ta propre annonce" })
        return
    end

    local hasMoney = exports.ox_inventory:Search(src, 'count', 'money')
    if not hasMoney or hasMoney < annonce.price then
        TriggerClientEvent('market:buyAnnonceResult', src, { success = false, message = "Pas assez d’argent !" })
        return
    end

    exports.ox_inventory:RemoveItem(src, 'money', annonce.price)
    exports.ox_inventory:AddItem(src, annonce.item_name, annonce.amount)

    MySQL.update('UPDATE lbc_annonces SET status="vendu" WHERE id=?', { annonceId })
    MySQL.insert('INSERT INTO lbc_historique (annonce_id, buyer_identifier, buyer_name, price, seller_identifier, seller_name, item_name, item_label, amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
        annonceId, xPlayer.identifier, xPlayer.getName(), annonce.price, annonce.seller_identifier, annonce.seller_name, annonce.item_name, annonce.item_label, annonce.amount
    })

    -- ==== CREDIT VENDEUR ====
    local seller = ESX.GetPlayerFromIdentifier(annonce.seller_identifier)
    if seller then
        -- Il est connecté : on crédite tout de suite
        exports.ox_inventory:AddItem(seller.source, 'money', annonce.price)
        TriggerClientEvent('lbc:notify', seller.source, {
            title = "💸 Vente réalisée",
            description = ("Tu as vendu %sx %s pour %s $ !"):format(annonce.amount, annonce.item_label, annonce.price),
            type = "success"
        })
        -- Après la vente :
        local sales = MySQL.scalar.await('SELECT COUNT(*) FROM lbc_historique WHERE seller_identifier = ?', { annonce.seller_identifier })
        if sales >= 10 then
            giveBadge(annonce.seller_identifier, '10sales')
        end
    else
        -- Il est offline : on stocke à remettre plus tard (champ à ajouter dans ta table lbc_annonces OU une table à part)
        -- Exemple champ à ajouter : ALTER TABLE lbc_annonces ADD COLUMN pending_money INT DEFAULT 0;
        -- Ici, on crédite l'argent en attente sur l'annonce (pratique pour remise à la connexion)
        MySQL.update('UPDATE lbc_annonces SET pending_money = IFNULL(pending_money,0) + ? WHERE id = ?', { annonce.price, annonceId })
        -- Après la vente :
        local sales = MySQL.scalar.await('SELECT COUNT(*) FROM lbc_historique WHERE seller_identifier = ?', { annonce.seller_identifier })
        if sales >= 10 then
            giveBadge(annonce.seller_identifier, '10sales')
        end
    end

    TriggerClientEvent('market:buyAnnonceResult', src, { success = true })
end)


-- ===== Récupérer l'historique du joueur (ventes/achats) =====
RegisterNetEvent('market:getAnnonces')
AddEventHandler('market:getAnnonces', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local playerIdentifier = xPlayer.identifier

    local annonces = MySQL.query.await('SELECT * FROM lbc_annonces WHERE status="en_vente" ORDER BY created_at DESC')
    -- Ajoute l'identifiant du joueur à CHAQUE annonce envoyée
    for i=1, #annonces do
        annonces[i].player_identifier = playerIdentifier
    end

    TriggerClientEvent('market:returnAnnonces', src, annonces or {})
end)



-- ===== Supprimer une annonce (admin ou joueur) =====
lib.callback.register('lbc:deleteAnnonce', function(source, data, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local annonceId = tonumber(data.id)
    if not xPlayer or not annonceId then return cb({ success = false }) end

    local annonce = MySQL.single.await('SELECT * FROM lbc_annonces WHERE id=?', { annonceId })
    if not annonce then return cb({ success = false }) end

    -- Autorisation : propriétaire ou admin (à ajuster si staff)
    if annonce.seller_identifier ~= xPlayer.identifier then
        return cb({ success = false, message = "Non autorisé." })
    end

    MySQL.update('UPDATE lbc_annonces SET status="supprime_admin" WHERE id=?', { annonceId })
    cb({ success = true })
end)
--------------------------------------
function giveBadge(identifier, badge_code)
    -- Check si déjà
    local badge = MySQL.single.await('SELECT 1 FROM lbc_user_badges WHERE identifier = ? AND badge_code = ?', {identifier, badge_code})
    if badge then return false end
    MySQL.insert.await('INSERT INTO lbc_user_badges (identifier, badge_code) VALUES (?, ?)', {identifier, badge_code})
    return true
end

-------------
RegisterNetEvent('market:getUserBadges')
AddEventHandler('market:getUserBadges', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then 
        TriggerClientEvent('market:returnUserBadges', src, {})
        return
    end
    local rows = MySQL.query.await([[
        SELECT b.code, b.name, b.description, b.image_url
        FROM lbc_user_badges ub
        JOIN lbc_badges b ON ub.badge_code = b.code
        WHERE ub.identifier = ?
    ]], { xPlayer.identifier })
    TriggerClientEvent('market:returnUserBadges', src, rows or {})
end)



RegisterNetEvent('market:getBadgesForIdentifier')
AddEventHandler('market:getBadgesForIdentifier', function(identifier)
    local src = source
    local rows = MySQL.query.await([[
        SELECT b.code, b.name, b.description, b.image_url
        FROM lbc_user_badges ub
        JOIN lbc_badges b ON ub.badge_code = b.code
        WHERE ub.identifier = ?
    ]], { identifier })
    TriggerClientEvent('market:returnBadgesForIdentifier', src, rows or {})
end)


----------
-- Callback pour lister tous les badges disponibles
RegisterNetEvent('market:getAllBadges')
AddEventHandler('market:getAllBadges', function()
    local src = source
    local rows = MySQL.query.await('SELECT * FROM lbc_badges')
    TriggerClientEvent('market:returnAllBadges', src, rows or {})
end)

------------------
RegisterNetEvent('market:getActiveAnnonces')
AddEventHandler('market:getActiveAnnonces', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local result = MySQL.query.await('SELECT * FROM lbc_annonces WHERE seller_identifier = ? AND status = "en_vente" ORDER BY created_at DESC', {
        xPlayer.identifier
    })
    TriggerClientEvent('market:returnActiveAnnonces', src, result or {})
end)

RegisterNetEvent('market:getPlayerIdentifier')
AddEventHandler('market:getPlayerIdentifier', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        TriggerClientEvent('market:returnPlayerIdentifier', src, xPlayer.identifier)
    end
end)


RegisterNetEvent('market:getHistorique')
AddEventHandler('market:getHistorique', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local result = MySQL.query.await('SELECT * FROM lbc_historique WHERE seller_identifier = ? OR buyer_identifier = ? ORDER BY bought_at DESC', {
        xPlayer.identifier, xPlayer.identifier
    })
    TriggerClientEvent('market:returnHistorique', src, result or {})
end)
