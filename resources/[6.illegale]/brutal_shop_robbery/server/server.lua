CanRobbery = true
CurrentIndex = nil
CurrentRobber = nil

function SendNotify(Number, source)
    if source ~= nil and source ~= 0 then
        notification(source, Config.Notify[Number][1], Config.Notify[Number][2], Config.Notify[Number][3], Config.Notify[Number][4])
    end
end

RESCB('brutal_shop_robbery:server:getItem',function(source,cb,item)
    if GetItemCount(source, item) > 0 then
        RemoveItem(source, item, 1)
        cb(true)
    else
        cb(false)
    end
end)

RESCB("brutal_shop_robbery:server:PossibleRobbery",function(source,cb)
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
                SendNotify(1, source)
            elseif CurrentRobber == nil then
                SendNotify(8, source)
            end
            cb(false)
        end
	else
        SendNotify(2, source)
        cb(false)
	end
end)

RegisterServerEvent('brutal_shop_robbery:server:sync')
AddEventHandler('brutal_shop_robbery:server:sync', function(type, index, playerleft)
    if type == 'START ROBBERY' then
        CanRobbery = false
        CurrentIndex = index
        CurrentRobber = source

        if source ~= nil and source ~= 0 then
            DiscordWebhook('robberyProcess', '**'.. PlayerNameFunction(source)..' ['.. source ..'] **'.. Config.Webhooks.Locale['HasStarted'] ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. GetIdentifierFunction(source) ..'\n**'.. Config.Webhooks.Locale['Shop'] ..':** '.. Config.ShopRobberys[index].ShopName ..'')
        end

        TriggerClientEvent('brutal_shop_robbery:client:sync', -1, type, index)
    elseif type == 'RESET ROBBERY' then
        CurrentIndex = nil
        CurrentRobber = nil

        if source ~= nil and source ~= 0 then
            if playerleft == nil then
                DiscordWebhook('robberyFinished', '**'.. PlayerNameFunction(source)..' ['.. source ..'] **'.. Config.Webhooks.Locale['HasFinished'] ..'\n**'.. Config.Webhooks.Locale['Identifier'] ..':** '.. GetIdentifierFunction(source) ..'\n**'.. Config.Webhooks.Locale['Shop'] ..':** '.. Config.ShopRobberys[index].ShopName ..'')
            else
                DiscordWebhook('robberyFinished', Config.Webhooks.Locale['RobberHasQuit'])
            end
        end

        TriggerClientEvent('brutal_shop_robbery:client:sync', -1, type, index)

        Citizen.CreateThread(function()
            Citizen.Wait(1000*60*Config.Cooldown)
            CanRobbery = true
        end)
    elseif type == 'NPC SYNC' then
        TriggerClientEvent('brutal_shop_robbery:client:sync', -1, type, index)
    end
end)

RegisterServerEvent('brutal_shop_robbery:server:PoliceAlert')
AddEventHandler('brutal_shop_robbery:server:PoliceAlert', function(coords, index)
    local Players = GetPlayersFunction()
	for i = 1, #Players do
        for ii=1, #Config.CopsJobs do
            if GetPlayerJobFunction(Players[i]) == Config.CopsJobs[ii] then
                TriggerClientEvent('brutal_shop_robbery:client:PoliceAlert', Players[i], coords, index)
             end
         end
	end
end)

RegisterServerEvent('brutal_shop_robbery:server:AddMoney')
AddEventHandler('brutal_shop_robbery:server:AddMoney', function(type, index)
    if source == CurrentRobber then
        Money = 0
        if type == 'SAFE' then
            Money = math.random(Config.ShopRobberys[index].SafeMoney[1], Config.ShopRobberys[index].SafeMoney[2])
        elseif type == 'CASH REGISTER' then
            Money = math.random(Config.ShopRobberys[index].CashRegisterMoney[1], Config.ShopRobberys[index].CashRegisterMoney[2])
        end
        AddMoneyFunction(source, Money)

        TriggerClientEvent('brutal_shop_robbery:client:sync', CurrentRobber, 'RECEIVED MONEY', index, Money)
    else
        print('^1HACKER ^2>>>^7 ID: ^4'.. source ..' ^1[^4'.. GetIdentifierFunction(source) ..'^1] try to create money with the "brutal_shop_robbery" trigger!')
    end
end)

RegisterServerEvent('brutal_shop_robbery:server:AddItem')
AddEventHandler('brutal_shop_robbery:server:AddItem', function(type, index)
    if source == CurrentRobber then
        if type == 'SAFE' then
            local Text = ''
            local Items = {}
            for k, v in pairs(Config.ShopRobberys[index].SafeRewardItems) do
                local randomCount = math.random(v.count[1], v.count[2])

                if Text == '' then
                    Text = randomCount..'x '..v.label
                else
                    Text = Text..', '..randomCount..'x '..v.label
                end

                table.insert(Items, {label = v.label, count = randomCount})
                AddItem(source, v.item, randomCount)
            end
            notification(source, Config.Notify[10][1], Config.Notify[10][2]..' '..Text, Config.Notify[10][3], Config.Notify[10][4])
            TriggerClientEvent('brutal_shop_robbery:client:sync', CurrentRobber, 'RECEIVED ITEMS', index, Items)
        else
            print('^1HACKER ^2>>>^7 ID: ^4'.. source ..' ^1[^4'.. GetIdentifierFunction(source) ..'^1] try to create money with the "brutal_shop_robbery" trigger!')
        end
    else
        print('^1HACKER ^2>>>^7 ID: ^4'.. source ..' ^1[^4'.. GetIdentifierFunction(source) ..'^1] try to create money with the "brutal_shop_robbery" trigger!')
    end
end)

RegisterServerEvent('brutal_shop_robbery:server:SellItems')
AddEventHandler('brutal_shop_robbery:server:SellItems', function(index)
    local Text = ''
    local AllGotMoney = 0
    for k,v in pairs(Config.ShopRobberys) do
        if k == index then
            for _k, _v in pairs(v.SafeRewardItems) do
                local itemCount = GetItemCount(source, _v.item)
                if itemCount > 0 then
                    if Text == '' then
                        Text = itemCount..'x '.._v.label
                    else
                        Text = Text..', '..itemCount..'x '.._v.label
                    end

                    RemoveItem(source, _v.item, itemCount)
                    AllGotMoney += itemCount*_v.sellPrice
                end
            end
            if AllGotMoney > 0 then
                AddMoneyFunction(source, AllGotMoney)
                notification(source, Config.Notify[12][1], Config.Notify[12][2]..' '..Text..', '.. Config.Notify[10][2] ..' '.. AllGotMoney ..' '..Config.MoneyForm, Config.Notify[12][3], Config.Notify[12][4])
            else
                SendNotify(13, source)
            end
        end
    end
end)

-----------------------------------------------------------
----------------------| player drop |----------------------
-----------------------------------------------------------

AddEventHandler('playerDropped', function()
	if CurrentRobber == source then
        TriggerEvent('brutal_shop_robbery:server:sync', 'RESET ROBBERY', CurrentIndex, true)
    end
end)