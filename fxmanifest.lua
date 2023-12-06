fx_version 'adamant'

game 'gta5'

description 'ESX psg Job'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua',
	'client/vehicle.lua',
	'client/garage.lua'
}

dependencies {
	'es_extended',
}
