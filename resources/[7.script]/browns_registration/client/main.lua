local FW = config.Core.framework 

local Notify = config.Core.notify

local Targ = config.Core.target

local inZone = false

local Viewing = false

local dict = 'missfam4'
local clip = 'base'
local clipboard = 'p_amb_clipboard_01'
local bone = 36029
local offset = vector3(0.16, 0.08, 0.1)
local rot = vector3(-170.0, 50.0, 20.0)

Citizen.CreateThread(function()
    if string.find(Targ, 'ox') then 
        exports.ox_target:addGlobalVehicle({
            label = 'Regardez le VIN',
            icon = 'fa-solid fa-hashtag',
            distance = 2.5,
            onSelect = function(data)
                local vehicle = data.entity 
                if not Entity(vehicle).state.vin then 
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local Gen = GenerateVin()
                    while true do 
                        Citizen.Wait(0)
                        if type(Gen) == 'string' then 
                            if string.len(Gen) == 10 then 
                                break 
                            end
                        end
                    end
                    local replace = plate .. Gen

                    local VIN = lib.callback.await('reg:server:GetVin', false, plate, replace)

                    Entity(vehicle).state:set('vin', VIN, true)

                    ShowVin(VIN)
                else
                    ShowVin(Entity(vehicle).state.vin)
                end
            end
        })
    else
        exports[Targ]:AddGlobalVehicle({
            options = { 
                { 
                    icon = 'fa-solid fa-hashtag', 
                    label = 'Regardez le VIN', 
                    action = function(entity) 
                        local vehicle = entity
                        if not Entity(vehicle).state.vin then 
                            local plate = GetVehicleNumberPlateText(vehicle)
                            local Gen = GenerateVin()
                            while true do 
                                Citizen.Wait(0)
                                if type(Gen) == 'string' then 
                                    if string.len(Gen) == 10 then 
                                        break 
                                    end
                                end
                            end
                            local replace = plate .. Gen
        
                            local VIN = lib.callback.await('reg:server:GetVin', false, plate, replace)
        
                            Entity(vehicle).state:set('vin', VIN)
        
                            ShowVin(VIN)
                        else
                            ShowVin(Entity(vehicle).state.vin)
                        end
                    end,
                    
                }
            },
            distance = 2.5,
        })
    end
end)

function ShowVin(vin)
    lib.alertDialog({
        header = 'VIN Number:',
        content = vin,
        centered = true,
        cancel = false,
        labels = {
            confirm = 'Okay'
        }
    })
end

-- Immatriculation
exports.ox_target:addBoxZone({
    coords = vec3(config.locations.registration.x, config.locations.registration.y, config.locations.registration.z),
    size = vec3(2.5, 2.5, 2.5),
    rotation = config.locations.registration.w or 0.0,
    debug = false,
    options = {
        {
            name = 'immatriculation_target',
            label = 'Immatriculation du véhicule',
            icon = 'fa-solid fa-car',
            distance = 2.5,
            onSelect = function()
                OpenMenu()
            end
        }
    }
})

-- Assurance
exports.ox_target:addBoxZone({
    coords = vec3(config.locations.insurance.x, config.locations.insurance.y, config.locations.insurance.z),
    size = vec3(2.5, 2.5, 2.5),
    rotation = config.locations.insurance.w or 0.0,
    debug = false,
    options = {
        {
            name = 'assurance_target',
            label = 'Assurance du véhicule',
            icon = 'fa-solid fa-shield-halved',
            distance = 2.5,
            onSelect = function()
                OpenMenu_2()
            end
        }
    }
})

Citizen.CreateThread(function()
    lib.zones.box({
        coords = config.locations.registration,
        onEnter = onEnter,
        onExit = onExit
    })
end)

Citizen.CreateThread(function()
    lib.zones.box({
        coords = config.locations.insurance,
        onEnter = onEnter_2,
        onExit = onExit_2
    })
end)

function OpenMenu()
    local plates = {}

    local vehicles, playerName = lib.callback.await('reg:server:GetVehicles', false)

    if FW == 'esx' then 
        local pdata = CORE.GetPlayerData() 
        
        if pdata and pdata.firstName and pdata.lastName then 
            playerName = pdata.firstName .. " " .. pdata.lastName
        else
            playerName = lib.callback.await('reg:server:esxdataName', false)
        end
        
    end

    if vehicles[1] then 
        for i = 1, #vehicles do 
            local data = vehicles[i]
            table.insert(plates, {
                title = data.plate,
                description = 'Cliquez pour acheter Immatriculation d’un véhicule avec plaque d’immatriculation:' .. " " .. data.plate,
                onSelect = function()
                    local bool = lib.callback.await('reg:server:AddRegistration', false, data.plate, playerName)
                    
                    if not bool then 
                        Notify('Immatriculation du véhicule', 'Vous n’avez pas assez d’argent', 'error', 5000)
                    end
                end
            })
        end

        lib.registerContext({
            id = 'browns_registration',
            title = 'Vehicle Registration',
            options = plates
        })

        lib.showContext('browns_registration')

    else

        Notify('Immatriculation du véhicule', 'Vous n’avez pas assez d’argent', 'error', 5000)

    end

end

function OpenMenu_2()
    local plates = {}
    local vehicles, playerName = lib.callback.await('reg:server:GetVehicles', false)

    if FW == 'esx' then 
        local pdata = CORE.GetPlayerData() 
        if pdata and pdata.firstName and pdata.lastName then 
            playerName = pdata.firstName .. " " .. pdata.lastName
        else
            playerName = lib.callback.await('reg:server:esxdataName', false)
        end
    end

    if vehicles[1] then 
        for i = 1, #vehicles do
            local data = vehicles[i]
            table.insert(plates, {
                label = 'Plate:' .. " " .. data.plate,
                value = data.plate
            })
        end

        local input = lib.inputDialog('Assurance achats - ($' .. tostring(config.costs.insurance) .. " par mois)", {
            {type = 'select', label = 'Choisir un véhicule', options = plates, description = 'Choisissez le véhicule par plaque'},
            {type = 'select', label = 'Choisir un Plan', options = {
                {label = '1 mois', value = '30'},
                {label = '2 mois', value = '60'},
                {label = '3 mois', value = '90'},
                {label = '4 mois', value = '120'},
                {label = '5 mois', value = '150'},
                {label = '6 mois', value = '180'},
                {label = '7 mois', value = '210'},
                {label = '8 mois', value = '240'},
                {label = '9 mois', value = '270'},
                {label = '10 mois', value = '300'},
                {label = '11 mois', value = '330'},
                {label = '12 mois', value = '360'},
            }},
        })
    
        if input then 
            local _, playerName = lib.callback.await('reg:server:GetVehicles', false)
    
            if FW == 'esx' then 
                local pdata = CORE.GetPlayerData()
                if pdata and pdata.firstName and pdata.lastName then 
                    playerName = pdata.firstName .. " " .. pdata.lastName
                else
                    playerName = lib.callback.await('reg:server:esxdataName', false)
                end
            end
    
            local bool = lib.callback.await('reg:server:AddInsurance', false, input[1], input[2], playerName)
    
            if not bool then 
                Notify('Assurance du véhicule', 'Vous n’avez pas assez d’argent', 'error', 5000)
            end
        end

    else
        Notify('Assurance du véhicule', 'Vous ne possédez aucun véhicule', 'error', 5000)

    end

end

Citizen.CreateThread(function()
    if config.blip.registration.enable then 

        local blipsettings = config.blip.registration

        local x, y, z = table.unpack(config.locations.registration)
        local blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(blip, blipsettings.sprite)
        SetBlipColour(blip, blipsettings.color)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, 250)
        SetBlipScale(blip, blipsettings.scale)
        SetBlipAsShortRange(blip, true)
        PulseBlip(blip)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipsettings.label)
        EndTextCommandSetBlipName(blip)

    end
end)

Citizen.CreateThread(function()
    if config.blip.insurance.enable then 

        local blipsettings = config.blip.insurance

        local x, y, z = table.unpack(config.locations.insurance)
        local blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(blip, blipsettings.sprite)
        SetBlipColour(blip, blipsettings.color)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, 250)
        SetBlipScale(blip, blipsettings.scale)
        SetBlipAsShortRange(blip, true)
        PulseBlip(blip)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipsettings.label)
        EndTextCommandSetBlipName(blip)

    end
end)

RegisterNetEvent('reg:client:ShowRegistration', function(plate, name, date)

    if not Viewing then 

        Viewing = true

        local Gen = GenerateVin()

        while true do 
            Citizen.Wait(0)
            if type(Gen) == 'string' then 
                if string.len(Gen) == 10 then 
                    break 
                end
            end
        end
    
        local comb = plate .. Gen 
    
        local VIN, netId = lib.callback.await('reg:server:GetVINVEH', false, plate, comb)
    
        if netId ~= false then 
            local Vehicle = NetToVeh(netId)
    
            if Entity(Vehicle).state.vin ~= nil and string.len(Entity(Vehicle).state.vin) >= 10 then 
    
                VIN = Entity(Vehicle).state.vin
    
            else
    
                Entity(Vehicle).state:set('vin', VIN, true)
    
            end
    
        end
    
        SendNUIMessage({
            show = 'reg',
            plate = 'Plate:' .. " " .. plate, 
            name = 'Owner:' .. " " .. name,
            vin = 'VIN:' .. " " .. VIN,
            date = 'REGISTRATION DATE:' .. " " .. date,
            msg = 'REGISTRATION SHALL EXPIRE' .. " " .. tostring(config.expire) .. " " .. 'DAYS AFTER ABOVE DATE'
        })

        DoAnimation()
    
        Citizen.CreateThread(function()
            while true do 
                Citizen.Wait(0)
                if IsControlJustPressed(0, 202) then 
                    SendNUIMessage({
                        show = 'hide'
                    })  
                    Viewing = false
                    break 
                end
            end
        end)
    else
        Notify('Notification', 'Vous ne pouvez pas le faire, vos documents déjà consultés', 'error', 5000)
    end
    
end)

RegisterNetEvent('reg:client:ShowInsurance', function(plate, name, date, expire)

    if not Viewing then 

        Viewing = true

        local Gen = GenerateVin()

        while true do 
            Citizen.Wait(0)
            if type(Gen) == 'string' then 
                if string.len(Gen) == 10 then 
                    break 
                end
            end
        end
    
        local comb = plate .. Gen 
    
        local VIN, netId = lib.callback.await('reg:server:GetVINVEH', false, plate, comb)
    
        if netId ~= false then 
            local Vehicle = NetToVeh(netId)
    
            if Entity(Vehicle).state.vin ~= nil and string.len(Entity(Vehicle).state.vin) >= 10 then 
    
                VIN = Entity(Vehicle).state.vin
    
            else
    
                Entity(Vehicle).state:set('vin', VIN, true)
    
            end
    
        end
    
    
        SendNUIMessage({
            show = 'ins',
            plate = 'Plate:' .. " " .. plate, 
            name = 'Owner:' .. " " .. name,
            vin = 'VIN:' .. " " .. VIN,
            date = 'PAYMENT DATE:' .. " " .. date,
            msg = 'INSURANCE SHALL EXPIRE' .. " " .. expire .. " " .. 'DAYS AFTER ABOVE DATE'
        })

        DoAnimation()
    
        Citizen.CreateThread(function()
            while true do 
                Citizen.Wait(0)
                if IsControlJustPressed(0, 202) then 
                    SendNUIMessage({
                        show = 'hide'
                    })  
                    Viewing = false
                    break 
                end
            end
        end)
    else
        Notify('Notification', 'Vous ne pouvez pas le faire, vos documents déjà consultés', 'error', 5000)
    end

end)

function DoAnimation()
    Citizen.CreateThread(function()

        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do 
            Citizen.Wait(0)
        end

        local model = GetHashKey(clipboard)
        RequestModel(model)
        while not HasModelLoaded(model) do 
            Citizen.Wait(0)
        end

        local prop = CreateObject(model, 0.0, 0.0, 0.0, true, true, false)
        local boneIndex = GetPedBoneIndex(PlayerPedId(), bone)
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, true, false, false, false, 2, true)
        SetModelAsNoLongerNeeded(prop)
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if Viewing then 
                    if not IsEntityPlayingAnim(PlayerPedId(), dict, clip, 3) then
                        TaskPlayAnim(PlayerPedId(), dict, clip, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                    end
                else
                    ClearPedSecondaryTask(PlayerPedId())
                    DetatchAnim(prop)
                    break 
                end
            end
        end)
    end)
end

function DetatchAnim(entity)
    Citizen.CreateThread(function()
        Citizen.Wait(250)
        DetachEntity(entity, true, false)
        DeleteEntity(entity)
        while DoesEntityExist(entity) do 
            Citizen.Wait(0)
            DetachEntity(entity, true, false)
            DeleteEntity(entity)
        end
    end)
end

function GenerateVin()
    local string = ''

    local chars = {
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I', 
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '0'
    }

    while true do 
        Citizen.Wait(0)
        if string.len(string) ~= 10 then 
            local char = chars[math.random(1, #chars)]
            string = string .. char
        else
            break 
        end
    end

    return string

end

local function SpawnPedWithSpeech(coords, heading, model, animDict, animName)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end

    local ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)

    -- Salutation logic
    local saidHello = false

    Citizen.CreateThread(function()
        while true do
            Wait(500)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local dist = #(playerCoords - GetEntityCoords(ped))

            if dist < 3.0 then
                if not saidHello then
                    saidHello = true
                    PlayAmbientSpeech1(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE") -- dit "Bonjour"
                end
            else
                saidHello = false
            end
        end
    end)
end

Citizen.CreateThread(function()
    -- Immatriculation ped
    local reg = config.locations.registration
    SpawnPedWithSpeech(
        vector3(reg.x, reg.y, reg.z),
        reg.w or 0.0,
        `s_m_y_cop_01`,
        'amb@world_human_clipboard@male@idle_a',
        'idle_a'
    )

    -- Assurance ped
    local ins = config.locations.insurance
    SpawnPedWithSpeech(
        vector3(ins.x, ins.y, ins.z),
        ins.w or 0.0,
        `s_m_m_highsec_01`,
        'amb@world_human_clipboard@male@idle_a',
        'idle_a'
    )
end)


