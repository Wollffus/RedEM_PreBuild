fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
client_scripts {
	'client/main.lua',
	'config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
}

files{
	'html/bg.png',
	'html/crock.ttf',
	'html/style.css',
	'html/ui.html',
	'html/circle.gif',
	'html/loading.png',
	'html/js/jquery-1.4.1.min.js',
	'html/js/jquery-func.js',
	'html/js/jquery.jcarousel.pack.js',
	'html/js/listener.js',
	'html/*.png',
}

ui_page 'html/ui.html'