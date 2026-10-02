fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
author 'NSXEDDY'
description 'NSXEDDY'
lua54 'yes'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua',
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
    'config.lua'
}

files {
    'locales/en.json'
}