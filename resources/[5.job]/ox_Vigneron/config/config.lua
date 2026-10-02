Config = {}

--- Blip Vigneron
Config.vigneronLocation =  {x = -1897.66, y = 2068.58, z = 140.81} 	
Config.vigneronBlipText = "Vigneron"
Config.vigneronBlipColor = 49
Config.vigneronBlipSprite = 85

Config.useMarker = false -- Marker or Target (true = Marker) (false = Target)
Config.TypeMarker = 2 -- Si marker true vous pouvez changez le marker que vous-voulez (https://docs.fivem.net/docs/game-references/markers/)
Config.ColorMarker = { r = 0, g = 60, b = 255, a = 200 }

-- Position Marker
Config.PositionMarker = {
    BossMarker =  {x = -1876.232, y = 2060.754, z = 145.5738}, 	-- Position du menu Boss vector4(-1876.232, 2060.754, 145.5738, 121.5417)
    CoffreMarker =  {x = -1876.4818, y = 2058.8184, z = 141.0060}, 	-- Position du Coffre Vigneron
    ClothesMarker =  {x = -1875.8593, y = 2054.5991, z = 141.0690}, -- Position du Vestiare Vigneron
    GarageMarker =  {x = -1922.5287, y = 2057.5308, z = 140.8321}, -- Position du Vestiare Vigneron
}

-- Position Target
Config.PositionTarget = {
    Boss =  {x = -1876.232, y = 2060.754, z = 145.5738}, 	-- Position du menu Boss
    Clothes =  {x = -1887.509, y = 2069.565, z = 145.5739}, -- Position du Vestiare Vigneron
    Garage =  {x = -1923.12, y = 2057.68, z = 140.82}, -- Position du Vestiare Vigneron 

	Coffre =  {x = -1890.374, y = 2064.519, z = 144.8739}, 	-- Position du Coffre Vigneron vector4(-1890.374, 2064.519, 145.5739, 242.4997)
	Poids = 100000, -- 100000 en gr equivalent a 100Kg
}

Config.cars = {
	vigneron = {
    {nom = "Ranger véhicule", modele = ""},
    {nom = "PickUp", modele = "bodhi2"}, 
	{nom = "Quatre Roue", modele = "verus"},
	},
}

Config.SpawnVeh = {
    vigneron = vector4(-1919.014, 2057.14, 140.73, 252.83),
}

--- Vettements de travail
Config.Uniforms = {
	Vigneron_wear = {
 		male = {
 			['tshirt_1'] = 39,  ['tshirt_2'] = 0,
 			['torso_1'] = 466,   ['torso_2'] = 7,
 			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 28,
 			['pants_1'] = 116,   ['pants_2'] = 0,
 			['shoes_1'] = 56,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
        },

 		female = {
 			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 			['torso_1'] = 27,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 6,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
 			['helmet_1'] = -1,  ['helmet_2'] = 0,
 			['chain_1'] = 0,    ['chain_2'] = 0,
 			['ears_1'] = -1,     ['ears_2'] = 0	
        },
	},
}

Config.RaisinRouge = {
	removeraisinrouge = 2, -- enleve 2 raisin rouge
	addbarque = 1, -- donne 1 barquet de raisin rouge pressée apres les avoir enlever
}

Config.RaisinBlanc = {
	removeraisinblanc = 2, -- enleve 2 raisin blanc
	addbarque = 1, -- donne 1 barquet de raisin blanc pressée apres les avoir enlever
}

Config.BarqueRouge = {
	removebarquerouge = 2, -- enleve 2 barque de raisin rouge
	addvinrouge = 1, -- donne 1 vin rouge apres avoir enleve 2 barque de raisin rouge 
}

Config.BarqueBlanc = {
	removebarqueblanc = 2, -- enleve 2 barque de raisin blanc
	addvinblanc = 1, -- donne 1 vin blanc apres avoir enleve 2 barque de raisin blanc
}

Config.Bouteille = {
	prixduvinrouge = 100, -- prix par bouteille
	prixduvinblanc = 75, -- prix par bouteille
}

-- ANNONCE

--ouvert
Config.announceouvert = {
	Vigneron = 'Le Vigneron vient d\'ouvrir !'
}

--fermer
Config.announcefermer = {
	Vigneron = 'Le Vigneron vient de fermer !'
}

