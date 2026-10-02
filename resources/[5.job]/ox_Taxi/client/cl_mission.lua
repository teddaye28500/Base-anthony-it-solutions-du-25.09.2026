RegisterCommand('starttaxi', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed and IsInAuthorizedVehicle() then
            StartTaxiJob()
        else
            lib.notify({
                title = 'Taxi',
                description = "Vous n'étes pas dans un Taxi",
                type = 'error'
            })
        end
    end
end)

RegisterCommand('stoptaxi', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
        StopTaxiJob()
        lib.notify({
            title = 'Taxi',
            description = "Mission terminée.",
            type = 'success'
        })
    end
end)

RegisterNetEvent('startpnj')
AddEventHandler('startpnj', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed and IsInAuthorizedVehicle() then
            StartTaxiJob()
        else
            lib.notify({
                title = 'Taxi',
                description = "Tu n\'es pas dans un taxi.",
                type = 'error'
            })
        end
    end
end)

RegisterNetEvent('stoppnj')
AddEventHandler('stoppnj', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
        StopTaxiJob()
        lib.notify({
            title = 'Taxi',
            description = "Mission terminée.",
            type = 'success'
        })
    end
end)

function IsInAuthorizedVehicle()
    local playerPed = PlayerPedId()
    local vehModel = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

    for i = 1, #Config.AuthorizedVehicles, 1 do
        if vehModel == joaat(Config.AuthorizedVehicles[i].model) then
            return true
        end
    end

    return false
end

function DrawSub(msg, time)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

function ShowLoadingPromt(msg, time, type)
    CreateThread(function()
        Wait(0)

        BeginTextCommandBusyspinnerOn('STRING')
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandBusyspinnerOn(type)
        Wait(time)

        BusyspinnerOff()
    end)
end

function GetRandomWalkingNPC()
    local search = {}
    local peds = GetGamePool("CPed")

    for i = 1, #peds, 1 do
        if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
            search[#search + 1] = peds[i]
        end
    end

    if #search > 0 then
        return search[math.random(#search)]
    end
end

function ClearCurrentMission()
    if DoesBlipExist(CurrentCustomerBlip) then
        RemoveBlip(CurrentCustomerBlip)
    end

    if DoesBlipExist(DestinationBlip) then
        RemoveBlip(DestinationBlip)
    end

    CurrentCustomer = nil
    CurrentCustomerBlip = nil
    DestinationBlip = nil
    IsNearCustomer = false
    CustomerIsEnteringVehicle = false
    CustomerEnteredVehicle = false
    targetCoords = nil
end

function StartTaxiJob()
    ShowLoadingPromt(TranslateCap('taking_service'), 5000, 3)
    ClearCurrentMission()

    OnJob = true
end

function StopTaxiJob()
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) and CurrentCustomer ~= nil then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        TaskLeaveVehicle(CurrentCustomer, vehicle, 0)

        if CustomerEnteredVehicle then
            TaskGoStraightToCoord(CurrentCustomer, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
        end
    end

    ClearCurrentMission()
    OnJob = false
    DrawSub(TranslateCap('mission_complete'), 5000)
end

CreateThread(function()
    while true do
        local Sleep = 1500

        if OnJob then
            Sleep = 0
            local playerPed = PlayerPedId()
            if CurrentCustomer == nil then
                DrawSub(TranslateCap('drive_search_pass'), 5000)
            
                if IsPedInAnyVehicle(playerPed, false) and OnJob then
                    Wait(5000)
                        CurrentCustomer = GetRandomWalkingNPC()

                        if CurrentCustomer ~= nil then
                            CurrentCustomerBlip = AddBlipForEntity(CurrentCustomer)

                            SetBlipAsFriendly(CurrentCustomerBlip, true)
                            SetBlipColour(CurrentCustomerBlip, 2)
                            SetBlipCategory(CurrentCustomerBlip, 3)
                            SetBlipRoute(CurrentCustomerBlip, true)

                            SetEntityAsMissionEntity(CurrentCustomer, true, false)
                            ClearPedTasksImmediately(CurrentCustomer)
                            SetBlockingOfNonTemporaryEvents(CurrentCustomer, true)

                            local standTime = GetRandomIntInRange(60000, 180000)
                            TaskStandStill(CurrentCustomer, standTime)

                            ESX.ShowNotification(TranslateCap('customer_found'))
                        end
                end
            else
                if IsPedFatallyInjured(CurrentCustomer) then
                    ESX.ShowNotification(TranslateCap('client_unconcious'))

                    if DoesBlipExist(CurrentCustomerBlip) then
                        RemoveBlip(CurrentCustomerBlip)
                    end

                    if DoesBlipExist(DestinationBlip) then
                        RemoveBlip(DestinationBlip)
                    end

                    SetEntityAsMissionEntity(CurrentCustomer, false, true)

                    CurrentCustomer, CurrentCustomerBlip, DestinationBlip, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, targetCoords =
                        nil, nil, nil, false, false, false, nil
                end

                if IsPedInAnyVehicle(playerPed, false) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    local playerCoords = GetEntityCoords(playerPed)
                    local customerCoords = GetEntityCoords(CurrentCustomer)
                    local customerDistance = #(playerCoords - customerCoords)

                    if IsPedSittingInVehicle(CurrentCustomer, vehicle) then
                        if CustomerEnteredVehicle then
                            local targetDistance = #(playerCoords - targetCoords)

                            if targetDistance <= 10.0 then
                                TaskLeaveVehicle(CurrentCustomer, vehicle, 0)

                                ESX.ShowNotification(TranslateCap('arrive_dest'))

                                TaskGoStraightToCoord(CurrentCustomer, targetCoords.x, targetCoords.y, targetCoords.z,
                                    1.0, -1, 0.0, 0.0)
                                SetEntityAsMissionEntity(CurrentCustomer, false, true)
                                TriggerServerEvent('taxijob:success')
                                RemoveBlip(DestinationBlip)

                                local function scope(customer)
                                    ESX.SetTimeout(60000, function()
                                        DeletePed(customer)
                                    end)
                                end

                                scope(CurrentCustomer)

                                CurrentCustomer, CurrentCustomerBlip, DestinationBlip, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, targetCoords =
                                    nil, nil, nil, false, false, false, nil
                            end

                            if targetCoords then
                                DrawMarker(36, targetCoords.x, targetCoords.y, targetCoords.z + 1.1, 0.0, 0.0, 0.0, 0.0,
                                    0.0, 0.0, 1.0, 1.0, 1.0, 234, 223, 72, 155, false, false, 2, true, nil, nil, false)
                            end
                        else
                            RemoveBlip(CurrentCustomerBlip)
                            CurrentCustomerBlip = nil
                            targetCoords = Config.JobLocations[GetRandomIntInRange(1, #Config.JobLocations)]
                            local distance = #(playerCoords - targetCoords)
                            while distance < Config.MinimumDistance do
                                Wait(0)

                                targetCoords = Config.JobLocations[GetRandomIntInRange(1, #Config.JobLocations)]
                                distance = #(playerCoords - targetCoords)
                            end

                            local street = table.pack(GetStreetNameAtCoord(targetCoords.x, targetCoords.y,
                                targetCoords.z))
                            local msg = nil

                            if street[2] ~= 0 and street[2] ~= nil then
                                msg = string.format(TranslateCap('take_me_to_near', GetStreetNameFromHashKey(street[1]),
                                    GetStreetNameFromHashKey(street[2])))
                            else
                                msg = string.format(TranslateCap('take_me_to', GetStreetNameFromHashKey(street[1])))
                            end

                            ESX.ShowNotification(msg)

                            DestinationBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

                            BeginTextCommandSetBlipName('STRING')
                            AddTextComponentSubstringPlayerName('Destination')
                            EndTextCommandSetBlipName(DestinationBlip)
                            SetBlipRoute(DestinationBlip, true)

                            CustomerEnteredVehicle = true
                        end
                    else
                        DrawMarker(36, customerCoords.x, customerCoords.y, customerCoords.z + 1.1, 0.0, 0.0, 0.0, 0.0,
                            0.0, 0.0, 1.0, 1.0, 1.0, 234, 223, 72, 155, false, false, 2, true, nil, nil, false)

                        if not CustomerEnteredVehicle then
                            if customerDistance <= 40.0 then

                                if not IsNearCustomer then
                                    ESX.ShowNotification(TranslateCap('close_to_client'))
                                    IsNearCustomer = true
                                end

                            end

                            if customerDistance <= 20.0 then
                                if not CustomerIsEnteringVehicle then
                                    ClearPedTasksImmediately(CurrentCustomer)

                                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

                                    for i = maxSeats - 1, 0, -1 do
                                        if IsVehicleSeatFree(vehicle, i) then
                                            freeSeat = i
                                            break
                                        end
                                    end

                                    if freeSeat then
                                        TaskEnterVehicle(CurrentCustomer, vehicle, -1, freeSeat, 2.0, 0)
                                        CustomerIsEnteringVehicle = true
                                    end
                                end
                            end
                        end
                    end
                else
                    DrawSub(TranslateCap('return_to_veh'), 5000)
                end
            end
        end
        Wait(Sleep)
    end
end)