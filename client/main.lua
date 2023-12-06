local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function OpenTeleportsMenu()
	local ped = PlayerPedId()
	local elements = {
		{label = '[PSG] Comisaria - Sandy', value = 'sandy'},
		{label = '[PSG] Comisaria - Paleto', value = 'paleto'},
	}
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'psg_actions', {
		title    = 'Teleport',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'sandy' then
			SetPedCoordsKeepVehicle(ped, 1859.256, 3677.374, 33.671)
			exports['mythic_notify']:DoCustomHudText('inform', 'Te has telestranspotado a Sandy',3000)
		elseif data.current.value == 'paleto' then
			SetPedCoordsKeepVehicle(ped, -449.227, 6009.080, 36.995	)
			exports['mythic_notify']:DoCustomHudText('inform', 'Te has telestranspotado a Paleto',3000)
		end
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'menu_teleports'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
			SetPedComponentVariation(playerPed, 9, 4, 0, 2)

			if uniform == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			ESX.ShowNotification(_U('no_outfit'))
		end
	end)
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
			SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 2)

			if uniform == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			ESX.ShowNotification(_U('no_outfit'))
		end
	end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name
	
	local elements = {
		{label = _U('citizen_wear'), value = 'citizen_wear'},
		{label = _U('psg_wear'), uniform = grade}
	}
	if ESX.PlayerData.job ~= nil and grade == 'sargento1' or grade == 'teniente' or grade == 'subinspector' or grade == 'inspector' or grade == 'subcomisario' or grade == 'comisario' or grade == 'subjefe' or grade == 'jefe' or grade == 'boss' then 
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local isMale = skin.sex == 0

				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
			end)
		end

		if data.current.uniform then
			setUniform(data.current.uniform, playerPed)
		elseif data.current.value == 'freemode_ped' then
			local modelHash

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)
					SetPedDefaultComponentVariation(PlayerPedId())

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenChalecoMenu()
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name
	
	local elements = {
		{label = '<i class="fas fa-horizontal-rule"></i> </i> Sacar Chaleco', armor = 0},
		{label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> Low PSG ', armor = 0},
		{label = '<i class="fas fa-car"></i> Chaleco Ligero' , armor = 50},
		{label = '<i class="fas fa-car"></i> Chaleco Pesado', armor = 75},
		{label = '<i class="fas fa-horizontal-rule"></i><i class="fas fa-horizontal-rule"> </i> Unidad Fanteria', armor = 0},
		{label = '<i class="fas fa-shuttle-van"></i> Chaleco Pesada', armor = 100},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = 'Chalecos',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		SetPedArmour(ped,data.current.armor)
		if data.current.armor == 0 then
			exports['mythic_notify']:DoCustomHudText('inform', 'Te Has Sacado Tu Chaleco',2000)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 0)
			menu.close()
			ClearPedSecondaryTask(GetPlayerPed(-1))
		else
			if data.current.armor == 50 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Te Has Puesto Un Chaleco Ligero',2000)
				if not IsEntityPlayingAnim(GetPlayerPed(-1), 'move_m@_idles@shake_off', 'shakeoff_1', 3) then
					ESX.Streaming.RequestAnimDict('move_m@_idles@shake_off', function()
						TaskPlayAnim(GetPlayerPed(-1), 'move_m@_idles@shake_off', 'shakeoff_1', 8.0, -8, -1, 49, 0, 0, 0, 0)
					end)
				end
				TriggerEvent("mythic_progressbar:client:progress" , {
					name            = "burburbur",
					duration        = 2000,
					label           = "Colocando chaleco",
					useWhileDead    = false,
					canCancel       = true,
					controlDisables = {
						disableMovement    = false,
						disableCarMovement = false,
						disableMouse       = false,
						disableCombat      = false,
					}
				} , function(status)
					if not status then
						-- Do Something If Event Wasn't Cancelled
					end
				end)
				Wait(2000)
				SetPedComponentVariation(PlayerPedId(), 9, 10, 0, 2)
				menu.close()
				ClearPedSecondaryTask(GetPlayerPed(-1))
			elseif data.current.armor == 75 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Te Has Puesto Un Chaleco Pesado',2000)
				if not IsEntityPlayingAnim(GetPlayerPed(-1), 'move_m@_idles@shake_off', 'shakeoff_1', 3) then
					ESX.Streaming.RequestAnimDict('move_m@_idles@shake_off', function()
						TaskPlayAnim(GetPlayerPed(-1), 'move_m@_idles@shake_off', 'shakeoff_1', 8.0, -8, -1, 49, 0, 0, 0, 0)
					end)
				end
				TriggerEvent("mythic_progressbar:client:progress" , function(status)
					if not status then
						-- Do Something If Event Wasn't Cancelled
					end
				end , {
					name            = "chaeel",
					duration        = 2000,
					label           = "Colocando chaleco",
					useWhileDead    = false,
					canCancel       = true,
					controlDisables = {
						disableMovement    = false,
						disableCarMovement = false,
						disableMouse       = false,
						disableCombat      = false,
					}
				})
				Wait(2000)
				SetPedComponentVariation(PlayerPedId(), 9, 2, 0, 2)
				menu.close()
				ClearPedSecondaryTask(GetPlayerPed(-1))
			elseif data.current.armor == 100 then
				exports['mythic_notify']:DoCustomHudText('inform', 'Te Has Puesto Un Chaleco Halcon',2000)
				if not IsEntityPlayingAnim(GetPlayerPed(-1), 'move_m@_idles@shake_off', 'shakeoff_1', 3) then
					ESX.Streaming.RequestAnimDict('move_m@_idles@shake_off', function()
						TaskPlayAnim(GetPlayerPed(-1), 'move_m@_idles@shake_off', 'shakeoff_1', 8.0, -8, -1, 49, 0, 0, 0, 0)
					end)
				end
				TriggerEvent("mythic_progressbar:client:progress" , {
					name            = "chalecoalcon",
					duration        = 2000,
					label           = "Colocando chaleco",
					useWhileDead    = false,
					canCancel       = true,
					controlDisables = {
						disableMovement    = false,
						disableCarMovement = false,
						disableMouse       = false,
						disableCombat      = false,
					}
				} , function(status)
					if not status then
						-- Do Something If Event Wasn't Cancelled
					end
				end)
				Wait(2000)
				SetPedComponentVariation(PlayerPedId(), 9, 2, 0, 2)
				menu.close()
				ClearPedSecondaryTask(GetPlayerPed(-1))
			end
		end
	end, function(data, menu)
		menu.close()
		ClearPedSecondaryTask(GetPlayerPed(-1))

		CurrentAction     = 'menu_chaleco'
		CurrentActionMsg  = _U('open_chaleco')
		CurrentActionData = {}
	end)
end

function OpenAccesoriosMenu(station)
	local elements = {}
	local ped = GetPlayerPed(-1)

	for k,v in pairs(Config.WeaponsInArmory) do
		if v.attachment == true then
			table.insert(elements,{label = v.label, weaponhash = v.weaponHash, type = v.type, attachment = v.attachment, flashlight = v.flashlight, grip = v.grip, suppressor = v.suppressor})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = _U('armory'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.weaponhash == data.current.weaponhash then
			if GetSelectedPedWeapon(ped) == GetHashKey(data.current.weaponhash) then
				ListOfAttachments(data.current.type, data.current.label, data.current.weaponhash, data.current.attachment, data.current.flashlight, data.current.grip, data.current.suppressor)
			else
				ESX.ShowNotification(Config.WeaponMustBeInHand)
			end
		end	
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_accesorios'
		CurrentActionMsg  = _U('open_accesorios')
		CurrentActionData = {station = station}
	end)
end

function ListOfAttachments(type,name,weaponhash,attachment,flashlight,grip,suppressor)
	local elements = {}
	
	local ped = GetPlayerPed(-1)
			
	if flashlight then
		local state = HasPedGotWeaponComponent(ped, weaponhash, flashlight)
		local text
		
		if state then
			text = "Linterna: "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Linterna: "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = flashlight,
			state = not state
		})
	end
			
	if grip then
		local state = HasPedGotWeaponComponent(ped, weaponhash, grip)
		local text
		
		if state then
			text = "Mira: "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Mira: "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = grip,
			state = not state
		})
	end
			
	if suppressor then
		local state = HasPedGotWeaponComponent(ped, weaponhash, suppressor)
		local text
		
		if state then
			text = "Silenciador: "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Silenciador: "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = suppressor,
			state = not state
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'esx_psgarmory_list_of_attachments', {
		title    = 'Accesorios',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local newData = data.current
		
		if data.current.value == flashlight then
			if data.current.state then
				newData.label = "Linterna: "..('<span style="color:green;">%s</span>'):format("On")
				GiveWeaponComponentToPed(ped, weaponhash, data.current.value)
				exports['mythic_notify']:DoCustomHudText('cajaverde', 'Has equipado una Linterna a tu Arma',7000)
			else
				newData.label = "Linterna: "..('<span style="color:red;">%s</span>'):format("Off")
				RemoveWeaponComponentFromPed(ped, weaponhash, data.current.value)
				exports['mythic_notify']:DoCustomHudText('cajaroja', 'Has retirado la Linterna de tu Arma',7000)
			end
		elseif data.current.value == grip then
			if data.current.state then
				newData.label = "Mira: "..('<span style="color:green;">%s</span>'):format("On")
				GiveWeaponComponentToPed(ped, weaponhash, data.current.value)
				exports['mythic_notify']:DoCustomHudText('cajaverde', 'Has equipado una Mira a tu Arma',7000)
			else
				newData.label = "Mira: "..('<span style="color:red;">%s</span>'):format("Off")
				RemoveWeaponComponentFromPed(ped, weaponhash, data.current.value)
				exports['mythic_notify']:DoCustomHudText('cajaroja', 'Has retirado la Mira de tu Arma',7000)
			end
		elseif data.current.value == suppressor then
			if data.current.state then
				newData.label = "Silenciador: "..('<span style="color:green;">%s</span>'):format("On")
				GiveWeaponComponentToPed(ped, weaponhash, data.current.value)
				exports['mythic_notify']:DoCustomHudText('cajaverde', 'Has equipado un Silenciador a tu Arma',7000)
			else
				newData.label = "Silenciador: "..('<span style="color:red;">%s</span>'):format("Off")
				RemoveWeaponComponentFromPed(ped, weaponhash, data.current.value)
				exports['mythic_notify']:DoCustomHudText('cajaroja', 'Has retirado el Silenciador del Arma',7000)
			end
		end
				
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()		
	end)
end

VehiculosMenu = function(type)	
	local elements = {
		{ label = 'Guardar vehiculo', action = "store_vehicle" },
		{ label = 'Sacar vehiculo', action = "get_vehicle" },
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_psgGarage_menu",
		{
			title    = 'Garage',
			align    = "right",
			elements = elements
		},
	function(data, menu)
		menu.close()
		local action = data.current.action
		if action == "get_vehicle" then
			if type == 'car' then
				VehicleMenu('car')
			elseif type == 'helicopter' then
				VehicleMenu('helicopter')
			end
		elseif data.current.action == 'store_vehicle' then
			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
			if dist < 3 then
				DeleteEntity(veh)
				exports['mythic_notify']:SendAlert('cajaroja', 'Guardaste un vehiculo.', 2500, { ['background-color'] = '#00000065', ['color'] = '#fff' })
			else
				exports['mythic_notify']:SendAlert('cajaroja', 'No estas en un vehiculo.', 2500, { ['background-color'] = '#00000065', ['color'] = '#fff' })
			end
			insideMarker = false
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Vehicle Spawn Menu:
VehicleMenu = function(type)
	local storage = nil
	local elements = {}
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
	
	if type == 'car' then
		for k,v in pairs(Config.Vehiculos) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
		end
	elseif type == 'helicopter' then
		for k,v in pairs(Config.Helicopteros) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'helicopter'})
		end
	end
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Garage",
		{
			title    = 'Garage',
			align    = "right",
			elements = elements
		},
	function(data, menu)
		menu.close()
		insideMarker = false
		local plate = exports['esx_vehicleshop']:GeneratePlate()
		VehicleLoadTimer(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)
		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetVehicleNumberPlateText(veh,plate)
		
		if type == 'car' then
			exports['mythic_notify']:SendAlert('cajaverde', 'Sacaste un vehiculo.', 2500, { ['background-color'] = '#00000065', ['color'] = '#fff' })
		elseif type == 'helicopter' then
			exports['mythic_notify']:SendAlert('cajaverde', 'Sacaste un helicoptero.', 2500, { ['background-color'] = '#00000065', ['color'] = '#fff' })
		end
		
		TriggerEvent("fuel:setFuel",veh,100.0)
		SetVehicleDirtLevel(veh, 0.1)		
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)
		end
	end
end

-- Loading Text for Vehicles Function:
function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenArmoryMenu(station)

	local elements = {
		{label = ('<i class="fas fa-money-bill-wave"></i> Comprar armas'), value = 'buy_weapons'}
	}

	if Config.EnableArmoryManagement then
		table.insert(elements, {label = ('<i class="fas fa-box-open"></i> Objetos Incautados'), value = 'get_weapon1'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = _U('armory'),
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon1' then
			TriggerEvent('inventory:openPsgincautadosInventory', 'psg')
		elseif data.current.value == 'get_weapon2' then
			TriggerEvent('inventory:openPsgglobalInventory', 'psg')
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end


function OpenpsgActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'psg_actions', {
		title    = '<i class="fas fa-angle-double-right"></i> Menú Faccionario',
		align    = 'right',
		elements = {
			{label = ('<i class="fas fa-angle-double-right"></i> Menú de acciones'), value = 'citizen_interaction'},

			{label = ('<i class="fas fa-car"></i> Menú de vehiculos'), value = 'vehicle_interaction'},

			{label = ('<i class="fas fa-cube"></i> Menú de objetos'), value = 'object_spawner'},

			{label = ('<i class="fas fa-headset"></i> Cortar'), value = 'cortar_negociaciones'},
	}}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = ('<i class="fas fa-search"></i> Cachear'), value = 'search'},

				{label = ('<i class="fas fa-lock"></i> Esposar/Desesposar'), value = 'handcuff'},

				{label = ('<i class="fas fa-handshake"></i> Escoltar'), value = 'drag'},

				{label = ('<i class="fas fa-paper-plane"></i> Meter al vehículo'), value = 'put_in_vehicle'},

				{label = ('<i class="fas fa-minus-circle"></i> Sacar del vehículo'), value = 'out_the_vehicle'},

			}
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('citizen_interaction'),
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'search' then
						OpenBodySearchMenu(GetPlayerServerId(closestPlayer))
					elseif action == 'esx_worek:nalozNa' then
						TriggerServerEvent('esx_worek:nalozNa', GetPlayerServerId(closestPlayer))
					elseif action == 'handcuff' then
						TriggerServerEvent('esx_psg:handcuff', GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('esx_psg:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_psg:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_psg:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					elseif action == 'community_service' then
						OpenCommunutyServiceMenu(closestPlayer)
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = ('<i class="fas fa-clipboard"></i> Información del vehículo'), value = 'vehicle_infos'})

				table.insert(elements, {label = ('<i class="fas fa-lock-open"></i> Forzar vehículo'), value = 'hijack_vehicle'})

				table.insert(elements, {label = ('<i class="fas fa-car-crash"></i> Embargar vehículo'), value = 'impound'})
			end

			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {

				title    = ('<i class="fas fa-car"></i> Menú de vehiculos'),

				align    = 'right',

				elements = elements

			}, function(data2, menu2)

				local coords  = GetEntityCoords(playerPed)

				vehicle = ESX.Game.GetVehicleInDirection()

				action  = data2.current.value



				if action == 'search_database' then

					LookupVehicle()

				elseif DoesEntityExist(vehicle) then

					if action == 'vehicle_infos' then

						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

						OpenVehicleInfosMenu(vehicleData)

					elseif action == 'hijack_vehicle' then

						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

							Citizen.Wait(20000)

							ClearPedTasksImmediately(playerPed)



							SetVehicleDoorsLocked(vehicle, 1)

							SetVehicleDoorsLockedForAllPlayers(vehicle, false)

							ESX.ShowNotification(_U('vehicle_unlocked'))

						end

					elseif action == 'impound' then

						-- is the script busy?

						if currentTask.busy then

							return

						end



						ESX.ShowHelpNotification(_U('impound_prompt'))

						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)



						currentTask.busy = true

						currentTask.task = ESX.SetTimeout(10000, function()

							ClearPedTasks(playerPed)

							ImpoundVehicle(vehicle)

							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality

						end)



						-- keep track of that vehicle!

						Citizen.CreateThread(function()

							while currentTask.busy do

								Citizen.Wait(1000)



								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)

								if not DoesEntityExist(vehicle) and currentTask.busy then

									ESX.ShowNotification(_U('impound_canceled_moved'))

									ESX.ClearTimeout(currentTask.task)

									ClearPedTasks(playerPed)

									currentTask.busy = false

									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'right',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('spikestrips'), model = 'prop_air_conelight'},
					{label = _U('barrier'), model = 'prop_mp_barrier_02b'},
					{label = _U('cash'), model = 'prop_mp_arrow_barrier_01'},
					{label = _U('box'), model = 'p_ld_stinger_s'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)

				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)

	
end


function OpenBodySearchMenu(id)
	TriggerServerEvent('esx_psg:requestSearch', id)
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'right',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
		
	end)	
end


function OpenCommunutyServiceMenu(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", GetPlayerServerId(player), community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_psg:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = _U('fine'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_psg', _U('fine_total', data.current.fineLabel), data.current.amount)
			else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_psg:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = _U('plate', retrivedInfo.plate)}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = _U('owner_unknown')})
				else
					table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = _U('vehicle_info'),
					align    = 'right',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_psg:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'right',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, playerData.name))
			TriggerServerEvent('esx_psg:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_psg:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if not retrivedInfo.owner then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_psg:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = _U('get_weapon_menu'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_psg:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_psg:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()
	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	for k,v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local components, label = {}
		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if v.components then
			for i=1, #v.components do
				if v.components[i] then
					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
						end
					end

					table.insert(components, {
						label = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					})
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			end
		end

		table.insert(elements, {
			label = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = components,
			price = v.price,
			hasWeapon = hasWeapon
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			ESX.TriggerServerCallback('esx_psg:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end
	end, function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_psg:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_psg'),
		number     = 'psg',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'psg' and ESX.PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.EnableESXService and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('esx_psg:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Chaleco' then
		CurrentAction     = 'menu_chaleco'
		CurrentActionMsg  = _U('open_chaleco')
		CurrentActionData = {station = station}
	elseif part == 'Vehiculos' then
		CurrentAction     = 'menu_vehiculos'
		CurrentActionMsg  = _U('open_vehiculos')
		CurrentActionData = {station = station}
	elseif part == 'Helicopteros' then
		CurrentAction     = 'menu_helicopteros'
		CurrentActionMsg  = _U('open_vehiculos')
		CurrentActionData = {station = station}
	elseif part == 'Accesorios' then
		CurrentAction     = 'menu_accesorios'
		CurrentActionMsg  = _U('open_accesorios')
		CurrentActionData = {station = station}
	elseif part == 'Teleports' then
		CurrentAction = 'menu_teleports'
		CurrentActionMsg = _U('open_teleports')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_psg:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_psg:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'psg' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_psg:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_psg:handcuff')
AddEventHandler('esx_psg:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		DisplayRadar(false)

		if Config.EnableHandcuffTimer then
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			StartHandcuffTimer()
		end
	else
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('esx_psg:unrestrain')
AddEventHandler('esx_psg:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_psg:drag')
AddEventHandler('esx_psg:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_psg:putInVehicle')
AddEventHandler('esx_psg:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('esx_psg:OutVehicle')
AddEventHandler('esx_psg:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.psgStations) do 
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Create blips x2
Citizen.CreateThread(function()
	for k,v in pairs(Config.psg1Stations) do 
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'psg' then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.psgStations) do
				for i=1, #v.Cloakrooms, 1 do
					local distance = #(playerCoords - v.Cloakrooms[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Cloakrooms, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
							DrawText3D(-1112.1810, -824.3599, 19.3159, 'Presiona ~b~[E]~w~ para abrir la vestimenta.')
						end
						
					end
				end
				
				for i=1, #v.Teleports, 1 do
					local distance = #(playerCoords - v.Teleports[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Teleports, v.Teleports[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Teleports', i
						end
						
					end
				end
				
				for i=1, #v.Vehiculos, 1 do
					local distance = #(playerCoords - v.Vehiculos[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Vehiculos, v.Vehiculos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehiculos', i
							DrawText3D(-1107.3193, -800.1888, 18.0742, 'Presiona ~b~[E]~w~ para abrir el garage.')
						end
						
					end
				end
				
				for i=1, #v.Helicopteros, 1 do
					local distance = #(playerCoords - v.Helicopteros[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Helicopteros, v.Helicopteros[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopteros', i
							DrawText3D(-1107.0397, -793.6418, 18.4601, 'Presiona ~b~[E]~w~ para abrir el garage de helicopteros.')
						end
						
					end
				end

				for i=1, #v.Armories, 1 do
					local distance = #(playerCoords - v.Armories[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Armories, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
							DrawText3D(-1108.9032, -843.6177, 19.3170, 'Presiona ~b~[E]~w~ para abrir la armeria.')
						end
					end
				end
				
				for i=1, #v.Chaleco, 1 do
					local distance = #(playerCoords - v.Chaleco[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Chaleco, v.Chaleco[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Chaleco', i
							DrawText3D(-1091.8213, -808.7587, 19.2704, 'Presiona ~b~[E]~w~ para abrir la seleccion de chalecos.')
						end
						
					end
				end
				
				for i=1, #v.Accesorios, 1 do
					local distance = #(playerCoords - v.Accesorios[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Accesorios, v.Accesorios[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Accesorios', i
							DrawText3D(-1107.1489, -845.6832, 19.3170, 'Presiona ~b~[E]~w~ para abrir los accesorios.')
						end
						
					end
				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						local distance = #(playerCoords - v.BossActions[i])

						if distance < Config.DrawDistance then
							DrawMarker(Config.MarkerType.BossActions, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false

							if distance < Config.MarkerSize.x then
								isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
								DrawText3D(449.56591796875, -975.44366455078, 30.689599990845, 'Presiona ~b~[E]~w~ para abrir las acciones del jefe.')
							end
						end
					end
				end
			end

			

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_psg:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_psg:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_psg:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_air_conelight',
		'prop_mp_barrier_02b',
		'prop_mp_arrow_barrier_01',
		'p_ld_stinger_s'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance = #(playerCoords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_psg:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_psg:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'psg' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_teleports' then
					OpenTeleportsMenu()
				elseif CurrentAction == 'menu_chaleco' then
					OpenChalecoMenu()
				elseif CurrentAction == 'menu_vehiculos' then
					VehiculosMenu('car')
				elseif CurrentAction == 'menu_helicopteros' then
					VehiculosMenu('helicopter')
				elseif CurrentAction == 'menu_accesorios' then
					OpenAccesoriosMenu()
				elseif CurrentAction == 'menu_armory' then
					if not Config.EnableESXService then
						OpenArmoryMenu()
						--TriggerEvent('inventory:openPolInventory', tostring(zone), 'psg', items)
					elseif playerInService then
						OpenArmoryMenu()
						--TriggerEvent('inventory:openPolInventory', tostring(zone), 'psg', items)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'psg', function(data, menu)
						menu.close()

						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'psg' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'psg_actions') then
			if not Config.EnableESXService then
				OpenpsgActionsMenu()
			elseif playerInService then
				OpenpsgActionsMenu()
			else
				ESX.ShowNotification(_U('service_not'))
			end
		end

		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())

			currentTask.busy = false
		end
	end
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_psg:updateBlip')
AddEventHandler('esx_psg:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.EnableESXService and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'psg' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'psg' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_psg:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_psg:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_psg:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'psg')

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_psg:unrestrain')
		handcuffTimer.active = false
	end)
end

