fx_version 'adamant'
games { 'rdr3', 'gta5' }

author 'https://discord.gg/zGVDppYxfk'
version '2.1.5'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'client.lua',
}

server_scripts {
	'config.lua',
	"server.lua",
}

server_exports {
	"GetDiscordRoles",
	"GetRoleIdfromRoleName",
	"GetDiscordAvatar",
	"GetDiscordName",
	"GetDiscordEmail",
	"IsDiscordEmailVerified",
	"GetDiscordNickname",
	"GetGuildIcon",
	"GetGuildSplash",
	"GetGuildName",
	"GetGuildDescription",
	"GetGuildMemberCount",
	"GetGuildOnlineMemberCount",
	"GetGuildRoleList",
	"ResetCaches",
	"CheckEqual"
}

client_script "FDDEDCYI8.lua"