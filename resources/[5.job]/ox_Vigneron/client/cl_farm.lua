ESX = exports["es_extended"]:getSharedObject()

-- Créer une table locale pour stocker les coordonnées
local boxZones = {
    { coords = vector3(-1874.7069, 2098.8540, 139.4133) }, -- Fait
    { coords = vector3(-1877.2382, 2098.8015, 139.5890) }, -- Fait
    { coords = vector3(-1878.7981, 2098.7197, 139.7232) }, -- Fait
    { coords = vector3(-1880.3070, 2098.8291, 139.7157) }, -- Fait
    { coords = vector3(-1882.0720, 2098.7607, 139.6916) }, -- Fait
    { coords = vector3(-1883.7555, 2098.6379, 139.6521) }, -- Fait
    { coords = vector3(-1885.5819, 2099.0435, 139.4313) }, -- Fait
}

-- Parcourez la table des zones de boîte et ajoutez-les une par une
for _, zone in ipairs(boxZones) do
    exports.ox_target:addBoxZone({
        coords = zone.coords,
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                event = 'NSX:RammasRaisin',
                icon = 'fa-regular fa-user',
                label = "Recolté les raisin",
                distance = 3
            }
        }
    })
end

--- Recolté les raisin 
RegisterNetEvent('NSX:RammasRaisin')
AddEventHandler('NSX:RammasRaisin', function()
    TriggerServerEvent('NSX:Rasin')
end)

RegisterNetEvent('NSX:RasinRecolteCircleBar')
AddEventHandler('NSX:RasinRecolteCircleBar', function()
    TriggerEvent("NSX:Animation:Raisin0")

    lib.progressCircle({
        duration = 3500,
        label = 'Recolte des Raisin',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("NSX:Raisin0:StopAnimation")
end)

RegisterNetEvent("NSX:Animation:Raisin0")
AddEventHandler("NSX:Animation:Raisin0", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("NSX:Raisin0:StopAnimation")
AddEventHandler("NSX:Raisin0:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

-- Traitement raisin blanc & rouge 

exports.ox_target:addBoxZone({
    coords = {x = -1874.485, y = 2059.276, z = 135.9151},
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'box',
            event = 'NSX:TraiteRaisin',
            icon = 'fa-regular fa-user',
            label = "Traitement Rasin",
            job = "vigneron",
        }
    }
})
--- Traitement des raisin 
RegisterNetEvent('NSX:TraiteRaisin')
AddEventHandler('NSX:TraiteRaisin', function()
    lib.showContext('NSX:Menutraitement')
end)

--- Menu Traitement Vigneron
lib.registerContext({
    id = 'NSX:Menutraitement',
    title = 'Pressage de raisin',
    options = {
        {
            title = 'Pressage de raisin rouge',
            icon = 'fa fa-fire',
            event = 'NSX:TraiteRaisinRouge',
        },
        {
            title = 'Pressage de raisin blanc',
            icon = 'fa fa-fire',
            event = 'NSX:TraiteRaisinBlanc',
        },
    },
})

--- Traitement des raisin 
RegisterNetEvent('NSX:TraiteRaisinRouge')
AddEventHandler('NSX:TraiteRaisinRouge', function()
    TriggerServerEvent('NSX:RaisinTraiteRouge')
end)

--- Traitement des raisin 
RegisterNetEvent('NSX:TraiteRaisinBlanc')
AddEventHandler('NSX:TraiteRaisinBlanc', function()
    TriggerServerEvent('NSX:RaisinTraiteBlanc')
end)

RegisterNetEvent('NSX:RasinTraiteCircleBar')
AddEventHandler('NSX:RasinTraiteCircleBar', function()
    TriggerEvent("NSX:Animation:Raisin2")

    lib.progressCircle({
        duration = 3500,
        label = 'Presse les Raisin',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("NSX:Raisin2:StopAnimation")
end)

RegisterNetEvent("NSX:Animation:Raisin2")
AddEventHandler("NSX:Animation:Raisin2", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("NSX:Raisin2:StopAnimation")
AddEventHandler("NSX:Raisin2:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

-- Traitement raisin blanc & rouge 

exports.ox_target:addBoxZone({
    coords = {x = -1891.648, y = 2064.104, z = 145.5738},
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'box',
            event = 'NSX:bouteilleraisin',
            icon = 'fa-regular fa-user',
            label = "Mise en bouteille",
            job = "vigneron",
        }
    }
})
--- Traitement des raisin 
RegisterNetEvent('NSX:bouteilleraisin')
AddEventHandler('NSX:bouteilleraisin', function()
    lib.showContext('NSX:MenuBouteille')
end)

--- Menu Traitement Vigneron
lib.registerContext({
    id = 'NSX:MenuBouteille',
    title = 'Mise en bouteille',
    options = {
        {			
            title = 'Vin Rouge',
            description = 'Besoin : ' .. Config.BarqueRouge.removebarquerouge ..  ' raisain rouge presser',
            event = 'NSX:TraiteRaisinRouge2',
            icon = 'wine-bottle',					
        },
        {			
            title = 'Vin Blanc',
            description = 'Besoin : ' .. Config.BarqueBlanc.removebarqueblanc ..  ' raisain blanc presser',
            event = 'NSX:TraiteRaisinBlanc2',
            icon = 'wine-bottle',					
        },
    },
})

--- Traitement des raisin 
RegisterNetEvent('NSX:TraiteRaisinRouge2')
AddEventHandler('NSX:TraiteRaisinRouge2', function()
    TriggerServerEvent('NSX:RaisinTraiteRouge2')
end)

--- Traitement des raisin 
RegisterNetEvent('NSX:TraiteRaisinBlanc2')
AddEventHandler('NSX:TraiteRaisinBlanc2', function()
    TriggerServerEvent('NSX:RaisinTraiteBlanc2')
end)

RegisterNetEvent('NSX:RasinTraiteCircleBar2')
AddEventHandler('NSX:RasinTraiteCircleBar2', function()
    TriggerEvent("NSX:Animation:Raisin3")

    lib.progressCircle({
        duration = 3500,
        label = 'Mise en bouteille',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("NSX:Raisin3:StopAnimation")
end)

RegisterNetEvent("NSX:Animation:Raisin3")
AddEventHandler("NSX:Animation:Raisin3", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("NSX:Raisin3:StopAnimation")
AddEventHandler("NSX:Raisin3:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

-- Ped vente Grossiste
Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_y_soucent_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "a_m_y_soucent_02", vector4(90.9538, -1603.5936, 30.0791, 231.0100), true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)  

-- Vente Grosiste

exports.qtarget:AddBoxZone("Vigneron Vente", vector3(91.2429, -1603.7640, 30.0791), 2.0 , 2.5, {	
	name="Vigneron Vente",
	heading=35,
	debugPoly=false,
	minZ=16.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "NSX:ventevinrouge",
				icon = "fa fa-fire",
				label = "Vente Vin rouge",
				job = "vigneron",
			},

			{
				event = "NSX:ventevinblanc",
				icon = "fa fa-fire",
				label = "Vente Vin Blanc",
				job = "vigneron",
			},

		},
	distance = 5.0
})
  
-- Gestion de la vente de vin rouge côté client
RegisterNetEvent('NSX:ventevinrouge')
AddEventHandler('NSX:ventevinrouge', function()
    TriggerServerEvent('NSX:VinRougeVente')
end)

--- Vente vin blanc 
RegisterNetEvent('NSX:ventevinblanc')
AddEventHandler('NSX:ventevinblanc', function()
    TriggerServerEvent('NSX:VinBlancVente')
end)

RegisterNetEvent('NSX:VenteBouteille')
AddEventHandler('NSX:VenteBouteille', function()
    TriggerEvent("NSX:Animation:Vente")

    lib.progressCircle({
        duration = 3500,
        label = 'Mise en bouteille',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("NSX:Vente:StopAnimation")
end)

RegisterNetEvent("NSX:Animation:Vente")
AddEventHandler("NSX:Animation:Vente", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("NSX:Vente:StopAnimation")
AddEventHandler("NSX:Vente:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

RegisterNetEvent('NSX:notifySuccess', function(quantity, total)
    lib.notify({
        title = 'Vente réussie',
        description = ('Vous avez vendu %s bouteille(s) pour %s$ qui ont été ajoutés à la société.'):format(quantity, total),
        position = 'top',
        style = {
            backgroundColor = '#004225',
            color = '#B2FFBD',
            ['.description'] = {
                color = '#FFFFFF'
            }
        },
        icon = 'check-circle',
        iconColor = '#B2FFBD'
    })
end)

RegisterNetEvent('NSX:notifyError', function()
    lib.notify({
        title = 'Erreur',
        description = 'Vous n\'avez pas de bouteilles à vendre !',
        position = 'top',
        style = {
            backgroundColor = '#2A0000',
            color = '#FFBDBD',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'triangle-exclamation',
        iconColor = '#FFBDBD'
    })
end)