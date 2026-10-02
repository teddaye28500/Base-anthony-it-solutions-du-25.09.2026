local Config = require "config"

local function openCustom(vehicle)
    currentVehProperties.old = getVehicleProperties(vehicle)

    local color1_r, color1_g, color1_b = GetVehicleCustomPrimaryColour(vehicle)
    currentVehProperties.old.color1 = { color1_r, color1_g, color1_b }

    local color2_r, color2_g, color2_b = GetVehicleCustomSecondaryColour(vehicle)
    currentVehProperties.old.color2 = { color2_r, color2_g, color2_b }

    openTuningMenu()
end

for i = 1, #Config.WorkShops do
    local cfg = Config.WorkShops[i]

    if cfg.blip.enable then
        local blip = AddBlipForCoord(cfg.pos)

        SetBlipSprite(blip, cfg.blip.type)
        SetBlipDisplay(blip, 6)
        SetBlipScale(blip, cfg.blip.scale)
        SetBlipColour(blip, cfg.blip.color)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(cfg.blip.name)
        EndTextCommandSetBlipName(blip)
    end

    local option = {
        name = "exotic_custom_" .. i,
        icon = "fa-solid fa-screwdriver-wrench",
        label = "Custom le véhicule",
        distance = 2.0,
        canInteract = function()
            return cache.vehicle ~= nil and hasAccess(cfg.job)
        end,
        onSelect = function()
            if not cache.vehicle then return end
            openCustom(cache.vehicle)
        end,
    }

    if cfg.job then
        option.groups = { [cfg.job] = 0 }
    end

    exports.ox_target:addBoxZone({
        coords = cfg.pos,
        size = vec3(2.0, 2.0, 2.0),
        rotation = 0,
        debug = false,
        options = { option },
    })
end
