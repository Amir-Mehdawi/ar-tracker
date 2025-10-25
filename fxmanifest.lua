fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Amir'
description 'Phone Tracker'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'C/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'S/main.lua'
}

dependencies {
    'qb-core',
    'lb-phone',
    'ox_lib',
    'minigames'
}