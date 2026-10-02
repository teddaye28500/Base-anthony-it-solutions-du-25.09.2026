-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kickplayer')
AddEventHandler('kickplayer', function()
    DropPlayer(source, 'Vous avez été expulsé du serveur parce que vous volez des voitures d’urgence')
end)
