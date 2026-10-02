fx_version 'adamant'
lua54 'yes'
game 'gta5'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}
 
client_scripts {
     "config.lua",    
	'client/*.lua',
}

server_script {
  'server/*.lua',
}