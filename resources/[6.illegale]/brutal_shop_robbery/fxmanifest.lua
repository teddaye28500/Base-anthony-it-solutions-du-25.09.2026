fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Keres & Dév'
description 'Brutal Shop Robbery - store.brutalscripts.com'
version '1.2'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts { 
	'config.lua',
	'core/client-core.lua',
	'cl_utils.lua',
	'client/*.lua',
}

server_scripts { 
	'config.lua',
	'core/server-core.lua',
	'sv_utils.lua',
	'server/*.lua',
}

escrow_ignore {
	'config.lua',
	'sv_utils.lua',
	'cl_utils.lua',
	'core/client-core.lua',
	'core/server-core.lua',
}
