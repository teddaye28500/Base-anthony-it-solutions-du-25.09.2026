HeistInProgress = false

HoldingCarts = {
    [1] = false,
    [2] = false,
    [3] = false
}

CartsPhase = {
    [1] = 0.1566388,
    [2] = 0.1566388,
    [3] = 0.1566388
}

ESX.RegisterServerCallback("esx_pacificheist:canLootThisCart", function(source, cb, cart)
    if HoldingCarts[cart] == false then
        cb(CartsPhase[cart]) 
        HoldingCarts[cart] = true
    else
        cb(false)
    end
 end)

 ESX.RegisterServerCallback("esx_pacificheist:getHeistInfos", function(source, cb)
    cb(HeistInProgress)
  end)

RegisterNetEvent("esx_pacificheist:stopUsingCartServer", function(cart, phase)
    print(cart)
    print(phase)
    HoldingCarts[cart] = false
    CartsPhase[cart] = phase
end)

RegisterNetEvent("esx_pacificheist:changeDoorModel", function(doorCoords, oldModel, newModel, fix)
    TriggerClientEvent("esx_pacificheist:changeDoorModelClient", -1, doorCoords, oldModel, newModel, fix)
end)

RegisterNetEvent("esx_pacificheist:fixDoor", function(index, status)
    PoliceDoors[index].locked = status
    if status == true then
        TriggerClientEvent("esx_pacificheist:fixDoorClient", -1, PoliceDoors[index].loc, PoliceDoors[index].newModel, status)
    else
        TriggerClientEvent("esx_pacificheist:fixDoorClient", -1, PoliceDoors[index].loc, PoliceDoors[index].oldModel, status)
    end
end)

ESX.RegisterServerCallback("esx_pacificheist:canRob", function(source, cb)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    if HeistInProgress == false and #xPlayers >= Config.MinCops then
        cb(true)
    else
        cb(false)
    end
 end)

 RegisterNetEvent("esx_pacificheist:sendHeistInfos", function(status)
    HeistInProgress = status
    TriggerClientEvent("esx_pacificheist:receiveHeistInfos", -1, status)
    TriggerClientEvent("esx_pacificheist:createLootingCart", -1)
end)

RegisterNetEvent("esx_pacificheist:sendChargeInfos", function(stage)
    TriggerClientEvent("esx_pacificheist:receiveChargeInfos", -1, stage)
end)

RegisterNetEvent("esx_pacificheist:sendVaultInfos", function(status)
    TriggerClientEvent("esx_pacificheist:receiveVaultInfos", -1, status)
end)

RegisterNetEvent("esx_pacificheist:pickUpRack", function(table)
    local xPlayer = ESX.GetPlayerFromId(source)
    if table.mdp == "blablacar" then
        xPlayer.addAccountMoney(Config.Account, math.random(Config.moneyPerRack.min, Config.moneyPerRack.max))
    else
        xPlayer.kick("cheat")
    end
end)

RegisterNetEvent("esx_pacificheist:removeItem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, 1)
end)

RegisterNetEvent("esx_pacificheist:startAlarm", function()
    if Config.useXsound then
        CreateThread(function()
            exports["xsound"]:PlayUrlPos(-1, "Alarm", "https://www.youtube.com/watch?v=PSlEnOSfsag", 1.0, vector3(251.9768371582, 229.14535522461, 106.28688049316), true)
            exports["xsound"]:Distance(-1, "Alarm", 50)
            Wait(300)
            exports["xsound"]:Destroy(-1, "Alarm")
        end)
    end
    if Config.PoliceAlert then
        local xPlayers = ESX.GetExtendedPlayers('job', 'police')
        for _, xPlayer in pairs(xPlayers) do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "911", "DISPATCH", Config.Locales[Config.Language]['police_alert'], "CHAR_CHAT_CALL", 8)
        end
    end
end)

