RegisterNetEvent('taxivetement')
AddEventHandler('taxivetement', function()
    if Config.Vetement == 'fivem-appearance' then 
        TriggerEvent('fivem-appearance:Job')
    elseif Config.Vetement == 'ownvetement' then 
        TriggerEvent('esxbasicvetementtaxi')
    end
end)

RegisterNetEvent('esxbasicvetementtaxi')
AddEventHandler('esxbasicvetementtaxi', function()
    lib.registerContext({
        id = 'taxiclothing',
        title = "Menu vetements",
        onExit = function()
        end,
        options = {
            {
                event = "taxidefaultskin",
                icon = "fa fa-box",
                title = "Prendre c'est vetement",
            },
            {
                event = "taxitravail",
                title = "Prendre vetement travail",
                icon = "fa fa-box",
            },
        },
    })
    lib.showContext('taxiclothing')
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniformTaxi(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.TaxiUniform[uniform].male
		else
			uniformObject = Config.TaxiUniform[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			ESX.ShowNotification('Tu n\'a pas de vetement')
		end
	end)
end

RegisterNetEvent('taxidefaultskin')
AddEventHandler('taxidefaultskin', function()
    FreezeEntityPosition(PlayerPedId(), true)
    lib.progressBar({
        duration = 5000,
        label = 'Entrain de ce changer',
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d'
        },
    })
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(PlayerPedId())
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent('taxitravail')
AddEventHandler('taxitravail', function()
    local playerPed = PlayerPedId()
    FreezeEntityPosition(PlayerPedId(), true)
    lib.progressBar({
        duration = 5000,
        label = 'Entrain de ce changer',
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d'
        },
    })
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(PlayerPedId())
    setUniformTaxi('travail', playerPed)
end)
