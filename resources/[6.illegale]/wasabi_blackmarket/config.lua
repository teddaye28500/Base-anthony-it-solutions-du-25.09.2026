-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

Config = {}

Config.checkForUpdates = true -- Check for Updates?

Config.PayAccount = 'black_money' -- Account you want the black market to use('black_money', 'money', 'bank')
Config.OldESX = false -- Set to true for older ESX versions lacking xPlayer.canCarryItem function
Config.qtarget = true -- Use target? If set to false will use 3D text
Config.MarketPed = `mp_m_bogdangoon` -- Jenkins hash of ped here
Config.WebhookLink = 'https://discord.com/api/webhooks/' -- Webhook here / leave as is if you don't want to use

Config.Locations = { --[[ Locations black market ped will spawn at random per restart.
					 	  If only one desired, that works too]]--
	[1] = {
		coords = vector3(1711.301, 4786.497, 42.03176),
		heading = 256.8319
	},

	[2] = {
		coords = vector3(-519.7377, -595.9959, 25.45374),
		heading = 282.2165
	},
}

Config.randomLocation = Config.Locations[math.random(1,#Config.Locations)]

Config.Items = { -- If weapons are not as items (Older inventories) then set type = 'weapon' to paramaters like the one commented out under
--	{
--		label = 'Compact Rifle',
--		item = 'WEAPON_COMPACTRIFLE',
--		price = 42500,
--		type = 'weapon'
--	},
	{
		label = 'bomb atm',
		item = 'atm_bomb',
		price = 100,
	},
	{
		label = 'Drill',
		item = 'drill',
		price = 500,
	},
	{
		label = 'lockpick',
		item = 'lockpick',
		price = 2250,
	},
	{
		label = 'Clé usb Hacker',
		item = 'cleusb',
		price = 10000,
	},
	{
		label = 'Thermique',
		item = 'thermal_charge',
		price = 30000,
	},
	{
		label = 'PC Hackeur',
		item = 'hacker_laptop',
		price = 50000,
	},
	{
		label = 'Camera Hackin',
		item = 'cam_hacking',
		price = 300000,
	},
}