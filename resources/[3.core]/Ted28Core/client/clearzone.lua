local zones = {
    { coords = vector3(-101.4, -2079.8, 17.5), radius = 60.0 },
}

local function HasPlayerInside(vehicle)
    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    for seat = -1, maxSeats - 1 do
        local ped = GetPedInVehicleSeat(vehicle, seat)
        if ped ~= 0 and IsPedAPlayer(ped) then
            return true
        end
    end
    return false
end

local function ShouldDelete(vehicle)
    if not vehicle or vehicle == 0 or not DoesEntityExist(vehicle) then
        return false
    end
    if HasPlayerInside(vehicle) then
        return false
    end
    if NetworkGetEntityIsNetworked(vehicle) then
        return false
    end
    return true
end

CreateThread(function()
    while true do
        if #zones > 0 then
            local pool = GetGamePool('CVehicle')

            for z = 1, #zones do
                local zone = zones[z]
                local center = zone.coords
                local radius = zone.radius or 20.0
                local min = center - vector3(radius, radius, radius)
                local max = center + vector3(radius, radius, radius)

                SetAllVehicleGeneratorsActiveInArea(min.x, min.y, min.z, max.x, max.y, max.z, false, false)
                RemoveVehiclesFromGeneratorsInArea(min.x, min.y, min.z, max.x, max.y, max.z)

                for i = 1, #pool do
                    local vehicle = pool[i]
                    if ShouldDelete(vehicle) and #(GetEntityCoords(vehicle) - center) <= radius then
                        SetEntityAsMissionEntity(vehicle, true, true)
                        DeleteVehicle(vehicle)
                    end
                end
            end

            Wait(500)
        else
            Wait(2000)
        end
    end
end)
