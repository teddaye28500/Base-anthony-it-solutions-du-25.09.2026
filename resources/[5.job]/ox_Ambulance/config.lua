local seconds, minutes = 1000, 60000
Config = {}
Config.gksPhoneDistress = false 
Config.customCarlock = false 
Config.MythicHospital = false 
Config.jobMenu = 'F6' 
Config.billingSystem = false 
Config.skinScript = 'appearance' -- Options actuelles: 'esx' (Pour esx_skin) / 'appearance' (Pour fivem-appearance) ou bien sur false pour désactiver
Config.RespawnTimer = 5 * minutes -- Temps avant la réapparition facultative
Config.BleedoutTimer = 20 * minutes -- Temps avant qu'il force la réapparition
Config.removeItemsOnDeath = false -- Supprimer des objets en cas de décès ?
Config.Inventory = 'ox' 

Config.AntiCombatLog = { 
    enabled = true, 
    notification = {
        enabled = true, 
        title = 'Connecté alors que mort',
        desc = 'Tu es parti mort pour la dernière fois et maintenant tu es revenu mort'
    }
}

Config.RespawnPoint = { -- Où le joueur réapparaît s'il saigne
    coords = vec3(316.93057250977,-582.21142578125,43.284103393555), -- Par défaut
    heading = 343.982177734375
}

Config.EMSItems = {
    revive = {
        item = 'defib',
        remove = false 
    },
    heal = {
        item = 'medikit', 
        duration = 5 * seconds, 
        remove = true 
    },
    sedate = {
        item = 'sedative', 
        duration = 8 * seconds, 
        remove = true 
    },
    medbag = 'medbag', 
    stretcher = 'stretcher' 
}

Config.ReviveRewards = {
    enabled = false, -- Enable cash rewards for reviving
    no_injury = 4000, -- If above enabled, how much reward for fully treated patient with no injury in diagnosis
    burned = 3000,  -- How much if player is burned and revived without being treated
    beat = 2500, -- So on, so forth
    stabbed = 2000,
    shot = 1500,
}

Config.ReviveHealth = { -- How much health to deduct for those revived without proper treatment
    shot = 60, -- Ex. If player is shot and revived without having the gunshots treated; they will respond with 60 health removed
    stabbed = 50,
    beat = 40,
    burned = 20
}

Config.TreatmentTime = 9 * seconds -- Time to perform treatment

Config.TreatmentItems = {
    shot = 'tweezers',
    stabbed = 'suturekit',
    beat = 'icepack',
    burncream = 'burncream'
}

Config.Locations = {
    Pillbox = {

        Blip = {
            Enabled = true,
            Coords = vec3(315.53747558594,-581.40301513672,43.284103393555), 
            Sprite = 61,
            Color = 2,
            Scale = 0.6,
            String = 'Hôpital EMS'
        },

        BossMenu = {
            Enabled = true,
            Target = {
                label = 'Acces Menu Patron',
                coords = vec3(335.47, -594.3, 42.28),
                heading = 21.4856,
                width = 2.0,
                length = 1.0,
                minZ = 43.21-0.9,
                maxZ = 43.21+0.9
            
            }
        },

        CheckIn = { -- Hospital check-in
            Enabled = false, -- Enabled?
            Ped = 's_m_m_scientist_01', -- Check in ped
            Coords = vec3(308.40356445313,-595.4228515625,42.3), -- Coords of ped
            Heading = 68.45450592041016, -- Heading of ped
            Cost = 200, -- Cost of using hospital check-in. Set to false for free
            MaxOnDuty = 3, 
            PayAccount = 'money', -- Account dead player pays from to check-in
            Label = 'Appuyer sur [E] pour Demander un soin'
        },

        Cloakroom = {
            Enabled = true, -- Set to false if you don't want to use (Compatible with esx_skin & wasabi fivem-appearance fork)
            Coords = vec3(302.08822631836,-599.04724121094,43.284099578857), -- Coords of cloakroom
            Label = 'Appuyer sur [E] pour Change de tenue', -- String of text ui of cloakroom
            Range = 2.0, -- Range away from coords you can use.
            Uniforms = { -- Uniform choices
                ['Medic'] = { -- Name of outfit that will display in menu
                    male = { -- Male variation
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 206,   ['torso_2'] = 2,
                        ['arms'] = 5,
                        ['pants_1'] = 11,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 7,
                        ['helmet_1'] = 44,  ['helmet_2'] = 7,
                    },
                    female = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 4,   ['torso_2'] = 14,
                        ['arms'] = 4,
                        ['pants_1'] = 25,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 4,
                    }
                },
                ['Doctor'] = {
                    male = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 5,   ['torso_2'] = 2,
                        ['arms'] = 5,
                        ['pants_1'] = 6,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 7,
                        ['helmet_1'] = 44,  ['helmet_2'] = 7,
                    },
                    female = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 4,   ['torso_2'] = 14,
                        ['arms'] = 4,
                        ['pants_1'] = 25,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 4,
                    }
                },
            }
        },

        MedicalSupplies = { -- EMS Shop for supplies
            Enabled = true, -- If set to false, rest of this table do not matter
            Ped = 's_m_m_doctor_01', -- Ped to target
            Coords = vec3(306.916015625,-601.95031738281,42.284080505371), -- Coords of ped/target
            Heading = 341.0133972167969, -- Heading of ped
            Supplies = { -- Supplies
                { item = 'medbag', label = 'Sac Medical', price = 1000 }, -- Pretty self explanatory, price may be set to 'false' to make free
                { item = 'medikit', label = 'Kit de Premier Soin', price = 150 },
            }
        },

--------------------------------- ANCIEN GARAGE --------------------------------------------------
        Vehicles = { -- Vehicle Garage
            Enabled = false, -- Enable? False if you have you're own way for medics to obtain vehicles.
            Zone = {
                coords = vec3(294.92575073242,-599.80450439453,43.148864746094), -- Area to prompt vehicle garage
                range = 5.5, -- Range it will prompt from coords above
                label = 'Appuyer sur [E] pour Accedez au Garage',
                return_label = 'Appuyer sur [E] pour Ranger le Vehicle'
            },
            Spawn = {
                land = {
                    coords = vec3(296.71139526367,-607.87194824219,43.26049041748),
                    heading = 72.95391845703125
                },
                air = {
                    coords = vec3(-396.0056, -343.4620, 70.9680),
                    heading =  52.8418
                }
            },
            Options = {
                ['ambulance'] = { -- Car/Helicopter/Vehicle Spawn Code/Model Name
                    label = 'Ambulance',
                    category = 'land', -- Options are 'land' and 'air'
                },
                ['dodgeems'] = { -- Car/Helicopter/Vehicle Spawn Code/Model Name
                    label = 'Dodge Charger',
                    category = 'land', -- Options are 'land' and 'air'
                },
                ['polmav'] = { -- Car/Helicopter/Vehicle Spawn Code/Model Name
                    label = 'Maverick',
                    category = 'air', -- Options are 'land' and 'air'
                },
            }
        },
    }
}

------------ GARAGE ------------

-- Title
Config.Title = {
    ambulance  = "Menu Garage",
}

Config.Garage = {
    {
        coords = vec3(295.23138427734,-599.92132568359,43.15242767334 -0.9),
        heading = 7.01077985763549,
        icon      = "fas fa-hand-paper",
        labeltarget = "Menu Garage", 
    },
}

Config.ambulance = {
    { nom = "Ranger véhicule", modele = "" },
    { nom = "Ambulance", modele = "ambulance" },
    { nom = "Durango", modele = "c3durango" },

}

Config.SpawnVeh = {
	ambulance  = vec4(295.27969360352, -607.54473876953,43.014171600342,70.945816040039),
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
        coords = vec3(295.23138427734,-599.92132568359,43.15242767334),
        heading = 165.6260528564453,
		gender = "male",
		--animDict = "",
		--animName = "", 
		scenario = "WORLD_HUMAN_CLIPBOARD"
	},

}