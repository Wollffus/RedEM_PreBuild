fx_version "adamant"

games { 'rdr3'}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/*.png",
	"ui/assets/heritage/*.png",
	"ui/fonts/*.ttf",
	"ui/script.js",
	"ui/style.css",
	'ui/debounce.min.js'
}

-- Client Scripts
client_scripts {
    'client/client.lua',
	'config.lua',
   	'client/cloth_hash_names.lua',
}

-- Server Scripts
server_scripts {
    '@mysql-async/lib/MySQL.lua',     -- MySQL init
    'server/server.lua',
}

export 'GetComponentId'
export 'GetClothesComponents'

dependencies {
	'redemrp_skin',
	'redemrp_menu_base'
}