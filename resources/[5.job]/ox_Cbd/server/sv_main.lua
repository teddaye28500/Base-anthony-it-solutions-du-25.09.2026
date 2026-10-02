-- 📌 Enregistrement du job dans esx_society
TriggerEvent('esx_society:registerSociety', 'cbd', 'cbd', 'society_cbd', 'society_cbd', 'society_cbd', {type = 'public'})

-- 📌 Définition des stocks pour ox_inventory
local stashes = {
    {
        id = 'cbdStash',
        label = 'Frigo | Cbd',
        slots = 90,
        weight = 50000
    },
    {
        id = 'CbdSecretStash',
        label = 'Stock entreprise',
        slots = 90,
        weight = 15000
    }
}

-- 📌 Initialisation des stockages quand ox_inventory démarre
AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for _, stash in pairs(stashes) do
            exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, 'steam:')
        end
    end
end)

-- 📌 Fonction pour envoyer une annonce à tous les joueurs
local function sendAnnouncement(title, description, notifType, icon)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = title,
        description = description,
        type = notifType,
        position = 'top-center',
        duration = 10000,
        icon = icon
    })
end

-- 📌 Événements d'annonces
RegisterServerEvent('annonceOcbdserveur', function() sendAnnouncement('🌿 CBD Shop - Ouverture 🌿', Config.announceouvert.Cbd, 'inform', 'bell') end)
RegisterServerEvent('annonceFcbdserveur', function() sendAnnouncement('🌙 CBD Shop - Fermeture 🌙', Config.announcefermer.Cbd, 'error', 'times-circle') end)
RegisterServerEvent('annonceRcbdserveur', function() sendAnnouncement('📢 CBD Shop - Recrutement 📢', Config.announcerecrutement.Cbd, 'success', 'user-plus') end)

RegisterNetEvent('cbd:SendAnnonce')
AddEventHandler('cbd:SendAnnonce', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'CBD',
        description = msg,
        type = 'info',
        position = 'top-center',
        duration = 10000,
        icon = 'fa-solid fa-user-tie'
    })
end)

-- 📌 Fonction générique pour ajouter un item à l'inventaire
local function giveItem(source, item, quantity)
    local player = ESX.GetPlayerFromId(source)
    if player then player.addInventoryItem(item, quantity) end
end

-- 📌 Événements de récolte
RegisterServerEvent("nsx:Givefeuillecbdb", function(quantity) giveItem(source, "feuillecbdb", quantity) end)
RegisterServerEvent("nsx:Givefeuillecbdk", function(quantity) giveItem(source, "feuillecbdk", quantity) end)

-- 📌 Fonction générique pour transformer un item en un autre
local function processItem(source, inputItem, inputQty, outputItem, outputQty)
    local player = ESX.GetPlayerFromId(source)
    if not player then return end

    local item = player.getInventoryItem(inputItem)
    if item.count >= inputQty then
        player.removeInventoryItem(inputItem, inputQty)
        player.addInventoryItem(outputItem, outputQty)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'error',
            title = 'Erreur',
            description = 'Vous n\'avez pas suffisamment d\'ingrédients !'
        })
    end
end

-- 📌 Événements de traitement
RegisterServerEvent("nsx:Giveblue_dream_bag", function() processItem(source, "feuillecbdb", 2, "blue_dream_bag", 1) end)
RegisterServerEvent("nsx:Givebanana_kush_bag", function() processItem(source, "feuillecbdk", 2, "banana_kush_bag", 1) end)
RegisterServerEvent("nsx:Givebanana_kush_joint", function() processItem(source, "banana_kush_bag", 1, "banana_kush_joint", 1) end)
RegisterServerEvent("nsx:Giveblue_dream_joint", function() processItem(source, "blue_dream_bag", 1, "blue_dream_joint", 1) end)

-- 📌 Fonction générique pour la vente et versement d'argent à la société
local function sellItem(source, item, quantity, price, society)
    local player = ESX.GetPlayerFromId(source)
    if not player then return end

    local inventoryItem = player.getInventoryItem(item)
    if inventoryItem.count >= quantity then
        player.removeInventoryItem(item, quantity)

        TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
            if account then
                account.addMoney(price)
                TriggerClientEvent('ox_lib:notify', source, {
                    type = 'success',
                    title = 'Vente réussie',
                    description = ('Vous avez vendu %s %s pour %s$ qui ont été ajoutés à la société.'):format(quantity, item, price),
                    position = 'top',
                    icon = 'check-circle',
                    iconColor = '#B2FFBD'
                })
            end
        end)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'error',
            title = 'Erreur',
            description = 'Vous n\'avez pas assez d\'articles pour vendre !',
            position = 'top',
            icon = 'triangle-exclamation',
            iconColor = '#FFBDBD'
        })
    end
end

-- 📌 Événements de vente
RegisterServerEvent("nsx:Ventefeuillecbdb", function() sellItem(source, "blue_dream_joint", 2, 90, 'society_cbd') end)
RegisterServerEvent("nsx:Ventefeuillecbdk", function() sellItem(source, "banana_kush_joint", 2, 120, 'society_cbd') end)

-- 📌 Vérification de la tenue du joueur
RegisterServerEvent('cbdclothes:getTenueCbd')
AddEventHandler('cbdclothes:getTenueCbd', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    if not player then return end

    local playerPed = player.getPed()
    local skin = player.getSkin()
    local estEnTenue = skin['tshirt_1'] == 'cbd_wear'

    TriggerClientEvent('cbdclothes:tenueCbdResult', src, estEnTenue)
end)