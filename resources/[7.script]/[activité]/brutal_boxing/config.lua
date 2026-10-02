----------------------------------------------------------------------------------------------
-------------------------------------| BRUTAL BOXING :) |-------------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'ESX',  -- 'ESX' / 'QBCORE' | Other core setting on the 'core' folder.
    TextUI = 'ox_lib', -- 'ox_lib' / 'okokTextUI' / 'ESXTextUI' / 'QBDrawText' // Custom can be add in the cl_utils.lua!!!
    BrutalNotify = false, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    SteamName = true, -- true = Steam name | false = character name

    Marker = {use = true, marker = 20, bobUpAndDown = true, rotate = false, size = {0.3, 0.2, 0.2}, rgb = {15, 100, 210}},
    DisableControls = {22}, -- These controls will blocked during the boxing match.
    DemageModifier = {Use = true, Basic = 0.25, Glove = 0.15},
    TimeToBet = 30, -- After the start there is this time to bet.

    Areas = {
        -- INFO: The ring names can't be same. Each one should have a different name.--

        ['ufc'] = { 
            Time = 60,
            Start = vector3(-295.3483581543, -1998.3304443359, 30.135353088379),
            Player1 = vector4(-298.43188476563, -1992.3775634766, 30.966032028198, 275.11459350586),
            Player2 = vector4(-291.18643188477, -1992.0543212891, 30.966032028198, 99.72437286377),
        },

        ['Club de boxe'] = { -- MLO [FREE]: https://www.gta5-mods.com/maps/mlo-underground-box-ring-at-tequilala-sp-fivem
            Time = 60,
            Start = vector3(-569.18591308594,286.02615356445,77.676445007324),
            Player1 = vector4(-553.72277832031,286.39297485352,78.526527404785, 119.67),
            Player2 = vector4(-559.54205322266,281.52862548828,78.526527404785, 313.32),
        },

        ['boxe de rue'] = { -- MLO [FREE]: https://www.gta5-mods.com/maps/mlo-underground-box-ring-at-tequilala-sp-fivem
            Time = 60,
            Start = vector3(-523.16363525391, -1716.4436035156, 19.309118270874),
            Player1 = vector4(-521.95288085938, -1712.3181152344, 20.461315155029, 267.14727783203),
            Player2 = vector4(-513.70172119141, -1711.6998291016, 20.461292266846, 86.127632141113),
        },

        ['boxe de rue2'] = { -- MLO [FREE]: https://www.gta5-mods.com/maps/mlo-underground-box-ring-at-tequilala-sp-fivem
            Time = 60,
            Start = vector3(653.95422363281, -1508.2244873047, 10.681735992432),
            Player1 = vector4(655.79925537109, -1499.3367919922, 10.681735038757, 238.75134277344),
            Player2 = vector4(661.03594970703, -1501.9327392578, 10.681735038757, 60.499885559082),
        },                

        ['~g~∑ Activités Boxe~g~ ∑ '] = { -- MLO [FREE]: https://gta5mod.net/gta-5-mods/maps/fight-ring-add-on-sp-fivem-1-0/
            Time = 60,
            Blip = {color = 27, sprite = 311, size = 0.6},
            Start = vector3(-1276.9813232422,-1538.4147949219,4.3136792182922),
            Player1 = vector4(-1271.4685058594,-1529.02734375,5.15412044525159, 120.81),
            Player2 = vector4(-1278.0476074219,-1532.7025146484,5.15411901474, 283.0),
        },                

        ['angels shoppers'] = {
            Time = 60,
            Start = vector3(-70.445442199707, 6494.140625, 31.490886688232),
            Player1 = vector4(-66.520523071289, 6493.6323242188, 32.309814453125, 185.25442504883),
            Player2 = vector4(-66.63191986084, 6487.5927734375, 32.309814453125, 2.2473373413086),
        },
    },
   
    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    MoneyForm = '$', -- Money form

    Locales = {
        Male = 'Male',
        Female = 'Female',
    },

    MenuOpen = {'[E] - Boxing Menu', 38}, -- Label, control1
    
    -- Notify function EDITABLE >> cl_utils.lua
    Notify = { 
        [1] = {"Boxing", "Vous êtes déjà inscrit!", 5000, "error"},
        [2] = {"Boxing", "L’opposant a quitté la parti.", 5000, "info"},
        [3] = {"Boxing", "Vous avez déjà parié!", 5000, "error"},
        [4] = {"Boxing", "Vous avez réussi votre pari: <b>", 5000, "success"},
        [5] = {"Boxing", "Vous avez récupéré le montant de la mise:", 5000, "info"},
        [6] = {"Boxing", "Vous n’avez pas assez d’argent.", 5000, "error"},
        [7] = {"Boxing", "Vous avez gagner", 5000, "success"},
        [8] = {"Boxing", "Vous n’avez pas gagné.", 5000, "error"},
    }
}



