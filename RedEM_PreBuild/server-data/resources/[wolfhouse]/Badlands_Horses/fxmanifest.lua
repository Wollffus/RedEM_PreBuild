
fx_version "bodacious"

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Wolfhouse Studios' -- https://discord.gg/zGVDppYxfk

client_scripts {
    '@warmenu/warmenu.lua',
    'client.lua',
    'config.lua'
}

shared_script 'config.lua'

server_scripts {
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
}
dependencies {
	'redemrp_menu_base'
}

escrow_ignore {
	"config.lua",
	"readme.md",
    "client.lua",
}

lua54 'yes'
