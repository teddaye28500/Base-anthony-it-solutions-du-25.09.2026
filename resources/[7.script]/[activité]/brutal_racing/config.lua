


----------------------------------------------------------------------------------------------
-------------------------------------| BRUTAL GOKART :) |-------------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'ESX',  -- STANDALONE / ESX / QBCORE | Other core setting on the 'core' folder and the client and server utils.lua
    Spectate = true,  -- Spectate menu | true / false
    StartAnimation = true, -- Vehicle Camera Animation before the race | true / false
    DisableControls = {75}, -- Disables controls when the Player in Race | More keys: https://docs.fivem.net/docs/game-references/controls/
    SpecDisableControls = {202}, -- Disables controls when the Player in Spectator Mode | More keys: https://docs.fivem.net/docs/game-references/controls/
    AfkKick = {Use = true, CheckTime = 5}, -- When player afk in the Race, get kick out of the race? | true / false
    PlateText = 'RACER', -- The Race Vehicle Plate | Example: 'RACER 12' | RACER + RACER ID

    Races = {
        ['~g~∑ kart~g~ ∑'] = {
            MenuText = '~h~[E]~h~ pour lancer une ~r~course', -- Menu Open Label
            OpenMenuMarker = {distance = 15, opendistance = 1.5, sprite = 1, rotation = false, upanddown = false, brightness = 100, sizes = {x = 1.5, y = 1.5, z = 1.2}}, -- Menu Marker
            
            MenuColor = {r = 255, g = 0, b = 0}, -- Menu Color (RGB) | Colors >> https://www.w3schools.com/colors/colors_rgb.asp
            Image = 'gokart.png', -- png name / none | put the png >> html/assets

            StartPlace = {x = -155.1325, y = -2138.7854, z = 16.7050}, -- The Race menu position
            Blip = {Use = true, sprite = 611, color = 1, size = 0.6}, -- Race blip
            
            Countdown = 3, -- Countdown before the Start
            MaximumLaps = 3, -- Maximum Laps amount
            Vehicles = {  -- Vehicles (The Party leader can chose vehicle of these)
                {Label = 'Veto', Model = 'veto'},
                {Label = 'Veto2', Model = 'veto2'},
                -- you can add more vehicles...
            },
            
            MinimumPlayerToStart = 1,  -- These amount how many people, you need to start the race
            StartPositions = {
                [1] = {x = -108.9535, y = -2111.8296, z = 16.7050, heading = 109.7840},
                [2] = {x = -107.4270, y = -2115.7952, z = 16.7050, heading = 112.0350},
                [3] = {x = -103.9880, y = -2114.7769, z = 16.7050, heading = 108.7055},
                -- You can add more
            },

            UseBlipRoute = false, -- true / false
            CheckPoints = {
                -- type is always 'CHECK' except for finish
                [1] = {type = 'CHECK', x = -137.5697, y = -2124.6213, z = 16.7050},
                [2] = {type = 'CHECK', x = -103.6637, y = -2125.5085, z = 16.7050},
                [3] = {type = 'CHECK', x = -22.0583, y = -2090.0203, z = 16.7050},
                [4] = {type = 'CHECK', x = -92.0535, y = -2023.2430, z = 18.0168},
                [5] = {type = 'CHECK', x = -74.7696, y = -1989.4807, z = 18.0168},
                [6] = {type = 'CHECK', x = -116.3052, y = -2019.2426, z = 18.0174},
                [7] = {type = 'FINISH', x = -118.7661, y = -2117.7083, z = 16.7050},
            },
            
            CheckPointsMarkers = {
                -- Chekpoint sprites: https://docs.fivem.net/docs/game-references/checkpoints/
                AcceptDistance = 5.0,
                CheckPoints = {sprite = 12, size = 2.5, height = 0.7, r = 236, g = 240, b = 41, r2 = 11, g2 = 79, b2 = 217},
                NewLap = {sprite = 15, size = 4.0, height = 1.3, r = 255, g = 167, b = 95, r2 = 11, g2 = 79, b2 = 217},
                Finish = {sprite = 16, size = 5.0, height = 1.7, r = 255, g = 0, b = 0, r2 = 255, g2 = 255, b2 = 255},
            },

            Blips = {
                Racer = {Use = true, label = 'Racer', sprite = 1, color = 0, size = 0.5},
                Checkpoint = {label = 'Checkpoint', sprite = 1, color = 46, size = 0.8},
                NewLap = {label = 'New Lap', sprite = 1, color = 44, size = 0.9},
                Finish = {label = 'Finish', sprite = 1, color = 1, size = 0.9},
            },
            
        }, 

        -- Separate --

        ['~g~∑ Moto cross~g~ ∑'] = {
            MenuText = '~h~[E]~h~ pour lancer une ~b~course',
            OpenMenuMarker = {distance = 15, opendistance = 2.5, sprite = 1, rotation = false, upanddown = false, brightness = 100, sizes = {x = 1.5, y = 1.5, z = 1.2}},
            
            MenuColor = {r = 31, g = 76, b = 224},
            Image = 'motorcross.png',

            StartPlace = {x = 876.9960, y = 2353.6643, z = 51.1639},
            Blip = {Use = true, sprite = 379, color = 38, size = 0.6},
            
            Countdown = 3,
            MaximumLaps = 10,
            Vehicles = {
                {Label = 'Sanchez', Model = 'sanchez'},
                {Label = 'Sanchez 2', Model = 'sanchez2'},
                {Label = 'BF400', Model = 'bf400'},
            },
            
            MinimumPlayerToStart = 1,
            StartPositions = {
                [1] = {x = 891.4086, y = 2371.3882, z = 50.7886, heading = 186.1757}, 
                [2] = {x = 894.2198, y = 2371.9565, z = 51.0189, heading = 186.4175},
                [3] = {x = 890.9589, y = 2376.4568, z = 50.9534, heading = 186.5240},
                [4] = {x = 893.5837, y = 2376.1418, z = 50.8579, heading = 186.5240},
            },

            UseBlipRoute = false,
            CheckPoints = {
                [1] = {type = 'CHECK', x = 912.6369, y = 2266.5212, z = 44.6082},
                [2] = {type = 'CHECK', x = 1047.7155, y = 2193.2375, z = 44.4257},
                [3] = {type = 'CHECK', x = 1093.2423, y = 2160.5864, z = 52.8970},  
                [4] = {type = 'CHECK', x = 1164.6794, y = 2160.4233, z = 53.5996},
                [5] = {type = 'CHECK', x = 1104.5979, y = 2251.5044, z = 48.2457}, 
                [6] = {type = 'CHECK', x = 1000.3408, y = 2255.0613, z = 46.8931},
                [7] = {type = 'CHECK', x = 972.2839, y = 2393.9055, z = 51.0686},
                [8] = {type = 'CHECK', x = 1108.6628, y = 2410.5945, z = 50.1342},
                [9] = {type = 'CHECK', x = 1166.1816, y = 2263.1521, z = 49.7072},
                [10] = {type = 'CHECK', x = 1157.9310, y = 2472.8311, z = 53.4489},
                [11] = {type = 'CHECK', x = 982.0073, y = 2453.8176, z = 49.4780},  
                [12] = {type = 'CHECK', x = 912.4703, y = 2484.0940, z = 51.7866}, 
                [13] = {type = 'FINISH', x = 896.0545, y = 2345.9719, z = 51.8621},  
            },
            
            CheckPointsMarkers = {
                AcceptDistance = 7.0,
                CheckPoints = {sprite = 32, size = 7.0, height = -1.0, r = 236, g = 240, b = 41, r2 = 108, g2 = 183, b2 = 220},
                NewLap = {sprite = 3, size = 7.0, height = -1.0, r = 255, g = 167, b = 95, r2 = 11, g2 = 79, b2 = 217},
                Finish = {sprite = 4, size = 8.0, height = -1.0, r = 255, g = 0, b = 0, r2 = 255, g2 = 255, b2 = 255},
            },
            
            Blips = {
                Racer = {Use = true, label = 'Racer', sprite = 1, color = 0, size = 0.5},
                Checkpoint = {label = 'Checkpoint', sprite = 1, color = 46, size = 0.8},
                NewLap = {label = 'New Lap', sprite = 1, color = 44, size = 0.9},
                Finish = {label = 'Finish', sprite = 1, color = 1, size = 0.9},
            },
            
        },

        -- Separate --

        ['~g~∑ Buggy~g~ ∑'] = {
            MenuText = '~h~[E]~h~ pour lancer une ~g~course',
            OpenMenuMarker = {distance = 15, opendistance = 2.5, sprite = 1, rotation = false, upanddown = false, brightness = 100, sizes = {x = 1.5, y = 1.5, z = 1.2}},
            
            MenuColor = {r = 8, g = 158, b = 8},
            Image = 'street.png',

            StartPlace = {x = -791.09631347656, y = 5424.7900390625, z = 35.337730407715},   
            Blip = {Use = true, sprite = 315, color = 2, size = 0.6},
            
            Countdown = 3,
            MaximumLaps = 10,
            Vehicles = {
                {Label = 'Outlaw', Model = 'outlaw'},
                {Label = 'Zentorno', Model = 'zentorno'},
                {Label = 'T20', Model = 't20'},
                {Label = 'Tigon', Model = 'tigon'},
                {Label = 'Krieger', Model = 'krieger'},
            },
            
            MinimumPlayerToStart = 1,    
            StartPositions = {            
                [1] = {x = -784.35583496094, y = 5433.173828125, z =35.853755950928, heading = 278.64},  
                [2] = {x = -784.74591064453, y = 5429.2265625, z = 35.911685943604, heading = 278.64},    
                [3] = {x = -789.89935302734, y = 5427.6083984375, z = 35.544979095459, heading = 278.64},
                [4] = {x = -791.59033203125, y = 5431.8403320313, z = 35.370288848877, heading = 278.64},
            },

            UseBlipRoute = true,   
            CheckPoints = {
                [1] = {type = 'CHECK', x = -711.43096923828, y = 5437.1865234375, z = 44.415271759033},
                [2] = {type = 'CHECK', x = -707.58978271484, y = 5314.2475585938, z = 70.92749786377},
                [3] = {type = 'CHECK', x = -942.43023681641, y = 5277.5756835938, z = 81.223892211914},
                [4] = {type = 'CHECK', x = -632.04296875, y = 5098.9306640625, z = 130.39183044434},
                [5] = {type = 'CHECK', x = -511.0188293457, y = 4932.720703125, z = 147.27182006836}, 
                [6] = {type = 'CHECK', x = -520.06213378906, y = 4846.2236328125, z = 181.24252319336}, 
                [7] = {type = 'CHECK', x = -674.21057128906, y = 4736.23828125, z = 238.8740234375}, 
                [8] = {type = 'CHECK', x = -900.85656738281, y = 4768.2690429688, z = 294.60894775391},
                [9] = {type = 'CHECK', x = -1056.5718994141, y = 4775.3466796875, z = 235.57481384277},
                [10] = {type = 'CHECK', x = -1313.7264404297, y = 4852.1137695313, z = 143.45138549805},
                [11] = {type = 'CHECK', x = -1074.0432128906, y = 5073.4184570313, z = 162.35406494141}, 
                [12] = {type = 'CHECK', x = -737.87377929688, y = 5182.4731445313, z = 108.52027130127},
                [13] = {type = 'CHECK', x = -939.18395996094, y = 5280.9462890625, z = 81.011787414551},
                [14] = {type = 'CHECK', x = -668.44885253906, y = 5317.0834960938, z = 66.316131591797},
                [15] = {type = 'FINISH', x = -751.42779541016, y = 5439.0883789063, z = 39.605289459229},
            },
            
            CheckPointsMarkers = {
                AcceptDistance = 7.0,
                CheckPoints = {sprite = 32, size = 7.0, height = -1.0, r = 236, g = 240, b = 41, r2 = 108, g2 = 183, b2 = 220},
                NewLap = {sprite = 3, size = 7.0, height = -1.0, r = 255, g = 167, b = 95, r2 = 11, g2 = 79, b2 = 217},
                Finish = {sprite = 4, size = 8.0, height = -1.0, r = 255, g = 0, b = 0, r2 = 255, g2 = 255, b2 = 255},
            },
            
            Blips = {
                Racer = {Use = true, label = 'Racer', sprite = 1, color = 0, size = 0.5},
                Checkpoint = {label = 'Checkpoint', sprite = 1, color = 46, size = 0.8},
                NewLap = {label = 'New Lap', sprite = 1, color = 44, size = 0.9},
                Finish = {label = 'Finish', sprite = 1, color = 1, size = 0.9},
            },
        },

        -- You can add more Races...
    },

    -----------------------------------------------------------
    ---------------------| ADMIN COMMANDS |--------------------
    -----------------------------------------------------------

    AdminGroups = {'superadmin', 'admin', 'mod'},  -- Only if the Core = ESX / QBCORE
    IdentifierPermission = true,
    Admins = {
        'discord:858314326981214258',
        'discord:858314326981214258',

        --[[ TYPES ]]--
        -- 'steam:123456789',
        -- 'license:123456789',
        -- 'fivem:123456789',
        -- 'ip:123456789',
        -- 'discord:123456789',
    },

    AdminCommands = {
        ShowRaces = {Use = true, Command = 'showraces'},  -- /showraces
        CloseParty = {Use = true, Command = 'closeparty'}, -- /closeparty [Race Name] | Use the /showraces to get the partys names
        KickPlayer = {Use = true, Command = 'kickplayer'}, -- /kickplayer [Player ID]
    },
    
    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    MoneyForm = '$',
    Notify = {
        [1] =  {'Brutal Racing', "La Partie a déjà commencé!", 5000, 'error'},
        [2] =  {'Brutal Racing', "La Partie est complète!", 5000, 'error'},
        [3] =  {'Brutal Racing', "Vous êtes déjà dans la Partie!", 5000, 'error'},
        [4] =  {'Brutal Racing', "Il n’y a pas de joueur minimum!", 5000, 'error'},
        [5] =  {'Brutal Racing', "La Partie est déjà créé!", 5000, 'error'},
        [6] =  {'Brutal Racing', "Vous n’avez pas assez d’argent!", 5000, 'error'},
        [7] =  {'Brutal Racing', "Vous avez rejoint le groupe avec succès!", 5000, 'success'},
        [8] =  {'Brutal Racing', "Votre demande doit être acceptée!", 5000, 'info'},
        [9] =  {'Brutal Racing', "Votre demande a été acceptée!", 5000, 'success'},
        [10] =  {'Brutal Racing', "Votre demande a été rejetée!", 5000, 'error'},
        [11] =  {'Brutal Racing', "Vous avez été expulsé de la Partie!", 5000, 'error'},
        [12] =  {'Brutal Racing', "Vous êtes déjà sur la liste d’attente!", 5000, 'error'},
        [13] =  {'Brutal Racing', "Vous ne pouvez pas ouvrir le menu dans le véhicule!", 5000, 'error'},
        [14] =  {'Brutal Racing', "Vous ne pouvez pas quitter la Partie!", 5000, 'error'},
        [15] =  {'Brutal Racing', "Vous avez fermé le panneau de statistiques!", 5000, 'info'},
        [16] =  {'Brutal Racing', "Vous avez été expulsé de la Partie! (AFK)", 5000, 'info'},
        [17] =  {'Brutal Racing', "Vous êtes Partie trop loin!<br>La Partie a été fermée!", 5000, 'error'},
        [18] =  {'Brutal Racing', "Nom de la course:", 5000, 'info'},
        [19] =  {'Brutal Racing', "Vous n’êtes pas autorisé à utiliser cette commande!", 5000, 'error'},
        [20] =  {'Brutal Racing', "Joueur invalide ID!", 5000, 'error'},
        [21] =  {'Brutal Racing', "Partie invalide! [Use: /showraces]", 5000, 'error'},
        [22] =  {'Brutal Racing', "La Partie a été clôturée avec succès!", 5000, 'success'},
        [23] =  {'Brutal Racing', "Vous avez reçu votre prix:<b>", 5000, 'success'},
        [24] =  {'Brutal Racing', "Le joueur n’est pas dans un groupe!", 5000, 'error'},
        [25] =  {'Brutal Racing', "Vous avez été expulsé du groupe par un administrateur!", 5000, 'error'},
        [26] =  {'Brutal Racing', "Le joueur a été expulsé!", 5000, 'success'},
    }
}