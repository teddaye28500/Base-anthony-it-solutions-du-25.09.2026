Config = {}

-- BLIPS 

-- nom 
Config.nameblips = {
	Gouv = "Gouvernement"
}

-- style du blips que vous pouvez changer en prenant l'id d'un blips sur ce site https://docs.fivem.net/docs/game-references/blips/
Config.style = {
	Gouv = 419
}

-- couleur
Config.color = {
	Gouv = 0
}

-- position
Config.blipsgouv = {

	x = -555.1648,
	y = -186.9758,
	z = 38.2102

}

-- ANNONCE

--ouvert
Config.announceouvert = {
	Gouv = 'Le Gouvernement vient d\'ouvrir !'
}

--fermer
Config.announcefermer = {
	Gouv = 'Le Gouvernement vient de fermer !'
}

--recrutement
Config.announcerecrutement = {
	Gouv = 'Le Gouvernement recrute venez vite !'
}

-- GARAGE


-- ped
Config.pedgouvgarage = {

	x = -557.7362,
	y = -165.9428,
	z = 37.3114,
	h = 20.881896

}

Config.pedgaragegouvped = 's_m_m_bouncer_01'

-- Véhicules
Config.cars = {
	Gouv = {
    {nom = "Ranger véhicule", modele = ""},
    {nom = "Véhicule", modele = "sultan"}, -- choix des voitures
	{nom = "4x4", modele = "rumpo"}, -- choix des voitures
	},
}

-- Plaque
Config.Plate = {
	Gouv = "Gouv",
} 

--Spawn véhicule 
Config.SpawnVeh = {
    Gouv = vector4(-559.0549, -162.5802, 38.1428, 110.551186),
}

Config.garagegouv = {

	x = -557.7362,
	y = -165.9428,
	z = 38.3114,

}

-- coffregouv

Config.coffregouv = {

    x = -584.6769, 
    y = -202.3648,
    z = 41.8271,

}

-- MENU BOSS

Config.bossgouv = {

    x = -585.3120, 
    y = -208.9450,
    z = 42.8271

}

-- VESTIAIRE

Config.vestiairegouv = {

    x = -563.4066,
    y = -207.4813,
    z = 42.8271,

}

-- Comptoire

Config.comptoir = {

    x = -555.1648,
    y = -186.9758,
    z = 38.2102,

}

-- VETEMENTS

Config.Uniformsgouv = {
	gouv_wear = {
 		male = {
 			['tshirt_1'] = 32,  ['tshirt_2'] = 0,
 			['torso_1'] = 295,   ['torso_2'] = 0,
 			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 39,		['arms_2'] = 9,
 			['pants_1'] = 37,   ['pants_2'] = 2,
 			['shoes_1'] = 103,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
        },

 		female = {
 			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 			['torso_1'] = 27,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 37,   ['pants_2'] = 0,
			['shoes_1'] = 103,   ['shoes_2'] = 0,
 			['helmet_1'] = -1,  ['helmet_2'] = 0,
 			['chain_1'] = 0,    ['chain_2'] = 0,
 			['ears_1'] = -1,     ['ears_2'] = 0	
        }
    }
}