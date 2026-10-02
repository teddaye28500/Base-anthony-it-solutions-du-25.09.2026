RegisterNetEvent('offline:burger')
AddEventHandler('offline:burger', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflineburger")},
            })
            if input then
                local montantburger = tonumber(input[1])
                if montantburger == nil or montantburger < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local burgerPrice = Config.OfflineBurger
                    local totalPrice = burgerPrice * montantburger
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'burger')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:poutine')
AddEventHandler('offline:poutine', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflinepoutine")},
            })
            if input then
                local montantpoutine = tonumber(input[1])
                if montantpoutine == nil or montantpoutine < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local poutinePrice = Config.OfflinePoutine
                    local totalPrice = poutinePrice * montantpoutine
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'poutine')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:clubsandwitch')
AddEventHandler('offline:clubsandwitch', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflineclubsandwich")},
            })
            if input then
                local montantclubsandwich = tonumber(input[1])
                if montantclubsandwich == nil or montantclubsandwich < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local sandwichPrice = Config.OfflineSandwitch
                    local totalPrice = sandwichPrice * montantclubsandwich
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'clubsandwitch')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:frites')
AddEventHandler('offline:frites', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflinefrites")},
            })
            if input then
                local montantfrites = tonumber(input[1])
                if montantfrites == nil or montantfrites < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local fritesPrice = Config.OfflineFrites
                    local totalPrice = fritesPrice * montantfrites
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'frites')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:croquette')
AddEventHandler('offline:croquette', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflinecroquette")},
            })
            if input then
                local montantcroquette = tonumber(input[1])
                if montantcroquette == nil or montantcroquette < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local croquettePrice = Config.OfflineCroquette
                    local totalPrice = croquettePrice * montantcroquette
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'croquette')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:liqueur')
AddEventHandler('offline:liqueur', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflineliqueur")},
            })
            if input then
                local montantliqueur = tonumber(input[1])
                if montantliqueur == nil or montantliqueur < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local liqueurPrice = Config.OfflineLiqueur
                    local totalPrice = liqueurPrice * montantliqueur
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'liqueur')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:pepper')
AddEventHandler('offline:pepper', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflinepepper")},
            })
            if input then
                local montantpepper = tonumber(input[1])
                if montantpepper == nil or montantpepper < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local pepperPrice = Config.OfflinePepper
                    local totalPrice = pepperPrice * montantpepper
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'pepper')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)

RegisterNetEvent('offline:jusorange')
AddEventHandler('offline:jusorange', function()
    ESX.TriggerServerCallback('Burgershot:count', function(burger)
        if burger < 1 then
            local input = lib.inputDialog(locale("magasin"), {
                { type = 'input', label = locale("montant"), description = locale("descriptionofflinejusorange")},
            })
            if input then
                local montantjusorange = tonumber(input[1])
                if montantjusorange == nil or montantjusorange < 0 then
                    Notification("error", "", locale("montantinvalide"))
                else
                    local jusorangePrice = Config.OfflineJusOrange
                    local totalPrice = jusorangePrice * montantjusorange
                    local hasItem = exports.ox_inventory:Search('count', 'money')
                    if hasItem >= totalPrice then
                        TriggerServerEvent('ledjo:RemoveAccount', totalPrice)
                        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ProgressBar(Config.Progress_bar.Buy.Duration, Config.Progress_bar.Buy.Label)
                        TriggerServerEvent('ledjo:add', 'item', input[1], 'jusorange')
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Notification("success", "", locale("acheter"))
                    else
                        Notification("error", "", locale("pasargent"))
                    end
                end
            end
        else
            Notification("error", "", locale("employer"))
        end
    end)
end)