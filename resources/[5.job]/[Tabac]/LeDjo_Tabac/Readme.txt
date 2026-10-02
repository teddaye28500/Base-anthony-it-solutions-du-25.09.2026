1 :

Rajouter les images Dans Ox_Inventoty / web / images

2 : 

Rajouter les Items Dans Ox_Inventory / Data / Items.lua 


['pacquet'] = {
		label = 'Pacquet de clope',
		weight = 1,
		stack = true,
		allowArmed = true,
	},

	['cartourche'] = {
		label = 'Cartourche De Clope',
		weight = 1,
		stack = true,
		allowArmed = true,
	},


['cigarette'] = { 
        label = 'Cigarettes',
        weight = 115,
        consume = 0.267,
        weight = 15,
        description = "Oh man, what a dingus, just Look at em",
        client = {
            anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c', flag = 49 },
            prop = { model = 'bzzz_cigarpack_cig002', 
            pos = vec3(-0.01, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0), bone = 28422 },
            disable = { move = false, car = false, combat = true },
            usetime = 16000,
        }
    },

	['tabac'] = {
		label = 'Feuille de tabac',
		weight = 160,
		stack = true,
	},

	['feuilletabac'] = {
		label = 'tabac',
		weight = 160,
		stack = true,
	},


	['shovel'] = {
		label = 'Pelle',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
