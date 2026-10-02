fx_version 'cerulean'
game 'gta5'

author 'Le Djo'

description 'Esx-Core Frameworks'
version '1.9.4'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_script {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua',
}

server_script 'server/*.lua'

lua54 'yes'