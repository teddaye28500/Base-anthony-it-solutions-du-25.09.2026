local lastPlayerSuccess = {}

if Config.Version == "esxold" then
    ESX = nil
    CreateThread(function()
        while ESX == nil do
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
            Wait(100)
        end
    end)
elseif Config.Version == "esxnew" then
    ESX = exports['es_extended']:getSharedObject()
end

TriggerEvent('esx_society:registerSociety', 'taxi', 'taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'public'})

local taxicoffre = {
    id = 'taxicoffre',
    label = 'Coffre Taxi',
    slots = 50,
    weight = 20000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(taxicoffre.id, taxicoffre.label, taxicoffre.slots, taxicoffre.weight, taxicoffre.owner)
    end
end)

RegisterNetEvent('taxijob:success')
AddEventHandler('taxijob:success', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local timeNow = os.clock()

    if xPlayer.job.name == 'taxi' then
        if not lastPlayerSuccess[source] or timeNow - lastPlayerSuccess[source] > 5 then
            lastPlayerSuccess[source] = timeNow

            math.randomseed(os.time())
            local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)

            if xPlayer.job.grade >= 3 then
                total = total * 2
            end

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
                if account then
                    local playerMoney = ESX.Math.Round(total / 100 * 30)
                    local societyMoney = ESX.Math.Round(total / 100 * 70)

                    xPlayer.addMoney(playerMoney, "Taxi Fair")
                    account.addMoney(societyMoney)

                    xPlayer.showNotification(TranslateCap('comp_earned', societyMoney, playerMoney))
                else
                    xPlayer.addMoney(total, "Taxi Fair")
                    xPlayer.showNotification(TranslateCap('have_earned', total))
                end
            end)
        end
    else
        print(('BE CAREFUL THERE MIGHT BE A CHEATER AROUND HERE'):format(source))
    end
end)

RegisterServerEvent('taxi:ouvert')
AddEventHandler('taxi:ouvert', function()
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '🚖 Taxi - En Service 🚖',
        description = 'Besoin d\'un trajet rapide et sécurisé ? Nos chauffeurs sont prêts à vous conduire où vous voulez ! 📍💨',
        type = 'success',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#25262b',
            color = '#fcc419',
            ['.description'] = {
                color = '#2f9e44'
            }
        },
        icon = 'bell'
    })
end)

RegisterServerEvent('taxi:fermer')
AddEventHandler('taxi:fermer', function()
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '⛔ Taxi - Hors Service ⛔',
        description = 'Nos chauffeurs prennent une pause ! Merci de votre confiance et à bientôt sur la route ! 🚕💤',
        type = 'error',
        position = 'top-center',
        duration = 10000,
        style = {
            backgroundColor = '#2A0000',
            color = '#fcc419',
            ['.description'] = {
                color = '#c92a2a'
            }
        },
        icon = 'times-circle'
    })
end)

RegisterServerEvent('taxi:recruter')
AddEventHandler('taxi:recruter', function()
    TriggerClientEvent('ox_lib:notify', -1, {
        title = '📢 Taxi - Recrutement 📢',
        description = 'Vous aimez conduire et aider les citoyens à se déplacer ? Rejoignez notre équipe de chauffeurs ! 🚖💼',
        type = 'inform',
        position = 'top-center',
        duration = 10000,
        icon = 'user-plus'
    })
end)

RegisterNetEvent('taxiperso')
AddEventHandler('taxiperso', function(msg)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = 'Taxi',
        description = msg,
        type = 'info',
        position = 'top-center',
        icon = 'fa-solid fa-user-tie'
    })
end)

-- Événement serveur pour envoyer la notification à tous les employés taxi
RegisterNetEvent("taxi:alertEmployees")
AddEventHandler("taxi:alertEmployees", function()
    local players = ESX.GetPlayers()

    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            if xPlayer.job and xPlayer.job.name == "taxi" then
                TriggerClientEvent("taxi:notifyEmployee", playerId)
            end
        end
    end
end)