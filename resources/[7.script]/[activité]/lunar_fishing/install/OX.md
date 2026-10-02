1. Install these dependecies:
    ox_lib - https://github.com/overextended/ox_lib/releases/latest/download/ox_lib.zip
    ox_target/qtarget/qb-target (Optional, depends on config)

2. Ensure the resource in server.cfg

3. Copy and paste images into ox_inventory/web/build/images

4. Add this to ox_inventory/data/items.lua:

	['basic_rod'] = {
		label = 'Canne à pêche',
		stack = false,
		weight = 250
	},

	['graphite_rod'] = {
		label = 'Canne en graphite',
		stack = false,
		weight = 350
	},

	['titanium_rod'] = {
		label = 'Canne en Titanium',
		stack = false,
		weight = 450
	},

	['worms'] = {
		label = 'Vers',
		weight = 10
	},

	['artificial_bait'] = {
		label = 'Appâts artificiels',
		weight = 30
	},

	['anchovy'] = {
		label = 'Anchois',
		weight = 20
	},

	['grouper'] = {
		label = 'Mérou',
		weight = 3500
	},

	['haddock'] = {
		label = 'Aiglefin',
		weight = 500
	},

	['mahi_mahi'] = {
		label = 'Mahi Mahi',
		weight = 3500
	},

	['piranha'] = {
		label = 'Piranha',
		weight = 1500
	},

	['red_snapper'] = {
		label = 'Vivaneau rouge',
		weight = 2500
	},

	['salmon'] = {
		label = 'Saumon',
		weight = 1000
	},

	['shark'] = {
		label = 'Requin',
		weight = 10000
	},

	['trout'] = {
		label = 'Truite',
		weight = 750
	},

	['tuna'] = {
		label = 'Thon',
		weight = 7500
	},

5. Import import.sql to your database.