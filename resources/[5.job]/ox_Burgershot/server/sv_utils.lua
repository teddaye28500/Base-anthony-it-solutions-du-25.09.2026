if Config.Framework == "ESX" then 
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "ESXOLD" then
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    end)
end