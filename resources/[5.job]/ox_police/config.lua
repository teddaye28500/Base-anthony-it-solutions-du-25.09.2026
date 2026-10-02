Config = {}
Config.Progress = "circle" -- what kind of progress bar u wanna use ? circle or bar ?
Config.NotificationType = "ox_lib" -- ESX or ox_lib

Config.PoliceCartePermisArme = "ppa" -- items de la carte permis arme
Config.EnableHandcuffTimer        = true 
Config.HandcuffTimer              = 10 * 60000 

-- Title
Config.Title = {
    police  = "Menu Garage",
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
	Cartepermisarmepolice = {
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

Config.PoliceStations = {

	POLICE = {

		Blip = {
			Coords  = vec3(460.39501953125,-996.68450927734,30.689580917358),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
			Colour  = 29,
            Name    = "Comissariat LSPD"
		},
    }
}

--############################
--############ Boss ##########
--############################
Config.Bossmenu = {
    {
        coords = vec3(447.04, -974.01, 30.4-0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Patron", 
    },
}

--##############################
--############ Coffre ########## 
--##############################

Config.StashPolice = {
    {
        coords = vec3(450.20, -993.3, 30.6 -0.9),
        coords = vec3(452.6665, -993.3670, 30.6895), 
        heading = 170.70,
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
        coords = vec3(455.63272094727, -1012.641418457, 28.428649902344),
        heading = 182.66,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Garage", 
    },
}

Config.police = {
    { nom = "Ranger véhicule", modele = "" },
    { nom = "Valor1",  modele = "police", image = "https://cdn.discordapp.com/avatars/799954906697564170/866da8341e59b15a6d4bbcc7ae7fb9e2.png?size=4096&ignore=true"},
    { nom = "Valor3",  modele = "valor3rb", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181456509813661706/Capture_decran_2023-12-05_054612.png?ex=6581201e&is=656eab1e&hm=14d0859a3d77114ad36a26f6618e142d2674e710dff573dc4dfc2d9afabaf65b&" },
    { nom = "Valor4",  modele = "Valor4rb", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181456770389004408/Capture_decran_2023-12-05_054715.png?ex=6581205c&is=656eab5c&hm=e8e1a15b8eab90087e9d55be6a744bc941e255b2751c13cc51bb1be86cfdc4d4&" },
    { nom = "Valor7",  modele = "valor7rb", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181456940820332564/Capture_decran_2023-12-05_054759.png?ex=65812085&is=656eab85&hm=02bd6fb4f12d17d8e13201b3cf30dc147c5ccd8f0d2d2d188d14979ac2b39876&"},
    { nom = "Valor8",  modele = "valor8rb", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181457113067835412/Capture_decran_2023-12-05_054840.png?ex=658120ae&is=656eabae&hm=b4fd34c72839074c33073cd28efb6f46761278885305987fb42d627d8b377b2f&" },
    { nom = "Valor9",  modele = "valor9rb", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181457303371792444/Capture_decran_2023-12-05_054926.png?ex=658120db&is=656eabdb&hm=8f0cb9bbcb098f0815e363eba29a1f114d09d8c646887f943d93c11bc7aa3197&" },
    { nom = "Valor10",  modele = "valor10rb", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181457963995635722/Capture_decran_2023-12-05_055159.png?ex=65812179&is=656eac79&hm=3763808d95901c9bac13c1f0405754c35b6a145a1fab6741f6f1f1e244cedbee&" },
    { nom = "Moto",  modele = "c3bmwbike", image = "https://cdn.discordapp.com/attachments/1040480775067402252/1181458189640798218/Capture_decran_2023-12-05_055255.png?ex=658121ae&is=656eacae&hm=6275051968b7c9465ea868ba1c459bf061fdd39069c640522f2a3cd5f24cac61&" },        
}

Config.SpawnVeh = {
	police  = vec4(453.73901367188, -1019.6408691406, 28.375080108643, 91.164077758789),
}

Config.Invincible = true 
Config.Frozen = true 
Config.Stoic = true 
Config.Fade = true
Config.PedsDistance = 20.0 
Config.MinusOne = true

Config.PedList = {
    -- ped garage  455.63272094727, -1012.641418457, 28.428649902344, 182.66
	{
		model = "s_m_m_gardener_01",
		coords = vec3(455.63272094727, -1012.641418457, 28.428649902344),
		heading = 182.66,
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

Config.VetementsPolice = {
    {
        coords = vec3(461.64, -995.45, 30.6 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Vetements", 
    },
}


-- Vetements
Config.Uniforms = {
	employer = {
		male = {
			tshirt_1 = 34,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 3,
			arms = 33,
			pants_1 = 215,   pants_2 = 0,
			shoes_1 = 126,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 61,    chain_2 = 0,
            bproof_1 = 18,  bproof_2 = 0,
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
            bproof_1 = 13,  bproof_2 = 1,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 18,  bproof_2 = 4
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		},
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
