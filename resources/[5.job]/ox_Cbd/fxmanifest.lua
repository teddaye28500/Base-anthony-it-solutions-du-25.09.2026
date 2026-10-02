fx_version 'adamant'
game 'gta5'

lua54 'yes'

creator 'NSXEDDY'

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'shared/config.lua',
	'client/cl_jobmenu.lua',
	'client/cl_coffre.lua',
	'client/cl_vestiaire.lua',
	'client/cl_main.lua',
	'client/cl_garage.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'shared/config.lua',
	'server/sv_main.lua'
}

dependencies {
	'es_extended'
}
