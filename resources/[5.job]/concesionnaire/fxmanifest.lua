fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'@ox_lib/init.lua',
	'config.lua',
}

client_script {
	'@es_extended/locale.lua',
    'config.lua',
	'locales/en.lua',
	'client/cl_concess.lua',
	'client/bridge.lua',
	'client/c_utils.lua'
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/sv_concess.lua',
	'locales/fn.lua',
}

ui_page "html/ui.html"

files {
	'locales/en.json',
}

--exports {
--	'GetVehicleStatusList',
--	'GetVehicleStatus',
--	'SetVehicleStatus',
--	'GeneratePlate',
--}

dependency {
	'ox_inventory',
	'ox_lib',
	'es_extended'
}

--provide 'esx_vehicleshop'