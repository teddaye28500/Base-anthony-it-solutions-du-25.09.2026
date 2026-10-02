Config = {}
Config.MaxDistance = 10.0 -- Max interact distance
Config.UseKeySystem = true -- Implemented only for qb-vehiclekeys, you can implement it for other systems in cl_edit.lua
Config.SpawnpointCheck = true -- Checks if the vehicle spawnpoint is empty before spawning it.

-- The global setting for target however you can still combine target/TextUI by omitting Position or PedPosition in garage/impound data
Config.Target = false

---@alias VehicleType string

---@class BlipData
---@field Name string
---@field Sprite integer
---@field Size number
---@field Color integer

---@type table<VehicleType, table<'Garage' | 'Impound', BlipData>>
Config.Blips = {
    ['car'] = {
        Garage = {
            Name = 'Garage',
            Sprite = 357,
            Size = 0.5,
            Color = 24
        },
        Impound = {
            Name = 'Fourrière',
            Sprite = 477,
            Size = 0.5,
            Color = 47
        },
    },
    ['air'] = {
        Garage = {
            Name = 'Garage Avion',
            Sprite = 359,
            Size = 0.5,
            Color = 42
        },
        Impound = {
            Name = 'Fouriere Avion',
            Sprite = 481,
            Size = 0.5,
            Color = 47
        },
    },
    ['boat'] = {
        Garage = {
            Name = 'Garage Bateau',
            Sprite = 356,
            Size = 0.5,
            Color = 77
        },
        Impound = {
            Name = 'fouriere Bateau',
            Sprite = 317,
            Size = 0.5,
            Color = 47
        },
    },
}

---@class LocationData
---@field Visible boolean Blip visibility on map.
---@field Type VehicleType The vehicle type.
---@field Position? vector3 Needs to be defined if PedPosition isn't.
---@field PedPosition? vector4 Needs to be defined if Position isn't.
---@field Model? number | string Needs to be defined if PedPosition is defined.
---@field SpawnPosition vector4 The vehicle spawn position.
---@field Jobs? string | string[] Optionally limit to jobs.

---@class GarageData : LocationData
---@field Interior string? The interior name.

---@type GarageData[]
Config.Garages = {
    {
        Visible = true,
        Type = 'car',
        Position = vector3(220.1418, -800.1686, 30.7227),
        PedPosition = vector4(215.4677, -808.5453, 30.7597, 248.1795),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(229.3425, -801.4708, 30.5659, 161.8591),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(273.0, -343.85, 44.91),
        PedPosition = vector4(276.0835, -343.4283, 44.9198, 344.8690),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(270.75, -340.51, 44.92, 342.03),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-71.46, -1821.83, 26.94),
        PedPosition = vector4(-71.1413, -1829.9701, 26.9420, 230.2688),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-66.51, -1828.01, 26.94, 235.64),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(1032.84, -765.1, 58.18),
        PedPosition = vector4(1035.1685, -765.1791, 57.9946, 152.8775),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(1023.2, -764.27, 57.96, 319.66),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-1248.69, -1425.71, 4.32),
        PedPosition = vector4(-1253.3109, -1420.1212, 4.3231, 306.8438),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-1244.27, -1422.08, 4.32, 37.12),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-3142.876, 1115.338, 20.70409),
        PedPosition = vector4(-2961.7307, 375.5100, 14.8210, 171.7270),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-3145.076, 1110.067, 20.70487, 286.3625),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(1741.204, 3714.908, 34.1039),
        PedPosition = vector4(1873.9102, 3752.6917, 32.9840, 306.1647),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(1722.239, 3712.5,  34.23228, 16.62634),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(365.21, 295.6, 103.46),
        PedPosition = vector4(363.3373, 296.9839, 103.5044, 251.6143),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(364.84, 289.73, 103.42, 164.23),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-341.7255, -875.3903, 31.07091),
        PedPosition = vector4(106.0233, 6613.0356, 31.9787, 230.0135),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-338.2952, -892.4809, 31.07092, 351.8946),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(107.32, 6611.77, 31.98),
        PedPosition = vector4(106.0233, 6613.0356, 31.9787, 230.0135),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(110.84, 6607.82, 31.86, 265.28),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-1480.0311, -496.4789, 32.8068),
        PedPosition = vector4(-1471.2198, -490.6253, 32.8068, 129.3045),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-1480.0311, -496.4789, 32.8068, 215.6816),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-1667.8083, 72.3026, 63.5343),
        PedPosition = vector4(-1677.5203, 66.0455, 63.9183, 317.4938),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-1667.8083, 72.3026, 63.5343, 48.9008),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'air',
        Position = vector3(-1182.7245, -2852.9495, 14.0404),
        PedPosition = vector4(-1186.2985, -2841.2820, 13.9461, 236.5903),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-1178.4406, -2845.8442, 13.9457, 333.0016),
    },
    {
        Visible = true,
        Type = 'boat',
        Position = vector3(-802.3275, -1415.8136, 1.5952),
        PedPosition = vector4(-797.7064, -1419.6964, 1.5952, 54.2872),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-803.2337, -1421.8733, -0.4749, 230.6403)
    },
}

Config.GarageInteriors = {
    ['small'] = {
        -- The teleport coords
        Coords = vector4(637.1520, 4750.6572, -59.0000, 91.4643), 
        -- The vehicle spot coords array
        Vehicles = {
            vector4(623.0, 4750.4780, -59.5000, 179.0),
            vector4(626.0, 4750.4790, -59.5000, 179.0),
            vector4(629.0, 4750.5620, -59.5000, 179.0),
            vector4(632.0, 4750.5078, -59.5000, 179.0),
        }
    },
    ['large'] = {
        -- The teleport coords
        Coords = vector4(238.0297, -1004.8235, -99.0000, 90.0),
        -- The vehicle spot coords array
        Vehicles = {
            vector4(232.7722, -984.5818, -99.0000, 90.0),
            vector4(232.7722, -988.5818, -99.0000, 90.0),
            vector4(232.7722, -992.5818, -99.0000, 90.0),
            vector4(232.7722, -996.5818, -99.0000, 90.0),
            vector4(232.7722, -1000.5818, -99.0000, 90.0),
            vector4(223.7722, -984.5818, -99.0000, -90.0),
            vector4(223.7722, -988.5818, -99.0000, -90.0),
            vector4(223.7722, -992.5818, -99.0000, -90.0),
            vector4(223.7722, -996.5818, -99.0000, -90.0),
            vector4(223.7722, -1000.5818, -99.0000, -90.0),
        }
    }
}

Config.ImpoundPrice = 1000 --Price to return your vehicle.

---@class ImpoundData : LocationData

---@type ImpoundData[]
Config.Impounds = {
    {
        Visible = true,
        Type = 'car',
        Position = vector3(401.7906, -1631.6171, 29.2920),
        PedPosition = vector4(399.1730, -1629.3943, 29.2919, 232.0665),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(407.8341, -1645.6790, 29.2921, 228.1345)
    },
    {
        Visible = true,
        Type = 'air',
        Position = vector3(-1150.4854, -2871.9438, 13.9459),
        PedPosition = vector4(-1153.9452, -2860.0886, 13.9460, 241.3252),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-1146.0892, -2864.6094, 13.9460, 331.5881)
    },
    {
        Visible = true,
        Type = 'boat',
        Position = vector3(-844.2191, -1366.7213, 1.6052),
        PedPosition = vector4(-848.3743, -1368.4086, 1.6052, 291.1638),
        Model = `s_m_m_armoured_01`,
        SpawnPosition = vector4(-843.4146, -1372.2310, -0.4749, 114.3669)
    },
}

Config.Contract = {
    Duration = 5000, -- The animation duration
    Item = 'contract' -- The item name
}