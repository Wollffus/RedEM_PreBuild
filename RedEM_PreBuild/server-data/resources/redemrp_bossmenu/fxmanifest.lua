fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script 'config.lua'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_exports {
    'JobLedgerWithdraw',
    'JobLedgerDeposit',
    'GetJobDuty',
}