fx_version "adamant"

games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'utils/hairs.lua',
	'utils/cloth_hash_names.lua',
	'utils/overlays.lua',
	'utils/features.lua',
	'utils/functions.lua',
	'utils/menu.lua',
	'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',    
    'server/main.lua',
}

ui_page {
	'html/ui.html'
}

files {
	'img/*.png',
	'html/ui.html',
	'html/*.png',
	'html/css/app.css',
	'html/css/*.png',
	'html/js/mustache.min.js',
	'html/js/app.js',
	'html/js/wrapper.js',
	'html/fonts/RDRLino-Regular.ttf',
	'html/fonts/HapnaSlabSerif-Medium.ttf',
	'html/fonts/bankgothic.ttf'
}
