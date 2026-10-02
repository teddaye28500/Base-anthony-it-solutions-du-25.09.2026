-- Buy here: (4€+VAT) https://store.brutalscripts.com
function notification(title, text, time, type)
    if Config.BrutalNotify then
        exports['brutal_notify']:SendAlert(title, text, time, type)
    else
        -- Put here your own notify and set the Config.BrutalNotify to false
        TriggerEvent('brutal_truck_robbery:client:DefaultNotify', text)
    end
end

RegisterNetEvent('brutal_truck_robbery:client:DefaultNotify')
AddEventHandler('brutal_truck_robbery:client:DefaultNotify', function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(0,1)

    --Default ESX Notify:
    TriggerEvent('esx:showNotification', text)

    -- Default QB Notify:
    --TriggerEvent('QBCore:Notify', text, 'info', 5000)
end)

RegisterNetEvent('brutal_truck_robbery:client:DefaultNotify', function(text)
    lib.notify({
        title = 'Braquage Shop',
        description = text,
        type = 'inform', -- types possibles : 'inform', 'success', 'error'
        duration = 5000 -- en millisecondes
    })
end)

RegisterNetEvent('brutal_truck_robbery:client:PoliceAlert')
AddEventHandler('brutal_truck_robbery:client:PoliceAlert', function(coords)
    notification('ROBBERY PROCESS', 'Vol de camion en cours ! Marqué sur la carte !', 10000, 'info')

    AlertPlace = AddBlipForCoord(coords[1], coords[2], coords[3])
    SetBlipSprite(AlertPlace, Config.PoliceAlertBlip.sprite)
    SetBlipScale(AlertPlace, Config.PoliceAlertBlip.size)
    SetBlipColour(AlertPlace, Config.PoliceAlertBlip.color)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.PoliceAlertBlip.label)
    EndTextCommandSetBlipName(AlertPlace)
end)

function PlayerDied()
    local died = false
    if (GetEntityHealth(PlayerPedId()) <= PlayerDiedHealth) then
        died = true
    end
    return died
end

function NoCarryWeapon()
    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
        return true
    else
        SendNotify(9)
        return false
    end
end