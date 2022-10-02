fx_version 'cerulean'
games { 'gta5' }

author "Celestic Network"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'local/end.lua',
    'config.lua',
    'shared/shared.lua'
}

client_scripts {
    'client/client_main.lua',
    'client/lib/c_lib.lua',
    'client/menu/menu.lua',
    'client/target/target.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/server_main.lua',
    'server/lib/s_lib.lua'
}

dependency 'oxmysql'

lua54 'yes'