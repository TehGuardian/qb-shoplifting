fx_version 'cerulean'
games { 'gta5' }

version {'1.0'}
author {'Guardian'}

client_scripts {
    'client/*'
}

server_scripts {
	'server/*'
}

shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'config.lua'
}
