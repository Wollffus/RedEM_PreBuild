fx_version "bodacious"

games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Wolfhouse Studios' -- https://discord.gg/zGVDppYxfk


client_script 'client.lua'
server_script 'server.lua'

server_script 'config.lua'
client_script 'config.lua'

escrow_ignore {
	"config.lua",
	"readme.md",
}

lua54 'yes'