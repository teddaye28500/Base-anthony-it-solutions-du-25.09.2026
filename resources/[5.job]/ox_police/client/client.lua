lib.locale()

--############################
--########### Blips ##########
--############################

CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.Blip.Name)
		EndTextCommandSetBlipName(blip)
	end
end)

--############################
--############ Boss ##########
--############################

RegisterNetEvent('police:bossmenu')
AddEventHandler('police:bossmenu', function()
    TriggerEvent('esx_society:openBossMenu', 'police', function(data)
    end, { wash = false })
end)

CreateThread(function()
    for i=1, #Config.Bossmenu do
        exports.qtarget:AddBoxZone(i.."_police_menu", Config.Bossmenu[i].coords, 1.0, 1.0, {
            name=i.."_police_menu",
            heading=Config.Bossmenu[i].heading,
            debugPoly=false,
            minZ=Config.Bossmenu[i].coords.z-1.5,
            maxZ=Config.Bossmenu[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'police:bossmenu',
                    icon = Config.Bossmenu[i].icon,
                    label = Config.Bossmenu[i].labeltarget,
                    job = "police",
                }
            },
            distance = 1.5
        })
    end
end)

--#################################
--############ Vetements ##########
--#################################

CreateThread(function()
    for i = 1, #Config.VetementsPolice do
        exports.qtarget:AddBoxZone(i .. "_vetementpolice_menu", Config.VetementsPolice[i].coords, 1.0, 1.0, {
            name = i .. "_vetementpolice_menu",
            heading = Config.VetementsPolice[i].heading,
            debugPoly = false,
            minZ = Config.VetementsPolice[i].coords.z - 1.5,
            maxZ = Config.VetementsPolice[i].coords.z + 1.5
        }, {
            options = {
                {
                    event = 'openpoliceclothing',
                    icon = Config.VetementsPolice[i].icon,
                    label = Config.VetementsPolice[i].labeltarget,
                    job = "police",
                }
            },
            distance = 1.5
        })
    end
end)

RegisterNetEvent('openpoliceclothing')
AddEventHandler('openpoliceclothing', function()
	lib.registerContext({
		id = 'openclothingpolice',
		title = Config.Clothing.Title,
		onExit = function()
		end,
		options = {
			{
				event = "policedefaultskin", 
				icon = Config.Clothing.OwnIcon,
				description = Config.Clothing.OwnDescription,
				title = Config.Clothing.OwnLabel,
			},
			{
				event = "policechangeclothes",
				title = Config.Clothing.EmployerLabel,
				icon = Config.Clothing.EmployerIcon,
				description = Config.Clothing.EmployerDescription,
			},
		},
	})
	lib.showContext('openclothingpolice')
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			Notification("error", "", locale('nooutfit'))
		end
	end)
end

RegisterNetEvent('policedefaultskin')
AddEventHandler('policedefaultskin', function()
	dict = "clothingshirt"
    clip = "try_shirt_positive_d"
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
    FreezeEntityPosition(cache.ped, true)
	ProgressBar(Config.LoadProgress.Civilclothe.Duration, Config.LoadProgress.Civilclothe.Label)
    StopAnimTask(cache.ped, dict, clip, 1.0)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasks(cache.ped)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent('policechangeclothes')
AddEventHandler('policechangeclothes', function()
	local playerPed = PlayerPedId()
	dict = "clothingshirt"
    clip = "try_shirt_positive_d"
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
    FreezeEntityPosition(cache.ped, true)
	ProgressBar(Config.LoadProgress.Employerclothe.Duration, Config.LoadProgress.Employerclothe.Label)
    StopAnimTask(cache.ped, dict, clip, 1.0)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasks(cache.ped)
    setUniform('employer', playerPed)
end)

--####################################
--########### Progresse bar ##########
--####################################
ProgressBar = function(duration, label)
    if Config.Progress == "bar" then
        lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false
        })
    elseif Config.Progress == "circle" then
        lib.progressCircle({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false
        })
    end
end

--##############################
--############ Coffre ##########
--##############################

CreateThread(function()
    for i=1, #Config.StashPolice do
        exports.qtarget:AddBoxZone(i.."_stash_menu", Config.StashPolice[i].coords, 1.0, 1.0, {
            name=i.."_stash_menu",
            heading=Config.StashPolice[i].heading,
            debugPoly=false,
            minZ=Config.StashPolice[i].coords.z-1.5,
            maxZ=Config.StashPolice[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'police:stash',
                    icon = Config.StashPolice[i].icon,
                    label = Config.StashPolice[i].labeltarget,
                    job = "police",
                }
            },
            distance = 1.5
        })
    end
end)

RegisterNetEvent('police:stash')
AddEventHandler('police:stash', function()
    exports.ox_inventory:openInventory('stash', { id = 'StashPolice' })
end)
