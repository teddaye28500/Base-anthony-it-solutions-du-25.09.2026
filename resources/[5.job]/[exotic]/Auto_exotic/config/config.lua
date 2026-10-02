Config = {}

Config.Locale = GetConvar('esx:locale', 'fr')

Config.Blips = {

	MECHANIC = {
		Pos     = { x = 547.60437011719, y = -189.2431640625, z = 54.508560180664},
		Sprite  = 488,
		Display = 4,
		Scale   = 0.6,
		Colour  = 26,
	},
}




Config.Boss = {
	
	Boss ={
		coords = vec3(558.58666992188, -198.5069732666, 57.852660369873),
		groups = 'exotic',
		minZ=31.29,
		maxZ=35.29,
	},
	
}




Config.vet = {
	
	vet ={
		coords = vec3(541.05126953125, -167.28999328613, 54.50853729248),
		groups = 'exotic',
		minZ=28.49,
		maxZ=32.49,
	},
}

Config.Uniforms = {
	mechanic_wear = {
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
        }			
    }
}


------------ GARAGE ------------

-- Title
Config.Title = {
    mechanic  = "Menu Garage",
}

Config.Garage = {
    {
        coords = vec3(570.59857177734, -203.88671875, 54.830600738525),
        heading = 174.85038757324,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Garage", 
    },
}

Config.mechanic = {
    { nom = "Ranger véhicule", modele = "" },
    { nom = "Flatbed",           modele = "flatbed" },

}

Config.SpawnVeh = {
	mechanic  = vec4(580.36737060547, -217.33015441895, 55.918224334717, 65.506378173828),
}

Config.Invincible = true 
Config.Frozen = true 
Config.Stoic = true 
Config.Fade = true
Config.PedsDistance = 20.0 
Config.MinusOne = true

Config.PedList = {
    -- ped garage
	{
		model = "s_m_m_gardener_01",
        coords = vec3(570.59857177734, -203.88671875, 55.830600738525),
        heading = 174.85038757324,
		gender = "male",
		--animDict = "",
		--animName = "", 
		scenario = "WORLD_HUMAN_CLIPBOARD"
	},

}

