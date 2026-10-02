local containers = {}

---@class ItemContainerProperties
---@field slots number
---@field maxWeight number
---@field whitelist? table<string, true> | string[]
---@field blacklist? table<string, true> | string[]

local function arrayToSet(tbl)
	local size = #tbl
	local set = table.create(0, size)

	for i = 1, size do
		set[tbl[i]] = true
	end

	return set
end

---Registers items with itemName as containers (i.e. backpacks, wallets).
---@param itemName string
---@param properties ItemContainerProperties
---@todo Rework containers for flexibility, improved data structure; then export this method.
local function setContainerProperties(itemName, properties)
	local blacklist, whitelist = properties.blacklist, properties.whitelist

	if blacklist then
		local tableType = table.type(blacklist)

		if tableType == 'array' then
			blacklist = arrayToSet(blacklist)
		elseif tableType ~= 'hash' then
			TypeError('blacklist', 'table', type(blacklist))
		end
	end

	if whitelist then
		local tableType = table.type(whitelist)

		if tableType == 'array' then
			whitelist = arrayToSet(whitelist)
		elseif tableType ~= 'hash' then
			TypeError('whitelist', 'table', type(whitelist))
		end
	end

	containers[itemName] = {
		size = { properties.slots, properties.maxWeight },
		blacklist = blacklist,
		whitelist = whitelist,
	}
end

setContainerProperties('paperbag', {
	slots = 80,
	maxWeight = 6000,
	whitelist = { 'hotdog_classique','hotdog_gourmet','hotdog_epice','frites_hotdog','hotdog_vegan','menu_hotdog','hotdog_chili','boisson','frite','eaufraise','sandwich','sandwichp','sandwicht','bread','donutsrose','dd_donut4','dd_donut6','dd_croissant','kebab','pizzaananas','pizzanature','pizzakebab','quesadilla','burrito','heartst','chickenbg','taco','sports_drink','icetea','fanta','burger','water','cola','drpepper','nestea','pepsi','sprite','7up','apple_juice','arizona_punch','aw','big_blue','big_red','brisk_pink','canada_dry','capri_sun','junk_blue','junk_green','junk_orange','junk_purple','junk_red','espresso','coffee','chocolate_cream_frappuccino','caremel_frappucino','coffee_frappuccino','caffeagra','flusher','highnoon','cheetos','cheetos_hot','doritos_cr','doritos_nc','lays','lays_baked','sunchips','goldfish','honeybun','cheez_its','chips_ahoy','cup_of_noodles','fritos','fruit_snacks','funyuns','gushers' }
})

setContainerProperties('pizzabox', {
	slots = 5,
	maxWeight = 1000,
	whitelist = { 'pizza','pizzaananas','pizzanature','pizzakebab' }
})

setContainerProperties('wallet', {
	slots = 40,
	maxWeight = 80000,
	whitelist = { 'papier','visite_card','visite_empty_card','cartebancaire','bankcard','pdbadge','receipt','sim_card','carteidentite','ppa','notepad','permis','permispeche','mastercard','vehicle_reg','vehicle_ins','hunting_license','coke_access','meth_access','weed_access','casinochips','jeton','contract','cartebancaire','carteidentite','ppa','drive','money' } 

})

setContainerProperties('glaciere', {
	slots = 20,
	maxWeight = 80000,
	whitelist = { 'brain','heart','intestines','kidneys','liver','lungs','pancreas','stomach' } 

})

setContainerProperties('packvetement', {
	slots = 70,
	maxWeight = 1000000,
	whitelist = { 'gloves','watch','bracelet','bodyarmor','jacket','undershirt','earrings','hat','torso','pants','shoes','mask','ears','chain','glasses','vest','helmet','bag','kevlar','plongee1','plongee2','parachute','bulletproofvest','lowbulletproofvest','mediumbulletproofvest' }
})

setContainerProperties('ammocrate', {
	slots = 25,
	maxWeight = 40000,
	whitelist = { 'ammo-rifle','ammo-9','ammo-22','ammo-50','ammo-44','ammo-rifle2','ammo-shotgun','ammo-laser','ammo-rifle2','ammo-musket','ammo-grenade','ammo-38','ammo-emp','ammo-firework','ammo-flare','ammo-45','ammo-railgun','ammo-rocket','ammo-heavysniper','ammo-sniper','ammo-9-box','ammo-shotgun-box','ammo-rifle-box','ammo-rifle2-box' }
})

setContainerProperties('keyring', {
	slots = 20,
	maxWeight = 3000,
	whitelist = { 'vehiclekey','carkeys'}

})

setContainerProperties('fishtacklebox', {
	slots = 70,
	maxWeight = 1000000,
	whitelist = { 'basic_rod','graphite_rod','titanium_rod','artificial_bait','worms' }
})

setContainerProperties('fishicebox', {
	slots = 70,
	maxWeight = 1000000,
	whitelist = { 'anchovy','grouper','haddock','mahi_mahi','piranha','red_snapper','salmon','shark','trout','tuna','meat' }
})

setContainerProperties('polaroid_photobook', {
	slots = 70,
	maxWeight = 1000000,
	whitelist = { 'photo_polaroid' }
})

setContainerProperties('valisetravail', {
	slots = 80,
	maxWeight = 1000000,
	blacklist = { 'testburger' } 

})

return containers
