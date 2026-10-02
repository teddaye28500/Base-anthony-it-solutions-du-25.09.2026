fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'Keres & Dév'
description 'Brutal Racing - store.brutalscripts.com'
version '1.0'

client_scripts { 
	'config.lua',
	'client-utils.lua',
	'client/*.lua'
}

server_scripts { 
	'config.lua',
	'server-utils.lua',
	'server/*.lua'
}

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/assets/*.png'
}

escrow_ignore {
	'config.lua',
	'server-utils.lua', 
	'client-utils.lua'
}
