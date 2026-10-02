RegisterNetEvent("itemclothes:applyComponent", function(component_id, drawable, texture)
    local ped = PlayerPedId()
    exports["illenium-appearance"]:setPedComponent(ped, {
        component_id = component_id,
        drawable = drawable or 0,
        texture = texture or 0
    })
end)

RegisterNetEvent("itemclothes:applyProp", function(prop_id, drawable, texture)
    local ped = PlayerPedId()
    exports["illenium-appearance"]:setPedProp(ped, {
        prop_id = prop_id,
        drawable = drawable or 0,
        texture = texture or 0
    })
end)

RegisterNetEvent("itemclothes:saveAppearance", function()
    local ped = PlayerPedId()
    local appearance = exports["illenium-appearance"]:getPedAppearance(ped)
    TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
end)
