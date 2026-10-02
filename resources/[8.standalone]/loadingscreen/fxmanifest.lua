fx_version 'cerulean'
game {'gta5'}
author 'uyuyorum'
description 'UM Loading Screen V3'
version '1.3.0'
loadscreen 'nui/index.html'
loadscreen_cursor 'yes'
lua54 'yes'
loadscreen_manual_shutdown 'yes'

files {
		'config.js',
		'nui/index.html',
		'nui/assets/images/*.png',
		'nui/assets/images/*.jpg',
		'nui/assets/images/bg/*.png',
		'nui/assets/images/bg/*.jpg',
        'nui/assets/images/cardbg/*.png',
        'nui/assets/images/cardbg/*.jpg',
        'nui/assets/images/characters/*.png',
        'nui/assets/images/dcicon/*.webp',
        'nui/assets/images/player/*.png',
		'nui/assets/css/*.css',
		'nui/assets/js/*.js',
		'nui/assets/audio/*.mp3',
		--'nui/assets/video/*.mp4'
}

client_script 'lua/spawn.lua'
--server_script 'lua/enum.lua'


escrow_ignore {
	'lua/spawn.lua',
	'config.js',
}