fx_version 'cerulean'
game 'gta5'

description 'Simple Notification Script using https://notifyjs.com/'

ui_page 'html/index.html'

client_script 'cl_notify.lua'

exports {
    'SetQueueMax',
    'SendNotification'
}

files {
    'html/index.html',
    'html/pNotify.js',
    'html/noty.js',
    'html/noty.css',
    'html/themes.css',
    --'html/sound-example.wav'
}
