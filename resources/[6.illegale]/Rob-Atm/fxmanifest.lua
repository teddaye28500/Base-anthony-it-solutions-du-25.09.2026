fx_version 'adamant'
game 'gta5'
description 'BBV ATM ROB'
version '1.0.0'


client_scripts {
	'client/main.lua',
	'wrapper/cl_wrapper.lua',
	'wrapper/cl_wp_callback.lua',
}

server_scripts {
	'server/main.lua',
	'wrapper/sv_wrapper.lua',
	'wrapper/sv_wp_callback.lua',
}

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'config.lua',
}

lua54 'yes'