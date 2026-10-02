TriggerEvent('esx_society:registerSociety', 'burgershot', 'burgershot', 'society_burgershot', 'society_burgershot', 'society_burgershot', {type = 'public'})

local trashcanburgershot = {
    id = 'TrashCanBurgershot',
    label = Config.Title.TrashCan,
    slots = 25,
    weight = 20000,
    owner = 'steam:'
}

local StashBurgershot = {
    id = 'StashBurgershot',
    label = Config.Title.Stash,
    slots = 55,
    weight = 20000,
    owner = 'steam:'
}

local Commandburgershot = {
    id = 'CommandeBurgershot',
    label = Config.Title.Commands,
    slots = 10,
    weight = 20000,
    owner = 'steam:'
}

local Commandburgershot2 = {
    id = 'CommandeBurgershot2',
    label = Config.Title.Commands,
    slots = 10,
    weight = 20000,
    owner = 'steam:'
}

local Commandburgershot3 = {
    id = 'CommandeBurgershot3',
    label = Config.Title.Commands,
    slots = 10,
    weight = 20000,
    owner = 'steam:'
}

local Commandburgershot4 = {
    id = 'CommandeBurgershot4',
    label = Config.Title.Commands,
    slots = 10,
    weight = 20000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(trashcanburgershot.id, trashcanburgershot.label, trashcanburgershot.slots, trashcanburgershot.weight, trashcanburgershot.owner)
        exports.ox_inventory:RegisterStash(StashBurgershot.id, StashBurgershot.label, StashBurgershot.slots, StashBurgershot.weight, StashBurgershot.owner)
        exports.ox_inventory:RegisterStash(Commandburgershot.id, Commandburgershot.label, Commandburgershot.slots, Commandburgershot.weight, Commandburgershot.owner)
        exports.ox_inventory:RegisterStash(Commandburgershot2.id, Commandburgershot2.label, Commandburgershot2.slots, Commandburgershot2.weight, Commandburgershot2.owner)
        exports.ox_inventory:RegisterStash(Commandburgershot3.id, Commandburgershot3.label, Commandburgershot3.slots, Commandburgershot3.weight, Commandburgershot3.owner)
        exports.ox_inventory:RegisterStash(Commandburgershot4.id, Commandburgershot4.label, Commandburgershot4.slots, Commandburgershot4.weight, Commandburgershot4.owner)
    end
end)

RegisterServerEvent('checkItemBurgershot')
AddEventHandler('checkItemBurgershot', function(itemID)
    local xPlayer = ESX.GetPlayerFromId(source)
    local canCraft = true

    for _, v in pairs(Config.Crafting[itemID].requiredItems) do
        if xPlayer.getInventoryItem(v.name).count < v.amount then
            canCraft = false
            TriggerClientEvent('esx:showNotification', source, 'Tu a pas ' .. v.label) 
            break
        else
            canCraft = true
        end
    end
    if canCraft then
        for _, v in pairs(Config.Crafting[itemID].requiredItems) do
            xPlayer.removeInventoryItem(v.name, v.amount)
        end
        xPlayer.addInventoryItem(itemID, Config.AddItem)
        TriggerClientEvent('esx:showNotification', source, 'Tu a craft ' .. Config.Crafting[itemID].label) 
    end
end)

RegisterServerEvent('ledjo:add')
AddEventHandler('ledjo:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)

RegisterServerEvent('ledjo:remove')
AddEventHandler('ledjo:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)

ESX.RegisterServerCallback('ledjo:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('Burgershot:count', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local burger = 0

    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'burgershot' then
            burger = burger + 1
        end
    end
    cb(burger)
end)

RegisterServerEvent('ledjo:RemoveAccount')
AddEventHandler('ledjo:RemoveAccount', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('money', amount)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        print(account)
		account.addMoney(amount)
	end)
end)

RegisterNetEvent('burgershot:Ouvert')
AddEventHandler('burgershot:Ouvert', function()
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'BurgerShot',
        description = '🍔 Le BurgerShot ouvre ses portes, venez nombreux !',
        type = 'success',
        position = 'top-center',
        icon = 'door-open'
    })
end)

RegisterNetEvent('burgershot:Fermer')
AddEventHandler('burgershot:Fermer', function()
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'BurgerShot',
        description = '🚪 Le BurgerShot est fermé, repassez plus tard !',
        type = 'error',
        position = 'top-center',
        icon = 'door-closed'
    })
end)

RegisterNetEvent('burgershot:Recrutement')
AddEventHandler('burgershot:Recrutement', function()
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'BurgerShot',
        description = '🚪 Le BurgerShot recrute venez vite !',
        type = 'inform',
        position = 'top-center',
        icon = 'bell'
    })
end)

RegisterNetEvent('burgershot:SendAnnonce')
AddEventHandler('burgershot:SendAnnonce', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'BurgerShot',
        description = msg,
        type = 'info',
        position = 'top-center',
        icon = 'hamburger'
    })
end)

--  server ACHAT 

RegisterServerEvent('add:sauceserveur')
AddEventHandler('add:sauceserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.sauce then
            account.removeMoney(Config.prix.sauce)
            
            -- Ajouter une bouteille d'sauce à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('sauce', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une Sauce.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:fromageserveur')
AddEventHandler('add:fromageserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.fromage then
            account.removeMoney(Config.prix.fromage)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('fromage', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Fromage.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:pouletserveur')
AddEventHandler('add:pouletserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.poulet then
            account.removeMoney(Config.prix.poulet)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('poulet', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un Poulet.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:bouletteserveur')
AddEventHandler('add:bouletteserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.boulette then
            account.removeMoney(Config.prix.boulette)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('boulette', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une Boulette.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:saladeserveur')
AddEventHandler('add:saladeserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.salade then
            account.removeMoney(Config.prix.salade)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('salade', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une salade.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:ketchupserveur')
AddEventHandler('add:ketchupserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.ketchup then
            account.removeMoney(Config.prix.ketchup)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('ketchup', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu du Ketchup.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:baconserveur')
AddEventHandler('add:baconserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.bacon then
            account.removeMoney(Config.prix.bacon)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('bacon', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu du Bacon.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:beurreserveur')
AddEventHandler('add:beurreserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.beurre then
            account.removeMoney(Config.prix.beurre)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('beurre', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu du Beurre.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:patateserveur')
AddEventHandler('add:patateserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.patate then
            account.removeMoney(Config.prix.patate)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('patate', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une Patate.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:glacesserveur')
AddEventHandler('add:glacesserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.glaces then
            account.removeMoney(Config.prix.glaces)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('glaces', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu une glaces.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)

RegisterServerEvent('add:spongeserveur')
AddEventHandler('add:spongeserveur', function()
    local src = source
    
    -- Retirer 500$ de la société 'society_burgershot'
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
        if account.money >= Config.prix.sponge then
            account.removeMoney(Config.prix.sponge)
            
            -- Ajouter une bouteille d'eau à l'inventaire du joueur
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer then
                    xPlayer.addInventoryItem('sponge', 1)
                    TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Success' , description = 'Vous avez reçu un sponge.' })
                else
                    print('Impossible de trouver le joueur correspondant à l ID : ', src)
                end
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Erreur' , description = 'La société n\'a pas assez d\'argent.' })
        end
    end)
end)
