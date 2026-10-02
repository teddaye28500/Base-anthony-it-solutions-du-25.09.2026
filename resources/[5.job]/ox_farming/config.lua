Config = Config or {}

Config.Framework = "ESX"     ------  ESX Framework ----     
Config.Target = "OX"         --------  OX Target ------          

--------------------------------- Activer les Blips ---------------------------------


Config.UseBlips = true

-------------------------------------- Objetcs ---------------------------------------

Config.Tomato = "tomato"
Config.Mango = "mango"
Config.Orange = "orange"
Config.Apple = "apple"
Config.Gauva = "gauva"

-------------------------------------- Produits ----------------------------------------

Config.TomatoKetchup = 'tomato_ketchup'
Config.TomatoPaste = 'tomato_paste'

Config.MangoJuice = 'mangojuice'
Config.MangoWine = 'mangowine'

Config.OrangeJuice = 'orangejuice'
Config.OrangeWine = 'orangewine'

Config.AppleJuice = 'applejuice'
Config.AppleWine = 'applewine'

Config.GauvaJuice = 'gauvajuice'
Config.GauvaWine = 'gauvawine'

------------------------------------- Montants Récoltes ----------------------------------

Config.PickAmountTomato = math.random(1, 2)
Config.PickAmountMango = 1
Config.PickAmountOrange = 1
Config.PickAmountApple = 1
Config.PickAmountGauva = 1


Config.JuicePrice = 200
Config.WinePrice = 680

Config.PedLocation = {

    -------- Fabricant d'aliments --------

    [1] = {
        coords = vector4(2310.5981, 4885.0073, 40.8082, 44.3728),
        model = 'a_m_m_hillbilly_01',
        scenario = 'WORLD_HUMAN_CLIPBOARD',
    },

    -------- Processus de vente --------

    [2] = {
        coords = vector4(83.947, 190.760, 104.4, 257.952),
        model = 'a_m_m_ktown_01',
        scenario = 'WORLD_HUMAN_CLIPBOARD',
    },
}

--------------------------------- Blips ---------------------------------

Config.Allblips = {
    [1] = {
        coords = vector4(1797.3, 4985.68, 50.44, 46.66),
        SetBlipSprite = 171,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 9,
        BlipName = "Serre à Tomate",
    },
    [2] = {
        coords = vector4(1876.93, 5057.98, 51.38, 63.76),
        SetBlipSprite = 171,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 9,
        BlipName = "Serre à Tomate",
    },
    [3] = {
        coords = vector4(2335.95, 5005.26, 42.40, 223.93),
        SetBlipSprite = 171,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 5,
        BlipName = "Jardin à Mangue",
    },
    [4] = {
        coords = vector4(2381.64, 4720.12, 32.986816, 252.28),
        SetBlipSprite = 171,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 47,
        BlipName = "Jardin à Orange",
    },
    [5] = {
        coords = vector4(239.80, 6516.276, 30.509888, 110.55),
        SetBlipSprite = 171,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 75,
        BlipName = "Jardin à Pomme",
    },
    [6] = {
        coords = vector4(349.09, 6517.34, 28.65, 198.42),
        SetBlipSprite = 171,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 43,
        BlipName = "Jardin à Goyave",
    },
    [7] = {
        coords = vector4(83.947, 190.760, 105.255, 257.952),
        SetBlipSprite = 605,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 64,
        BlipName = "Acheteur de Legumes",
    },
    [8] = {
        coords = vector4(2310.5981, 4885.0073, 40.8082, 133.22),
        SetBlipSprite = 615,
        SetBlipDisplay = 6,
        SetBlipScale = 0.50,
        SetBlipColour = 57,
        BlipName = "Preparation Aliments",
    },
}




-------------------------------- Cuissons et Ventes -------------------------------

Config.Label = {
    Food = 'Vendre de la nourriture',
    PickTomato =  'Commencer la Cueillette des tomates',
    SellTomato = 'Vendre des tomates',
    MakeTomatoKetchup = 'Démarrer la fabrication du Ketchup',
    MakeTomatoPaste = 'Commencer à faire de la Purée de tomate',
    SellTomatoKetchup = 'Vendre du Ketchup',
    SellTomatoPatse = 'Vendre de la Purée de tomate',

--------------------------------------- Mangues -------------------------------------

    PickMango = 'Démarrer la cueillette des mangues',
    SellMango = 'Vendres des mangues',
    MakeMangoJuice = 'Commencer à faire du jus de mangue',
    MakeMangoWine = 'Commencez à faire du vin de mangue',
    SellMangoJuice = 'Vendre le jus de mangue',
    SellMangoWine = 'Vendre le vin de mangue',

--------------------------------------- Oranges -------------------------------------

    PickOrange = 'Démarrer la cueillette des Oranges',
    SellOrange = 'Vendre des Oranges',
    MakeOrangeJuice = 'Commencer à faire du jus d orange',
    MakeOrangeWine = 'Commencez à faire du vin d orange',

--------------------------------------- Pommes -------------------------------------

    PickApple = 'Démarrer la cueillette des Pommes',
    SellApple = 'Vendre des Pommes',
    MakeAppleJuice = 'Commencer à faire du jus de pommes',
    MakeAppleWine = 'Commencez à faire du cidres',

--------------------------------------- Goyaves -------------------------------------

    PickGauva = 'Démarrer la cueillette des Goyaves',
    SellGauva = 'Vendre des Goyaves',
    MakeGauvaJuice = 'Commencer à faire du jus de goyaves',
    MakeGauvaWine = 'Commencez à faire du vin de goyaves',

--------------------------------------- Processus -------------------------------------

    ProcessFood = 'Traitement des aliments',
    SellProduct = 'Vendres des Produits',
}

--------------------------------------- Erreurs -------------------------------------

Config.Error = {
    PickRTomatoerro = 'Vous avais une erreur de sélection',
    TomatoKetchup = 'Besoin de 5 tomates',
    TomatoPaste = 'Besoin de 10 tomates',
}

------------------------------------------------------------------------------
--------------------------------- By Le Djo ----------------------------------
------------------------------------------------------------------------------
