fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'BCC @ Jake2k4'

server_scripts {
    'server/main.lua',
    'server/versioncheck.lua'
}

shared_scripts {
    'config/*.lua',
    'locale.lua',
    'languages/*.lua'
    
}

client_scripts {
	'/client/functions.lua',
    '/client/menusetup.lua',
    '/client/nazarspawn.lua',
    '/client/treasurehunt.lua',
    '/client/cards.lua'
}

version '1.5.0'

dependency {
    'vorp_core',
    'vorp_inventory',
    'bcc-utils',
}
