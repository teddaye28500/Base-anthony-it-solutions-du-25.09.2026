Config = {
    HudResource = 'esx_hud',
    Cruise = {
        Enable = true,
        Key = "CAPITAL",
        Export = function (state)
            exports[Config.HudResource]:CruiseControlState(state)
        end,
    },
    Seatbelt = {
        Enable = true,
        Key = "B",
        EjectCheckSpeed = 45, -- MPH
        RagdollTime = 1, -- MS
        Export = function (state)
            exports[Config.HudResource]:SeatbeltState(state)
        end
    }
}

Config.Visible = true
Config.EnableESXIdentity = true
Config.MaxSalary = 3500
Config.StatusMax      = 1000000
Config.TickTime       = 1000
Config.UpdateInterval = 30000
Config.Display        = false	-- Enable the esx_status bars (disable if you are using another HUD)

Config.EnableCommands     = ESX.GetConfig().EnableDebug

-- EXPERIMENTAL Character Registration Method
Config.UseDeferrals       = false

-- These values are for the date format in the registration menu
-- Choices: DD/MM/YYYY | MM/DD/YYYY | YYYY/MM/DD
Config.DateFormat         = 'DD/MM/YYYY'

-- These values are for the second input validation in server/main.lua
Config.MinFirstNameLength = 2                           -- Min First Name Length.
Config.MaxFirstNameLength = 25                          -- Max First Name Length.
Config.MinLastNameLength  = 2                           -- Min Last Name Length.
Config.MaxLastNameLength  = 25                          -- Max Last Name Length.
Config.MinHeight          = 120                         -- 120 cm lowest height
Config.MaxHeight          = 220                         -- 220 cm max height.
Config.LowestYear         = 1900                        -- 112 years old is the oldest you can be.
Config.HighestYear        = 2005                        -- 18 years old is the youngest you can be.

Config.FullCharDelete     = true                        -- Delete all reference to character.
Config.EnableDebugging    = ESX.GetConfig().EnableDebug -- prints for debugging :)


Config.Items = {
	["bread"] = {
		type = "food",
		prop = "prop_cs_burger_01",
		status = 200000,
		remove = true,
		anim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}}
	},
	
	["water"] = {
		type = "drink",
		prop = "prop_ld_flow_bottle",
		status = 100000,
		remove = true,
		anim = {dict = 'mp_player_intdrink', name = 'loop_bottle', settings = {1.0, -1.0, 2000, 0, 1, true, true, true}}
	}
}

Config.BossGrades = { -- Uncomment and/or add additional grades you want to have access to the boss menu.
    ['boss'] = true,
    --['staff1'] = false,
    --['staff2'] = false,
    --['staff3'] = false,
}

Config.allowedJobs  = {
	['police'] = true
}

Config.BackpackWeight = {
	[40] = 16,
	[41] = 20,
	[44] = 25,
	[45] = 23
}

Config.Components = { {
    label = TranslateCap('sex'),
    name = 'sex',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('mom'),
    name = 'mom',
    value = 21,
    min = 21,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('dad'),
    name = 'dad',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('resemblance'),
    name = 'face_md_weight',
    value = 50,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('skin_tone'),
    name = 'skin_md_weight',
    value = 50,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_1'),
    name = 'nose_1',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_2'),
    name = 'nose_2',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_3'),
    name = 'nose_3',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_4'),
    name = 'nose_4',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_5'),
    name = 'nose_5',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('nose_6'),
    name = 'nose_6',
    value = 0,
    min = -10,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('cheeks_1'),
    name = 'cheeks_1',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('cheeks_2'),
    name = 'cheeks_2',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('cheeks_3'),
    name = 'cheeks_3',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lip_fullness'),
    name = 'lip_thickness',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('jaw_bone_width'),
    name = 'jaw_1',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('jaw_bone_length'),
    name = 'jaw_2',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_height'),
    name = 'chin_1',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_length'),
    name = 'chin_2',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_width'),
    name = 'chin_3',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('chin_hole'),
    name = 'chin_4',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('neck_thickness'),
    name = 'neck_thickness',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_1'),
    name = 'hair_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_2'),
    name = 'hair_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_color_1'),
    name = 'hair_color_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('hair_color_2'),
    name = 'hair_color_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65
}, {
    label = TranslateCap('tshirt_1'),
    name = 'tshirt_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 8
}, {
    label = TranslateCap('tshirt_2'),
    name = 'tshirt_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'tshirt_1'
}, {
    label = TranslateCap('torso_1'),
    name = 'torso_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 11
}, {
    label = TranslateCap('torso_2'),
    name = 'torso_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'torso_1'
}, {
    label = TranslateCap('decals_1'),
    name = 'decals_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 10
}, {
    label = TranslateCap('decals_2'),
    name = 'decals_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'decals_1'
}, {
    label = TranslateCap('arms'),
    name = 'arms',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('arms_2'),
    name = 'arms_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('pants_1'),
    name = 'pants_1',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.5,
    componentId = 4
}, {
    label = TranslateCap('pants_2'),
    name = 'pants_2',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.5,
    textureof = 'pants_1'
}, {
    label = TranslateCap('shoes_1'),
    name = 'shoes_1',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.8,
    componentId = 6
}, {
    label = TranslateCap('shoes_2'),
    name = 'shoes_2',
    value = 0,
    min = 0,
    zoomOffset = 0.8,
    camOffset = -0.8,
    textureof = 'shoes_1'
}, {
    label = TranslateCap('mask_1'),
    name = 'mask_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 1
}, {
    label = TranslateCap('mask_2'),
    name = 'mask_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'mask_1'
}, {
    label = TranslateCap('bproof_1'),
    name = 'bproof_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 9
}, {
    label = TranslateCap('bproof_2'),
    name = 'bproof_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'bproof_1'
}, {
    label = TranslateCap('chain_1'),
    name = 'chain_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 7
}, {
    label = TranslateCap('chain_2'),
    name = 'chain_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'chain_1'
}, {
    label = TranslateCap('helmet_1'),
    name = 'helmet_1',
    value = -1,
    min = -1,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 0
}, {
    label = TranslateCap('helmet_2'),
    name = 'helmet_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'helmet_1'
}, {
    label = TranslateCap('glasses_1'),
    name = 'glasses_1',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    componentId = 1
}, {
    label = TranslateCap('glasses_2'),
    name = 'glasses_2',
    value = 0,
    min = 0,
    zoomOffset = 0.6,
    camOffset = 0.65,
    textureof = 'glasses_1'
}, {
    label = TranslateCap('watches_1'),
    name = 'watches_1',
    value = -1,
    min = -1,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 6
}, {
    label = TranslateCap('watches_2'),
    name = 'watches_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'watches_1'
}, {
    label = TranslateCap('bracelets_1'),
    name = 'bracelets_1',
    value = -1,
    min = -1,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 7
}, {
    label = TranslateCap('bracelets_2'),
    name = 'bracelets_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'bracelets_1'
}, {
    label = TranslateCap('bag'),
    name = 'bags_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    componentId = 5
}, {
    label = TranslateCap('bag_color'),
    name = 'bags_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15,
    textureof = 'bags_1'
}, {
    label = TranslateCap('eye_color'),
    name = 'eye_color',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eye_squint'),
    name = 'eye_squint',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_size'),
    name = 'eyebrows_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_type'),
    name = 'eyebrows_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_color_1'),
    name = 'eyebrows_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_color_2'),
    name = 'eyebrows_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_height'),
    name = 'eyebrows_5',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('eyebrow_depth'),
    name = 'eyebrows_6',
    value = 0,
    min = -10,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_type'),
    name = 'makeup_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_thickness'),
    name = 'makeup_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_color_1'),
    name = 'makeup_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('makeup_color_2'),
    name = 'makeup_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_type'),
    name = 'lipstick_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_thickness'),
    name = 'lipstick_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_color_1'),
    name = 'lipstick_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('lipstick_color_2'),
    name = 'lipstick_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('ear_accessories'),
    name = 'ears_1',
    value = -1,
    min = -1,
    zoomOffset = 0.4,
    camOffset = 0.65,
    componentId = 2
}, {
    label = TranslateCap('ear_accessories_color'),
    name = 'ears_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65,
    textureof = 'ears_1'
}, {
    label = TranslateCap('chest_hair'),
    name = 'chest_1',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('chest_hair_1'),
    name = 'chest_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('chest_color'),
    name = 'chest_3',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb'),
    name = 'bodyb_1',
    value = -1,
    min = -1,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb_size'),
    name = 'bodyb_2',
    value = 0,
    min = 0,
    zoomOffset = 0.75,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb_extra'),
    name = 'bodyb_3',
    value = -1,
    min = -1,
    zoomOffset = 0.4,
    camOffset = 0.15
}, {
    label = TranslateCap('bodyb_extra_thickness'),
    name = 'bodyb_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.15
}, {
    label = TranslateCap('wrinkles'),
    name = 'age_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('wrinkle_thickness'),
    name = 'age_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blemishes'),
    name = 'blemishes_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blemishes_size'),
    name = 'blemishes_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blush'),
    name = 'blush_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blush_1'),
    name = 'blush_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('blush_color'),
    name = 'blush_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('complexion'),
    name = 'complexion_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('complexion_1'),
    name = 'complexion_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('sun'),
    name = 'sun_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('sun_1'),
    name = 'sun_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('freckles'),
    name = 'moles_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('freckles_1'),
    name = 'moles_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_type'),
    name = 'beard_1',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_size'),
    name = 'beard_2',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_color_1'),
    name = 'beard_3',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
}, {
    label = TranslateCap('beard_color_2'),
    name = 'beard_4',
    value = 0,
    min = 0,
    zoomOffset = 0.4,
    camOffset = 0.65
} }
