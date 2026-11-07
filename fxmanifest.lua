fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
author 'Troy Scripts; satellietbasis: Oulsen / referenties in docs/CREDITS.md'
description 'Standalone satellietkaart met Nederlandse gebiedsteksten voor Gemert RP'
version '1.0.9'
shared_scripts { '@ox_lib/init.lua', 'config/config.lua' }
client_scripts { 'client/main.lua', 'client/postcodes.lua' }
files { 'data/postcodes.json' }
server_scripts { 'server/main.lua', 'server/update_check.lua' }
dependency 'ox_lib'
