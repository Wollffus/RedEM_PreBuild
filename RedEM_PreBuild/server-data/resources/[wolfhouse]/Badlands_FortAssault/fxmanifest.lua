fx_version "bodacious"

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Wolfhouse Studios' -- https://discord.gg/zGVDppYxfk


server_scripts {
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'client/client.lua'
}

escrow_ignore {
	"config.lua",
	"readme.md",
}

lua54 'yes'