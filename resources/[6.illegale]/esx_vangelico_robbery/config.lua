Config = {}
Config.Locale = 'fr'

-- Nombre de policiers requis
Config.RequiredCopsRob  = 0   -- Pour commencer le braquage
Config.RequiredCopsSell = 0   -- Pour vendre les bijoux

-- Récompenses
Config.MinJewels       = 1
Config.MaxJewels       = 10
Config.MaxWindows      = 20
Config.MaxJewelsSell   = 20
Config.PriceForOneJewel = 500

-- Cooldown entre deux braquages (en secondes)
Config.SecBetwNextRob = 3600 -- 1 heure

-- Options
Config.EnableMarker = true
Config.NeedBag      = false   -- Si true → nécessite un sac pour braquer

-- ID des sacs (si NeedBag = true)
Config.Borsoni = {40, 41, 44, 45}

-- Magasin(s)
Stores = {
    ["jewelry"] = {
        position = { x = -629.99, y = -236.542, z = 38.05 },
        nameofstore = "Bijouterie",
        lastrobbed = 0
    }
}
