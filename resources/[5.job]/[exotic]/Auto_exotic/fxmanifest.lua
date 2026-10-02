fx_version 'adamant'

game 'gta5'
lua54 'yes'

dependency 'ox_lib'
dependency 'ox_target'
dependency 'es_extended'

escrow_ignore {
	'config/config.lua'  -- Only ignore one file
  }

developer 'Venom_Dev'

ui_page 'nui/index.html'

files {
	'nui/lang/*',
	'nui/font/*',
	'nui/images/*',
	'nui/images/repair/*',
	'nui/images/maintenance/*',
	'nui/images/upgrades/*',
	'nui/jquery-3.5.1.min.js',
	'nui/animations.css',
	'nui/style.css',
	'nui/index.html',
	'nui/script.js',
	'config.lua',
	'client/vehicle/vehicles.lua',
	'client/vehicle/modList.lua',
	'client/vehicle/colorList.lua',
	'locales/*.json',
}

client_scripts {
	'config/config.lua',
	'config/advanced_vehicles.lua',
	'config/peinture.lua',
	'lang/*.lua',
	'client/utils.lua',
	'client/cl_mechanic.lua',
	'client/gestion.lua',
	'client/cl_garage.lua',
	'client/advanced_vehicles.lua',
	'client/functions/utils.lua',
	'client/functions/payment.lua',
	'client/functions/menu.lua',
	'client/bridge/esx.lua',
	'client/bridge/ox.lua',
	'client/bridge/qb.lua',
	'client/bridge/custom.lua',
	'client/client.lua',
	'client/peinture_functions.lua',
	'client/peinture.lua'
}

server_scripts {
	'config/config.lua',
	'config/advanced_vehicles.lua',
	'config/peinture.lua',
	'lang/*.lua',
	'server/sv_mecano.lua',
	'server/advanced_vehicles.lua',
	'server/server.lua',
	'server/bridge/esx.lua',
	'server/bridge/ox.lua',
	'server/bridge/qb.lua',
	'server/bridge/custom.lua',
	'server/peinture.lua'
}


shared_script {
'@ox_lib/init.lua',
'@es_extended/imports.lua'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }