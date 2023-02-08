fx_version 'adamant'

games { 'rdr3' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

-- UI
ui_page 'ui/index.html'
files {
	'ui/index.html',
	'ui/script.js',
	'ui/style.css',
	'ui/crock.ttf',
	'ui/ter.png',
}

shared_script 'config.lua'

client_scripts {
	'client/animations.lua',
	'client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/usables.lua',
}

client_exports {
	'SetInInterior',
}


lua54 'yes'