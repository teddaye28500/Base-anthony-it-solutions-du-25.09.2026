fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'LeDjo_Developpement'
author 'LeDjo_Developpement#5110'
version '1.10.1'

client_scripts {
  'client/*.lua',
  'death_reasons.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/*.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'strings.lua',
  'config.lua'
}

dependencies {
	'es_extended',
	'ox_lib',
        'qtarget'
}

provides {
  'esx_ambulancejob'
}

escrow_ignore {
  'config.lua',
  'strings.lua',
  'death_reasons.lua',
  'client/*.lua',
  'server/*.lua'
  
}


