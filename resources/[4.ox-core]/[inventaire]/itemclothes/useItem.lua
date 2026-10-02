exports('useItem', function(item, metadata)
    TriggerServerEvent("itemclothes:apply", item.name, metadata)
end)
