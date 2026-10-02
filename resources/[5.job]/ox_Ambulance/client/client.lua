ESX = exports["es_extended"]:getSharedObject()
isDead, disableKeys, inMenu, stretcher, stretcherMoving, isBusy = nil, nil, nil, nil, nil, nil
local playerLoaded, injury
plyRequests = {}

CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(1000)
    end
    ESX.PlayerData.job = ESX.GetPlayerData().job
    exports.qtarget:AddTargetModel({`xm_prop_x17_bag_med_01a`}, {
        options = {
            {
                event = 'ledjo_ambulance:pickupBag',
                icon = 'fas fa-hand-paper',
                label = Strings.pickup_bag_target,
            },
            {
                event = 'ledjo_ambulance:interactBag',
                icon = 'fas fa-briefcase',
                label = Strings.interact_bag_target,
            },

        },
        job = 'all',
        distance = 1.5
    })
    exports.qtarget:Player({
        options = {
            {
                event = 'ledjo_ambulance:diagnosePatient',
                icon = 'fas fa-stethoscope',
                label = Strings.diagnose_patient,
                job = 'ambulance',
            },
            {
                event = 'ledjo_ambulance:reviveTarget',
                icon = 'fas fa-medkit',
                label = Strings.revive_patient,
                job = 'ambulance',
            },
            {
                event = 'ledjo_ambulance:healTarget',
                icon = 'fas fa-bandage',
                label = Strings.heal_patient,
                job = 'ambulance',
            },
            {
                event = 'ledjo_ambulance:useSedative',
                icon = 'fas fa-syringe',
                label = Strings.sedate_patient,
                job = 'ambulance',
            }
        },
        distance = 2.5,
    })
end)

AddEventHandler("onClientMapStart", function()
	exports.spawnmanager:spawnPlayer()
	Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    local ped = cache.ped
    SetEntityMaxHealth(ped, 200)
    SetEntityHealth(ped, 200)
	ESX.PlayerData = xPlayer
	playerLoaded = true
    if Config.AntiCombatLog.enabled then
        ESX.TriggerServerCallback('ledjo_ambulance:checkDeath', function(dead)
            if dead then
                Wait(2000) -- For slow clients we will wait 2 seconds~ for the ped to be spawned
                SetEntityHealth(PlayerPedId(), 0)
                if Config.AntiCombatLog.notification.enabled then
                    TriggerEvent('ledjo_ambulance:notify', Config.AntiCombatLog.notification.title, Config.AntiCombatLog.desc, 'error', 'skull-crossbones')
                end
            end
        end)
    end
    if ESX.PlayerData.job.name == 'ambulance' then
        TriggerServerEvent('ledjo_ambulance:requestSync')
    end
end)

RegisterNetEvent('ledjo_ambulance:notify', function(title, desc, style, icon)
    if icon then
        lib.notify({
            title = title,
            description = desc,
            duration = 3500,
            icon = icon,
            type = style
        })
    else
        lib.notify({
            title = title,
            description = desc,
            duration = 3500,
            type = style
        })
    end
end)

RegisterNetEvent('esx:setJob', function(job)
	ESX.PlayerData.job = job
    if job.name == 'ambulance' then
        TriggerServerEvent('ledjo_ambulance:requestSync')
    end
end)

CreateThread(function()
	while true do
		local sleep = 1500
		if isDead or disableKeys then
            sleep = 0
			DisableAllControlActions(0)
            EnableControlAction(0, 1, true) -- Camera Pan(Mouse)
			EnableControlAction(0, 2, true) -- Camera Tilt(Mouse)
            EnableControlAction(0, 38, true) -- E Key
			EnableControlAction(0, 46, true) -- E Key
            EnableControlAction(0, 47, true) -- G Key
			EnableControlAction(0, 245, true) -- T Key
		end
        Wait(sleep)
	end
end)

AddEventHandler('esx:onPlayerSpawn', function()
    isDead = false
    local ped = cache.ped
    SetEntityMaxHealth(ped, 200)
    SetEntityHealth(ped, 200)
    SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
    if firstSpawn then
        firstSpawn = false
        while not playerLoaded do
            Wait(1000)
        end
        lib.requestAnimDict('get_up@directional@movement@from_knees@action', 100)
        TaskPlayAnim(ped, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
    else
        AnimpostfxStopAll()
        lib.requestAnimDict('get_up@directional@movement@from_knees@action', 100)
        TaskPlayAnim(ped, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
    end
    TriggerServerEvent('ledjo_ambulance:setDeathStatus', false)
    RemoveAnimDict('get_up@directional@movement@from_knees@action')
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    injury = nil
    ESX.UI.Menu.CloseAll()
    if Config.MythicHospital then
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
    end
    for k,v in pairs(DeathReasons) do
        for i=1, #v do
            if data.deathCause == v[i] then
                injury = tostring(k) -- Not sure maybe will return string anyway
                break
            end
        end
    end
    TriggerServerEvent('ledjo_ambulance:injurySync', injury)
    OnPlayerDeath()
end)

-- I am monster thread
CreateThread(function()
    while ESX.PlayerData.job == nil do
        Wait(1000) -- Necessary for some of the loops that use job check in these threads within threads.
    end
    for k,v in pairs(Config.Locations) do
        if v.Blip.Enabled then
            CreateBlip(v.Blip.Coords, v.Blip.Sprite, v.Blip.Color, v.Blip.String, v.Blip.Scale, false)
        end
        if v.BossMenu.Enabled then
            exports.qtarget:AddBoxZone(k.."BossMenu", v.BossMenu.Target.coords, v.BossMenu.Target.width, v.BossMenu.Target.length, {
                name=k.."BossMenu",
                heading=v.BossMenu.Target.heading,
                debugPoly=false,
                minZ=v.BossMenu.Target.minZ,
                maxZ=v.BossMenu.Target.maxZ
            }, {
                options = {
                    {
                        event = 'ledjo_ambulance:openBossMenu',
                        icon = 'fa-solid fa-suitcase-medical',
                        label = v.BossMenu.Target.label
                    }
                },
                job = 'ambulance',
                distance = 2.0
            })
        end
        if v.CheckIn.Enabled then
            CreateThread(function()
                local ped, pedSpawned
                local textUI
                while true do
                    local sleep = 1500
                    local playerPed = cache.ped
                    local coords = GetEntityCoords(playerPed)
                    local dist = #(coords - v.CheckIn.Coords)
                    if dist <= 30 and not pedSpawned then
                        lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                        lib.requestModel(v.CheckIn.Ped, 100)
                        ped = CreatePed(28, v.CheckIn.Ped, v.CheckIn.Coords.x, v.CheckIn.Coords.y, v.CheckIn.Coords.z, v.CheckIn.Heading, false, false)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                        pedSpawned = true
                    elseif dist < 5 and pedSpawned then
                        if not textUI then
                            lib.showTextUI(v.CheckIn.Label)
                            textUI = true
                        end
                        sleep = 0
                        if IsControlJustReleased(0, 38) then
                            textUI = nil
                            lib.hideTextUI()
                            ESX.TriggerServerCallback('ledjo_ambulance:tryRevive', function(cb)
                                if cb == 'success' then
                                    TriggerEvent('ledjo_ambulance:notify', Strings.checkin_hospital, Strings.checkin_hospital_desc, 'success')
                                elseif cb == 'max' then
                                    TriggerEvent('ledjo_ambulance:notify', Strings.max_ems, Strings.max_ems_desc, 'error')
                                else
                                    TriggerEvent('ledjo_ambulance:notify', Strings.not_enough_funds, Strings.not_enough_funds_desc, 'error')
                                end
                            end, v.CheckIn.Cost, v.CheckIn.MaxOnDuty, v.CheckIn.PayAccount)
                        end
                    elseif dist > 4 and textUI then
                        lib.hideTextUI()
                        textUI = nil
                    elseif dist >= 31 and pedSpawned then
                        local model = GetEntityModel(ped)
                        SetModelAsNoLongerNeeded(model)
                        DeletePed(ped)
                        SetPedAsNoLongerNeeded(ped)
                        RemoveAnimDict('mini@strip_club@idles@bouncer@base')
                        pedSpawned = nil
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.Cloakroom.Enabled then
            CreateThread(function()
                local textUI
                while true do
                    local sleep = 1500
                    if ESX.PlayerData.job.name == 'ambulance' then
                        local ped = cache.ped
                        local coords = GetEntityCoords(ped)
                        local dist = #(coords - v.Cloakroom.Coords)
                        if dist <= v.Cloakroom.Range then
                            if not textUI then
                                lib.showTextUI(v.Cloakroom.Label)
                                textUI = true
                            end
                            sleep = 0
                            if IsControlJustReleased(0, 38) then
                                openOutfits(k)
                            end
                        else
                            if textUI then
                                lib.hideTextUI()
                                textUI = nil
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.MedicalSupplies.Enabled then
            exports.qtarget:AddBoxZone(k.."_medsup", v.MedicalSupplies.Coords, 1.0, 1.0, {
                name=k.."_medsup",
                heading=v.MedicalSupplies.Heading,
                debugPoly=false,
                minZ=v.MedicalSupplies.Coords.z-1.5,
                maxZ=v.MedicalSupplies.Coords.z+1.5
            }, {
                options = {
                    {
                        event = 'ledjo_ambulance:medicalSuppliesMenu',
                        icon = 'fa-solid fa-suitcase-medical',
                        label = Strings.request_supplies_target,
                        hospital = k
                    }
                },
                job = 'ambulance',
                distance = 1.5
            })
            CreateThread(function() 
                local ped, pedSpawned
                while true do
                    local sleep = 1500
                    local playerPed = cache.ped
                    local coords = GetEntityCoords(playerPed)
                    local dist = #(coords - v.MedicalSupplies.Coords)
                    if dist <= 30 and not pedSpawned then
                        lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                        lib.requestModel(v.MedicalSupplies.Ped, 100)
                        ped = CreatePed(28, v.MedicalSupplies.Ped, v.MedicalSupplies.Coords.x, v.MedicalSupplies.Coords.y, v.MedicalSupplies.Coords.z, v.MedicalSupplies.Heading, false, false)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                        pedSpawned = true
                    elseif dist >= 31 and pedSpawned then
                        local model = GetEntityModel(ped)
                        SetModelAsNoLongerNeeded(model)
                        DeletePed(ped)
                        SetPedAsNoLongerNeeded(ped)
                        RemoveAnimDict('mini@strip_club@idles@bouncer@base')
                        pedSpawned = false
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.Vehicles.Enabled then
            CreateThread(function()
                local zone = v.Vehicles.Zone
                local textUI
                while true do
                    local sleep = 1500
                    if ESX.PlayerData.job.name == 'ambulance' then
                        local playerPed = cache.ped
                        local coords = GetEntityCoords(playerPed)
                        local dist = #(coords - zone.coords)
                        local dist2 = #(coords - v.Vehicles.Spawn.air.coords)
                        if dist < zone.range + 1 and not inMenu and not IsPedInAnyVehicle(playerPed, false) then
                            sleep = 0
                            if not textUI then
                                lib.showTextUI(zone.label)
                                textUI = true
                            end
                            if IsControlJustReleased(0, 38) then
                                textUI = nil
                                lib.hideTextUI()
                                openVehicleMenu(k)
                                sleep = 1500
                            end
                        elseif dist < zone.range + 1 and not inMenu and IsPedInAnyVehicle(playerPed, false) then
                            sleep = 0
                            if not textUI then
                                textUI = true
                                lib.showTextUI(zone.return_label)
                            end
                            if IsControlJustReleased(0, 38) then
                                textUI = nil
                                lib.hideTextUI()
                                if DoesEntityExist(cache.vehicle) then
                                    DoScreenFadeOut(800)
                                    while not IsScreenFadedOut() do Wait(100) end
                                    SetEntityAsMissionEntity(cache.vehicle)
                                    DeleteVehicle(cache.vehicle)
                                    DoScreenFadeIn(800)
                                end
                            end
                        elseif dist2 < 10 and IsPedInAnyVehicle(playerPed, false) then
                            sleep = 0
                            if not textUI then
                                textUI = true
                                lib.showTextUI(zone.return_label)
                            end
                            if IsControlJustReleased(0, 38) then
                                textUI = nil
                                lib.hideTextUI()
                                if DoesEntityExist(cache.vehicle) then
                                    DoScreenFadeOut(800)
                                    while not IsScreenFadedOut() do Wait(100) end
                                    SetEntityAsMissionEntity(cache.vehicle)
                                    DeleteVehicle(cache.vehicle)
                                    SetEntityCoordsNoOffset(playerPed, zone.coords.x, zone.coords.y, zone.coords.z, false, false, false, true)
                                    DoScreenFadeIn(800)
                                end
                            end
                        else
                            if textUI then
                                textUI = nil
                                lib.hideTextUI()
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
    end
end)

RegisterNetEvent('ledjo_ambulance:syncRequests')
AddEventHandler('ledjo_ambulance:syncRequests', function(_plyRequests, quiet)
    if ESX.PlayerData.job.name == 'ambulance' then
        plyRequests = _plyRequests
        if not quiet then
            TriggerEvent('ledjo_ambulance:notify', Strings.assistance_title, Strings.assistance_desc, 'error', 'suitcase-medical')
        end
    end
end)

-- esx_ambulancejob compatibility
RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
    TriggerEvent("ledjo_ambulance:revive")
end)

RegisterNetEvent('ledjo_ambulance:revivePlayer', function()
    if LocalPlayer.state.dead then
        local ped = cache.ped
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        local injury = LocalPlayer.state.injury
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(50)
        end
        TriggerServerEvent('ledjo_ambulance:setDeathStatus', false)
        isDead = false
        NetworkResurrectLocalPlayer(coords, heading, true, false)
        ClearPedBloodDamage(ped)
        if Config.MythicHospital then
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            TriggerEvent('mythic_hospital:client:ResetLimbs')
        end
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(800)
        AnimpostfxStopAll()
        TriggerServerEvent('esx:onPlayerSpawn')
        TriggerEvent('esx:onPlayerSpawn')
        ClearPedTasks(ped)
        if not injury then
            SetEntityHealth(ped, 200)
        else
            ApplyDamageToPed(ped, Config.ReviveHealth[injury])
        end
    end 
end)

RegisterNetEvent('ledjo_ambulance:revive',function()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    TriggerServerEvent('ledjo_ambulance:setDeathStatus', false)
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Wait(50)
    end
    NetworkResurrectLocalPlayer(coords, heading, true, false)
    ClearPedBloodDamage(ped)
    isDead = false
    if Config.MythicHospital then
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
    end
    DoScreenFadeIn(800)
    AnimpostfxStopAll()
    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
end)

RegisterNetEvent('ledjo_ambulance:heal', function(full, quiet)
    local ped = cache.ped
    local maxHealth = 200
    if not full then
        local health = GetEntityHealth(ped)
        local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
        SetEntityHealth(ped, newHealth)
    else
        SetEntityHealth(ped, maxHealth)
    end
    if not quiet then
        TriggerEvent('ledjo_ambulance:notify', Strings.player_successful_heal, Strings.player_healed_desc, 'success')
    end
end)

RegisterNetEvent('ledjo_ambulance:sedate', function()
    local ped = cache.ped
    TriggerEvent('ledjo_ambulance:notify', Strings.assistance_title, Strings.assistance_desc, 'success', 'syringe')
    ClearPedTasks(ped)
    lib.requestAnimDict('mini@cpr@char_b@cpr_def', 100)
    disableKeys = true
    TaskPlayAnim(ped, 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    Wait(Config.EMSItems.sedate.duration)
    FreezeEntityPosition(ped, false)
    disableKeys = false
    ClearPedTasks(ped)
    RemoveAnimDict('mini@cpr@char_b@cpr_def')
end)

RegisterNetEvent('ledjo_ambulance:intoVehicle', function()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    if IsPedInAnyVehicle(ped) then
        coords = GetOffsetFromEntityInWorldCoords(ped, -2.0, 1.0, 0.0)
        SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    else
        if IsAnyVehicleNearPoint(coords, 6.0) then
            local vehicle = GetClosestVehicle(coords, 6.0, 0, 71)
            if DoesEntityExist(vehicle) then
                local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
                for i=maxSeats - 1, 0, -1 do
                    if IsVehicleSeatFree(vehicle, i) then
                        freeSeat = i
                        break
                    end
                end
                if freeSeat then
                    TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
                end
            end
        end
    end
end)

RegisterNetEvent('ledjo_ambulance:syncObj', function(netObj)
    local obj = NetToObj(netObj)
    deleteObj(obj)
end)

RegisterNetEvent('ledjo_ambulance:useSedative', function()
    useSedative()
end)

RegisterNetEvent('ledjo_ambulance:useMedbag', function()
    useMedbag()
end)

RegisterNetEvent('ledjo_ambulance:treatPatient', function(injury)
    treatPatient(injury)
end)

AddEventHandler('ledjo_ambulance:buyItem', function(data)
    TriggerServerEvent('ledjo_ambulance:restock', data)
end)

RegisterNetEvent('ledjo_ambulance:placeOnStretcher', function()
    placeOnStretcher()
end)

AddEventHandler('ledjo_ambulance:openBossMenu', function()
	TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
		menu.close()
	end, {wash = false})
end)

AddEventHandler('ledjo_ambulance:spawnVehicle', function(data)
    inMenu = false
    local model = data.model
    local category = Config.Locations[data.hospital].Vehicles.Options[data.model].category
    local spawnLoc = Config.Locations[data.hospital].Vehicles.Spawn[category]
    if not IsModelInCdimage(GetHashKey(model)) then
        print('Vehicle model not found: '..model)
    else
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(100)
        end
        lib.requestModel(model, 100)
        local vehicle = CreateVehicle(GetHashKey(model), spawnLoc.coords.x, spawnLoc.coords.y, spawnLoc.coords.z, spawnLoc.heading, 1, 0)
        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
        if Config.customCarlock then
            -- Leave like this if using wasabi_carlock OR change with your own!
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('wasabi_carlock:addKey', plate)
        end
        SetModelAsNoLongerNeeded(model)
        DoScreenFadeIn(800)
    end
end)

AddEventHandler('ledjo_ambulance:changeClothes', function(data) -- Change with your own code here if you want?
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if data == 'civ_wear' then
            if Config.skinScript == 'appearance' then
                    skin.sex = nil
                    exports['illenium-appearance']:setPlayerAppearance(skin)
            else
               TriggerEvent('skinchanger:loadClothes', skin)
            end
        elseif skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, data.male)
		elseif skin.sex == 1 then
			TriggerEvent('skinchanger:loadClothes', skin, data.female)
		end
    end)
end)

AddEventHandler('ledjo_ambulance:billPatient', function()
    if ESX.PlayerData.job.name == 'ambulance' then
        local player, dist = ESX.Game.GetClosestPlayer()
        if player == -1 or dist > 4.0 then
            TriggerEvent('ledjo_ambulance:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
        else
            local targetId = GetPlayerServerId(player)
            local input = lib.inputDialog('Bill Patient', {'Amount'})
            if not input then return end
            local amount = math.floor(tonumber(input[1]))
            if amount < 1 then
                TriggerEvent('ledjo_ambulance:notify', Strings.invalid_entry, Strings.invalid_entry_desc, 'error')
            elseif Config.billingSystem == 'okok' then
                local data =  {
                    target = targetId,
                    invoice_value = amount,
                    invoice_item = Strings.medical_services,
                    society = 'society_ambulance',
                    society_name = 'Hospital',
                    invoice_notes = ''
                }
                TriggerServerEvent('okokBilling:CreateInvoice', data)
            else
                TriggerServerEvent('esx_billing:sendBill', targetId, 'society_ambulance', 'EMS', amount)
            end
        end
    end
end)

AddEventHandler('ledjo_ambulance:medicalSuppliesMenu', function(data)
    medicalSuppliesMenu(data.hospital)
end)

AddEventHandler('ledjo_ambulance:gItem', function(data)
    gItem(data)
end)

AddEventHandler('ledjo_ambulance:interactBag', function()
    interactBag()
end)

AddEventHandler('ledjo_ambulance:pickupBag', function()
    pickupBag()
end)

AddEventHandler('ledjo_ambulance:placeInVehicle', function()
    placeInVehicle()
end)

AddEventHandler('ledjo_ambulance:dispatchMenu', function()
    openDispatchMenu()
end)

AddEventHandler('ledjo_ambulance:setRoute', function(data)
    setRoute(data)
end)

AddEventHandler('ledjo_ambulance:diagnosePatient', function()
    diagnosePatient()
end)

AddEventHandler('ledjo_ambulance:loadStretcher', function()
    loadStretcher()
end)

RegisterNetEvent('ledjo_ambulance:useStretcher')
AddEventHandler('ledjo_ambulance:useStretcher', function()
    useStretcher()
end)

AddEventHandler('ledjo_ambulance:pickupStretcher', function()
    pickupStretcher()
end)

AddEventHandler('ledjo_ambulance:moveStretcher', function()
    moveStretcher()
end)

AddEventHandler('ledjo_ambulance:addTarget', function(d)
    exports.qtarget:AddBoxZone(d.identifier, d.coords, d.width, d.length, {
        name=d.identifier,
        heading=d.heading,
        debugPoly=false,
        minZ=d.minZ,
        maxZ=d.maxZ
    }, {
        options = d.options,
        job = d.job,
        distance = d.distance
    })
end)

AddEventHandler('ledjo_ambulance:removeTarget', function(identifier)
    exports.qtarget:RemoveZone(identifier)
end)

RegisterNetEvent('ledjo_ambulance:reviveTarget')
AddEventHandler('ledjo_ambulance:reviveTarget', function()
    reviveTarget()
end)

RegisterNetEvent('ledjo_ambulance:healTarget')
AddEventHandler('ledjo_ambulance:healTarget', function()
    healTarget()
end)

RegisterCommand('emsJobMenu', function()
    openJobMenu()
end)

AddEventHandler('ledjo_ambulance:emsJobMenu', function()
    openJobMenu()
end)

TriggerEvent('chat:removeSuggestion', '/emsJobMenu')

RegisterKeyMapping('emsJobMenu', Strings.key_map_text, 'keyboard', Config.jobMenu)


RegisterNetEvent('ledjoems:setBlip')
AddEventHandler('ledjoems:setBlip', function(coords)
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
    ESX.ShowAdvancedNotification('Ambulance EMS', 'Un Agent EMS demande une assistance supplémentaire [Voir GPS]', 1)
    Wait(1000)
    PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    local blipId = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('[EMS] Demande Assistance')
    EndTextCommandSetBlipName(blipId)
    Wait(20 * 1000)
    RemoveBlip(blipId)
end)

RegisterNetEvent('ledjoems:test')
AddEventHandler('ledjoems:test', function(coords)
	TriggerServerEvent('ledjoems:renfortDemande')
end)

RegisterNetEvent('ledjoems:sendbill')
AddEventHandler('ledjoems:sendbill', function()
      local input = lib.inputDialog('Facture Ambulance', {'Amount'})

           if input then
                local amount = tonumber(input[1])

                if amount == nil or amount < 0 then
					lib.notify({
						title = 'Ambulance EMS',
						description = 'Montant Invalide!',
						type = 'erorr',
						position = 'top'
					})
                else
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 4.0 then
					lib.notify({
						title = 'Ambulance EMS',
						description = 'Personne proche!',
						type = 'erorr',
						position = 'top'
					})
                else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'Facture EMS', amount)
            end
        end
    end
end)