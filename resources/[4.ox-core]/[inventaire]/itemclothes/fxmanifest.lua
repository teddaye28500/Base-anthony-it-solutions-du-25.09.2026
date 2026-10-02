fx_version 'cerulean'
game 'gta5'

description 'itemclothes without hooks for ox_inventory 2.42.3'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'useItem.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
