fx_version 'adamant'
lua54 'yes'
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

game 'gta5'

author 'Young_Mame'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client.lua",
    "loot.lua",
    "datacrack.lua"
}


shared_script {
    "config.lua",
    '@es_extended/imports.lua'
}

server_scripts {
    "server.lua"
}
