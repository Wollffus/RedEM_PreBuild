--
--        RedEM-RP 2023 
-- https://github.com/RedEM-RP
--
fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page('client/html/UI.html') 


files {
	'client/html/UI.html', 
    'client/html/script.js',
    'client/html/style.css',
    'client/html/media/font/crock.ttf',
    'client/html/media/img/bg.png',
	'client/html/media/img/bg2.png',
    'client/html/media/img/bgt.png',
}