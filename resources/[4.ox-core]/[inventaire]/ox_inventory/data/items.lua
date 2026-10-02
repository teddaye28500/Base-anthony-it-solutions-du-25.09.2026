return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['mask'] = {
		label = 'Masque',
		weight = 100,
		stack = false,
	},

	['hat'] = {
		label = 'Chapeau',
		weight = 100,
		stack = false,
	},

	['earrings'] = {
		label = 'Boucles d\'oreilles',
		weight = 100,
		stack = false,
	},

	['glasses'] = {
		label = 'Lunettes',
		weight = 100,
		stack = false,
	},

	['chain'] = {
		label = 'Chaîne',
		weight = 100,
		stack = false,
	},

	['undershirt'] = {
		label = 'Maillot de corps',
		weight = 100,
		stack = false,
	},

	['jacket'] = {
		label = 'Veste',
		weight = 100,
		stack = false,
	},

	['bodyarmor'] = {
		label = 'Gilet pare-balles',
		weight = 100,
		stack = false,
	},

	['bracelet'] = {
		label = 'Bracelet',
		weight = 100,
		stack = false,
	},

	['watch'] = {
		label = 'montre',
		weight = 100,
		stack = false,
	},

	['bag'] = {
		label = 'Sac',
		weight = 100,
		stack = false,
	},

	['pants'] = {
		label = 'Pantalon',
		weight = 100,
		stack = false,
	},

	['shoes'] = {
		label = 'Chaussures',
		weight = 100,
		stack = false,
	},

	['gloves'] = {
		label = 'Gants',
		weight = 100,
		stack = false,
	},

    ['id_card'] = {
		label = 'ID card',
	},

	['license_drive'] = {
		label = 'Driving license',
	},

	['license_weapon'] = {
		label = 'Weapon license',
	},

	['contract'] = {
		label = 'Contract',
		weight = 100,
		stack = true
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['coffee'] = {
		label = 'café',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'p_amb_coffeecup_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Vous avez étanché votre soif avec du café'
		}
	},	

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['chiffon'] = { label = 'Chiffon', weight = 100, stack = true, close = true },
	['scanner'] = { label = 'Scanner', weight = 200, stack = true, close = true },

	-- Entretien
	['oil'] = { label = 'Huile moteur', weight = 200, stack = true, close = true },
	['tires'] = { label = 'Pneus', weight = 500, stack = true, close = true },
	['brake_pads'] = { label = 'Plaquettes de frein', weight = 200, stack = true, close = true },
	['transmission_oil'] = { label = 'Huile de boîte', weight = 200, stack = true, close = true },
	['shock_absorber'] = { label = 'Amortisseurs', weight = 300, stack = true, close = true },
	['shocks'] = { label = 'Amortisseurs', weight = 300, stack = true, close = true },
	['clutch'] = { label = 'Embrayage', weight = 300, stack = true, close = true },
	['air_filter'] = { label = 'Filtre à air', weight = 100, stack = true, close = true },
	['fuel_filter'] = { label = 'Filtre à carburant', weight = 100, stack = true, close = true },
	['spark_plugs'] = { label = 'Bougies', weight = 50, stack = true, close = true },
	['serpentine_belt'] = { label = 'Courroie de distribution', weight = 150, stack = true, close = true },

	-- Réparations
	['piston'] = { label = 'Piston', weight = 150, stack = true, close = true },
	['rod'] = { label = 'Bielle', weight = 150, stack = true, close = true },
	['gear'] = { label = 'Pignon', weight = 150, stack = true, close = true },
	['iron'] = { label = 'Fer', weight = 200, stack = true, close = true },
	['aluminum'] = { label = 'Aluminium', weight = 150, stack = true, close = true },
	['brake_discs'] = { label = 'Disques de frein', weight = 300, stack = true, close = true },
	['brake_caliper'] = { label = 'Étrier de frein', weight = 250, stack = true, close = true },
	['springs'] = { label = 'Ressorts', weight = 200, stack = true, close = true },

	-- Améliorations
	['susp'] = { label = 'Suspension très basse', weight = 400, stack = true, close = true },
	['susp1'] = { label = 'Suspension basse', weight = 400, stack = true, close = true },
	['susp2'] = { label = 'Suspension sport', weight = 400, stack = true, close = true },
	['susp3'] = { label = 'Suspension confort', weight = 400, stack = true, close = true },
	['susp4'] = { label = 'Suspension haute', weight = 400, stack = true, close = true },
	['turbo'] = { label = 'Turbo', weight = 400, stack = true, close = true },
	['garett'] = { label = 'Turbo Garett', weight = 400, stack = true, close = true },
	['engine1'] = { label = 'Moteur stage 1', weight = 800, stack = true, close = true },
	['engine2'] = { label = 'Moteur stage 2', weight = 800, stack = true, close = true },
	['engine3'] = { label = 'Moteur stage 3', weight = 800, stack = true, close = true },
	['engine4'] = { label = 'Moteur stage 4', weight = 800, stack = true, close = true },
	['trans1'] = { label = 'Transmission stage 1', weight = 700, stack = true, close = true },
	['trans2'] = { label = 'Transmission stage 2', weight = 700, stack = true, close = true },
	['trans3'] = { label = 'Transmission stage 3', weight = 700, stack = true, close = true },
	['trans4'] = { label = 'Transmission stage 4', weight = 700, stack = true, close = true },
	['brake1'] = { label = 'Freins stage 1', weight = 500, stack = true, close = true },
	['brake2'] = { label = 'Freins stage 2', weight = 500, stack = true, close = true },
	['brake3'] = { label = 'Freins stage 3', weight = 500, stack = true, close = true },
	['brake4'] = { label = 'Freins stage 4', weight = 500, stack = true, close = true },
	['nitrous'] = { label = 'Nitro', weight = 300, stack = true, close = true },
	['awd'] = { label = 'Conversion en 4 roues motrices', weight = 300, stack = true, close = true },
	['rwd'] = { label = 'Conversion en propulsion', weight = 300, stack = true, close = true },
	['fwd'] = { label = 'Conversion en traction', weight = 300, stack = true, close = true },
	['semislick'] = { label = 'Pneus semi-slick', weight = 400, stack = true, close = true },
	['slick'] = { label = 'Pneus slick', weight = 400, stack = true, close = true },
	['race_brakes'] = { label = 'Freins Brembo', weight = 400, stack = true, close = true },

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Mastercard',
		stack = false,
		weight = 10,
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	["stretcher"] = {
		label = "stretcher",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutter"] = {
		label = "cutter",
		weight = 1,
		stack = true,
		close = true,
	},

	["headbag"] = {
		label = "headbag",
		weight = 1,
		stack = true,
		close = true,
	},

	["zipties"] = {
		label = "zipties",
		weight = 1,
		stack = true,
		close = true,
	},
	
	["jewels"] = {
		label = "bijoux",
		weight = 25,
		stack = true,
		close = true,
	},	

    ['tomato'] = {
		label = 'Tamato',
		weight = 70,
		client = {
			status = { hunger = 20000 },
			anim = 'eating',
			usetime = 2500,
			notification = 'You ate a delicious Tomato'
		},
	},

	['mango'] = {
		label = 'Mango',
		weight = 200,
		client = {
			status = { hunger = 50000 },
			anim = 'eating',
			usetime = 2500,
			notification = 'You ate a delicious Mango'
		},
	},

	['orange'] = {
		label = 'Orange',
		weight = 200,
		client = {
			status = { hunger = 50000 },
			anim = 'eating',
			usetime = 2500,
			notification = 'You ate a delicious Orange'
		},
	},

	['apple'] = {
		label = 'Apple',
		weight = 200,
		client = {
			status = { hunger = 50000 },
			anim = 'eating',
			usetime = 2500,
			notification = 'You ate a delicious Apple'
		},
	},

	['gauva'] = {
		label = 'Gauva',
		weight = 200,
		client = {
			status = { hunger = 50000 },
			anim = 'eating',
			usetime = 2500,
			notification = 'You ate a delicious Gauva'
		},
	},

	['orangejuice'] = {
		label = 'Orange Juice',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drinks a delicious Orange Juice'
		}
	},

	['mangojuice'] = {
		label = 'Mango Juice',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drinks a delicious Mango Juice'
		}
	},

	['applejuice'] = {
		label = 'Apple Juice',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drinks a delicious Apple Juice'
		}
	},

	['gauvajuice'] = {
		label = 'Gauva Juice',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You drinks a delicious Gauva Juice'
		}
	},

	['applewine'] = {
		label = 'Apple Wine',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_amb_beer_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Im Drunk'
		}
	},

	['orangewine'] = {
		label = 'Orange Wine',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_amb_beer_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Im Drunk'
		}
	},

	['gauvawine'] = {
		label = 'Gauva Wine',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_amb_beer_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Im Drunk'
		}
	},
	['mangowine'] = {
		label = 'Mango Wine',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_amb_beer_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Im Drunk'
		}
	},

	['tomato_ketchup'] = {
		label = 'Tamato Ketchup',
		weight = 250,
	},
	['tomato_paste'] = {
		label = 'Tamato Paste',
		weight = 250,
	},
	
		['medikit'] = { -- Make sure not already a medikit
			label = 'Medikit',
			weight = 165,
			stack = true,
			close = true,
		},
		['medbag'] = {
			label = 'Medical Bag',
			weight = 165,
			stack = false,
			close = true,
		},
	
		['tweezers'] = {
			label = 'Tweezers',
			weight = 2,
			stack = true,
			close = true,
		},
	
		['suturekit'] = {
			label = 'Suture Kit',
			weight = 15,
			stack = true,
			close = true,
		},
	
		['icepack'] = {
			label = 'Ice Pack',
			weight = 29,
			stack = true,
			close = true,
		},
	
		['burncream'] = {
			label = 'Burn Cream',
			weight = 19,
			stack = true,
			close = true,
		},
	
		['defib'] = {
			label = 'Defibrillator',
			weight = 225,
			stack = false,
			close = true,
		},
	
		['sedative'] = {
			label = 'Sedative',
			weight = 15,
			stack = true,
			close = true,
		},
	
		['stretcher'] = {
			label = 'Stretcher',
			weight = 650,
			stack = false,
			close = true,
		},
	
		['wheelchair'] = {
			label = 'Wheel Chair',
			weight = 650,
			stack = false,
			close = true,
		},
	
		['recoveredbullet'] = {
			label = 'Recovered Bullet',
			weight = 1,
			stack = true,
			close = false,
		},
		
		['redbull'] = {
		label = 'Redbull',
		weight = 20,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
		}
	},

['vodka'] = {
	label = 'Vodka',
	weight = 20,
	client = {
		status = { thirst = 200000 },
		anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
		prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
		usetime = 2500,
		cancel = true,
	}
},

["hacker_laptop"] = {
    label = "PC de pirate",
    weight = 1500,
    stack = false
},

["cleusb"] = {
    label = "Clé usb Hacker",
    weight = 1500,
    stack = false
},

["thermal_charge"] = {
    label = "Charge thermique",
    weight = 300,
    stack = false
},

    ['tequilla'] = {
		label = 'Tequilla',
		weight = 20,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu une Tequilla el fucker'
		},
	},

    ['cocktail'] = {
		label = 'cocktail',
		weight = 20,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_paper_cup`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu un cocktail'
		},
	},

    ['jagerbomb'] = {
		label = 'Jager Bomb',
		weight = 20,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu un Jager Bomb el fucker'
		},
	},

    ['champagne'] = {
		label = 'Champagne',
		weight = 20,
		client = {
			status = { thirst = 2000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu un Champagne el fucker'
		},
	},

    ['raisinrouge'] = {
		label = 'Raisin rouge',
		weight = 100,
		stack = true,
	},
	
	['raisinblanc'] = {
		label = 'Raisin blanc',
		weight = 100,
		stack = true,
	},	
		
	['raisinrougepressage'] = {
		label = 'Raisin rouge presser',
		weight = 150,
		stack = true,
	},

	['raisinblancpressage'] = {
		label = 'Raisin blanc presser',
		weight = 150,
		stack = true,
	},
	
	['vinrouge'] = {
		label = 'Vin rouges',
		weight = 200,
		stack = true,
	},	
	
	['vinblanc'] = {
		label = 'Vin blancs',
		weight = 200,
		stack = true,
	},
	
    ['farine'] = { 
		label = 'Farine',
		weight = 50,
	},

	['jusorange'] = { 
		label = 'Jus Orange',
		weight = 50,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bs_cup`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'Tu as bu un jus Orange rafra�chissante'
		}
	},

	['pepper'] = { 
		label = 'Pepper',
		weight = 50,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bs_cup`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'Tu as bu un Pepper rafra�chissante'
		}
		
	},

	['sauce'] = { 
		label = 'Sauce',
		weight = 50,
	},

	['frites'] = { 
		label = 'Frites',
		weight = 50,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'prop_food_bs_chips',
			usetime = 1500,
			notification = 'Tu as mang� une d�licieuse Frite '
		},
	},

	['fromage'] = { 
		label = 'Fromage',
		weight = 50,
	},

	['poulet'] = { 
		label = 'Poulet',
		weight = 50,
	},

	['boulette'] = { 
		label = 'Boulette',
		weight = 50,
	},

	['saladecouper'] = { 
		label = 'Salade Couper',
		weight = 50,
	},

	['salade'] = { 
		label = 'Salade',
		weight = 50,
	},

	['steakhacher'] = { 
		label = 'Steak Hacher',
		weight = 50,
	},

	['pouletcouper'] = { 
		label = 'Morceau de Poulet',
		weight = 50,
	},

	['ketchup'] = { 
		label = 'Ketchup',
		weight = 50,
	},

	['bacon'] = { 
		label = 'Bacon',
		weight = 50,
	},

	['beurre'] = { 
		label = 'Beurre',
		weight = 50,
	},

	['patate'] = { 
		label = 'Patate',
		weight = 50,
	},

	['clubsandwitch'] = { 
		label = 'Club Sandwitch',
		weight = 50,
		client = {
			status = { hunger = 400000 },
			anim = 'eating',
			prop = 'prop_sandwich_01',
			usetime = 2500,
			notification = 'Tu as mang� un d�licieux Sandwich'
		},
	},

	['burito'] = { 
		label = 'Burito',
		weight = 50,
		client = {
			status = { hunger = 700000 },
			anim = 'eating',
			prop = 'prop_sandwich_01',
			usetime = 2500,
			notification = 'Tu as mang� une d�licieuse Bourito '
		},
	},

	['poutine'] = { 
		label = 'Poutine',
		weight = 50,
		client = {
			status = { hunger = 600000 },
			anim = 'eating',
			prop = 'prop_sandwich_01',
			usetime = 2500,
			notification = 'Tu as mang� une d�licieuse Poutine '
		},
	},

	['croquette'] = { 
		label = 'Croquette',
		weight = 50,
		client = {
			status = { hunger = 500000 },
			anim = 'eating',
			prop = 'prop_sandwich_01',
			usetime = 2500,
			notification = 'Tu as mang� une d�licieuse Poutine '
		},
	},

	['menuburger'] = { 
		label = 'Menu Classique',
		weight = 50,
		client = {
			status = { hunger = 1500000, thirst = 400000 },
			anim = 'eating',
			prop = 'prop_sandwich_01',
			usetime = 2500,
			notification = 'Tu as mang� un D�licieux Menu '
		},
	},

	['liqueur'] = { 
		label = 'Liqueur',
		weight = 50,
		client = {
			status = { thirst = 400000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_bs_cup`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'Tu as bu un liqueur rafra�chissante'
		}
	},

	['glaces'] = { 
		label = 'Glacon',
		weight = 50,
	},
	['sponge'] = { 
        label = '�ponge',
        weight = 50,
    },
    ['spongedirty'] = { 
        label = '�ponge sale',
        weight = 50,
    },
	
    ["feuillecbdb"] = {
		label = "Feuille de cbd dream",
		weight = 1,
		stack = true,
		close = true,
    },
	
    ["feuillecbdk"] = {
		label = "Feuille de cbd kush ",
		weight = 1,
		stack = true,
		close = true,
    },
	
    ["banana_kush_bag"] = {
		label = "Banana Kush Cbd",
		weight = 1,
		stack = true,
		close = true,
    },
	
	["banana_kush_joint"] = {
		label = "joint de Banana Lush ",
		weight = 1,
		stack = true,
		close = true,
    },
	
	["blue_dream_bag"] = {
		label = "Blue Dream Cbd",
		weight = 1,
		stack = true,
		close = true,
    },
	
	["blue_dream_joint"] = {
		label = "joint de Blue Dream ",
		weight = 1,
		stack = true,
		close = true,
    },

    ['biere'] = {
		label = 'Biere',
		weight = 220,
		client = {
			status = { drunk = 50000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_amb_beer_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu une biere'
		},
	},
	
	['whisky'] = {
		label = 'whisky',
		weight = 220,
		client = {
			status = { drunk = 50000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu un whisky el fucker'
		},
	},

    ['jagerbomb'] = {
		label = 'Jager Bomb',
		weight = 220,
		client = {
			status = { drunk = 50000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu un Jager Bomb el fucker'
		},
	},

    ['sangria'] = {
		label = 'Sangria',
		weight = 220,
		client = {
			status = { drunk = 50000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_whiskey_bottle`, pos = vec3(0.01, 0.01, 0.01), rot = vec3(-5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu bu une Sagria el fucker'
		},
	},

    ['redbull'] = {
		label = 'Redbull',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
		}
	},

    ['caprisun'] = {
		label = 'Capri Sun',
		weight = 20,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola.'
		}
	},

	['cola'] = {
		label = 'Coca Cola',
		weight = 350,
		client = {
			status = { thirst = 100000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},
	
	['trowel'] = {
		label = 'Trowel',
		description = "Perfect for your garden or for Coca plant",
		weight = 250,
		stack = true
	},

	['coke_leaf'] = {
		label = 'Coca Leaf',
		description = "Leaf from amazing plant",
		weight = 15,
		stack = true
	},

	['coke_access'] = {
		label = 'Access card',
		description = "Access Card for Coke Lab",
		weight = 50,
		stack = true
	},

	['coke_box'] = {
		label = 'Box with Coke',
		description = "Be careful not to spill it on the ground",
		weight = 2000,
		stack = true
	},

	['coke_raw'] = {
		label = 'Raw Coke',
		description = "Coke with some dirty particles",
		weight = 50,
		stack = true
	},

	['coke_pure'] = {
		label = 'Pure Coke',
		description = "Coke without any dirty particles",
		weight = 70,
		stack = true,
		close = true
	},

	['coke_figure'] = {
		label = 'Action Figure',
		description = "Action Figure of the cartoon superhero Impotent Rage",
		weight = 150,
		stack = true
	},

	['coke_figureempty'] = {
		label = 'Action Figure',
		description = "Action Figure of the cartoon superhero Impotent Rage",
		weight = 150,
		stack = true
	},

	['coke_figurebroken'] = {
		label = 'Pieces of Action Figure',
		description = "You can throw this away or try to repair with glue",
		weight = 100,
		stack = true
	},

	['meth_amoniak'] = {
		label = 'Ammonia',
		description = "Warning! Dangerous Chemicals!",
		weight = 1000,
		stack = true
	},

	['meth_pipe'] = {
		label = 'Meth Pipe',
		description = "Enjoy your new crystal clear stuff!",
		weight = 880,
		stack = true
	},

	['crack_pipe'] = {
		label = 'Crack Pipe',
		description = "Enjoy your Crack!",
		weight = 550,
		stack = true
	},

	['meth_syringe'] = {
		label = 'Syringe Meth',
		description = "Enjoy your new crystal clear stuff!",
		weight = 300,
		stack = true
	},

	['heroin_syringe'] = {
		label = 'Syringe Heroin',
		description = "Enjoy your new crystal clear stuff!",
		weight = 300,
		stack = true
	},

	['syringe'] = {
		label = 'Syringe',
		description = "Enjoy your new crystal clear stuff!",
		weight = 300,
		stack = true
	},

	['meth_sacid'] = {
		label = 'Sodium Benzoate Canister',
		description = "Warning! Dangerous Chemicals!",
		weight = 5000,
		stack = true
	},

	['meth_emptysacid'] = {
		label = 'Empty Canister',
		description = "Material: Plastic, Good for Sodium Benzoate",
		weight = 2000,
		stack = true
	},

	['meth_access'] = {
		label = 'Access card',
		description = "Access Card for Meth Lab",
		weight = 100,
		stack = true,
		close = true
	},

	['meth_glass'] = {
		label = 'Tray with meth',
		description = "Needs to be smashed with hammer",
		weight = 1000,
		stack = true
	},

	['meth_sharp'] = {
		label = 'Tray with smashed meth',
		description = "Can be packed",
		weight = 1000,
		stack = true
	},

	['meth_bag'] = {
		label = 'Meth bag',
		description = "Plastic bag with magic stuff!",
		weight = 1000,
		stack = true
	},

	['weed_package'] = {
		label = 'Weed Bag',
		description = "Plastic bag with magic stuff!",
		weight = 500,
		stack = true
	},

	['weed_access'] = {
		label = 'Access card',
		description = "Access Card for Weed Lab",
		weight = 100,
		stack = true
	},

	['weed_bud'] = {
		label = 'Weed Bud',
		description = "Needs to be clean at the table",
		weight = 40,
		stack = true
	},

	['weed_blunt'] = {
		label = 'Blunt',
		description = "Enjoy your weed!",
		weight = 90,
		stack = true,
		close = true
	},

	['weed_wrap'] = {
		label = 'Blunt wraps',
		description = "Get Weed Bag and roll blunt!",
		weight = 75,
		stack = true,
		close = true
	},

	['weed_papers'] = {
		label = 'Weed papers',
		description = "Get Weed Bag and roll joint!",
		weight = 15,
		stack = true,
		close = true
	},

	['weed_joint'] = {
		label = 'Joint',
		description = "Enjoy your weed!",
		weight = 50,
		stack = true,
		close = true
	},

	['weed_budclean'] = {
		label = 'Weed Bud',
		description = "You can pack this at the table",
		weight = 35,
		stack = true
	},

	['plastic_bag'] = {
		label = 'Plastic bag',
		description = "You can pack a lot of stuff here!",
		weight = 8,
		stack = true
	},

	['scissors'] = {
		label = 'Scissors',
		description = "To help you with collecting",
		weight = 40,
		stack = true
	},

	['ecstasy1'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy2'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy3'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy4'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['ecstasy5'] = {
		label = 'Ecstasy',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd1'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd2'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd3'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd4'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['lsd5'] = {
		label = 'LSD',
		description = "Explore a new universe!",
		weight = 10,
		stack = true,
		close = true
	},

	['magicmushroom'] = {
		label = 'Mushroom',
		description = "Explore a new universe!",
		weight = 30,
		stack = true,
		close = true
	},

	['peyote'] = {
		label = 'Peyote',
		description = "Explore a new universe!",
		weight = 30,
		stack = true,
		close = true
	},

	['xanaxpack'] = {
		label = 'Pack of Xanax',
		description = "Needs to be open",
		weight = 130,
		stack = true,
		close = true
	},

	['xanaxplate'] = {
		label = 'Plate of Xanax',
		description = "Needs to be open",
		weight = 30,
		stack = true,
		close = true
	},

	['xanaxpill'] = {
		label = 'Xanax pill',
		description = "Explore a new universe!",
		weight = 2,
		stack = true,
		close = true
	},

    ['glue'] = {
		label = 'Glue',
		description = "Good for repairing things!",
		weight = 30,
		stack = true
	},

    ['hammer'] = {
		label = 'Hammer',
		description = "Good for smashing things!",
		weight = 500,
		stack = true
	},

	['poppyplant'] = {
		label = 'Poppy Plant',
		description = "Very nice plant!",
		weight = 30,
		stack = true
	},
	
	['heroin'] = {
		label = 'Heroin',
		description = "Explore a new universe!",
		weight = 30,
		stack = true
	},

	['crack'] = {
		label = 'Crack',
		description = "Explore a new universe!",
		weight = 30,
		stack = true
	},
	
	['baking_soda'] = {
		label = 'Baking Soda',
		description = "Baking Bad!",
		weight = 30,
		stack = true
	},	

	["scale"] = {
		label = "Scale",
		weight = 1,
		stack = true,
		close = true,
	},

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
	
	['basic_rod'] = {
		label = 'Canne à pêche',
		stack = false,
		weight = 250
	},

	['graphite_rod'] = {
		label = 'Canne en graphite',
		stack = false,
		weight = 350
	},

	['titanium_rod'] = {
		label = 'Canne en Titanium',
		stack = false,
		weight = 450
	},

	['worms'] = {
		label = 'Vers',
		weight = 10
	},

	['artificial_bait'] = {
		label = 'Appâts artificiels',
		weight = 30
	},

	['anchovy'] = {
		label = 'Anchois',
		weight = 20
	},

	['grouper'] = {
		label = 'Mérou',
		weight = 3500
	},

	['haddock'] = {
		label = 'Aiglefin',
		weight = 500
	},

	['mahi_mahi'] = {
		label = 'Mahi Mahi',
		weight = 3500
	},

	['piranha'] = {
		label = 'Piranha',
		weight = 1500
	},

	['red_snapper'] = {
		label = 'Vivaneau rouge',
		weight = 2500
	},

	['salmon'] = {
		label = 'Saumon',
		weight = 1000
	},

	['shark'] = {
		label = 'Requin',
		weight = 10000
	},

	['trout'] = {
		label = 'Truite',
		weight = 750
	},

	['tuna'] = {
		label = 'Thon',
		weight = 7500
	},
	
	["rentdocument"] = {
		label = "document de location",
		weight = 1,
		stack = true,
		close = true,
	},
	
	["atm_bomb"] = {
		label = "bomb atm",
		weight = 25,
		stack = true,
		close = true,
	},

	["vehicle_reg"] = {
		label = "papier d'immatriculation",
		weight = 0,
		stack = false,
		server = {
			export = 'browns_registration.UseRegistration'
		}
	}, 

	["vehicle_ins"] = {
		label = "papier d'assurance",
		weight = 0,
		stack = false,
		server = {
			export = 'browns_registration.UseInsurance'
		}
	},	
}