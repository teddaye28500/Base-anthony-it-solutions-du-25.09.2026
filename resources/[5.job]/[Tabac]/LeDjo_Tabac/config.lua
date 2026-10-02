Config = {}

Config.TabacLocation =  {x = 2891.811523, y = 4412.117188, z = 54.117287}
Config.TabacBlipText = "Tabac"
Config.TabacBlipColor = 76
Config.TabacBlipSprite = 140

Config.Description = "Ingrédients 1x" -- description du sous menu transformation
Config.Quantity = 1 -- quantité de feuille a avoir pour faire du tabac
Config.NombreRecu = 4 -- nombre de tabac que tu recoit
Config.Quantity2 = 2 -- quantité de tabac pour faire des cigarette
Config.NombreRecu2 = 2 -- nombre de cigarette que tu recoit
Config.Quantity3 = 20 -- quantité de cigarette pour faire un packet
Config.NombreRecu3 = 1 -- nombre de packet de clope que tu recoit
Config.Quantity4 = 10 -- quantité de packet de clope pour faire une cartouche
Config.NombreRecu4 = 1 -- nombre de cartouche que tu recoit
Config.Items = "tabac" -- nom de l'item tabac besoin pour fabriquer du tabac
Config.Items2 = "feuilletabac" -- nom de l'item tabac besoin pour fabriquer une cigarette
Config.Items3 = "cigarette" -- nom de l'item tabac besoin pour fabriquer un packet de clope
Config.Items4 = "pacquet" -- nom de l'item tabac besoin pour fabriquer une cartouche de clope
Config.Recoit = "feuilletabac" -- nom de l'item que tu recoit apres la fabrication
Config.Recoit2 = "cigarette" -- nom de l'item que tu recoit apres la fabrication
Config.Recoit3 = "pacquet" -- nom de l'item que tu recoit apres la fabrication
Config.Recoit4 = "cartourche" -- nom de l'item que tu recoit apres la fabrication

Config.title = {
	Tabac = "Tabac",
}

Config.cars = {
	Tabac = {
    {nom = "Ranger véhicule", modele = ""},
    {nom = "PickUp", modele = "bodhi2"}, -- choix des voitures
	{nom = "Quatre Roue", modele = "verus"}, -- choix des voitures
	},
}

Config.Plate = {
	Tabac = "Tabac",
} 

Config.SpawnVeh = {
    Tabac = vector4(2907.411133, 4397.719727, 50.266052, 200.126465),
}

Config.Uniforms = {
	tabac_wear = {
 		male = {
 			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 			['torso_1'] = 369,   ['torso_2'] = 8,
 			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 40,
 			['pants_1'] = 8,   ['pants_2'] = 3,
 			['shoes_1'] = 7,   ['shoes_2'] = 9,
			['helmet_1'] = 155,  ['helmet_2'] = 1,
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