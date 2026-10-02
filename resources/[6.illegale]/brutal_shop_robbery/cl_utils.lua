-- Buy here: (4€+VAT) https://store.brutalscripts.com
function notification(title, text, time, type)
    if Config.BrutalNotify then
        exports['brutal_notify']:SendAlert(title, text, time, type)
    else
        -- Put here your own notify and set the Config.BrutalNotify to false
        TriggerEvent('brutal_shop_robbery:client:DefaultNotify', text)
    end
end

RegisterNetEvent('brutal_shop_robbery:client:DefaultNotify', function(text)
    lib.notify({
        title = 'Braquage Shop',
        description = text,
        type = 'inform', -- types possibles : 'inform', 'success', 'error'
        duration = 5000 -- en millisecondes
    })
end)

function PoliceAlertNotify(coords, ShopName)
    notification('ROBBERY PROCESS', 'Vol en cours à '.. ShopName ..'. Marqué sur la carte!', 10000, 'info')
end

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
        SendNotify(18)
        return false
    end
end