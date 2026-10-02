fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'osc'

shared_script { '@es_extended/imports.lua', '@ox_lib/init.lua' }

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'esx_basicneeds/cmain.lua',
	'esx_billing/cmain.lua',
	'esx_service/cmain.lua',
	'esx_society/cmain.lua',
	'esx_status/cmain.lua',
	'esx_status/classes/cstatus.lua',
	'skinchanger/cmain.lua',
	'esx_identity/cmain.lua',
	'esx_cruisecontrol/cruisecontrol.lua',
	'esx_cruisecontrol/keybind.lua',
	'esx_cruisecontrol/seatbelt.lua',
	'esx_cruisecontrol/utils.lua',
}

server_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/*.lua',
	'config.lua',
	'esx_addonaccount/classes/addonaccount.lua',
	'esx_addonaccount/main.lua',
	'esx_addoninventory/classes/addoninventory.lua',
	'esx_addoninventory/main.lua',
	'esx_basicneeds/smain.lua',
	'esx_billing/smain.lua',
	'esx_datastore/classes/datastore.lua',
	'esx_datastore/main.lua',
	'esx_service/smain.lua',
	'esx_society/smain.lua',
	'esx_status/smain.lua',
	'esx_status/classes/sstatus.lua',
	'esx_license/smain.lua',
	'cron/smain.lua',
	'esx_identity/smain.lua',
}

server_exports {
    'GetSharedAccount',
    'AddSharedAccount',
	'GetSharedInventory',
    'AddSharedInventory'
}

ui_page 'esx_status/html/ui.html'

files {
	'esx_status/html/ui.html',
	'esx_status/html/css/app.css',
	'esx_status/html/scripts/app.js'
}

dependency 'es_extended'
