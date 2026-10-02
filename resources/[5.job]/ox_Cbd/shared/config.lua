Config = {
	title = {
		GarageCbd = "Garage | Cbd", -- Titre menu garage
	},
	cars = {
		GarageCbd = {
			{ nom = "Ranger le vehicule", modele = "" },
			{ nom = "Vehicule patron", modele = "rapidgt" },
			{ nom = "Vehicule employers", modele = "burrito8" }, -- Modèle de véhicule du garage (Nom qui apparait dans le menu + modèle de spawn)
		},
	},
	Plate = {
		GarageCbd = "cbd", -- 4 premières lettres de la plaque du véhicule du garage
	},
	SpawnVeh = {
		GarageCbd = vector4(197.14938354492, -265.08374023438, 50.474182128906, 203.63427734375), -- Spawn du véhicule
	},

-- MENU BOSS

bosscbd = {

    x = 182.71424865723,
    y = -250.65927124023,
    z = 54.07048034668

},

-- ANNONCE

--ouvert
announceouvert = {
	Cbd = '🌿💨 Le shop CBD ouvre ses portes ! Venez découvrir nos meilleurs produits pour une détente absolue ! 🔥🛒'
},

--fermer
announcefermer = {
	Cbd = '⏳🌿 Le shop CBD ferme ses portes ! Merci à tous et à bientôt pour un moment de relaxation unique ! 🍃💨'
},

--recrutement
announcerecrutement = {
	Cbd = '📢🌱 Le shop CBD recrute ! Passionné par le bien-être et la nature ? Rejoins notre équipe et fais découvrir nos meilleurs produits ! 💚💨'
},

	Blips = {
		Cbd = { -- Possibilité de changer le nom du blip dans le cl_vigneron.lua
			Pos = vector3(194.5492401123, -242.64199829102, 65.73543548584),           
			Sprite = 469,
			Display = 4,
			Scale = 0.6,
			Colour = 24,
		},
		--Recolte1 = { -- Possibilité de changer le nom du blip dans le cl_vigneron.lua
		--	Pos = vector3(45.63948059082,2918.1887207031,55.748115539551),
		--	Sprite = 1,
			--Display = 4,
		--	Scale = 0.3,
		--	Colour = 24,
	--},
		--Recolte2 = { -- Possibilité de changer le nom du blip dans le cl_vigneron.lua
	--	Pos = vector3(58.994590759277,2905.9956054688,56.507507324219),
		--Sprite = 1,
	--	Display = 4,
	--	Scale = 0.3,
		--Colour = 24,
--},
		--Traitement = { -- Possibilité de changer le nom du blip dans le cl_vigneron.lua
		--Pos = vector3(-57.863742828369,2912.669921875,60.099117279053),
	--	Sprite = 1,
		--Display = 4,
		--Scale = 0.3,
	--	Colour = 24,
--},
		Vente = { -- Possibilité de changer le nom du blip dans le cl_vigneron.lua
		Pos = vector3(-1168.6036376953,-1572.8452148438,4.663622379303),
		Sprite = 1,
		Display = 4,
		Scale = 0.3,
		Colour = 2,
},
	},
	Uniforms = { -- Tenue de travail
		cbd_wear = {
			male = {
				tshirt_1 = 15, tshirt_2 = 0,
				torso_1 = 7, torso_2 = 0,
				decals_1 = 0, decals_2 = 0,
				arms = 20,
				pants_1 = 10, pants_2 = 0,
				shoes_1 = 9, shoes_2 = 0,
				helmet_1 = -1, helmet_2 = 0,
				chain_1 = 0, chain_2 = 0,
				ears_1 = -1, ears_2 = 0,
			},
			female = {
				tshirt_1 = 15, tshirt_2 = 0,
				torso_1 = 27, torso_2 = 5,
				decals_1 = 0, decals_2 = 0,
				arms = 0,
				pants_1 = 23, pants_2 = 6,
				shoes_1 = 6, shoes_2 = 0,
				helmet_1 = -1, helmet_2 = 0,
				chain_1 = 0, chain_2 = 0,
				ears_1 = -1, ears_2 = 0,
			},
		},
	},
}
