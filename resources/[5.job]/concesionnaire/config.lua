Config                            = {}

Config.gsrUpdate                = 1 * 1000          -- Change first number only, how often a new shot is logged dont set this to low keep it above 1 min - raise if you experience performance issues (default: 1 min).
Config.waterClean               = true              -- Set to false if you dont want water to clean off GSR from people who shot
Config.waterCleanTime           = 30 * 1000         -- Change first number only, Set time in water needed to clean off GSR (default: 30 sec).
Config.gsrTime                  = 30 * 60           -- Change The first number only, if you want the GSR to be auto removed faster output is minutes (default: 30 min).
Config.gsrAutoRemove            = 10 * 60 * 1000    -- Change first number only, to set the auto clean up in minuets (default: 10 min).
Config.gsrUpdateStatus          = 5 * 60 * 1000     -- Change first number only, to change how often the client updates hasFired variable dont set it very high... 5-10 min should be fine. (default: 5 min).
Config.UseCharName				= true				-- This will show the suspects name in the PASSED or FAILED notification. Allows cop to make sure they checked the right person.

Config.weaponChecklist = {
	--Get models id here : https://pastebin.com/0wwDZgkF
	0x3656C8C1, -- stunGun
	0x678B81B1, -- nightStick
	0x84BD7BFD, -- crowBar
	0x60EC506, 	-- Fire Extinguisher
}

Config.TextDrawDistance           = 1.5

Config.DrawDistance               = 10.0 

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How many people can be in service at once? Set as -1 to have no limit
Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society

Config.EnableSocietyOwnedVehicles = false
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true 
Config.EnableESXOptionalneeds     = true 
Config.EnableLicenses             = true 

Config.ReviveReward               = 50  
Config.SaveDeathStatus            = true 
Config.LoadIpl                    = true 

Config.Locale = GetConvar('esx:locale', 'en')
Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 10 
Config.BleedoutTimer              = 60000 * 10

Config.EnablePlayerManagement     = true 
Config.EnablePlayerManagement2     = false

Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 225

Config.OxInventory                = ESX.GetConfig().OxInventory
Config.RespawnPoints = {
	{coords = vector3(-459.414337, -284.002502, 34.913486), heading = 204.88}
}

Config.menuPosition = 'right'
Config.textDistance = 1.0
Config.notifDuration = 10000
Config.usePEFCL = false -- if false it will use ox/esx default money logic
Config.oxTarget = true
Config.logging = 'oxlogger' -- oxlogger or 'YOUR_WEBHOOK'
Config.vehicleColors = {    
    primary = true,
    secondary = true
}

	Config.vehicleShops = {

		{
			shopLabel = 'Concessionaire Avion',
			shopIcon = 'fa-solid fa-plane',
			shopCoords = vec3(-1026.727, -3019.639, 13.94508),
			previewCoords = vec4(-976.2772, -3010.068, 13.94507, 63.71281),
			vehicleSpawnCoords = vec4(-976.2772, -3010.068, 13.94507, 63.71281),
			vehicleList = 'air',
			blipData = {color = 5, sprite = 584, scale = 0.6},
			npcData = {model = joaat('IG_Avon'), position = vec4(-1026.727, -3019.639, 12.94508, 340.0949)},
			showcaseVehicle = {
			}
		},

		{
			shopLabel = 'Concessionaire Voiture',
			shopIcon = 'fa-solid fa-car',
			shopCoords = vec3(127.7216, -142.6411, 54.8512),
			previewCoords = vec4(137.4799, -149.8305, 54.0499, 273.1056),
			vehicleSpawnCoords = vec4(116.6616, -139.6382, 54.8001, 337.3185),
			vehicleList = 'vehicles',
			blipData = {color = 5, sprite = 523, scale = 0.6},
			npcData = {model = joaat('IG_Avon'), position = vec4(127.7216, -142.6411, 53.8512, 166.9462)},
			showcaseVehicle = {
			}
		},
	
		{
			shopLabel = 'Concessionaire Bateau',
			shopIcon = 'fa-solid fa-anchor',
			shopCoords = vec3(-806.1019, -1368.464, 5.178344),
			previewCoords = vec4(-775.3362, -1385.132, -0.4747446, 218.6604),
			vehicleSpawnCoords = vec4(-767.8963, -1377.808, -0.4746756, 213.5107),
			vehicleList = 'boats',
			blipData = {color = 28, sprite = 455, scale = 0.6},
			npcData = {model = joaat('IG_Avon'), position = vec4(-806.0885, -1368.629, 4.178343, 359.5652)},
			showcaseVehicle = {
			}
		},
	
	}
	
	Config.vehicleList = {
		['vehicles'] = {
			{label = 'compacts', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Brioso', vehicleModel = joaat('brioso'), vehiclePrice = 1000},
				{label = 'BriosoB', vehicleModel = joaat('brioso2'), vehiclePrice = 1200}, 
				{label = 'Club', vehicleModel = joaat('club'), vehiclePrice = 2000}, 
				{label = 'Issi', vehicleModel = joaat('issi2'), vehiclePrice = 2300},
				{label = 'IssiB', vehicleModel = joaat('issi4'), vehiclePrice = 2000},
				{label = 'Blista', vehicleModel = joaat('blista'), vehiclePrice = 2700},
			}},
			{label = 'coupes', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Felon', vehicleModel = joaat('felon'), vehiclePrice = 60000}, 
				{label = 'FelonB', vehicleModel = joaat('felon2'), vehiclePrice = 65000}, 
				{label = 'Oracle', vehicleModel = joaat('oracle2'), vehiclePrice = 70000},
				{label = 'Windsor', vehicleModel = joaat('windsor'), vehiclePrice = 100000}, 
				{label = 'WindsorB', vehicleModel = joaat('windsor2'), vehiclePrice = 100000},
				{label = 'Zion', vehicleModel = joaat('zion2'), vehiclePrice = 70000},
				{label = 'Ocelot', vehicleModel = joaat('f620'), vehiclePrice = 72000},
			}},
			{label = 'muscles', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Buccaneer', vehicleModel = joaat('buccaneer'), vehiclePrice = 15000}, 
				{label = 'Phoenix', vehicleModel = joaat('phoenix'), vehiclePrice = 26000}, 
				{label = 'Faction', vehicleModel = joaat('faction'), vehiclePrice = 25000},
				{label = 'Gauntlet', vehicleModel = joaat('gauntlet'), vehiclePrice = 30000},
				{label = 'Moonbeam', vehicleModel = joaat('moonbeam'), vehiclePrice = 35000},
				{label = 'Sabre', vehicleModel = joaat('sabregt'), vehiclePrice = 28000},
				{label = 'Dominator', vehicleModel = joaat('dominator'), vehiclePrice = 40000},
				{label = 'Tampa', vehicleModel = joaat('tampa'), vehiclePrice = 25000},
				{label = 'Virgo', vehicleModel = joaat('virgo'), vehiclePrice = 30000},
				{label = 'Voodoo', vehicleModel = joaat('voodoo'), vehiclePrice = 25000},
				{label = 'Vamos', vehicleModel = joaat('vamos'), vehiclePrice = 25000},
				{label = 'Hermes', vehicleModel = joaat('hermes'), vehiclePrice = 20000},
			}},
			{label = 'offroads', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Bfinjection', vehicleModel = joaat('bfinjection'), vehiclePrice = 5000, description = vehiclePrice}, 
				{label = 'Bifta', vehicleModel = joaat('bifta'), vehiclePrice = 7000, description = vehiclePrice}, 
				{label = 'Bodhi', vehicleModel = joaat('bodhi2'), vehiclePrice = 15000, description = vehiclePrice},
				{label = 'Caracara', vehicleModel = joaat('caracara2'), vehiclePrice = 55000, description = vehiclePrice},
				{label = 'Dubsta 6x6', vehicleModel = joaat('dubsta3'), vehiclePrice = 120000, description = vehiclePrice},
				{label = 'Everon', vehicleModel = joaat('everon'), vehiclePrice = 80000, description = vehiclePrice},
				{label = 'Hellion', vehicleModel = joaat('hellion'), vehiclePrice = 90000, description = vehiclePrice},
				{label = 'Kamacho', vehicleModel = joaat('kamacho'), vehiclePrice = 150000, description = vehiclePrice},
				{label = 'Rebel', vehicleModel = joaat('Rebel'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'RancherXL', vehicleModel = joaat('rancherxl'), vehiclePrice = 30000, description = vehiclePrice},
				{label = 'Sandking', vehicleModel = joaat('sandking'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Trophytruck', vehicleModel = joaat('trophytruck'), vehiclePrice = 85000, description = vehiclePrice},
				{label = 'Vagrant', vehicleModel = joaat('vagrant'), vehiclePrice = 55000, description = vehiclePrice},
			}},
			{label = 'suvs', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Baller', vehicleModel = joaat('baller'), vehiclePrice = 60000, description = vehiclePrice}, 
				{label = 'Cavalcade', vehicleModel = joaat('cavalcade'), vehiclePrice = 50000, description = vehiclePrice}, 
				{label = 'Contender', vehicleModel = joaat('contender'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Dubsta', vehicleModel = joaat('dubsta'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Granger', vehicleModel = joaat('granger'), vehiclePrice = 40000, description = vehiclePrice},
				{label = 'Gresley', vehicleModel = joaat('gresley'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Huntley', vehicleModel = joaat('huntley'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Landstalker', vehicleModel = joaat('landstalker'), vehiclePrice = 40000, description = vehiclePrice},
				{label = 'Novak', vehicleModel = joaat('novak'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Mesa', vehicleModel = joaat('mesa'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Patriot', vehicleModel = joaat('patriot'), vehiclePrice = 55000, description = vehiclePrice},
				{label = 'Rebla', vehicleModel = joaat('rebla'), vehiclePrice = 80000, description = vehiclePrice},
				{label = 'Rocoto', vehicleModel = joaat('rocoto'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Seminole', vehicleModel = joaat('seminole'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Serrano', vehicleModel = joaat('serrano'), vehiclePrice = 35000, description = vehiclePrice},
				{label = 'Toros', vehicleModel = joaat('toros'), vehiclePrice = 70000, description = vehiclePrice},
				{label = 'Benefactor XLS', vehicleModel = joaat('xls'), vehiclePrice = 45000, description = vehiclePrice},
			}},
			{label = 'sedans', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Emperor', vehicleModel = joaat('emperor'), vehiclePrice = 35000, description = vehiclePrice},  
				{label = 'Asea', vehicleModel = joaat('asea'), vehiclePrice = 15000, description = vehiclePrice},
				{label = 'Asterope', vehicleModel = joaat('asterope'), vehiclePrice = 20000, description = vehiclePrice},
				{label = 'Cognoscenti', vehicleModel = joaat('cognoscenti'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Glendale', vehicleModel = joaat('glendale'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Intruder', vehicleModel = joaat('intruder'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Premier', vehicleModel = joaat('premier'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Primo', vehicleModel = joaat('primo'), vehiclePrice = 55000, description = vehiclePrice},
				{label = 'Regina', vehicleModel = joaat('regina'), vehiclePrice = 20000, description = vehiclePrice},
				{label = 'Stanier', vehicleModel = joaat('stanier'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Stratum', vehicleModel = joaat('stratum'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Tailgater', vehicleModel = joaat('tailgater'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Super Diamond', vehicleModel = joaat('superd'), vehiclePrice = 85000, description = vehiclePrice},
			}},
			{label = 'sports', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Alpha', vehicleModel = joaat('alpha'), vehiclePrice = 60000, description = vehiclePrice}, 
				{label = 'Banshee', vehicleModel = joaat('banshee'), vehiclePrice = 55000, description = vehiclePrice}, 
				{label = 'Bestia GTS', vehicleModel = joaat('bestiagts'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Buffalo', vehicleModel = joaat('buffalo'), vehiclePrice = 90000, description = vehiclePrice},
				{label = 'Carbonizzare', vehicleModel = joaat('carbonizzare'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Coquette', vehicleModel = joaat('coquette'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Drafter', vehicleModel = joaat('drafter'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Deveste', vehicleModel = joaat('deveste'), vehiclePrice = 70000, description = vehiclePrice},
				{label = 'Elegy', vehicleModel = joaat('elegy'), vehiclePrice = 75000, description = vehiclePrice},
				{label = 'Flash GT', vehicleModel = joaat('flashgt'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Furore GT', vehicleModel = joaat('furoregt'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Karin Futo', vehicleModel = joaat('futo'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Komoda', vehicleModel = joaat('komoda'), vehiclePrice = 95000, description = vehiclePrice},
				{label = 'Imorgon', vehicleModel = joaat('imorgon'), vehiclePrice = 70000, description = vehiclePrice},
				{label = 'Jugular', vehicleModel = joaat('jugular'), vehiclePrice = 87000, description = vehiclePrice},
				{label = 'Jester', vehicleModel = joaat('jester'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Kuruma', vehicleModel = joaat('kuruma'), vehiclePrice = 85000, description = vehiclePrice},
				{label = 'Lynx', vehicleModel = joaat('lynx'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Neon', vehicleModel = joaat('neon'), vehiclePrice = 80000, description = vehiclePrice},
				{label = 'NineF', vehicleModel = joaat('ninef'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Omnis', vehicleModel = joaat('omnis'), vehiclePrice = 55000, description = vehiclePrice},
				{label = 'Schwarzer', vehicleModel = joaat('schwarzer'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Italirsx', vehicleModel = joaat('italirsx'), vehiclePrice = 68000, description = vehiclePrice},
				{label = 'Sultan', vehicleModel = joaat('sultan'), vehiclePrice = 75000, description = vehiclePrice},
				{label = 'Schafter3', vehicleModel = joaat('schafter3'), vehiclePrice = 85000, description = vehiclePrice},
				{label = 'Schafter4', vehicleModel = joaat('schafter4'), vehiclePrice = 95000, description = vehiclePrice},
				{label = 'Raiden', vehicleModel = joaat('raiden'), vehiclePrice = 110000, description = vehiclePrice},
			}},
			{label = 'classics', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Ardent', vehicleModel = joaat('ardent'), vehiclePrice = 30000, description = vehiclePrice}, 
				{label = 'Casco', vehicleModel = joaat('casco'), vehiclePrice = 28000, description = vehiclePrice}, 
				{label = 'Michelli', vehicleModel = joaat('michelli'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Nebula', vehicleModel = joaat('nebula'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Manana', vehicleModel = joaat('manana'), vehiclePrice = 30000, description = vehiclePrice},
				{label = 'Mamba', vehicleModel = joaat('mamba'), vehiclePrice = 20000, description = vehiclePrice},
				{label = 'Retinue', vehicleModel = joaat('retinue'), vehiclePrice = 20000, description = vehiclePrice},
				{label = 'Stinger', vehicleModel = joaat('stinger'), vehiclePrice = 20000, description = vehiclePrice},
				{label = 'Tornado', vehicleModel = joaat('tornado'), vehiclePrice = 30000, description = vehiclePrice},
				{label = 'Torero', vehicleModel = joaat('torero'), vehiclePrice = 35000, description = vehiclePrice},
				{label = 'Ztype', vehicleModel = joaat('ztype'), vehiclePrice = 35000, description = vehiclePrice},
				{label = 'Btype', vehicleModel = joaat('btype'), vehiclePrice = 30000, description = vehiclePrice},
				{label = 'Btype3', vehicleModel = joaat('btype3'), vehiclePrice = 35000, description = vehiclePrice},
			}},
			{label = 'supers', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Addert', vehicleModel = joaat('adder'), vehiclePrice = 52000, description = vehiclePrice}, 
				{label = 'Cheetah', vehicleModel = joaat('cheetah'), vehiclePrice = 50000, description = vehiclePrice}, 
				{label = 'Emerus', vehicleModel = joaat('emerus'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'ItaliGTB', vehicleModel = joaat('italigtb'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Infernus', vehicleModel = joaat('infernus'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Penetrator', vehicleModel = joaat('penetrator'), vehiclePrice = 55000, description = vehiclePrice},
				{label = 'Sheava', vehicleModel = joaat('sheava'), vehiclePrice = 55000, description = vehiclePrice},
				{label = 'Turismor', vehicleModel = joaat('turismor'), vehiclePrice = 58000, description = vehiclePrice},
				{label = 'Visione', vehicleModel = joaat('visione'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Vacca', vehicleModel = joaat('vacca'), vehiclePrice = 50000, description = vehiclePrice},
				{label = 'Tyrus', vehicleModel = joaat('tyrus'), vehiclePrice = 65000, description = vehiclePrice},
				{label = 'Tempesta', vehicleModel = joaat('tempesta'), vehiclePrice = 60000, description = vehiclePrice},
				{label = 'Reaper', vehicleModel = joaat('reaper'), vehiclePrice = 65000, description = vehiclePrice},
			}},
			{label = 'vans', defaultIndex = 2, dbData = 'car', values = {
				{label = 'Burrito', vehicleModel = joaat('burrito'), vehiclePrice = 46000, description = vehiclePrice}, 
				{label = 'GBurrito', vehicleModel = joaat('gburrito'), vehiclePrice = 30000, description = vehiclePrice}, 
				{label = 'Journey', vehicleModel = joaat('journey'), vehiclePrice = 45000, description = vehiclePrice},
				{label = 'Pony', vehicleModel = joaat('pony'), vehiclePrice = 42000, description = vehiclePrice},
				{label = 'Minivan', vehicleModel = joaat('minivan'), vehiclePrice = 25000, description = vehiclePrice},
				{label = 'Rumpo', vehicleModel = joaat('rumpo'), vehiclePrice = 30000, description = vehiclePrice},
				{label = 'Speedo', vehicleModel = joaat('speedo'), vehiclePrice = 30000, description = vehiclePrice},
				{label = 'Surfer', vehicleModel = joaat('surfer'), vehiclePrice = 25000, description = vehiclePrice},
		   }},
		   {label = 'vélo', defaultIndex = 2, dbData = 'car', values = {
			{label = 'Bmx', vehicleModel = joaat('bmx'), vehiclePrice = 150, description = vehiclePrice},
			{label = 'Bmx2', vehicleModel = joaat('BIMX'), vehiclePrice = 800, description = vehiclePrice}, 
			{label = 'Scorcher', vehicleModel = joaat('scorcher'), vehiclePrice = 200, description = vehiclePrice}, 
			{label = 'Tribike', vehicleModel = joaat('tribike'), vehiclePrice = 250, description = vehiclePrice},
		   }},
		   {label = 'moto', defaultIndex = 2, dbData = 'car', values = {
			{label = 'Faggio', vehicleModel = joaat('faggio'), vehiclePrice = 1000, description = vehiclePrice}, 
			{label = 'Manchez2', vehicleModel = joaat('manchez2'), vehiclePrice = 15000, description = vehiclePrice}, 
			{label = 'Sanchez', vehicleModel = joaat('sanchez'), vehiclePrice = 8000, description = vehiclePrice},
			{label = 'Bf400', vehicleModel = joaat('bf400'), vehiclePrice = 12000, description = vehiclePrice},
			{label = 'Avarus', vehicleModel = joaat('avarus'), vehiclePrice = 16000, description = vehiclePrice},
			{label = 'Chimera', vehicleModel = joaat('chimera'), vehiclePrice = 18000, description = vehiclePrice},
			{label = 'Nightblade', vehicleModel = joaat('nightblade'), vehiclePrice = 20000, description = vehiclePrice},
			{label = 'Sanctus', vehicleModel = joaat('sanctus'), vehiclePrice = 25000, description = vehiclePrice},
			{label = 'Akuma', vehicleModel = joaat('akuma'), vehiclePrice = 20000, description = vehiclePrice},
			{label = 'Bati', vehicleModel = joaat('bati'), vehiclePrice = 25000, description = vehiclePrice},
			{label = 'Carbonrs', vehicleModel = joaat('carbonrs'), vehiclePrice = 23000, description = vehiclePrice},
			{label = 'Enduro', vehicleModel = joaat('enduro'), vehiclePrice = 18000, description = vehiclePrice},
			{label = 'Hakuchou', vehicleModel = joaat('hakuchou'), vehiclePrice = 30000, description = vehiclePrice},
		   }},
			
		},
		['boats'] = {
			{label = 'bateaux', defaultIndex = 2, dbData = 'boat', values = {
				{label = 'Dinghy3', vehicleModel = joaat('dinghy3'), vehiclePrice = 200000, description = vehiclePrice}, 
				{label = 'Marquis', vehicleModel = joaat('marquis'), vehiclePrice = 500000, description = vehiclePrice}, 
				{label = 'Seashark', vehicleModel = joaat('seashark'), vehiclePrice = 75000, description = vehiclePrice},
				{label = 'Seashark3', vehicleModel = joaat('seashark3'), vehiclePrice = 85000, description = vehiclePrice},
				{label = 'Speeder2', vehicleModel = joaat('speeder2'), vehiclePrice = 250000, description = vehiclePrice},
				{label = 'Toro2', vehicleModel = joaat('toro2'), vehiclePrice = 275000, description = vehiclePrice},
				{label = 'Jetmax', vehicleModel = joaat('jetmax'), vehiclePrice = 240000, description = vehiclePrice},
		   }},
		},
		['air'] = {
			{label = 'avions', defaultIndex = 2, dbData = 'air', values = {
				{label = 'Dodo', vehicleModel = joaat('dodo'), vehiclePrice = 1275000, description = vehiclePrice},
			    {label = 'Cuban800', vehicleModel = joaat('cuban800'), vehiclePrice = 1500000, description = vehiclePrice}, 
				{label = 'Luxor', vehicleModel = joaat('luxor'), vehiclePrice = 3000000, description = vehiclePrice}, 
				{label = 'Luxor2', vehicleModel = joaat('luxor2'), vehiclePrice = 5000000, description = vehiclePrice},
				{label = 'Velum2', vehicleModel = joaat('velum2'), vehiclePrice = 1700000, description = vehiclePrice}, 
			}},
			{label = 'hélicoptère', defaultIndex = 2, dbData = 'air', values = {
				{label = 'Buzzard2', vehicleModel = joaat('buzzard2'), vehiclePrice = 1600000, description = vehiclePrice},
				{label = 'Frogger', vehicleModel = joaat('frogger'), vehiclePrice = 2000000, description = vehiclePrice}, 
				{label = 'Supervolito2', vehicleModel = joaat('supervolito2'), vehiclePrice = 3200000, description = vehiclePrice}, 
				{label = 'Swift', vehicleModel = joaat('swift'), vehiclePrice = 4000000, description = vehiclePrice},
				{label = 'Volatus', vehicleModel = joaat('volatus'), vehiclePrice = 5000000, description = vehiclePrice},
			}},
    },

}