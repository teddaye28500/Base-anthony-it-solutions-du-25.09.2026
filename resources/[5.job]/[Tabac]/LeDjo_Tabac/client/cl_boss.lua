exports.qtarget:AddBoxZone("TabacBoss", vector3(2901.296875, 4411.257813, 50.285583), 1.0 , 1.5, {
	name="TabacBoss",
	heading=35,
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "tabacbossactions",
				icon = "fa fa-university",
				label = "Menu Patron Tabac",
				job = "tabac",
			},
		},
	distance = 2.5
})

RegisterNetEvent('tabacbossactions')
AddEventHandler('tabacbossactions', function()
	OpenTabcaBoss()
end)

function OpenTabcaBoss()
	TriggerEvent('esx_society:openBossMenu', 'tabac', function(data, menu)
		menu.close()
	end, { wash = false })
end

RegisterNetEvent('annonceO')
AddEventHandler('annonceO', function()
    TriggerServerEvent('Tabac:AnnonceOuvert')
end)

RegisterNetEvent('annonceF')
AddEventHandler('annonceF', function()
    TriggerServerEvent('Tabac:AnnonceFermer')
end)

