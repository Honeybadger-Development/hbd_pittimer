fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'hbd_pittimer'
author 'Honeybadger Development'
description 'PIT Timer for Police'
version '1.0.1'

shared_scripts {
    '@ox_lib/init.lua',
}

files {
    'locales/*.json',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

