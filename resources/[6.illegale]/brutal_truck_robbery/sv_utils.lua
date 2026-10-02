local YourWebhook = 'WEBHOOK-HERE'  -- help: https://docs.brutalscripts.com/site/others/discord-webhook

function GetWebhook()
    return YourWebhook
end

-- Buy here: (4€+VAT) https://store.brutalscripts.com
function notification(source, title, text, time, type)
    if Config.BrutalNotify then
        TriggerClientEvent('brutal_notify:SendAlert', source, title, text, time, type)
    else
        TriggerClientEvent('brutal_truck_robbery:client:DefaultNotify', text)
    end
end

function PlayerNameFunction(source)
    return GetPlayerName(source)
end

RegisterServerEvent('brutal_truck_robbery:server:PoliceAlert')
AddEventHandler('brutal_truck_robbery:server:PoliceAlert', function(coords)
    local Players = GetPlayersFunction()
	for i = 1, #Players do
        for ii=1, #Config.CopsJobs do
            if GetPlayerJobFunction(Players[i]) == Config.CopsJobs[ii] then
                TriggerClientEvent('brutal_truck_robbery:client:PoliceAlert', Players[i], coords)
             end
         end
	end
end)