fx_version "adamant"
games {"rdr3"}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '0.1.0'

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'MySQL plugin for ES'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'redem',
	'mysql-async'
}