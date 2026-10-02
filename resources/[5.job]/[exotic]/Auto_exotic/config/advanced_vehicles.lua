--[[
==========================================================================================================================
	PAY ATTENTION WHEN SETTING EVERYTHING, IF YOU BREAK ANYTHING DOWNLOAD THE ORIGINAL SETTING BACK AND TRY AGAIN
==========================================================================================================================
	To change the placement of the HUD open style.css and change the values ​​in lines 322 and 448
]]

Config.webhook = "WEBHOOK"						-- Webhook to send logs for discord
Config.lang = "fr"								-- Set the file language [en/br/de/fr]

Config.ESX = {									-- ESX settings, if you are using vRP, ignore
	['ESXSHAREDOBJECT'] = "esx:getSharedObject",-- Change your getshared object event here if you are using anti-cheat
}

Config.format = {
	['currency'] = 'USD',						-- This is the currency format, so your currency symbol appears correctly [Examples: BRL, USD]
	['location'] = 'fr-FR'						-- This is your country location, to format the decimal places according to your pattern [Examples: pt-BR, en-US]
}

Config.command = "status"						-- Command to open the menu (Event to open the menu if you want to trigger it from somewhere: TriggerEvent ('advanced_vehicles: showStatusUI'))
Config.Jobs = {'exotic'}			-- Jobs to perform actions in menu (set to false to disable permission)
Config.UseT1gerMechanic = true                  -- If set to true Vehicles will use the CarJack (toolbox) and Lift (mechanic_toolbox) from the t1ger_mechanic script. Look at the Readme for using this

Config.allVehicles = true						-- true: only cars will be available / false: all vehicles will be available
Config.itemToInspect = "scanner"				-- Item required to inspect vehicles

Config.NitroAmount = 100						-- Amount of nitro for each charge
Config.NitroRechargeTime = 60					-- Nitro recharge time
Config.NitroRechargeAmount = 5					-- Quantity of loads
-- You can set 2 keys for nitro
Config.NitroKey1 = 19 	-- ALT
Config.NitroKey2 = 210 	-- CTRL

Config.oil = "oil"								-- Oil index configured in Config.maintenance
-- Config for car services
Config.maintenance = {
	['default'] = { -- default means if you don't have a setting for the specific vehicle, it will default to
		['oil'] = {								-- Index
			['lifespan'] = 1500,				-- Number of KMs until the car needs service
			['damage'] = {
				['type'] = 'engine',			-- Damage type: engine: this will damage the vehicle's engine
				['amount_per_km'] = 0.0001,		-- This is the base value (in percentage) that the car will suffer damage for every km it runs [maximum engine health is 1000, so 0.0001 of 1000 is 0.1 | The maximum value for handling is obtained from the vehicle's handling.meta file]
				['km_threshold'] = 100,			-- This is the limit to increase the multiplier, so the multiplier will increase each time the player passes this km [Set this value to 99999 if you don't want the multiplier to work]
				['multiplier'] = 1.2,			-- This is the damage multiplier, this value will cause the car to take even more damage after the player has used the car longer [This value cannot be less than 1.0 | Set this value to 1.0 if you don't want the multiplier to work]
				['min'] = 0,					-- This is the minimum value that the piece's health can reach when taking damage.
				['destroy_engine'] = false		-- Will cause the car to stop running if the engine reaches the minimum value [applicable only when type = engine]
			},
			['repair_item'] = {
				['name'] = 'oil',				-- Item to do the car service
				['amount'] = 2,					-- Quantity of items
				['time'] = 10					-- repair time
			},
			['interface'] = {
				['name'] = 'Huile moteur',					-- Interface name
				['icon_color'] = '#ffffff00',				-- Background color in interface
				['icon'] = 'images/maintenance/oil.png',	-- Image
				['description'] = 'Il faut toujours une huile propre pour que le moteur tourne bien.',	-- Description
				['index'] = 0								-- This index means that items are ordered in the interface, 0 will be first, 1...
			}
		},
		['tires'] = {
			['lifespan'] = 5000,
			['damage'] = {
				['type'] = 'CHandlingData',			-- This will damage the physics of the vehicle (handling.meta)
				['handId'] = 'fTractionCurveMax',	-- Index on handling.meta
				['amount_per_km'] = 0.0001,			-- By setting 0.0001 (in quantity_per_km), 100 (in km limit) and 1.2 (in multiplier), the car will run approximately 1,300 km before reaching the minimum value
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.5
			},
			['repair_item'] = {
				['name'] = 'tires',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pneus',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/tires.png',
				['description'] = 'Les pneus gardent le véhicule droit. Usés, ils le font déraper plus facilement.',
				['index'] = 1
			}
		},
		['brake_pads'] = {
			['lifespan'] = 4000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'brake_pads',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Plaquettes de frein',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/brake_pads.png',
				['description'] = 'Les plaquettes permettent à la voiture de s\'arrêter au freinage.',
				['index'] = 2
			}
		},
		['transmission_oil'] = {
			['lifespan'] = 30000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveMaxFlatVel',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 100.0
			},
			['repair_item'] = {
				['name'] = 'transmission_oil',
				['amount'] = 2,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Huile de boîte',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/transmission_oil.png',
				['description'] = 'L\'huile doit rester propre pour que la boîte fonctionne.',
				['index'] = 3
			}
		},
		['shock_absorber'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'shock_absorber',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Amortisseurs',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/shocks.png',
				['description'] = 'La suspension dépend de bons amortisseurs.',
				['index'] = 4
			}
		},
		['clutch'] = {
			['lifespan'] = 35000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'clutch',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Embrayage',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/clutch.png',
				['description'] = 'L\'embrayage gère la vitesse des changements de vitesse.',
				['index'] = 5
			}
		},
		['air_filter'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.00005,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = false
			},
			['repair_item'] = {
				['name'] = 'air_filter',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Filtre à air',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/air_filter.png',
				['description'] = 'Le moteur a besoin d\'un filtre à air propre pour respirer.',
				['index'] = 6
			}
		},
		['fuel_filter'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.00005,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = false
			},
			['repair_item'] = {
				['name'] = 'fuel_filter',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Filtre à carburant',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/fuel_filter.png',
				['description'] = 'Il empêche la saleté du réservoir d\'arriver jusqu\'au moteur.',
				['index'] = 7
			}
		},
		['spark_plugs'] = {
			['lifespan'] = 15000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'spark_plugs',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Bougies',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/spark_plugs.png',
				['description'] = 'Les bougies produisent l\'étincelle nécessaire au bon fonctionnement du moteur.',
				['index'] = 8
			}
		},
		['serpentine_belt'] = {
			['lifespan'] = 20000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = true
			},
			['repair_item'] = {
				['name'] = 'serpentine_belt',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Courroie de distribution',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/serpentine_belt.png',
				['description'] = 'La courroie synchronise les soupapes, les pistons et le vilebrequin.',
				['index'] = 9
			}
		},
	},
	--[[['panto'] = {	-- If you enable this, the panto car will have these settings
		['example'] = {
			['lifespan'] = 999,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'example',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Exemple',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/example.png',
				['description'] = 'Exemple',
				['index'] = 9
			}
		},
	}]]
}

-- Upgrades availables
Config.upgrades = {
	['default'] = {
		['susp'] = {	-- Index
			['improvements'] = {
				['type'] = 'CHandlingData',			-- CHandlingData: will affect vehicle physics
				['handId'] = 'fSuspensionRaise',	-- The index in handling.meta
				['value'] = -0.2,					-- Changing value
				['fixed_value'] = false				-- This means whether the value will be relative or absolute (fixed)
			},
			['item'] = {
				['name'] = 'susp',					-- Item required to update
				['amount'] = 1,						-- Quantity of items
				['time'] = 10						-- Time
			},
			['interface'] = {
				['name'] = 'Suspension très basse',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp.png',
				['description'] = 'Suspension extrêmement basse. Réservée aux pick-up et aux véhicules hauts.',
				['index'] = 0
			},
			['class'] = 'suspension'
		},
		['susp1'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp1',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspension basse',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp1.png',
				['description'] = 'Ressorts courts qui rabaissent beaucoup le véhicule. Peut le rendre instable. Pas pour les véhicules déjà bas.',
				['index'] = 1
			},
			['class'] = 'suspension'
		},
		['susp2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.05,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp2',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspension sport',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp2.png',
				['description'] = 'Ressorts sport qui baissent un peu le véhicule. Pas pour les véhicules déjà bas.',
				['index'] = 2
			},
			['class'] = 'suspension'
		},
		['susp3'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp3',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspension confort',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp3.png',
				['description'] = 'Relève un peu la suspension pour plus de confort et de sécurité.',
				['index'] = 3
			},
			['class'] = 'suspension'
		},
		['susp4'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp4',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspension haute',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp4.png',
				['description'] = 'Relève fortement la suspension pour le tout-terrain.',
				['index'] = 4
			},
			['class'] = 'suspension'
		},

		['engine1'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.03,
				['handId2'] = 'fInitialDriveMaxFlatVel',
				['value2'] = 8.0,
				['engine'] = 0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'engine1',
				['amount'] = 1,
				['time'] = 15
			},
			['interface'] = {
				['name'] = 'Moteur stage 1',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/engine3.svg',
				['description'] = 'Préparation légère. Plus de couple et un peu plus de vitesse de pointe, y compris sur les véhicules addon.',
				['index'] = 13
			},
			['class'] = 'engine'
		},
		['engine2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.06,
				['handId2'] = 'fInitialDriveMaxFlatVel',
				['value2'] = 16.0,
				['engine'] = 1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'engine2',
				['amount'] = 1,
				['time'] = 15
			},
			['interface'] = {
				['name'] = 'Moteur stage 2',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/engine3.svg',
				['description'] = 'Préparation sport. Accélération et vitesse de pointe nettement plus hautes.',
				['index'] = 14
			},
			['class'] = 'engine'
		},
		['engine3'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.10,
				['handId2'] = 'fInitialDriveMaxFlatVel',
				['value2'] = 25.0,
				['engine'] = 2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'engine3',
				['amount'] = 1,
				['time'] = 20
			},
			['interface'] = {
				['name'] = 'Moteur stage 3',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/engine3.svg',
				['description'] = 'Préparation course. Gros gain de puissance, compatible véhicules custom.',
				['index'] = 15
			},
			['class'] = 'engine'
		},
		['engine4'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.15,
				['handId2'] = 'fInitialDriveMaxFlatVel',
				['value2'] = 35.0,
				['engine'] = 3,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'engine4',
				['amount'] = 1,
				['time'] = 20
			},
			['interface'] = {
				['name'] = 'Moteur stage 4',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/engine3.svg',
				['description'] = 'Moteur full course. Maximum de puissance et de vitesse de pointe.',
				['index'] = 16
			},
			['class'] = 'engine'
		},
		['trans1'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['value'] = 0.6,
				['handId2'] = 'fClutchChangeRateScaleDownShift',
				['value2'] = 0.6,
				['gearbox'] = 0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'trans1',
				['amount'] = 1,
				['time'] = 15
			},
			['interface'] = {
				['name'] = 'Transmission stage 1',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/gearbox.svg',
				['description'] = 'Boîte renforcée. Les passages de rapports sont un peu plus rapides.',
				['index'] = 17
			},
			['class'] = 'gearbox'
		},
		['trans2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['value'] = 1.2,
				['handId2'] = 'fClutchChangeRateScaleDownShift',
				['value2'] = 1.2,
				['gearbox'] = 1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'trans2',
				['amount'] = 1,
				['time'] = 15
			},
			['interface'] = {
				['name'] = 'Transmission stage 2',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/gearbox.svg',
				['description'] = 'Boîte sport. Montées et descentes de rapports plus franches.',
				['index'] = 18
			},
			['class'] = 'gearbox'
		},
		['trans3'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['value'] = 2.0,
				['handId2'] = 'fClutchChangeRateScaleDownShift',
				['value2'] = 2.0,
				['gearbox'] = 2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'trans3',
				['amount'] = 1,
				['time'] = 20
			},
			['interface'] = {
				['name'] = 'Transmission stage 3',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/gearbox.svg',
				['description'] = 'Boîte course. Gros gain sur la vitesse de passage des rapports.',
				['index'] = 19
			},
			['class'] = 'gearbox'
		},
		['trans4'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['value'] = 3.0,
				['handId2'] = 'fClutchChangeRateScaleDownShift',
				['value2'] = 3.0,
				['gearbox'] = 3,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'trans4',
				['amount'] = 1,
				['time'] = 20
			},
			['interface'] = {
				['name'] = 'Transmission stage 4',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/gearbox.svg',
				['description'] = 'Boîte full course. Passages de rapports au maximum.',
				['index'] = 20
			},
			['class'] = 'gearbox'
		},

		['garett'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.04,
				['turbo'] = true,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'garett',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Turbo Garett GTW',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/turbo.png',
				['description'] = 'Une plus grosse turbine envoie plus d\'air froid dans le moteur et donne plus de puissance.',
				['index'] = 5
			},
			['class'] = 'turbo'
		},
		['nitrous'] = {
			['improvements'] = {
				['type'] = 'nitrous'	-- Nitro
			},
			['item'] = {
				['name'] = 'nitrous',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Nitro',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/nitrous.png',
				['description'] = 'Le nitro envoie plus d\'oxygène dans les cylindres et donne un surplus de puissance pendant quelques secondes.',
				['index'] = 6
			},
			['class'] = 'nitro'
		},
		['AWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 0.5,
				['powered_wheels'] = {0,1,2,3},	-- If the update changes fDriveBiasFront, the wheels that will receive power from the vehicle must also be changed
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'awd',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Conversion en 4 roues motrices',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/awd.png',
				['description'] = 'Le moteur entraîne les 4 roues du véhicule.',
				['index'] = 7
			},
			['class'] = 'differential'
		},
		['RWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 0.0,
				['powered_wheels'] = {2,3},
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'rwd',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Conversion en propulsion',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/rwd.png',
				['description'] = 'Le moteur entraîne les 2 roues arrière.',
				['index'] = 8
			},
			['class'] = 'differential'
		},
		['FWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 1.0,
				['powered_wheels'] = {0,1},
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'fwd',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Conversion en traction',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/fwd.png',
				['description'] = 'Le moteur entraîne les 2 roues avant.',
				['index'] = 9
			},
			['class'] = 'differential'
		},

		['semislick'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.4,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'semislick',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pneus semi-slick',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/semislick.png',
				['description'] = 'Pneu homologué route, fait pour exploiter les performances du véhicule.',
				['index'] = 10
			},
			['class'] = 'tires'
		},
		['slick'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.8,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'slick',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pneus slick',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/slick.png',
				['description'] = 'Pneus lisses, plus de surface au sol et donc de meilleures performances.',
				['index'] = 11
			},
			['class'] = 'tires'
		},

		['race_brakes'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 2.0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'race_brakes',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Freins Brembo',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/race_brakes.png',
				['description'] = 'Freins de course, beaucoup plus puissants et qui chauffent moins que des freins classiques.',
				['index'] = 12
			},
			['class'] = 'brakes'
		},
		['brake1'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 0.20,
				['brakes'] = 0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'brake1',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Freins stage 1',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/disc-brake.svg',
				['description'] = 'Freinage renforcé. Distance d\'arrêt un peu plus courte.',
				['index'] = 21
			},
			['class'] = 'brakes'
		},
		['brake2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 0.45,
				['brakes'] = 1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'brake2',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Freins stage 2',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/disc-brake.svg',
				['description'] = 'Freins sport. Le véhicule s\'arrête plus franchement.',
				['index'] = 22
			},
			['class'] = 'brakes'
		},
		['brake3'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 0.80,
				['brakes'] = 2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'brake3',
				['amount'] = 1,
				['time'] = 15
			},
			['interface'] = {
				['name'] = 'Freins stage 3',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/disc-brake.svg',
				['description'] = 'Freins course. Gros gain de puissance de freinage.',
				['index'] = 23
			},
			['class'] = 'brakes'
		},
		['brake4'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 1.20,
				['brakes'] = 3,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'brake4',
				['amount'] = 1,
				['time'] = 15
			},
			['interface'] = {
				['name'] = 'Freins stage 4',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/repair/disc-brake.svg',
				['description'] = 'Freins full course. Distance d\'arrêt au maximum.',
				['index'] = 24
			},
			['class'] = 'brakes'
		},
	}
}

-- Repair config
Config.repair = {
	['engine'] = {			-- Part index (do not change)
		['items'] = {		-- Items needed to repair the part
			['piston'] = 4,
			['rod'] = 4,
			['oil'] = 3
		},
		['time'] = 10,		-- time to repair
		['repair'] = {		-- The handling.meta indices that will return to default
			"engine",		-- engine: will fix engine health
			"fInitialDriveForce",
		}
	},
	['transmission'] = {
		['items'] = {
			['gear'] = 5,
			['transmission_oil'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fClutchChangeRateScaleUpShift"
		}
	},
	['chassis'] = {
		['items'] = {
			['iron'] = 10,
			['aluminum'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"body"		-- body: will fix the chassis health
		}
	},
	['brakes'] = {
		['items'] = {
			['brake_discs'] = 4,
			['brake_pads'] = 4,
			['brake_caliper'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fBrakeForce"
		}
	},
	['suspension'] = {
		['items'] = {
			['shock_absorber'] = 4,
			['springs'] = 4
		},
		['time'] = 10,
		['repair'] = {
			"fTractionCurveMax",
			"fSuspensionForce"
		}
	}
}

Config.infoTextsPage = {
	[1] = {
		['icon'] = "images/info.png",
		['title'] = "Informations",
		['text'] = "Ceci est le panneau d'entretien du véhicule. Plusieurs pièces doivent être changées tous les X km. Par exemple, l'huile moteur se change tous les 1500 km, sinon le moteur s'abîme. D'autres contrôles se font plus tard. Amène le véhicule à un mécano pour connaître l'état de chaque pièce."
	},
	[2] = {
		['icon'] = "images/services.png",
		['title'] = "Comment faire les contrôles",
		['text'] = "L'entretien se fait au bon moment. Amène le véhicule à un mécano. Avec le scanner, il lit chaque pièce et voit celles qu'il faut remplacer."
	},
	[3] = {
		['icon'] = "images/repair.png",
		['title'] = "Réparations",
		['text'] = "L'onglet réparation sert quand une pièce perd en performance, en général parce que l'entretien n'a pas été fait à temps. Ces réparations coûtent cher, mais une pièce abîmée nuit vraiment au véhicule."
	},
	[4] = {
		['icon'] = "images/performance.png",
		['title'] = "Améliorations",
		['text'] = "Tu peux installer des pièces performance, mais <b>ATTENTION</b> : elles sont très puissantes et changent le comportement du véhicule. Choisis-les avec soin, sinon la voiture peut devenir instable, voire se retourner. Le mécano n'est pas responsable d'une mauvaise installation."
	}
}
Config.createTable = false