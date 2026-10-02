fx_version 'adamant'

game 'gta5'
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
    'config.lua',
}

server_scripts {
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}


data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_effect_cigarpack.ytyp'