ESX = exports['es_extended']:getSharedObject()
TriggerEvent('esx_society:registerSociety', 'cbd', 'CBD', 'society_cbd', 'society_cbd', 'society_cbd', {type = 'public'})

--- F6
lib.registerContext({
    id = 'menu_cbd',
    title = '🍁 Menu cbd',
    options = {
        {
            title = '📢 Annonces',
            icon = 'wifi',
            menu = 'annonce_menucbd',
        },
        {
            title = '💸 Facture',
            icon = 'file-lines',
            event = 'cbd:sendbill'
        },
    },
    {
        id = 'annonce_menucbd',
        title = '📢 Annonces',
        menu = 'menu_cbd',
        options = {
            ['✅ Ouvert'] = {event = 'cbd:annonce', icon = 'fa fa-check-circle', args = 'ouvert'},
            ['❌ Fermer'] = {event = 'cbd:annonce', icon = 'fa fa-times-circle', args = 'fermer'},
            ['👥 Recruter'] = {event = 'cbd:annonce', icon = 'fa fa-circle-info', args = 'recruter'},
            ['🚨 Personnalisé'] = {event = 'cbd:annoncePerso', icon = 'fa-comment'}
        }
    },
  })

  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 167) then -- Touche F6
            local xPlayer = ESX.GetPlayerData()
            if xPlayer.job.name == 'cbd' then
                lib.showContext('menu_cbd')
            end
        end
    end
  end)

-- 📢 Gestion des annonces
RegisterNetEvent('cbd:annonce')
AddEventHandler('cbd:annonce', function(type)
    local events = {
        ouvert = 'annonceOcbdserveur',
        fermer = 'annonceFcbdserveur',
        recruter = 'annonceRcbdserveur'
    }
    if events[type] then
        TriggerServerEvent(events[type])
    end
end)

RegisterNetEvent('cbd:annoncePerso')
AddEventHandler('cbd:annoncePerso', function()
    local input = lib.inputDialog('Annonce CBD', {'Message'})
    if input and input[1] ~= "" then
        TriggerServerEvent('cbd:SendAnnonce', input[1])
    else
        lib.notify({ title = 'Erreur', description = 'Vous devez entrer un message !', type = 'error' })
    end
end)

--- Facture
RegisterNetEvent('cbd:sendbill')
AddEventHandler('cbd:sendbill', function()
      local input = lib.inputDialog('Facture Cbd', {'Amount'})

           if input then
                local amount = tonumber(input[1])

                if amount == nil or amount < 0 then
                    ESX.ShowNotification('Montant Invalide')
                else
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 4.0 then
                    ESX.ShowNotification('~r~Personne proche !')
                else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_cbd', 'Facture Cbd', amount)
                ESX.ShowNotification("Facture envoyée")
            end
        end
    end
end)

-- Ped

local pedvente = nil

Citizen.CreateThread(function()
    local pedModel = GetHashKey("s_m_m_trucker_01")

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end

    pedvente = CreatePed(4, pedModel, -1168.6036376953,-1572.8452148438,3.663622379303, 127.3447, false, true)
    SetEntityHeading(pedvente, 127.38)
    SetEntityInvincible(pedvente, true)
    SetPedCombatAttributes(pedvente, 46, true)
    SetPedCombatAbility(pedvente, 0)
    SetPedCanSwitchWeapon(pedvente, false)
    SetBlockingOfNonTemporaryEvents(pedvente, true)
    Wait(1500)
    FreezeEntityPosition(pedvente, true)
end)

-- Job Blip

Citizen.CreateThread(function()
    local blipMarker = Config.Blips.Cbd
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("CBD")
    EndTextCommandSetBlipName(blipCoord)
end)







-- Targets

exports.qtarget:AddBoxZone("Recolte1", vector3(169.05296325684, -245.64483642578, 50.161220550537), 2.4, 20, {
	name="Recolte1",
	heading=355,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:Recoltefeuillecbdb",
				label = "Récolter",
                icon = "fa-solid fa-hands",
				job = "cbd",
			},
		},
		distance = 2.5
})
exports.qtarget:AddBoxZone("Recolte2", vector3(162.36128234863, -244.32145690918, 50.114711761475), 2.4, 20, {
	name="Recolte2",
	heading=21,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:Recoltefeuillecbdk",
				label = "Récolter",
                icon = "fa-solid fa-hands",
				job = "cbd",
			},
		},
		distance = 1.5
})

exports.qtarget:AddBoxZone("Traiterfeuillecbdb", vector3(166.1649017334, -235.16229248047, 50.05525970459), 2.4, 1, {
	name="Traiterfeuillecbdb",
	heading=21,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:Traiterfeuillecbdb",
				label = "Préparation de pochons de blue'dream",
                icon = "fa-solid fa-hands",
				job = "cbd",
			},
		},
		distance = 2.5
})
exports.qtarget:AddBoxZone("Traiterfeuillecbdk", vector3(165.4460144043, -232.81883239746, 50.055252075195), 2.4, 1, {
	name="Traiterfeuillecbdk",
	heading=21,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:Traiterfeuillecbdk",
				label = "Préparation de pochons de banana'kush",
                icon = "fa-solid fa-hands",
				job = "cbd",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("Traiterbananakush", vector3(185.353, -257.97, 53.09), 2.4, 1, { 
	name="Traiterbananakush",
	heading=21,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:Traiterbananakush",
				label = "Préparation de Joint de banana'kush",
                icon = "fa-solid fa-hands",
				job = "cbd",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("Traiterbluedream", vector3(183.006, -264.27, 53.09), 2.4, 1, { 
	name="Traiterbluedream",
	heading=21,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:Traiterbludream",
				label = "Préparation de Joint de blue'dream",
                icon = "fa-solid fa-hands",
				job = "cbd",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("Vente", vector3(-1168.6036376953,-1572.8452148438,4.663622379303), 2.4, 1, {
	name="Vente",
	heading=21,
	debugPoly=false,
	minZ=2.98,
	maxZ=5.98,
	}, {
		options = {
			{
				event = "nsx:VenteMalboro",
				label = "Vendre de la blue'dream",
                icon = "fa-solid fa-money-bill-wave",
				job = "cbd",
			},
            {
				event = "nsx:VenteRedwood",
				label = "Vendre de la banana'kush",
                icon = "fa-solid fa-money-bill-wave",
				job = "cbd",
			},
		},
		distance = 2.5
})

-- Animation Récolte

RegisterNetEvent("nsx:toggleCrouch")
AddEventHandler("nsx:toggleCrouch", function()
    local playerPed = PlayerPedId()
    if not crouchAnimPlaying then
        crouchAnimPlaying = true
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        Citizen.Wait(8000) 
        ClearPedTasks(playerPed)
        crouchAnimPlaying = false
    end
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        
        Citizen.Wait(1)
    end
end

RegisterNetEvent("nsx:VenteAnim")
AddEventHandler("nsx:VenteAnim", function()
    local playerPed = PlayerPedId()
    loadAnimDict('mp_common')

    TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(2500) 
    ClearPedTasks(playerPed)

    if pedvente then
        loadAnimDict('mp_common')

        TaskPlayAnim(pedvente, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        Citizen.Wait(2500) 
        ClearPedTasks(pedvente)
    end
end)

-- Récolte Raisin Blanc

RegisterNetEvent("nsx:Recoltefeuillecbdb")
AddEventHandler("nsx:Recoltefeuillecbdb", function()
    if EstEnService() then
        TriggerEvent("nsx:toggleCrouch")
        lib.progressCircle({
            duration = 10000,
            label = 'Récolte de feuille cbd dream',
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
            },
            anim = {},
            prop = {},
        })
        TriggerServerEvent("nsx:Givefeuillecbdb", math.random(2, 4))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)


-- Récolte Raisin Redwood

RegisterNetEvent("nsx:Recoltefeuillecbdk")
AddEventHandler("nsx:Recoltefeuillecbdk", function()
    if EstEnService() then
TriggerEvent("nsx:toggleCrouch") 
lib.progressCircle({
    duration = 10000,
    label = 'Récolte de feuille cbd kush',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
})
    TriggerServerEvent("nsx:Givefeuillecbdk", math.random(4, 8))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)





RegisterNetEvent("nsx:Traiterfeuillecbdb")
AddEventHandler("nsx:Traiterfeuillecbdb", function()
    if EstEnService() then
TriggerEvent("nsx:toggleCrouch") 
lib.progressCircle({
    duration = 10000,
    label = 'Assemblage ',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
})
    TriggerServerEvent("nsx:Giveblue_dream_bag", math.random(1, 2))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)

-- Traitement Raisin Redwood

RegisterNetEvent("nsx:Traiterfeuillecbdk")
AddEventHandler("nsx:Traiterfeuillecbdk", function()
    if EstEnService() then
TriggerEvent("nsx:toggleCrouch") 
lib.progressCircle({
    duration = 10000,
    label = 'Assemblage',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
})
    TriggerServerEvent("nsx:Givebanana_kush_bag", math.random(1, 2))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)


RegisterNetEvent("nsx:Traiterbananakush")
AddEventHandler("nsx:Traiterbananakush", function()
    if EstEnService() then
TriggerEvent("nsx:toggleCrouch") 
lib.progressCircle({
    duration = 10000,
    label = 'Assemblage',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
})
    TriggerServerEvent("nsx:Givebanana_kush_joint", math.random(1, 2))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)

RegisterNetEvent("nsx:Traiterbludream")
AddEventHandler("nsx:Traiterbludream", function()
    if EstEnService() then
TriggerEvent("nsx:toggleCrouch") 
lib.progressCircle({
    duration = 10000,
    label = 'Assemblage',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
})
    TriggerServerEvent("nsx:Giveblue_dream_joint", math.random(1, 2))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)

-- Vente Raisin Redwood

RegisterNetEvent("nsx:VenteMalboro")
AddEventHandler("nsx:VenteMalboro", function()
    if EstEnService() then
TriggerEvent("nsx:VenteAnim") 
 lib.progressCircle({
    duration = 5000,
    label = 'Vente de Joint de blue dream',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
}) 
    TriggerServerEvent("nsx:Ventefeuillecbdb", math.random(1, 2))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)

-- Vente Raisin blanc

RegisterNetEvent("nsx:VenteRedwood")
AddEventHandler("nsx:VenteRedwood", function()
    if EstEnService() then
TriggerEvent("nsx:VenteAnim") 
 lib.progressCircle({
    duration = 5000,
    label = 'Vente de Joint de banana kush',
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
    },
    anim = {},
    prop = {},
}) 
    TriggerServerEvent("nsx:Ventefeuillecbdk", math.random(1, 2))
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous devez être en service pour pouvoir travailler !',
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
    end
end)




exports.qtarget:AddBoxZone("CbdBill", vector3(188.39254760742, -240.87309265137, 54.070487976074), 2.0 , 1.5, {
	name="CbdBill",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{                                                                 
				event = "cbd:sendbill",
				icon = "fa fa-calculator",
				label = "Facture consommation",
				job = "cbd",
			},
		},
		distance = 2.5
})

-- PATRON 

exports.qtarget:AddBoxZone("CbdBoss", vector3(Config.bosscbd.x, Config.bosscbd.y, Config.bosscbd.z), 1.0 , 1.5, {
	name="CbdBoss",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:bosscbd",
				icon = "fas fa-user",
				label = "Boss CBD",
				job = "cbd",
			},
		},
	distance = 2.5
})

RegisterNetEvent('nsx:bosscbd')
AddEventHandler('nsx:bosscbd', function()
	OpenCbdBoss()
end)

function OpenCbdBoss()
	TriggerEvent('esx_society:openBossMenu', 'cbd', function(data, menu)

	end, { wash = false })
end


RegisterNetEvent('cbd:sendbill')
AddEventHandler('cbd:sendbill', function()
	ExecuteCommand('e notepad')
      local input = lib.inputDialog('FACTURE', {'Amount'})
	  ClearPedTasksImmediately(PlayerPedId())

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_cbd', 'Facture', amount)
			end
		end
    end
end)