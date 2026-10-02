fx_version "adamant"
game "gta5"

lua54 "yes"

shared_scripts {
    "@es_extended/imports.lua",
    "@ox_lib/init.lua",
    "config.lua"
}

client_scripts {
    "client/*.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
}

files {
    'locales/en.json',
    'locales/fr.json'
}

escrow_ignore {
    "config.lua"
}

exports{'getIdents', 'dclogs'}
