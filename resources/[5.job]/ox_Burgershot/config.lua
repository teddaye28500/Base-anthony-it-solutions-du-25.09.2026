Config = {}

Config.Framework        = "ESX"
Config.NotificationType = "ESX"  ---- ESX or ox_lib
Config.Progress         = "ox_lib_bar" 
Config.OfflineBurger = 100
Config.OfflineCroquette = 1 
Config.OfflinePoutine = 1 
Config.OfflinePepper = 1 
Config.OfflineLiqueur = 1 
Config.OfflineJusOrange = 1 
Config.OfflineSandwitch = 1 
Config.OfflineFrites = 1 

Config.BurgershotStations = {

	BURGERSHOT = {

		Blip = {
			Coords  = vector3(-1182.5528564453, -884.38006591797, 13.51708984375),
			Sprite  = 106,
			Display = 4,
			Scale   = 0.5,
			Colour  = 1,
            Name    = "Burgershot"
		},
    }
}


-- Config Achat 

Config.achatburgershot = {

	x = -1196.096680,
	y = -902.254944,
	z = 13.879150,

}

-- PRIX

Config.prix = {

	sauce = 5,
	fromage = 5,
	poulet = 10,
	boulette = 10,
	salade = 5,
	ketchup = 5,
	bacon = 9,
	beurre = 5,
	patate = 5,
	glaces = 5,
	sponge = 2,
}

Config.Progress_bar = {
    LavageMain = {
        Label    = "Lavement des mains",
        Duration = 7500,
    },
    LavageSponge = {
        Label    = "Lavement de l'éponge",
        Duration = 2000,
    },
    LavageServiette = {
        Label    = "Lavement de la serviette",
        Duration = 2000,
    },
    CuissonBurger = {
        Label    = "Cuisson en cours",
        Duration = 10000,
    },
    CuissonMenuburger = {
        Label    = "Cuisson en cours",
        Duration = 10000,
    },
    CuissonClubsandwitch = {
        Label    = "Cuisson en cours",
        Duration = 10000,
    },
    FriteuseFrites = {
        Label    = "Préparation des frites en cours",
        Duration = 2000,
    },
    FriteusePoutine = {
        Label    = "Préparation de la poutine en cours",
        Duration = 10000,
    },
    BoissonLoad = {
        Label    = "Préparation de la boisson en cours",
        Duration = 2000,
    },
    FriteuseCroquette = {
        Label    = "Préparation de la croquette en cours",
        Duration = 10000,
    },
    WashingTable = {
        Label    = "Entrain de nettoyer la table",
        Duration = 5000,
    },
    Peeing = {
        Label    = "Entrain de pisser",
        Duration = 5000,
    },
    Washingfloor = {
        Label    = "Entrain de laver le plancher",
        Duration = 10000,
    },
    Washingface = {
        Label    = "Entrain de laver votre visage",
        Duration = 10000,
    },
    Cutting = {
        Label    = "Entrain de couper des légumes",
        Duration = 10000,
    },
    Buy = {
        Label    = "Merci pour votre commande",
        Duration = 10000,
    },
}

-- Title
Config.Title = {
    Lavage      = "Menu Lavage",
    Cuisson     = "Menu Cuisson",
    Friteuse    = "Menu Friteuse",
    Main        = "Lavage des mains",
    Sponge      = "Lavage de l'éponge",
    Serviette   = "Lavage de la serviette",
    Burger      = "Burger",
    Menuburger  = "Menu Burger",
    Frites      = "Frites",
    Toilet      = "Menu Toilette",
    Pee         = "Toilette",
    Boisson     = "Menu Boisson",
    Jus         = "Jus d'orange",
    WashingFace = "Menu Visage",
    Face        = "Laver votre visage",
    TrashCan    = "Poubelle",
    burgershot  = "Menu Garage",
    Legumes     = "Menu Légumes",
    Salade      = "Salade",
    Stash       = "Coffre Entreprise",
    Commands    = "Commande du burgershot",
    Offline     = "Burgershot hors ligne",
    Water       = "Water",
    Poutine     = "Poutine",
    Croquette   = "Croquette",
    Liqueur     = "Liqueur",
    Coca        = "Coca",
    Pepper      = "Pepper",
    Sandwitch   = "Sandwitch",
    Poulet      = "Poulet",
    Onion       = "Onion",
    Boulette    = "Boulette",
    WashingHands = "Laver les mains",
    OPoutine    = "Poutine",
    Clubsandwich = "Club Sandwitch",
    OFrites      = "Frites",
    OPepper     = "Pepper",
    OLiqueur    = "Liqueur",
    OJusorange  = "Jus d'orange",
    OCroquette  = "Croquette",
}

-- Description
Config.description = {
    LavageSponge     = "Lavez l'éponge sale",
    LavageServiette  = "Lavez la serviette sale",
    CuissonBurger    = "[1] Boulette, [1] Salade Couper, [1] Ketchup",
    CuissonMenuburger   = "[1] Burger, [1] Frite, [1] Coca",
    CuissonSandwitch = "[1] Poulet Couper, [1] Bacon, [1] Beurre",
    FriteuseFrites   = "[1] Patate",
    FriteusePoutine  = "[1] Frites, [1] Fromage, [1] Sauce",
    FriteuseCroquette = "[1] Poulet",
    BoissonJus       = "[1] Glace",
    BoissonLiqueur    = "[1] Glace",
    BoissonCoca    = "[1] Glace",
    BoissonPepper    = "[1] Glace",
    DSalade          = "Couper la salade en morceau",
    DPoulet          = "Couper le poulet en morceau",
    DOnion           = "Couper l'onion en morceau",
    DBoulette        = "Préparer la boulette",
    OCroquette       = "Prix: "..Config.OfflineCroquette.. "$",
    OPoutine         = "Prix: "..Config.OfflinePoutine.. "$",
    OPepper          = "Prix: "..Config.OfflinePepper.. "$",
    OLiqueur         = "Prix: "..Config.OfflineLiqueur.. "$",
    OJusorange       = "Prix: "..Config.OfflineJusOrange.. "$",
    Clubsandwich     = "Prix: "..Config.OfflineSandwitch.. "$",
    OFrites          = "Prix: "..Config.OfflineFrites.. "$",
    OBurger          = "Prix: "..Config.OfflineBurger.. "$",
}

--- Coords
Config.Lavage = {
    {
        coords = vec3(-1202.3240966797, -899.15887451172, 13.802121162415 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Lavage", 
    },
}

Config.Cuisson = {
    {
        coords = vec3(-1195.484375, -897.48095703125, 13.897825241089 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Cuisson", 
    },
}

Config.Friteuse = {
    {
        coords = vec3(-1196.2281494141, -899.75213623047, 13.798212051392 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Friteuse", 
    },
}

Config.Boisson = {
    {
        coords = vec3(-1191.064453125, -898.76165771484, 14.320537567139 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Boisson", 
    },
}

Config.Legumes = {
    {
        coords = vec3(-1200.7766113281, -895.11010742188, 13.798721313477 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Légumes", 
    },
}

Config.Garage = {
    {
        coords = vec3(-1196.2798, -908.2723, 13.8345 -0.9),
        heading = 69.3411,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Garage", 
    },
}

Config.Bossmenu = {
    {
        coords = vec3(-1200.423828125, -902.51794433594, 13.324568748474 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Patron", 
    },
}

Config.StashBurgershot = {
    {
        coords = vec3(-1196.5043945313, -901.05450439453, 14.148693084717 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Coffre Entreprise", 
    },
}

Config.Commands = {
    {
        coords = vec3(-1196.7849121094, -892.86950683594, 14.073156356812 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Commande du burgershot", 
    },
}

Config.Billing = {
    {
        coords = vec3(-1191.46484375, -894.15472412109, 14.071376800537 -0.9),
        heading = 243.77,
        icon      = "fas fa-hand-paper",
        labeltarget = "Facture du burgershot", 
    },
}

Config.OfflineStore = {
    {
        coords = vec3(9999, 9999, 9999 -0.9),
        heading = 0,
        icon      = "fas fa-hand-paper",
        labeltarget = "Burgershot hors ligne", 
    },
}

Config.WashingTable = {
    {
        icon      = "fas fa-hand-paper",
        labeltarget = "Lavage de la table", 
    },
}

Config.Washingface = {
    {
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Lavage", 
    },
}

Config.Toilet = {
    {
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Toilet", 
    },
}

Config.Plancher = {
    {
        icon      = "fas fa-hand-paper",
        labeltarget = "Laver le plancher", 
    },
}

Config.Trash = {
    {
        icon      = "fas fa-hand-paper",
        labeltarget = "Ouvrir la poubelle", 
    },
}

Config.burgershot = {
    { nom = "Ranger véhicule", modele = "" },
    { nom = "vehicule entreprise",           modele = "sultan" },

}

Config.SpawnVeh = {
	burgershot  = vec4(-1200.3804, -909.1360, 13.2202, 34.7213),
}

-- Crafting
Config.AddItem = 1 
Config.Crafting = {
    ['burger'] = {
        requiredItems = {
            { name = 'boulette', label = 'Boulette', amount = 1 },
            { name = 'saladecouper', label = 'Salade Couper', amount = 1 },
            { name = 'ketchup', label = 'Ketchup', amount = 1 },
        },
        label = 'Burger',
    },
    ['menuburger'] = {
        requiredItems = {
            { name = 'burger', label = 'Burger', amount = 1 },
            { name = 'frites', label = 'Frite', amount = 1 },
            { name = 'coca', label = 'Coca Cola', amount = 1 },
        },
        label = 'Menu Classique',
    },
    ['clubsandwitch'] = {
        requiredItems = {
            { name = 'pouletcouper', label = 'Poulet Couper', amount = 1 },
            { name = 'bacon', label = 'Bacon', amount = 1 },
            { name = 'beurre', label = 'Beurre', amount = 1 },
        },
        label = 'Club Sandwitch',
    },
    ['frites'] = {
        requiredItems = {
            { name = 'patate', label = 'Patate', amount = 1 },
        },
        label = 'Frites',
    },
    ['poutine'] = {
        requiredItems = {
            { name = 'frites', label = 'Frites', amount = 1 },
            { name = 'sauce', label = 'Sauce', amount = 1 },
            { name = 'fromage', label = 'Fromage', amount = 1 },
        },
        label = 'Poutine',
    },
    ['croquette'] = {
        requiredItems = {
            { name = 'poulet', label = 'Poulet', amount = 1 },
        },
        label = 'Croquette',
    },
    ['jusorange'] = {
        requiredItems = {
            { name = 'glaces', label = 'Glaces', amount = 1 },
        },
        label = 'Jus d\'orange',
    },
    ['pepper'] = {
        requiredItems = {
            { name = 'glaces', label = 'Glaces', amount = 1 },
        },
        label = 'Pepper',
    },
    ['coca'] = {
        requiredItems = {
            { name = 'glaces', label = 'Glaces', amount = 1 },
        },
        label = 'Coca',
    },
    ['liqueur'] = {
        requiredItems = {
            { name = 'glaces', label = 'Glaces', amount = 1 },
        },
        label = 'Liqueur',
    }
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
		model = "mp_m_securoguard_01",
		coords = vector3(-1196.2640, -908.3015, 13.8345),
		heading = 73.5728,
		gender = "male",
		--animDict = "",
		--animName = "", 
		scenario = "WORLD_HUMAN_CLIPBOARD"
	},
    -- ped offline store
    {
		model = "a_m_m_fatlatin_01",
		coords = vector3(-1196.2640, -908.3015, 99999),
		heading = 73.5728,
		gender = "male",
		--animDict = "",
		--animName = "", 
		scenario = "PROP_HUMAN_SEAT_CHAIR_FOOD"
	},
}


Config.Uniforms = {
    burgerpatron_wear = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 150,   ['torso_2'] = 0,
            ['decals_1'] = 28,   ['decals_2'] = 0,
           ['arms'] = 0,
            ['pants_1'] = 28,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
           ['helmet_1'] = 26,  ['helmet_2'] = 0,
           ['chain_1'] = 37,    ['chain_2'] = 0,
           ['ears_1'] = 33,     ['ears_2'] = 0
       },

        female = {
     ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
     ['torso_1'] = 0,   ['torso_2'] = 0,
     ['decals_1'] = 28,   ['decals_2'] = 0,
    ['arms'] = 0,
     ['pants_1'] = 28,   ['pants_2'] = 0,
     ['shoes_1'] = 10,   ['shoes_2'] = 0,
    ['helmet_1'] = 26,  ['helmet_2'] = 0,
    ['chain_1'] = 37,    ['chain_2'] = 0,
    ['ears_1'] = 33,     ['ears_2'] = 0
       },
   },
   burgermanager_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 78,   ['torso_2'] = 0,
        ['decals_1'] = 28,   ['decals_2'] = 0,
       ['arms'] = 0,
        ['pants_1'] = 50,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
       ['helmet_1'] = 26,  ['helmet_2'] = 0,
       ['chain_1'] = 37,    ['chain_2'] = 0,
       ['ears_1'] = 33,     ['ears_2'] = 0
   },

    female = {
 ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 ['torso_1'] = 0,   ['torso_2'] = 0,
 ['decals_1'] = 28,   ['decals_2'] = 0,
['arms'] = 0,
 ['pants_1'] = 36,   ['pants_2'] = 0,
 ['shoes_1'] = 10,   ['shoes_2'] = 0,
['helmet_1'] = 26,  ['helmet_2'] = 0,
['chain_1'] = 37,    ['chain_2'] = 0,
['ears_1'] = 33,     ['ears_2'] = 0
   },
},
burgeremployer_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 50,   ['torso_2'] = 0,
        ['decals_1'] = 28,   ['decals_2'] = 0,
       ['arms'] = 0,
        ['pants_1'] = 28,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
       ['helmet_1'] = 26,  ['helmet_2'] = 0,
       ['chain_1'] = 37,    ['chain_2'] = 0,
       ['ears_1'] = 33,     ['ears_2'] = 0
   },

    female = {
 ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 ['torso_1'] = 50,   ['torso_2'] = 0,
 ['decals_1'] = 28,   ['decals_2'] = 0,
['arms'] = 0,
 ['pants_1'] = 85,   ['pants_2'] = 0,
 ['shoes_1'] = 10,   ['shoes_2'] = 0,
['helmet_1'] = 26,  ['helmet_2'] = 0,
['chain_1'] = 37,    ['chain_2'] = 0,
['ears_1'] = 33,     ['ears_2'] = 0
   },
},
burgerinterimaire_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 10,   ['torso_2'] = 0,
        ['decals_1'] = 28,   ['decals_2'] = 0,
       ['arms'] = 0,
        ['pants_1'] = 88,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
       ['helmet_1'] = 26,  ['helmet_2'] = 0,
       ['chain_1'] = 37,    ['chain_2'] = 0,
       ['ears_1'] = 33,     ['ears_2'] = 0
   },

    female = {
 ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 ['torso_1'] = 0,   ['torso_2'] = 0,
 ['decals_1'] = 28,   ['decals_2'] = 0,
['arms'] = 0,
 ['pants_1'] = 28,   ['pants_2'] = 0,
 ['shoes_1'] = 10,   ['shoes_2'] = 0,
['helmet_1'] = 26,  ['helmet_2'] = 0,
['chain_1'] = 37,    ['chain_2'] = 0,
['ears_1'] = 33,     ['ears_2'] = 0
   },
},
}