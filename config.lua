Config                            = {}

Config.Locale					  = 'es'
Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 42, Teleports = 24 , Armories = 3, BossActions = 22, Vehiculos = 36, Helicopteros = 34, Chaleco = 41, Accesorios = 31, Vehiculos = 36}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 255, g = 255, b = 0}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.

Config.Sandy = 331.92, -595.46, 43.28
Config.Paleto = 331.92, -595.46, 43.28


Config.psgStations = {

Sandy = {

        Blip = {
            Coords  = vector3(1861.507, 3676.622, 33.625),
            Sprite  = 67,
            Display = 4,
            Scale   = 0.5,
            Colour  = 46
        },

        Cloakrooms = {
            vector3(-440.082, 6010.706, 36.995), --PALETO
        },
        
        Teleports = {
            vector3(-448.881, 6008.598, 36.995), -- PALETO
            vector3(1851.980, 3690.024, 34.267), -- SANDY
        },

        Armories = {
            vector3(-449.119, 6014.877, 36.995), -- PALETO
        },

        BossActions = {
            vector3(1854.783, 3688.726, 34.267), -- PALETO
        },
        
        Accesorios = {
            vector3(-447.094, 6016.364, 36.995), -- PALETO
        },
        
        Chaleco = {
            vector3(-437.831, 6012.353, 36.995), -- PALETO
        },
        
        Vehiculos = {
            vector3(-482.791, 6024.730, 31.340), -- PALETO
            vector3(1867.715, 3698.170, 33.531), -- SANDY
        },
        
        Helicopteros = {
            vector3(-475.539, 5988.294, 31.336), -- PALETO
            vector3(1866.293, 3660.060, 33.866), -- SANDY 
        }

    }

}

Config.psg1Stations = {

	Paleto = {

		Blip = {
			Coords  = vector3(-439.794, 6019.686, 31.490),
			Sprite  = 67,
			Display = 4,
			Scale   = 0.5,
			Colour  = 46
		},

		Cloakrooms = {
		},
		
		Teleports = {
		},

		Armories = {
		},

		BossActions = {
		},
		
		Accesorios = {
		},
		
		Chaleco = {
		},
		
		Vehiculos = {
		},
		
		Helicopteros = {
		}

	}

}

Config.Vehiculos = {
    { model = 'sultan', label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> Low PSG '},
    { model = 'psg1', label = '<i class="fas fa-car"></i> Patrulla #1 - A382 PSG'},
	{ model = 'psg2', label = '<i class="fas fa-car"></i> Patrulla #2 - A822 PSG'},
    { model = 'sultan', label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> High PSG '},
    { model = 'psg3', label = '<i class="fas fa-shuttle-van"></i> Camioneta #1 - F933 PSG'},
	{ model = 'psg4', label = '<i class="fas fa-shuttle-van"></i> Camioneta #1 - F900 PSG'},
	{ model = 'sultan', label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> Unidad Infanteria'},
    { model = 'psg5', label = '<i class="fas fa-shuttle-van"></i> Camion #1 - Unidad INFANTERIA'},
	{ model = 'sultan', label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> Unidad Motorizada'},
	{ model = 'psg6', label = '<i class="fas fa-shuttle-van"></i> Camion #1 - Unidad MOTORIZADA'},
    --{ model = 'polgt17', label = '<i class="fas fa-car"></i>  Patrulla #6 - Ford PFA'},
}

-- Modelos de Helicopteros:
Config.Helicopteros = {
    { model = 'polmav', label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> High PSG '},
    { model = 'polmav', label = '<i class="fa-solid fa-helicopter"></i> Helicoptero #1 - Movil H PSG'},
}

Config.WeaponsInArmory = {
	{ weaponHash = 'WEAPON_COMBATPISTOL', label = 'Pistola de Combate', type = 'pistol', attachment = true, flashlight = 0x359B7AAE, grip = nil, suppressor = 0xC304849A},
	{ weaponHash = 'WEAPON_APPISTOL', label = 'Pistola de AP', type = 'pistol', attachment = true, flashlight = 0x359B7AAE, grip = nil, suppressor = 0xC304849A},
	{ weaponHash = 'WEAPON_PISTOL50', label = 'Pistola .50', type = 'pistol', attachment = true, flashlight = 0x359B7AAE, grip = nil, suppressor = 0xA73D4664},
	{ weaponHash = 'WEAPON_HEAVYPISTOL', label = 'Pistola Pesada', type = 'pistol', attachment = true, flashlight = 0x359B7AAE, grip = nil, suppressor = 0xC304849A},
	{ weaponHash = 'WEAPON_MICROSMG', label = 'Micro SMG', type = 'smg', attachment = true, flashlight = 0x359B7AAE, grip = 0x9D2FBF29, suppressor = 0xA73D4664},
	{ weaponHash = 'WEAPON_SMG', label = 'SMG', type = 'smg', attachment = true, flashlight = 0x7BC4CDDC, grip = 0x3CC6BA57, suppressor = 0xC304849A},
	{ weaponHash = 'WEAPON_ASSAULTSMG', label = 'SMG de Asalto', type = 'smg', attachment = true, flashlight = 0x7BC4CDDC, grip = 0x9D2FBF29, suppressor = 0xA73D4664},
	{ weaponHash = 'WEAPON_PUMPSHOTGUN', label = 'Escopeta', type = 'shotgun', attachment = true, flashlight = 0x7BC4CDDC, grip = nil, suppressor = 0xE608B35E},
	{ weaponHash = 'WEAPON_ASSAULTSMG', label = 'Escopeta Bullpup', type = 'shotgun', attachment = true, flashlight = 0x7BC4CDDC, grip = 0xC164F53, suppressor = 0xA73D4664},
	{ weaponHash = 'WEAPON_ASSAULTRIFLE', label = 'AK-47', type = 'rifle', attachment = true, flashlight = 0x7BC4CDDC, grip = 0x9D2FBF29, suppressor = 0xA73D4664},
	{ weaponHash = 'WEAPON_CARBINERIFLE', label = 'Carabina', type = 'rifle', attachment = true, flashlight = 0x7BC4CDDC, grip = 0xA0D89C42, suppressor = 0x837445AA},
	{ weaponHash = 'WEAPON_SPECIALCARBINE', label = 'Carabina Especial', type = 'rifle', attachment = true, flashlight = 0x7BC4CDDC, grip = 0xA0D89C42, suppressor = 0xA73D4664},
	{ weaponHash = 'WEAPON_SNIPERRIFLE', label = 'Francotirador', type = 'rifle', attachment = true, flashlight = nil, grip = nil, suppressor = 0xA73D4664},
	{ itemHash = 'SUPPRESSOR', label = 'Silenciador', type = 'silenciador', attachment = false, flashlight = nil, grip = nil, suppressor = 0xA73D4664},
}

Config.AuthorizedWeapons = {
	aspirante = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	aprendiz = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	empleado = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	experimentado = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	supervisor = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	auxiliar = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	gerente = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	seguridad = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	especialista = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
	},
	instructor = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
	},
	subdirector = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
	},
	director = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
	},
	subjefe = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
	},
	
	jefe = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_BZGAS', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_GRENADELAUNCHER_SMOKE', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_APPISTOL', price = 0},
		{weapon = 'WEAPON_ASSAULTSMG', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
	},
}

Config.Uniforms = {
	aspirante = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	aprendiz = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	empleado = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	experimentado = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	supervisor = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 220,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = 169, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 36,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = 63,  helmet_2 = 9,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	auxiliar = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 220,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = 169, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 36,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = 63,  helmet_2 = 9,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	gerente = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 220,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = 169, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 36,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = 63,  helmet_2 = 9,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	seguridad = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 220,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = 169, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 36,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = 63,  helmet_2 = 9,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	especialista = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	instructor = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	subdirector = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	director = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	subjefe = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},
	jefe = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 34,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 41,
            pants_1 = 87,   pants_2 = 6,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 146,   torso_2 = 0,
            decals_1 = -1,   decals_2 = 0,
            mask_1 = -1, mask_2 = 0,
            bproof_1 = -1,  bproof_2 = 0,
            arms = 30,
            pants_1 = 87,   pants_2 = 0,
            shoes_1 = 24,   shoes_2 = 0,
            helmet_1 = -1,  helmet_2 = 0,
            chain_1 = -1,    chain_2 = 0,
            ears_1 = -1,     ears_2 = 0,
		}
	},

	bullet_wear = {
		male = {
			tshirt_1 = 152,  tshirt_2 = 0
		},
		female = {
			bproof_1 = -1,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 152,  tshirt_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}