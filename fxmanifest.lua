game 'rdr3'
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

server_scripts {
    'server.lua',
}

shared_scripts {
    'config.lua',
}


client_scripts {
    '/client/client.lua',
    '/client/warmenu.lua',
    '/client/menusetup.lua',
    '/client/nazarspawn.lua',
    '/client/treasurehunt.lua',
}
