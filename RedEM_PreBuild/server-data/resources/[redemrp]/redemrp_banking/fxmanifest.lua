fx_version 'bodacious'

game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script{
'client/client.lua',
'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

ui_page('client/html/UI.html')


files {
	'client/html/UI.html',
    'client/html/style.css',
    'client/html/media/font/crock.ttf',
    'client/html/media/img/bg.png',
	'client/html/media/img/bg2.png',
}
