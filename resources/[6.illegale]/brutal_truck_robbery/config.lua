


----------------------------------------------------------------------------------------------
----------------------------------| BRUTAL TRUCK ROBBERY :) |---------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'ESX',  -- ESX / QBCORE | Other core setting on the 'core' folder and the client and server utils.lua
    BrutalNotify = false, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    CopsJobs = {'police', 'sheriff'}, -- Add the cops jobs
    RequiredCopsCount = 0, -- This is how many cops are needed to be in the server to start a robbery
    GiveBlackMoney = true, -- true / false | ONLY IN ESX
    Cooldown = 15, -- The time between robberies | in minutes
    BagNumber = 45,

    PoliceAlertBlip = {label = 'Truck Robbery', size = 1.0, sprite = 161, color = 1},
    TruckBlip = {label = 'Truck', size = 1.0, sprite = 85, color = 43},
    CollectableBlip = {label = 'Collectable', size = 0.7, sprite = 568, colour = 2},
    EnemyBlip = {label = 'NPC', size = 0.7, sprite = 270, colour = 1},
    
    BossModel = 'a_m_y_soucent_02',
    BossCoords = vector4(257.4908, -1722.8832, 29.6541, 317.6606),

    EnemyCount = 3,
    EnemiesModel = "a_m_m_soucent_03",
    EnemiesCoords = vector4(-556.6471, -1798.4000, 22.5874, 329.6938),

    Trucks = {
        [1] = {
            truckSpawn = vector4(-151.5961, -1920.3593, 24.7167, 45.3662),
            destination = vector3(130.6463, -1063.3026, 29.1924),
        },
    },

    TruckRewardItems = {
        {label = 'Gold', item = 'gold', count = {5, 10}, sellPrice = 1000},
        {label = 'Diamond', item = 'diamond', count = {5, 10}, sellPrice = 2000},
    },

    ItemsSellToBoss = {
        use = true, -- Use item sell functions? | you can use your custom too
        availableTime = 30, -- in minutes [That's how long the player have to deliver the items after the robbery]
        coords = vector4(-1233.7051, -1428.0791, 3.3256, 37.4345), -- Sell coords
        model = 'a_m_m_eastsa_01', -- Sell NPC model
        blip = {use = true, label = 'Items Sell', size = 0.9, sprite = 500, color = 2} -- Sell Blip
    },
    
    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    MoneyForm = '$',
    SecondForm = 'second',
    GrabMoney = 'Saisir de l\'argent',

    HelpNotify = {
        [1] = {'Appuyez sur ~INPUT_PICKUP~ pour parler au Boss', 38},
        [2] = {'Appuyez sur ~INPUT_PICKUP~ pour placer la dynamite', 38},
        [3] = {'Appuyez sur ~INPUT_PICKUP~ pour fouiller le camion.', 38},
        [4] = {'Maintenez [G] pour vous échapper', 47},
        [5] = {'Appuyez sur ~INPUT_PICKUP~ pour ramasser les papiers.', 38},
        [6] = {'Appuyez sur ~INPUT_PICKUP~ pour vendre les objets', 38},
    },    

    Notify = {
        [1] = {'Notification', "Piratage : ÉCHEC !", 5000, 'error'},
        [2] = {'Notification', "Piratage : RÉUSSI !", 5000, 'success'},
        [3] = {'Notification', "Piratage : TEMPS ÉCOULÉ !", 5000, 'error'},
        [4] = {'Notification', "Un braquage est déjà en cours.", 5000, 'error'},
        [5] = {'Notification', "Un braquage a eu lieu récemment, veuillez patienter !", 5000, 'error'},
        [6] = {'Notification', "Pas assez de policiers en ville !", 5000, 'error'},
        [7] = {'Notification', "Braquage échoué : Le camion est déjà arrivé !", 5000, 'error'},
        [8] = {'Notification', "Vous ne pouvez pas braquer un véhicule en mouvement.", 5000, 'error'},
        [9] = {'Notification', "Rangez votre arme !", 5000, 'error'},
        [10] = {'Notification', "Temps écoulé ! Le Boss est parti !", 5000, 'error'},
        [11] = {'Notification', "Vous n'avez rien d'utile sur vous !", 5000, 'error'},
        [12] = {'Notification', "Vous avez vendu :", 8000, 'success'},
        [13] = {'Notification', "Vous avez reçu :", 5000, 'success'},
    },
    

    InstructionTexts = {
        [1] = {'Allez aux coordonnées et volez la tablette pour obtenir l’emplacement du transporteur d’argent.'},
        [2] = {'Allez à l’arrière du camion et faites sauter les portes !'},
        [3] = {'Le camion est marqué sur la carte ! Braquez-le !'},
        [4] = {'Vendez les objets à l’endroit désigné !'},
    },    

    SuccessRobbery = {
        Use = true,
        missionTextLabel = "~y~BRAQUAGE DE CAMION~s~", 
        passFailTextLabel = "RÉUSSI.",
        messageLabel = "Échappez-vous de la police.",
        
        totalPayOut = "Paiement total",
    },    

    FailedRobbery = {
        Use = true,
        missionTextLabel = "~y~BRAQUAGE DE CAMION~s~", 
        passFailTextLabel = "ÉCHEC.",
        messageLabel = "Cette fois, c’est raté."
    },    

    IdentifierType = 'steam',  -- steam / license / discord
    Webhooks = {
        Locale = {
            ['robberyProcess'] = '⌛ Robbery started...',
            ['robberyFinished'] = '✅ Robbery finished.',

            ['HasStarted'] = 'started the Truck Robbery!',
            ['HasFinished'] = 'finished the Truck Robbery!',
            ['RobberHasQuit'] = '**The robber has quit the game!\nThe robbery is finished!**',

            ['Identifier'] = 'Identifier',
            ['Time'] = 'Time ⏲️'
        },

        -- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html
        Colors = {
            ['robberyProcess'] = 3145631, 
            ['robberyFinished'] = 16711680
        }
    },
}