Config = {}

-- BLIPS 

-- nom 
Config.nameblips = {
	Weazel = "Weazel news"
}

-- style du blips que vous pouvez changer en prenant l'id d'un blips sur ce site https://docs.fivem.net/docs/game-references/blips/
Config.style = {
	Weazel = 184
}

-- couleur
Config.color = {
	Weazel = 1
}

-- position
Config.blipsweazel = {

	x = -592.391236,
	y = -929.881348,
	z = 23.854248

}

-- ANNONCE

--ouvert
Config.announceouvert = {
	Weazel = 'Le weazel vient d\'ouvrir !'
}

--fermer
Config.announcefermer = {
	Weazel = 'Le weazel vient de fermer !'
}

--recrutement
Config.announcerecrutement = {
	Weazel = 'Le weazel recrute venez vite !'
}

-- GARAGE


-- ped
Config.pedweazelgarage = {

	x = -613.384644,
	y = -940.246154,
	z = 21.118652,
	h = 104.881896

}

Config.pedgarageweazelped = 's_m_m_bouncer_01'

-- Véhicules
Config.cars = {
	Weazel = {
    {nom = "Ranger véhicule", modele = ""},
    {nom = "Véhicule", modele = "sultan"}, -- choix des voitures
	{nom = "4x4", modele = "rumpo"}, -- choix des voitures
	},
}

-- Plaque
Config.Plate = {
	Weazel = "Weazel",
} 

--Spawn véhicule 
Config.SpawnVeh = {
    Weazel = vector4(-615.797790, -933.006592, 22.320922, 110.551186),
}

Config.garageweazel = {

	x = -613.384644,
	y = -940.246154,
	z = 22.118652,

}

-- coffreweazel

Config.coffreweazel = {

    x = -587.643982, 
    y = -934.351624,
    z = 27.150878,

}

-- MENU BOSS

Config.bossweazel = {

    x = -582.424194, 
    y = -929.905518,
    z = 28.150878

}

-- VESTIAIRE

Config.vestiaireweazel = {

    x = -585.204406,
    y = -939.006592,
    z = 23.854248,

}

-- Comptoire

Config.comptoir = {

    x = -594.3824,
    y = -929.8417,
    z = 23.8542,

}

-- VETEMENTS

Config.Uniformsweazel = {
	weazel_wear = {
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