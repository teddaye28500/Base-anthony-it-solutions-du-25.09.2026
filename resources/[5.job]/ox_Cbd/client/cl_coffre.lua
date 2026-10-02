exports.qtarget:AddBoxZone("CbdStash", vector3(175.57646179199, -239.23449707031, 50.055297851563), 1.6, 1, {
	name="CbdStash",
	heading=89.45,
	debugPoly=false,
	minZ=2.98,                     
	maxZ=5.38,
	}, {
		options = {
			{
				event = "CbdStash",
				icon = "fa-solid fa-box",
				label = "Frigo",
				job = "cbd",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("CbdSecretStash", vector3(186.09701538086, -242.10731506348, 54.070468902588), 1.6, 1, {
	name="CbdSecretStash",
	heading=86.96,
	debugPoly=false,      
	minZ=2.98,
	maxZ=5.38,
	}, {
		options = {
			{
				event = "CbdSecretStash",
				icon = "fa-solid fa-box",
				label = "Reserve",
				job = "cbd",
			},
		},
		distance = 2.5
})

-- 1
RegisterNetEvent('CbdStash')
AddEventHandler('CbdStash', function()
	OpenBusinessStash3()
end)

function OpenBusinessStash3()
	exports.ox_inventory:openInventory('stash', {id='cbdStash', owner= false, job = cbd})
end

-- 2
RegisterNetEvent('CbdSecretStash')
AddEventHandler('CbdSecretStash', function()
	OpenSecretBusinessStash3()
end)

function OpenSecretBusinessStash3()
	exports.ox_inventory:openInventory('stash', {id='CbdSecretStash', owner= false, job = cbd})
end