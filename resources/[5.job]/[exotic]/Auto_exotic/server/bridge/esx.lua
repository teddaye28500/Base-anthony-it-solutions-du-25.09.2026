lib.locale()
local esx = GetResourceState('es_extended'):find('start')
if not esx then return end

local ESX = exports.es_extended:getSharedObject()

--- @param amount number
lib.callback.register('A4Dev_tuning:hasMoney', function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or not xPlayer.job or xPlayer.job.name ~= "exotic" then return false end
    local hasMoney = false
    if SVConfig.EnableESXSocietyPayment == true then
        local societyName = ("society_%s"):format(xPlayer.job.name)
        local p = promise.new()
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            p:resolve(account ~= nil and account.money >= amount)
        end)
        return Citizen.Await(p)
    else
        local cash = xPlayer.getAccount("money")
        local bank = xPlayer.getAccount("bank")
        if cash and cash.money >= amount then
            hasMoney = true
        elseif bank and bank.money >= amount then
            hasMoney = true
        end
    end

    return hasMoney
end)

--- @param amount number
RegisterNetEvent("A4Dev_tuning:payMods", function(amount, properties)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or not xPlayer.job or xPlayer.job.name ~= "exotic" then return end

    if SVConfig.EnableESXSocietyPayment == true then
        local job = xPlayer.job.name
        local societyName = ("society_%s"):format(job)
        TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
            if account and account.money >= amount then
                account.removeMoney(amount)
                TriggerClientEvent('esx:showNotification', xPlayer.source, locale("L'argent a était retirer sur le compte Entrepise", amount), "success", 6000)
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, locale("Pas Assez D'argents sur le compte Entreprise"), "error", 6000)
                return
            end
        end)
    else
        local cash = xPlayer.getAccount("money")
        local bank = xPlayer.getAccount("bank")
        if cash.money >= amount then
            xPlayer.removeAccountMoney("money", amount)
            TriggerClientEvent('esx:showNotification', xPlayer.source, locale("Payement en espece avec succes", amount), "success", 6000)
        elseif bank and bank.money >= amount then
            xPlayer.removeAccountMoney("bank", amount)
            TriggerClientEvent('esx:showNotification', xPlayer.source, locale("Payement en banque avec succes", amount), "success", 6000)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, locale("Pas assez D'argent", amount), "error", 6000)
            return
        end
    end

    local properties = properties
    local isVehicleOwned = MySQL.prepare.await('SELECT plate FROM owned_vehicles WHERE plate = ?', { properties.plate })

    if isVehicleOwned then
        MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?',
            { json.encode(properties), properties.plate })
    end
end)
