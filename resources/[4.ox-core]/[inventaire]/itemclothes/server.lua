local Clothes = Config.Clothes

RegisterNetEvent("itemclothes:apply", function(item, metadata)
    local src = source
    local cfg = Clothes[item]
    if not cfg then return end

    if cfg.type == "component" then
        TriggerClientEvent("itemclothes:applyComponent", src, cfg.id, metadata.drawable, metadata.texture)
    else
        TriggerClientEvent("itemclothes:applyProp", src, cfg.id, metadata.drawable, metadata.texture)
    end

    TriggerClientEvent("itemclothes:saveAppearance", src)
end)
