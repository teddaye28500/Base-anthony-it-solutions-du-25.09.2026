Config = {}

Config.Menu = {
    x = -1367.4703,
    y = -457.2153,
    z = 33.4775,- 1,
}

Config.WebhookURL = "" -- Remplacez cela par l'URL de votre webhook

-- Police 
Config.MinPoliceOnline = 0  -- Nombre minimum de policiers en ville requis pour commencer le braquage

-- Config ped :
Config.PedSpawnCoords = { x = -1367.4703, y = -457.2153, z = 33.4775, h = 94.7459 }
Config.Ped = 'mp_m_bogdangoon' -- Pour changer le ped : https://docs.fivem.net/docs/game-references/ped-models/

-- Gofast le vehicule qui spawn
Config.VehicleModel = "dominator7" -- Modèle de véhicule
Config.delai = 900000 -- (900000) = 15 minutes de Delais pour faire un Gofast
Config.MarkerCoords = vector3(1966.6631, 5174.9175, 47.1883) -- Coordonée pour deposer le vehicule
Config.TypeMarker = 2 -- type de marker

Config.SpawnCoords = { -- Ou le vehicule spawn
    x = -1374.5579,
    y = -455.3492,
    z = 34.0655,
    h = 102.5559,   
}

Config.GPS = { -- Ou le GPS donne sur la map
    x = 1966.6631,
    y = 5174.9175
}

Config.Reward = {
    Type = "black_money",  -- Type de récompense : "money" pour de l'argent ou "black_money" pour de l'argent sale
    Min = 15000,       -- Montant minimum de la récompense
    Max = 20000       -- Montant maximum de la récompense
}
