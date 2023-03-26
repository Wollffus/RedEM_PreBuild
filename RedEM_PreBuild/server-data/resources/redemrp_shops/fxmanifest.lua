game 'rdr3'

fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'config.lua',
	'client/main.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'items.lua',
	'server/main.lua',
}

