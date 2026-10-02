Config = {}
Config.Progress = "circle" -- what kind of progress bar u wanna use ? circle or bar ?
Config.NotificationType = "ox_lib" -- ESX or ox_lib

Config.SheriffCartePermisArme = "ppa" -- items de la carte permis arme
Config.EnableHandcuffTimer        = true 
Config.HandcuffTimer              = 10 * 60000 

-- Title
Config.Title = {
    sheriff  = "Menu Garage",
	Stash = "Coffre Entreprise",
}

--####################################
--########### Progresse bar ##########
--####################################
-- Progress bar
Config.LoadProgress = {
    Civilclothe = {
        Duration  = 5500,
        Label  = "Vetement civil en cours..",
    },
    Employerclothe = {
        Duration  = 5500,
        Label  = "Vetement employer en cours..",
    },
	Duty = {
        Duration  = 5500,
        Label  = "Service en cours..",
    },
	Cartepermisarme = {
        Duration  = 5500,
        Label  = "Création de carte en cours..",
    },
	Impound = {
        Duration  = 5500,
        Label  = "Mettre le véhicule à la fourriere",
    },
}

--############################
--########### Blips ##########
--############################

Config.SheriffStations = {

	SHERIFF = {

		Blip = {
			Coords  = vec3(1831.5538330078,3682.466796875,34.189250946045),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
			Colour  = 28,
            Name    = "Sheriff"
		},
    }
}

--############################
--############ Boss ##########
--############################
Config.Bossmenu = {
    {
        coords = vec3(1844.04, 3685.70, 38.7 -0.9),
        heading = 335.75,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Patron", 
    },
}

--##############################
--############ Coffre ##########
--##############################

Config.StashSheriff = {
    {
        coords = vec3(1838.01, 3679.50, 39.0 -0.9),
        heading = 36.01,
        icon      = "fas fa-hand-paper",
        labeltarget = "Coffre Entreprise", 
    },
}

--############################
--############ Duty ##########
--############################
Config.DutyOn = 'Vous avez pris votre service'
Config.DutyOff = 'Vous etes hors service'

--############################
--########### Garage #########
--############################
Config.Garage = {
    {
        coords = vec3(1837.6484375, 3694.9501953125, 34.287895202637 -0.9),
        heading = 23.70,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Garage", 
    },
}

Config.sheriff = {
    { nom = "Ranger véhicule", modele = "" },
    { nom = "sultan", modele = "sultan" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540255477174302/Capture_decran_2023-12-02_165926.png?ex=657dcaca&is=656b55ca&hm=988dda1c4413c3aad52ef8291038694018ae81955aee828a13357999e6dad2ad&'},
    { nom = "13fpislegacy", modele = "13fpislegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540256139878490/Capture_decran_2023-12-02_170011.png?ex=657dcaca&is=656b55ca&hm=5f05040f0ea349ccc827a799109a1cf51aa80ac620fa6913756e1265d873299a&'},
    { nom = "14chgrlegacy", modele = "14chgrlegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540256806780948/Capture_decran_2023-12-02_170050.png?ex=657dcaca&is=656b55ca&hm=e0ecdf76ea7abde9eee7e6ad96c3099113b16d6a6e2e3e421c3c0d24aa79b069&'},
    { nom = "14explegacy", modele = "14explegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540321386479706/Capture_decran_2023-12-02_170122.png?ex=657dcad9&is=656b55d9&hm=2bf1788073f05e32710162c8f52a3ae4c533e977b09948e156b835c1b3ae1c29&'},
    { nom = "18chgrlegacy", modele = "18chgrlegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540336737619998/Capture_decran_2023-12-02_170148.png?ex=657dcadd&is=656b55dd&hm=f8f0517ba70f11eac8eb006fd3f14c1713fddc3ba8dcb48daee08d92dfb0324d&'},
    { nom = "18expdlegacy", modele = "18expdlegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540352642428998/Capture_decran_2023-12-02_170222.png?ex=657dcae1&is=656b55e1&hm=f64abe66d70743e45be3d8db9b7fa0aa8cc3f1a76b4b96d657fd0dc9c5c59e4c&'},
    { nom = "20tahoelegacy", modele = "20tahoelegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540380450672770/Capture_decran_2023-12-02_170337.png?ex=657dcae8&is=656b55e8&hm=6efb52d797d4a9cf0894afe0511022550e30e77fe89207b56c24e227bdced874&'},
    { nom = "21tahoelegacy", modele = "21tahoelegacy" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540398171603024/Capture_decran_2023-12-02_170408.png?ex=657dcaec&is=656b55ec&hm=c5eec80815843a01b7993eeeee072fb07fc1732bd1db4f830d866d49b787346d&'},
    { nom = "c3harley", modele = "c3harley" , image = 'https://cdn.discordapp.com/attachments/1040480775067402252/1180540408716083241/Capture_decran_2023-12-02_170437.png?ex=657dcaee&is=656b55ee&hm=df41241bbd6ac4ca3c5acfa0eef7445c37f7afff340bfa5e41d651322c309081&'},
}

Config.SpawnVeh = {
	sheriff  = vec4(1835.6850585938, 3697.734375, 34.13489151001, 117.11875152588),
}

Config.Invincible = true 
Config.Frozen = true 
Config.Stoic = true 
Config.Fade = true
Config.PedsDistance = 20.0 
Config.MinusOne = true

Config.PedList = {
    -- ped garage  1837.6484375, 3694.9501953125, 34.287895202637, 23.706243515015
	{
		model = "s_m_m_gardener_01",
		coords = vec3(1837.6484375, 3694.9501953125, 34.287895202637),
		heading = 23.70,
		gender = "male",
		--animDict = "",
		--animName = "", 
		scenario = "WORLD_HUMAN_CLIPBOARD"
	},
}

--#################################
--############ Vetements ##########
--#################################
Config.Clothing = {
    Title = "Menu Vetements",
    OwnIcon = "fa fa-box",
    OwnDescription = "Prendre ces vetement",
    OwnLabel = "Vetement civil",
	
    EmployerIcon = "fa fa-box",
    EmployerDescription = "Prendre sont service",
    EmployerLabel = "Vetement employer",
}

Config.VetementsSheriff = {
    {
        coords = vec3(1841.5107421875, 3678.0942382812, 37.949295043945 ),
        heading = 211.39,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Vetements", 
    },
}


-- Vetements
Config.Uniforms = {
	employer = {
		male = {
			tshirt_1 = 34,  tshirt_2 = 0,
			torso_1 = 35,   torso_2 = 0,
			decals_1 = 2,   decals_2 = 3,
			arms = 4,
			pants_1 = 78,   pants_2 = 0,
			shoes_1 = 23,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
