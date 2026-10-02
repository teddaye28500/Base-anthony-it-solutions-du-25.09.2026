fx_version "adamant"

games {"gta5"}

lua54 "yes"

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_script {
    '@es_extended/locale.lua',
	'locales/*.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'server.lua',
}