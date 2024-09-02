fx_version "bodacious"

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Wolfhouse Studios' -- https://discord.gg/zGVDppYxfk

-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/*.png",
	"ui/assets/heritage/*.png",
	"ui/fonts/*.ttf",
	"ui/front.js",
	"ui/script.js",
	"ui/style.css",
	'ui/debounce.min.js'
}

-- Client Scripts
client_scripts {
   	'components.lua',
    'client.lua',
	'config.lua',
}

-- Server Scripts
server_scripts {
    '@mysql-async/lib/MySQL.lua',     -- MySQL init
    'server.lua',
}

escrow_ignore {
	"config.lua",
	"readme.md",
}

lua54 'yes'