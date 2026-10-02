CanRobbery = true
CurrentRobber = nil 

function SendNotify(Number, source)
    if source ~= nil and source ~= 0 then
        notification(source, Config.Notify[Number][1], Config.Notify[Number][2], Config.Notify[Number][3], Config.Notify[Number][4])
    end
end

RESCB("brutal_truck_robbery:server:PossibleRobbery",function(source,cb)
	Citizen.Wait(1)

    local Players = GetPlayersFunction()
	local policeOnline = 0
	for i = 1, #Players do
        for ii=1, #Config.CopsJobs do
            if GetPlayerJobFunction(Players[i]) == Config.CopsJobs[ii] then
                policeOnline = policeOnline + 1
             end
         end
	end

	if policeOnline >= Config.RequiredCopsCount then
        if CanRobbery then
            cb(true)
        else
            if CurrentRobber ~= nil then
                SendNotify(4, source)
            elseif CurrentRobber == nil then
                SendNotify(5, source)
            end
            cb(false)
        end
	else
        SendNotify(6, source)
        cb(false)
	end
end)

RegisterServerEvent('brutal_truck_robbery:server:sync')
AddEventHandler('brutal_truck_robbery:server:sync', function(type, playerleft)
    if type == 'START ROBBERY' then
        CanRobbery = false
        CurrentRobber = source

        if source ~= nil and source ~= 0 then
            DiscordWebhook('robberyProcess', '**'.. PlayerNameFunction(source)..' ['.. source ..'] **'.. Config.Webhooks.Locale['HasStarted'] ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. GetIdentifierFunction(source) ..'')
        end

    elseif type == 'RESET ROBBERY' then
        CurrentRobber = nil

        if source ~= nil and source ~= 0 then
            if playerleft == nil then
                DiscordWebhook('robberyFinished', '**'.. PlayerNameFunction(source)..' ['.. source ..'] **'.. Config.Webhooks.Locale['HasFinished'] ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. GetIdentifierFunction(source) ..'')
            else
                DiscordWebhook('robberyFinished', Config.Webhooks.Locale['RobberHasQuit'])
            end
        end

        TriggerClientEvent('brutal_truck_robbery:client:sync', -1, type)

        Citizen.CreateThread(function()
            Citizen.Wait(1000*60*Config.Cooldown)
            CanRobbery = true
        end)
    end
end)

RegisterServerEvent('brutal_truck_robbery:server:AddItem')
AddEventHandler('brutal_truck_robbery:server:AddItem', function()
    local random = math.random(1, #Config.TruckRewardItems)
    local randomCount = math.random(Config.TruckRewardItems[random].count[1], Config.TruckRewardItems[random].count[2])

    AddItem(source, Config.TruckRewardItems[random].item, randomCount)
    TriggerClientEvent('brutal_truck_robbery:client:sync', CurrentRobber, 'RECEIVED ITEMS', {label = Config.TruckRewardItems[random].label, count = randomCount})
end)

RegisterServerEvent('brutal_truck_robbery:server:SellItems')
AddEventHandler('brutal_truck_robbery:server:SellItems', function()
    local Text = ''
    local AllGotMoney = 0
    for k, v in pairs(Config.TruckRewardItems) do
        local itemCount = GetItemCount(source, v.item)
        if itemCount > 0 then
            if Text == '' then
                Text = itemCount..'x '..v.label
            else
                Text = Text..', '..itemCount..'x '..v.label
            end

            RemoveItem(source, v.item, itemCount)
            AllGotMoney += itemCount*v.sellPrice
        end
    end
    if AllGotMoney > 0 then
        AddMoneyFunction(source, AllGotMoney)
        notification(source, Config.Notify[12][1], Config.Notify[12][2]..' '..Text..', '.. Config.Notify[13][2] ..' '.. AllGotMoney ..' '..Config.MoneyForm, Config.Notify[12][3], Config.Notify[12][4])
    else
        SendNotify(11, source)
    end
end)

-----------------------------------------------------------
----------------------| player drop |----------------------
-----------------------------------------------------------

AddEventHandler('playerDropped', function()
	if CurrentRobber == source then
        TriggerEvent('brutal_truck_robbery:server:sync', 'RESET ROBBERY', true)
    end
end)