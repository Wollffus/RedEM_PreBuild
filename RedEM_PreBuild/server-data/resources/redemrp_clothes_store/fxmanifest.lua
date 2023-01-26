lua54 'yes'
lua54 'yes'
fx_version "adamant"

games { 'rdr3'}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	-- 'test.lua',
	'utils/test.lua',
	'utils/functions.lua',
    'client/client.lua',
	'config.lua',
}

server_scripts {
	'config.lua',
    '@oxmysql/lib/MySQL.lua',     
    'server/server.lua',
}