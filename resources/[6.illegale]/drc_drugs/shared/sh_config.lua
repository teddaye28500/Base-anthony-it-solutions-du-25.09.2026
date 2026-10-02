Config = {}

Config.Debug = false
--SERVER SETTINGS
Config.Framework = "ESX" -- Set your framework! qbcore, ESX, standalone
Config.NewESX = true -- if you use esx 1.1 version set this to false
Config.InteractionType = "target" -- target or textui or 3dtext | which type of interaction you want
Config.Target = "qtarget" -- Which Target system do u use? qb-target, qtarget
Config.Dispatch = { enabled = true, script = "qs-outlawalert", "outlawalert", "qs-dispatch" } -- cd_dispatch, linden_outlawalert, ps-disptach
Config.Bob74_ipl = true -- Loads lab interiors
Config.PoliceJobs = { 'police', 'sheriff' }
Config.NotificationType = "ox_lib" -- Notifications | types: ESX, ox_lib, qbcore
Config.Progress = "ox_lib" -- ProgressBar | types: progressBars, ox_lib, qbcore
Config.Clothing = "fivem-appearance" -- fivem-appearance, esx_skin, qb-clothing, custom | change in client/cl_Utils.lua | GetSkin = function() | ApplySkin = function()
Config.TextUI = "ox_lib" -- TextUIs | types: esx, ox_lib, luke
Config.Input = "ox_lib" -- Input | types: ox_lib, qb-input
Config.Context = "ox_lib" -- Context | types: ox_lib, qbcore
Config.SellingMoneyType = "black_money" -- Selling Money Type | ESX types: bank, money, black_money or own types | QBCORE types: cash, bank, crypto or own types
--PLAYER CONTROL
Config.Logs = { enabled = true, type = "https://discord.com/api/webhooks/1181684464468902003/5YMXW7sYpvSntlUAChXXYVfNVw5Zl52F8YQi7qUhxiJG0IsGdf8DNd2Ff0bqeMcZdUdP" } -- use webhook or ox_lib (datadog) Can be changed in server > sv_utils.lua
Config.DropPlayer = true -- Drop (Kick) Player if tries to cheat!
Config.AnticheatBan = false -- Change in server/sv_Utils.lua!!! WIll not work by default you need to add your custom trigger to ban player!

--BLIPS
Config.Blips = {
    FlowerShop = { -- do not use same value twice (will result in overwriting of blip)
        --BlipCoords = vec3(307.91, -1286.48, 29.53), -- Blip coords
        --Sprite = 40, -- Blip Icon
        --Display = 4, -- keep 4
        --Scale = 0.6, -- Size of blip
        --Colour = 69, -- colour
        --Name = "Flower Shop" -- Blip name
    },
    ComicShop = {
        --BlipCoords = vec3(-143.52, 229.53, 93.94),
        --Sprite = 280,
        --Display = 4,
        --Scale = 0.8,
        --Colour = 50,
        --Name = "Comic Shop"
    },
}

--Madrazo Trade
Config.Madrazo = {
    enabled = true,
    Header = "Madrazo",
    Title = "Acheter l’accès au laboratoire de méthamphétamine",
    Description = "Échangez 5 figurines complètes contre l’accès au laboratoire!",
    Available = { -- Time
        enabled = false, from = 1, to = 22
    },
    RequiredItems = {
        { item = "coke_figure", count = 5, remove = true },
    },
    AddItems = {
        { item = "meth_access", count = 1 },
    },
    Location = {
        Coords = vec3(-1032.44, 686.0, 161.45),
        Heading = 270.7,
        radius = 0.7,
    },
    Log = "A échangé 5x la figurine de coke contre 1 carte d’accès à la méthamphétamine"
}

--Gerald Trade
Config.Gerald = {
    enabled = true,
    Header = "Gerald",
    Title = "Acheter l’accès au labo de Coke",
    Description = "Échangez 20 paquets d’herbe contre 1 laboratoire de coke avec Gerald!",
    Available = { -- Time
        enabled = false, from = 3, to = 10
    },
    RequiredItems = {
        { item = "weed_package", count = 20, remove = true },
    },
    AddItems = {
        { item = "coke_access", count = 1 },
    },
    Location = {
        Coords = vec3(-58.91, -1530.98, 34.5),
        Heading = 229.64,
        radius = 0.7,
    },
    Log = "A échangé 20x paquet d’herbe contre 1 carte d’accès au labo de Coke"
}

--Locate Dealer
Config.LocateDealer = {
    enabled = true,
    RequiredItems = {
        --{ item = "hack_usb", count = 1, remove = true }, -- Ajoutez votre élément usb de piratage à partir de votre serveur ou créez-en un!
    },
    DealerPos = { -- Location of dealers
        vec2(-1301.67, -776.34),
        vec2(819.61, -2348.83),
    },
    Location = { --Target
        Coords = vector3(-1055.31, -243.29, 44.05),
        radius = 0.4,
    },
}

--Pharmacist
Config.Pharmacist = {
    enabled = true,
    Header = "Pharmacist",
    Available = { -- Time
        enabled = false, from = 18, to = 23
    },
    Items = {
        { label = 'bidon d\'acid vide', item = 'meth_emptysacid', description = "Acheter une canette en plastique vide pour: $",
            price = 80, MinAmount = 1, MaxAmount = 10 },
        { label = 'amoniak', item = 'meth_amoniak', description = "Acheter Amoniak pour: $", price = 80, MinAmount = 1,
            MaxAmount = 10 },
        { label = 'seringue', item = 'syringe', description = "Acheter une seringue pour: $", price = 50, MinAmount = 1,
            MaxAmount = 1 },
        { label = 'Pipe a meth', item = 'meth_pipe', description = "Acheter une Pipe a meth pour: $", price = 70, MinAmount = 1,
            MaxAmount = 1 },
        { label = 'Pipe a Crack', item = 'crack_pipe', description = "Acheter une Pipe a Crack pour: $", price = 60, MinAmount = 1,
            MaxAmount = 1 },
    },

    Ped = {
        { model = "s_m_m_doctor_01", coords = vec4(75.76, -1622.35, 30.9 - 1.0, 236.13), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--Dealer
Config.Dealer = {
    enabled = true,
    Header = "Weed Dealer",
    Items = {
        { label = 'Carte d’accès Weed', item = 'weed_access', description = "Acheter Weed Access pour: $", price = 5000,
            MinAmount = 1, MaxAmount = 1 },
        { label = 'feuilles a rouler', item = 'weed_papers', description = "Acheter des feuilles de cannabis pour: $", price = 50, MinAmount = 1,
            MaxAmount = 5 },
        { label = 'Blunt', item = 'weed_wrap', description = "Acheter des Blunt pour: $", price = 60, MinAmount = 1,
            MaxAmount = 5 },
        { label = 'sac en plastique', item = 'plastic_bag', description = "Acheter un sac en plastique pour: $", price = 50, MinAmount = 1,
            MaxAmount = 10 },
    },
    Ped = {
        { model = "s_m_y_dealer_01", coords = vec4(-1301.67, -776.34, 18.47, 202.49), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--Medicament dealer
Config.MedicamentsShop = {
    enabled = true,
    Header = "Medicament Dealer",
    Items = {
        { label = 'LSD', item = 'lsd', description = "Acheter du LSD pour: $", price = 500, MinAmount = 1, MaxAmount = 2 },
        { label = 'Xanax', item = 'xanaxpack', description = "Acheter Xanax pour: $", price = 1500, MinAmount = 1,
            MaxAmount = 2 },
        { label = 'Ecstasy', item = 'ecstasy', description = "Acheter de l’ecstasy pour: $", price = 400, MinAmount = 1,
            MaxAmount = 2 },
    },
    Ped = {
        { model = "s_m_y_dealer_01", coords = vec4(819.61, -2348.83, 29.33, 261.57), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--ComicShop
Config.ComicShop = {
    enabled = true,
    Header = "Comic Shop",
    Items = {
        { label = 'figurine vide', item = 'coke_figureempty', description = "Acheter une figurine pour: $", price = 80,
            MinAmount = 1, MaxAmount = 10 },
    },
    Ped = {
        { model = "u_m_y_imporage", coords = vec4(-141.08, 229.84, 93.94, 353.3), scenario = "WORLD_HUMAN_MUSCLE_FLEX" },
    },
    Log = "A acheté Item %s, Count %s"
}

--Flowershop
Config.FlowerShop = {
    enabled = true,
    Header = "Flower Shop",
    Items = {
        { label = 'Marteau', item = 'hammer', description = "Acheter Hammer pour: $", price = 700, MinAmount = 1, MaxAmount = 2 },
        { label = 'truelle', item = 'trowel', description = "Acheter une truelle pour: $", price = 800, MinAmount = 1, MaxAmount = 2 },
        { label = 'ciseaux', item = 'scissors', description = "Acheter des ciseaux pour: $", price = 500, MinAmount = 1,
            MaxAmount = 2 },
        { label = 'colle Glue', item = 'glue', description = "Acheter de la colle pour: $", price = 50, MinAmount = 1, MaxAmount = 10 },
        { label = 'bicarbonate', item = 'baking_soda', description = "Acheter du bicarbonate de soude pour: $", price = 80, MinAmount = 1,
            MaxAmount = 10 },
    },
    Ped = {
        { model = "s_m_m_gardener_01", coords = vec4(307.91, -1286.48, 29.53, 165.26), scenario = "WORLD_HUMAN_SMOKING" },
    },
}

--Weed
Config.Weed = {
    --LABORATORY
    ElectricityNeeded = true,
    --Lab circlezone
    Lab = {
        coords = vector3(1054.33, -3196.17, -39.17),
        radius = 23.85,
        DebugPoly = false,
        name = "WeedLab",
    },
    --Air Conditioner
    AC = {
        coords = vector3(1045.32, -3194.84, -38.33),
        radius = 0.4,
    },
    --Mini game
    Minigame = { -- Select only one option
        Memorygame = false,
        oxlib = true
    },
    --ENTER LAB
    Enterlab = {
        coords = vector3(2855.56, 4447.03, 48.88),
        radius = 1.2,
        teleport = vector3(1066.12, -3183.43, -40.16),
        NeedItem = true,
        ItemName = "weed_access"
    },
    --LEAVE LAB
    LeaveLab = {
        coords = vector3(1066.57, -3183.46, -38.96), radius = 1.0, teleport = vector3(2855.99, 4445.97, 47.54),
    },
    --Collecting weed
    Pickup = {
        Models = { [`bkr_prop_weed_lrg_01a`] = true, [`bkr_prop_weed_lrg_01b`] = true },
        RequiredItems = {
            { item = "scissors", count = 1, remove = false },
        },
        AddItems = {
            { item = "weed_bud", count = 2 },
        },
        Log = "A ramassé des bourgeons de cannabis avec des feuilles"
    },
    --Clean
    Clean = {
        header = "Nettoyer la Weed",
        description = "Ingrédients: 1x bourgeon de cannabis avec feuilles",
        coords = vector3(1038.67, -3205.93, -38.3),
        radius = 0.8,
        teleport = vector3(1039.3 - 0.8, -3205.95, -37.69 - 1.4),
        heading = 90.0,
        leave = vector3(1039.28, -3205.38, -39.17),
        RequiredItems = {
            { item = "weed_bud", count = 10, remove = true },
        },
        AddItems = {
            { item = "weed_budclean", count = 10 },
        },
        Log = "A transformé 1x bourgeon de cannabis avec des feuilles en 1x bourgeon de cannabis"
    },
    --Package
    Package = {
        header = "empaqueter la Weed",
        description = "Ingredients: 5x Bourgeon de cannabis, 1x Sac en plastique",
        coords = vector3(1036.35, -3203.13, -38.24),
        radius = 0.8,
        RequiredItems = {
            { item = "weed_budclean", count = 5, remove = true },
            { item = "plastic_bag", count = 1, remove = true },
        },
        AddItems = {
            { item = "weed_package", count = 1 },
        },
        Log = "A traité 5x bourgeon de cannabis, 1x sac en plastique dans 1x Weed Packed"
    },
}

--Meth
Config.Meth = {
    --LABORATORY
    ElectricityNeeded = true,
    --Electricity
    Electricity = {
        coords = vector3(998.33, -3202.35, -38.48), radius = 0.7,
    },
    --Mini game
    Minigame = { -- Select only one option
        Memorygame = false,
        oxlib = true
    },
    --Lab circlezone
    Lab = {
        coords = vector3(1013.22, -3194.95, -37.88),
        radius = 18.85,
        DebugPoly = false,
        name = "MethLab",
    },
    --ENTER LAB
    Enterlab = {
        coords = vector3(762.93, -1092.78, 22.58),
        radius = 1.6,
        teleport = vector3(996.99, -3200.7, -37.39),
        NeedItem = true,
        ItemName = "meth_access"
    },
    --LEAVE LAB
    LeaveLab = {
        coords = vector3(996.49, -3200.62, -36.32),
        radius = 1.0,
        teleport = vector3(763.09, -1092.92, 21.22),
    },
    --GET ACID
    GetSacid = {
        coords = vector3(2718.76, 1558.05, 21.4),
        radius = 1.0,
        teleport = vector3(2718.82, 1558.8, 19.82),
        RequiredItems = {
            { item = "meth_emptysacid", count = 1, remove = true },
        },
        AddItems = {
            { item = "meth_sacid", count = 1 },
        },
        Log = "A rempli sa canette avec du bicarbonate de soude"
    },
    --HEAT
    Heat = {
        coords = vector3(1001.97, -3198.86, -38.53),
        radius = 0.4,
        teleport = vector3(1002.38, -3198.91, -39.99),
        heading = 82.52,
    },
    --Pouring
    Pouring = {
        header = "Commencer à cuisiner",
        description = "Ingredients: 1x Amoniak, 1x bicarbonate de soude",
        coords = vector3(1005.76, -3200.91, -38.1),
        radius = 0.6,
        teleport = vector3(1005.71, -3200.39, -38.51),
        heading = 180.0,
        -- Items are in Complete
    },
    --Complete
    Complete = {
        coords = vector3(1007.84, -3201.51, -38.53),
        radius = 0.5,
        teleport = vector3(1007.89, -3201.09, -39.99),
        heading = 188.27,
        RequiredItems = {
            { item = "meth_amoniak", count = 1, remove = true },
            { item = "meth_sacid", count = 1, remove = true },
        },
        AddItems = {
            { item = "meth_glass", count = 1 },
            { item = "meth_emptysacid", count = 1 },
        },
        Log = "A traité 1x Amoniak, 1x bicarbonate de soude dans 1x plateau de méthamphétamine"
    },
    --Break
    Break = {
        header = "Casser de la méthamphétamine",
        description = "Ingredients: 1x plateau de méthamphétamine, 1x marteau",
        coords = vector3(1016.47, -3194.15, -39.01),
        radius = 0.5,
        teleport = vector3(1016.70 - 3.6, -3195.64 - 1.0, -38.99 - 1.0),
        heading = 180.0,
        RequiredItems = {
            { item = "meth_glass", count = 1, remove = true },
            { item = "hammer", count = 1, remove = false },
        },
        AddItems = {
            { item = "meth_sharp", count = 1 },
        },
        Log = "A traité 1x plateau de méthamphétamine, 1x marteau dans 1x plateau de méthamphétamine cassé"
    },
    --Package
    Package = {
        header = "empaqueter la Meth",
        description = "Ingredients: 1x plateau de méthamphétamine cassé, 1x sac en plastique",
        coords = vector3(1011.28, -3194.15, -39.04),
        radius = 0.5,
        teleport = vector3(1012.24, -3196.25, -38.99),
        heading = 180.0,
        RequiredItems = {
            { item = "meth_sharp", count = 1, remove = true },
            { item = "plastic_bag", count = 1, remove = true },
        },
        AddItems = {
            { item = "meth_bag", count = 1 },
        },
        Log = "A traité 1x plateau de méthamphétamine cassé, 1x sac en plastique dans 1x sac de méthamphétamine"

    },
}

--Heroin
Config.Heroin = {
    --Field
    Field = {
        coords = vec3(4123.8, 4499.54, 17.55),
        radius = 20.85,
        Duration = 10000,
        name = "Champ de pavot",
        debugPoly = false,
        RequiredItems = {
            { item = "trowel", count = 1, remove = false },
        },
        AddItems = {
            { item = "poppyplant", count = 2 },
        },
        prop = `prop_plant_01b`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE
        Log = "A ramassé 2x Plant de pavot"
    },
    --Process
    Process = {
        header = "Traiter les plants de pavot",
        description = "Ingredients: 3x Plante de pavot, 1x Amoniak, 1x Sac en plastique",
        coords = vector3(1391.41, 3605.55, 39.07),
        radius = 0.4,
        Teleport = vector3(1391.87, 3605.64, 37.94),
        Duration = 30000,
        RequiredItems = {
            { item = "poppyplant", count = 3, remove = true },
            { item = "meth_amoniak", count = 1, remove = true },
            { item = "plastic_bag", count = 1, remove = true },
        },
        AddItems = {
            { item = "heroin", count = 1 },
        },
        Log = "A transformé 3x Plante de pavot, 1x Amoniak, 1x Sac en plastique dans 1x héroïne"
    },
}

--Crack
Config.Crack = {
    --Process
    Process = {
        header = "Faire du Crack",
        description = "Ingredients: 2x Coke pur, 1x Bicarbonate de soude, 1x Bouteille d’eau",
        coords = vector3(2431.04, 4971.46, 42.28),
        radius = 0.4,
        Teleport = vector3(2431.47, 4970.94, 41.35),
        Duration = 60000,
        RequiredItems = {
            { item = "coke_pure", count = 2, remove = true },
            { item = "baking_soda", count = 1, remove = true },
            { item = "water", count = 1, remove = true },
        },
        AddItems = {
            { item = "crack", count = 1 },
        },
        Log = "A traité 2x Coke pur, 1x Bicarbonate de soude, bouteille d’eau dans 1X crack"
    },
}

--Coke
Config.Coke = {
    --LABORATORY
    ElectricityNeeded = false,
    --Lab circlezone
    Electricity = {
        coords = vector3(1091.5, -3191.67, -39.7),
        radius = 0.4
    },
    --Mini game
    Minigame = { -- Select only one option
        Memorygame = false,
        oxlib = true
    },
    --Lab Circlezone
    Lab = {
        coords = vector3(1092.68, -3194.89, -38.99),
        radius = 18.85,
        DebugPoly = false,
        name = "CokeLab",
    },
    --ENTER LAB
    Enterlab = {
        coords = vector3(1242.16, -3113.78, 6.01),
        radius = 1.2,
        teleport = vector3(1088.76, -3187.68, -39.99),
        NeedItem = true,
        ItemName = "coke_access"
    },
    --LEAVE LAB
    LeaveLab = {
        coords = vector3(1088.66, -3187.51, -38.83),
        radius = 0.8,
        teleport = vector3(1242.16, -3113.78, 6.01),
    },
    --Field
    Field = {
        coords = vector3(2526.91, 4358.54, 40.09),
        radius = 40.0,
        DebugPoly = false,
        name = "Champ de coke",
        prop = `prop_plant_01a`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE
        RequiredItems = {
            { item = "trowel", count = 1, remove = false },
        },
        AddItems = {
            { item = "coke_leaf", count = 2 },
        },
        Log = "A ramassé 2X feuille de Coke"
    },
    --LeafProcess
    LeafProcess = {
        header = "Traiter les feuilles de Coke",
        description = "Ingredients: 2x Feuilles de Coke", coords = vector3(1101.8, -3193.06, -38.98), radius = 0.4,
        boxcoords = vector4(1101.81, -3193.14, -39.18, 90),
        RequiredItems = {
            { item = "coke_leaf", count = 2, remove = true },
        },
        AddItems = {
            { item = "coke_box", count = 1 },
        },
        Log = "A transformé 2x feuilles de Coke dans 1x boîte de Coke"
    },
    --CokeBox
    CokeBox = {
        header = "Pour Coke",
        description = "Ingredients: 1x Boîte avec Coke",
        coords = vector3(1086.8, -3195.31, -39.15), radius = 0.4, teleport = vector3(1087.31, -3196.04, -38.99),
        heading = 0.0,
        RequiredItems = {
            { item = "coke_box", count = 1, remove = true },
        },
        AddItems = {
            { item = "coke_raw", count = 3 },
        },
        Log = "A transformé 1x boîte de Coke en 3x Coke cru"
    },
    --Coke Cleaning
    Soda = {
        header = "Nettoyer la Coke",
        description = "Ingredients: 2x Cru Coke",
        RequiredItems = {
            { item = "coke_raw", count = 2, remove = true },
        },
        AddItems = {
            { item = "coke_pure", count = 1 },
        },
        Log = "A transformé 2x Coke cru en 1x Coke pur"
    },
    SodaTables = {
        -- use only headingtotable 0.0 or 180.0 | 270 and 90 dont work
        { coords = vector3(1095.39, -3196.3, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 0.0 },
        { coords = vector3(1093.04, -3196.36, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 0.0 },
        { coords = vector3(1090.33, -3196.2, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 0.0 },
        { coords = vector3(1095.36, -3195.34, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 180.0 },
        { coords = vector3(1093.09, -3195.33, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 180.0 },
        { coords = vector3(1090.28, -3195.3, -39.15), radius = 0.4, DebugPoly = false, headingtotable = 180.0 },
    },
    --Packaging
    FigurePackage = {
        header = "empaqueter la Coke",
        description = "Ingredients: 1x figurine vide, 5x Coke pur",
        coords = vector3(1100.43, -3199.39, -39.26), radius = 0.5,
        teleport = vector3(1100.62 - 7.0, -3198.83 + 2.2, -38.99 - 1.0), heading = 180.0,
        RequiredItems = {
            { item = "coke_pure", count = 5, remove = true },
            { item = "coke_figureempty", count = 1, remove = true },
        },
        AddItems = {
            { item = "coke_figure", count = 1 },
        },
        Log = "A transformé 1x figurine vide, 5x Coke pur dans 1x figurine de Coke"
    },
}

--Mushrooms
Config.MushroomsField = {
    --Field!
    coords = vec3(-582.9, 5834.17, 30.61),
    radius = 18.85,
    name = "Champ de champignons",
    debugPoly = false,
    prop = `prop_stoneshroom2`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
    RequiredItems = {
        { item = "trowel", count = 1, remove = false },
    },
    AddItems = {
        { item = "magicmushroom", count = 1 },
    },
    Log = "A ramassé Champignon"
}

--Peyote
Config.PeyoteField = {
    --Field!
    coords = vec3(318.78, 4319.8, 48.09),
    radius = 38.85,
    name = "Champ de peyote",
    debugPoly = false,
    RequiredItems = {
        { item = "trowel", count = 1, remove = false },
    },
    AddItems = {
        { item = "peyote", count = 1 },
    },
    prop = `prop_peyote_highland_01`, -- DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
    Log = "A ramassé Peyote"
}

--Selling
Config.PhoneBooths = { -- use hash
    -429560270,
    -1559354806,
    -78626473,
    295857659,
    -2103798695,
    1158960338,
    1511539537,
    1281992692
}

Config.Drugs = {
    weed_package = { -- Item name
        Label = "Weed", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 50, --Dispatch Chance 0 - 100 %
        MinPrice = 25, -- Min price
        MaxPrice = 850, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
        Chance = 80, -- 0 - 100% succes of negotiate for better price
        AttackChance = 5, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_weed_bag_01a`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        }
    },
    meth_bag = { -- Item name
        Label = "Meth", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 5, --Dispatch Chance 0 - 100 %
        MinPrice = 30, -- Min price
        MaxPrice = 3000, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
        Chance = 80, -- 0 - 100% succes of negotiate for better price
        AttackChance = 5, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `prop_meth_bag_01`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        },
    },
    crack = { -- Item name
        Label = "Crack", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 5, --Dispatch Chance 0 - 100 %
        MinPrice = 40, -- Min price
        MaxPrice = 1750, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
        Chance = 80, -- 0 - 100% succes of negotiate for better price
        AttackChance = 5, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_weed_bag_01a`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        },
    },
    heroin = { -- Item name
        Label = "Heroin", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 5, --Dispatch Chance 0 - 100 %
        MinPrice = 50, -- Min price
        MaxPrice = 2100, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
        Chance = 80, -- 0 - 100% succes of negotiate for better price
        AttackChance = 5, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_weed_bag_01a`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        },
    },
    coke_figure = { -- Item name
        Label = "Action Figure with Coke", -- Item label
        ReqPolice = 1, -- Police count
        ReportChance = 5, --Dispatch Chance 0 - 100 %
        MinPrice = 80, -- Min price
        MaxPrice = 2750, -- Max price
        MinCount = 1, -- Min Count
        MaxCount = 5, -- Max Count
        Chance = 80, -- 0 - 100% succes of negotiate for better price
        AttackChance = 5, -- 0 - 100% Chance of NPC atacking player
        animation = {
            model = `bkr_prop_coke_doll`,
            pos = vec3(0.16, 0.04, -0.05),
            rot = vec3(0.0, 26.0, 100.0),
            bone = 57005
        }
    }
}

--Consumables
Config.Consumables = {
    weed_joint = { -- Item name
        Remove = true, -- Remove item
        Log = "A fumé un joint",
        RemoveItem = "weed_joint", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Fumer de l’herbe",
        duration = 8500,
        effect = "weed",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 10,
            },
            armor = {
                enabled = true,
                add = 5,
            },
            strength = {
                enabled = false,
                time = 60 --TIME IS IN SECONDS
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = false,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = true,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    },
    meth_syringe = { -- Item name
        Remove = true, -- Remove item
        Log = "A utilisé une seringue avec de la méthamphétamine",
        RemoveItem = "meth_syringe", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "injecte de la Meth",
        duration = 15500,
        effect = "Poison",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 50,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = false,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    },
    heroin_syringe = { -- Item name
        Remove = true, -- Remove item
        Log = "A utilisé une seringue avec de l’héroïne",
        RemoveItem = "heroin_syringe", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "injecte de l'Heroin",
        duration = 17500,
        effect = "Poison",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 50,
            },
            armor = {
                enabled = true,
                add = 10,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = false,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    },
    meth_pipe = { -- Item name
        Remove = true, -- Remove item
        Log = "A fumé la pipe à méthamphétamine",
        RemoveItem = "meth_bag", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "fumé de la Meth",
        duration = 19500,
        effect = "Poison",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 50,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'switch@trevor@trev_smoking_meth',
                    clip = 'trev_smoking_meth_loop',
                },
                prop = {
                    model = `prop_cs_meth_pipe`,
                    pos = vec3(0.12, -0.05, -0.03),
                    rot = vec3(19.0, 10.0, -10.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    xanaxpill = { -- Item name
        Remove = true, -- Remove item
        Log = "A fait éclater la pilule Xanax",
        RemoveItem = "xanaxpill", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = " avale pilule xanax",
        duration = 2500,
        effect = "xanax",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 5,
            },
            armor = {
                enabled = true,
                add = 15,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 10
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_suicide',
                    clip = 'pill',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    lsd = { -- Item name
        Remove = true, -- Remove item
        Log = "a pris du LSD",
        RemoveItem = "lsd", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "prend du LSD",
        duration = 2500,
        effect = "trip",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 10,
            },
            armor = {
                enabled = false,
                add = 50,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = true,
                time = 30
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_suicide',
                    clip = 'pill',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    ecstasy = { -- Item name
        Remove = true, -- Remove item
        Log = "a pris de l'Ecstasy",
        RemoveItem = "ecstasy", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "prend de l'Ecstasy",
        duration = 2500,
        effect = "ecstasy",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = false,
                add = 50,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'mp_suicide',
                    clip = 'pill',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    coke_pure = { -- Item name
        Remove = true, -- Remove item
        Log = "A sniffé de la Coke pur",
        RemoveItem = "coke_pure", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "sniffe de la Coke",
        duration = 4000,
        effect = "coke",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 50,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'anim@amb@nightclub@peds@',
                    clip = 'missfbi3_party_snort_coke_b_male3',
                },
                prop = {
                    model = nil,
                    pos = nil,
                    rot = nil,
                    bone = nil
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    crack_pipe = { -- Item name
        Remove = true, -- Remove item
        Log = "A fumé la pipe à crack",
        RemoveItem = "crack", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "fume du Crack",
        duration = 17500,
        effect = "alien",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = true,
                add = 50,
            },
            strength = {
                enabled = true,
                time = 60
            },
            speed = {
                enabled = true,
                time = 60
            },
            stamina = {
                enabled = true,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'switch@trevor@trev_smoking_meth',
                    clip = 'trev_smoking_meth_loop',
                },
                prop = {
                    model = `prop_cs_crackpipe`,
                    pos = vec3(0.13, -0.09, -0.05),
                    rot = vec3(29.0, 28.0, -1.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    magicmushroom = { -- Item name
        Remove = true, -- Remove item
        Log = "A mangé des champignons magiques",
        RemoveItem = "magicmushroom", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Manger des champis",
        duration = 17500,
        effect = "trip",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = false,
                add = 90,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c',
                },
                prop = {
                    model = `ng_proc_leaves08`,
                    pos = vec3(0.14, 0.01, -0.03),
                    rot = vec3(0.0, 0.0, 50.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    peyote = { -- Item name
        Remove = true, -- Remove item
        Log = "A mangé une Peyote",
        RemoveItem = "peyote", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "Manger une Peyote",
        duration = 1500,
        effect = "trip",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 30,
            },
            armor = {
                enabled = false,
                add = 90,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    clip = 'idle_c',
                },
                prop = {
                    model = `prop_peyote_highland_01`,
                    pos = vec3(0.15, 0.01, -0.09),
                    rot = vec3(-90.0, -9.0, 0.0),
                    bone = 57005
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = false,
                anim = "syringe"
            }
        }
    },
    weed_blunt = { -- Item name
        Remove = true, -- Remove item
        Log = "A fumé un Blunt",
        RemoveItem = "weed_blunt", -- Remove Item name
        RemoveItemCount = 1, -- Remove Item Count
        ProgressBar = "fumé un blunt",
        duration = 17500,
        effect = "weed",
        add = {
            enabled = true,
            health = {
                enabled = true,
                add = 10,
            },
            armor = {
                enabled = true,
                add = 5,
            },
            strength = {
                enabled = false,
                time = 60
            },
            speed = {
                enabled = false,
                time = 60
            },
            stamina = {
                enabled = false,
                time = 60
            },
        },
        animation = {
            emote = {
                enabled = true,
                anim = {
                    dict = 'amb@world_human_aa_smoke@male@idle_a',
                    clip = 'idle_c'
                },
                prop = {
                    model = `prop_cigar_02`,
                    pos = vec3(0.01, 0.0, 0.02),
                    rot = vec3(0.0, 0.0, -170.0),
                    bone = 28422
                },
            },
            scenario = {
                enabled = false,
                anim = {
                    scenario = "WORLD_HUMAN_SMOKING_POT"
                },
            },
            custom = {
                enabled = true,
                anim = "syringe"
            }
        }
    }
}
