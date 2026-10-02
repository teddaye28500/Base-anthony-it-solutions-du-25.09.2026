local TabacObjects = 0
local TabacLists = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false

--Tabac--
TabacZone = {
	Pos = {
		x = 2843.33129,   
		y = 4651.415625,  
		z = 48.094165
	},
}

function GenerateTabacObjectCoords() 
	while true do
		Citizen.Wait(1)

		local TabacCoordX, TabacCoordY

		math.randomseed(GetGameTimer())
		local TabacmodX = math.random(-10, 10)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local TabacmodY = math.random(-10, 10)

		TabacCoordX = TabacZone.Pos.x + TabacmodX
		TabacCoordY = TabacZone.Pos.y + TabacmodY

		local coordZ = GetTabacCoordZ(TabacCoordX, TabacCoordY)
		local coord = vector3(TabacCoordX, TabacCoordY, coordZ)

		if ValidateTabacObjectCoord(coord) then
			return coord
		end
	end
end

function GetTabacCoordZ(x, y)
	local TabacgroundCheckHeights = { 1.0, 10.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 100.0 }

	for i, height in ipairs(TabacgroundCheckHeights) do
		local foundTabacGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundTabacGround then
			return z
		end
	end

	return 43.0
end

function ValidateTabacObjectCoord(Tabaccoord)
	if TabacObjects > 0 then
		local validate = true

		for k, v in pairs(TabacLists) do
			if GetDistanceBetweenCoords(Tabaccoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(Tabaccoord, TabacZone.Pos.x, TabacZone.Pos.y, TabacZone.Pos.z, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

TabacProp = {
	{ Name = "prop_plant_fern_02a" }
}

function SpawnTabacs()
	while TabacObjects < 10 do
		Citizen.Wait(0)
		local TabacObjectCoords = GenerateTabacObjectCoords()

		local TabacObject = TabacProp

		local random_stone = math.random(#TabacObject)

		ESX.Game.SpawnLocalObject(TabacObject[random_stone].Name, TabacObjectCoords, function(object)
			PlaceObjectOnGroundProperly(object)
			FreezeEntityPosition(object, true)

			table.insert(TabacLists, object)
			TabacObjects = TabacObjects + 1
		end)
	end
end

-- Spawn
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local PlayerCoords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(PlayerCoords, TabacZone.Pos.x, TabacZone.Pos.y, TabacZone.Pos.z, true) < 50 then
			SpawnTabacs()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)



local Tabacshit = {
	`prop_plant_fern_02a`,  
  }  
  Citizen.CreateThread(function()
  exports["qtarget"]:AddTargetModel(Tabacshit,{
	  options = {
                  {
					event = 'Tabac:start',
					label = 'Recolte Tabac',
					icon = 'fas fa-cube',
                    job = 'tabac',
				  },		
				 },
	  distance = 2.5
	})
end)

TabacAnimation = {
	Scenario = true,
	AnimationDirect = "",
	AnimationScene = "WORLD_HUMAN_GARDENER_PLANT",
}

RegisterNetEvent('Tabac:start')
AddEventHandler('Tabac:start', function()
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		
		for i=1, #TabacLists, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(TabacLists[i]), false) < 1 then
				nearbyObject, nearbyID = TabacLists[i], i
			end
		end
		
    ESX.TriggerServerCallback("TabacRecolte:checkItem", function(result, itemfull)
        if result == true then
			if TabacAnimation.Scenario then
					TaskStartScenarioInPlace(playerPed, TabacAnimation.AnimationScene, 0, false)
					  else
					ESX.Streaming.RequestAnimDict(TabacAnimation.AnimationDirect, function()
					TaskPlayAnim(GetPlayerPed(-1), TabacAnimation.AnimationDirect, TabacAnimation.AnimationScene, 8.0, -8, -1, 49, 0, 0, 0, 0)
				   end)
				end
			local success = true
			isUsing = GetGameTimer()
			isBusy = true
            for i = 1, 1, 1 do
                local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
                if finished <= 0 then
				    ESX.ShowNotification('Tu a casser la pelle..')
                     ClearPedTasksImmediately(PlayerPedId())
                     return
                end
            end
			if success then			
			ESX.Game.DeleteObject(nearbyObject)
			FreezeEntityPosition(playerPed, false)
			ClearPedTasks(playerPed)
			table.remove(TabacLists, nearbyID)
			TabacObjects = TabacObjects
			TriggerServerEvent('TabacRecolte:pickedUp')
			isUsing = GetGameTimer()
			isBusy = true
			print("[ledjo DEBUG:] Success!")
			IsPickingUp = false
            ESX.ShowNotification('Récolte réussit')
			end
			else
            ESX.ShowNotification('Achete toi une pelle avant')
		end
    end, 'tabac')
end)


RegisterNetEvent('blips2')
AddEventHandler('blips2', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then 
		local blip = AddBlipForCoord(2865.468018, 4601.007813, 48.011074) 
		SetBlipSprite (blip, 140) 
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5) 
		SetBlipColour (blip, 76) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Farm Tabac') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('Regarde ta carte pour le point de farm')
end)


RegisterNetEvent('blips3')
AddEventHandler('blips3', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then 
		local blip = AddBlipForCoord(2902.467529, 4489.675781, 48.152782) 
		SetBlipSprite (blip, 140) 
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5) 
		SetBlipColour (blip, 76) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Traitement Tabac') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('Regarde ta carte pour le point de traitement')
end)



