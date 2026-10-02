local holdingup = false
local store = ""
local blipRobbery = nil
local vetrineRotte = 0
local animazione = false
local incircle = false
local soundid = GetSoundId()

local ESX = exports["es_extended"]:getSharedObject()

local vetrine = {
    {x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},
    {x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},
    {x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},
    {x = -625.770, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},
    {x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},
    {x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},
    {x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},
    {x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},
    {x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},
    {x = -619.225, y = -233.677, z = 38.057, heading = 213.350, isOpen = false},
    {x = -620.025, y = -233.354, z = 38.057, heading = 34.180, isOpen = false},
    {x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},
    {x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},
    {x = -619.741, y = -230.320, z = 38.057, heading = 124.283, isOpen = false},
    {x = -619.686, y = -227.753, z = 38.057, heading = 305.245, isOpen = false},
    {x = -620.481, y = -226.590, z = 38.057, heading = 304.677, isOpen = false},
    {x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},
    {x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},
    {x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},
    {x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},
}

--========================================================
--  FONCTIONS UTILITAIRES
--========================================================

local function DrawText3D(x, y, z, text)
    local onScreen,_x,_y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x,_y)
end

local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

local function drawTxt(text)
    SetTextFont(4)
    SetTextScale(0.6, 0.6)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.90)
end

--========================================================
--  EVENTS SERVEUR → CLIENT
--========================================================

RegisterNetEvent('esx_vangelico_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico_robbery:currentlyrobbing', function(robb)
    holdingup = true
    store = robb
end)

RegisterNetEvent('esx_vangelico_robbery:killblip')
AddEventHandler('esx_vangelico_robbery:killblip', function()
    if blipRobbery then RemoveBlip(blipRobbery) end
end)

RegisterNetEvent('esx_vangelico_robbery:setblip')
AddEventHandler('esx_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery, 161)
    SetBlipScale(blipRobbery, 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:toofarlocal')
AddEventHandler('esx_vangelico_robbery:toofarlocal', function()
    holdingup = false
    store = ""
    incircle = false
end)

RegisterNetEvent('esx_vangelico_robbery:robberycomplete')
AddEventHandler('esx_vangelico_robbery:robberycomplete', function()
    holdingup = false
    ESX.ShowNotification(_U('robbery_complete'))
    store = ""
    incircle = false
end)

--========================================================
--  BLIPS DES MAGASINS
--========================================================

Citizen.CreateThread(function()
    for k,v in pairs(Stores) do
        local pos = v.position
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
        SetBlipSprite(blip, 439)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('shop_robbery'))
        EndTextCommandSetBlipName(blip)
    end
end)

--========================================================
--  THREAD PRINCIPAL
--========================================================

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        --===========================
        --  DÉBUT DU BRAQUAGE
        --===========================
        for k,v in pairs(Stores) do
            local dist = #(pos - vector3(v.position.x, v.position.y, v.position.z))

            if dist < 15.0 and not holdingup then
                DrawMarker(27, v.position.x, v.position.y, v.position.z - 0.9, 0,0,0, 0,0,0, 2.0,2.0,0.5, 255,0,0,200)

                if dist < 1.0 then
                    RageUI.Text({message = "Tire en l'air pour commencer le casse !", time_display = 1})

                    if IsPedShooting(ped) then
                        ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
                            if CopsConnected >= Config.RequiredCopsRob then
                                TriggerServerEvent('esx_vangelico_robbery:rob', k)
                                PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", v.position.x, v.position.y, v.position.z)
                            else
                                RageUI.Popup({message = "~r~Il faut minimum ~b~"..Config.RequiredCopsRob.."~r~ policiers en ville !"})
                            end
                        end)
                    end
                end
            end
        end

        --===========================
        --  BRAQUAGE EN COURS
        --===========================
        if holdingup then
            drawTxt(_U('smash_case').." : "..vetrineRotte.."/"..Config.MaxWindows)

            for i,v in pairs(vetrine) do
                local dist = #(pos - vector3(v.x, v.y, v.z))

                if dist < 10.0 and not v.isOpen and Config.EnableMarker then
                    DrawMarker(20, v.x, v.y, v.z, 0,0,0, 0,0,0, 0.5,0.5,0.5, 255,0,0,200)
                end

                if dist < 0.75 and not v.isOpen then
                    RageUI.Text({message = "Appuyez sur ~r~[E]~s~ pour voler les bijoux", time_display = 1})

                    if IsControlJustPressed(0, 38) then
                        animazione = true
                        SetEntityCoords(ped, v.x, v.y, v.z - 0.95)
                        SetEntityHeading(ped, v.heading)
                        v.isOpen = true

                        PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z)

                        loadAnimDict("missheist_jewel")
                        TaskPlayAnim(ped, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0)

                        TriggerEvent("mt:missiontext", _U('collectinprogress'), 3000)
                        Citizen.Wait(5000)

                        ClearPedTasksImmediately(ped)
                        TriggerServerEvent('esx_vangelico_robbery:gioielli')
                        PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

                        vetrineRotte += 1
                        animazione = false

                        if vetrineRotte >= Config.MaxWindows then
                            for _,vv in pairs(vetrine) do vv.isOpen = false end
                            vetrineRotte = 0
                            TriggerServerEvent('esx_vangelico_robbery:endrob', store)
                            ESX.ShowNotification(_U('lester'))
                            holdingup = false
                            StopSound(soundid)
                        end
                    end
                end
            end

            --===========================
            --  JOUEUR TROP LOIN
            --===========================
            if #(pos - vector3(-622.566, -230.183, 38.057)) > 11.5 then
                TriggerServerEvent('esx_vangelico_robbery:toofar', store)
                holdingup = false
                for _,v in pairs(vetrine) do v.isOpen = false end
                vetrineRotte = 0
                StopSound(soundid)
            end
        end

        Citizen.Wait(0)
    end
end)

--========================================================
--  ANIMATION LOOP
--========================================================

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if animazione then
            if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
                TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
            end
        end
    end
end)

--========================================================
--  VENTE CHEZ LESTER
--========================================================

local blipSell = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        if #(pos - vector3(-1100.75, 2722.53, 18.800)) <= 1.0 and not blipSell then
            DisplayHelpText(_U('press_to_sell'))

            if IsControlJustReleased(1, 51) then
                blipSell = true

                ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                    if quantity >= Config.MaxJewelsSell then
                        ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
                            if CopsConnected >= Config.RequiredCopsSell then
                                FreezeEntityPosition(ped, true)
                                TriggerEvent('mt:missiontext', _U('goldsell'), 10000)
                                Citizen.Wait(10000)
                                FreezeEntityPosition(ped, false)
                                TriggerServerEvent('lester:vendita')
                            else
                                ESX.ShowNotification(_U('copsforsell')..Config.RequiredCopsSell.._U('copsforsell2'))
                            end
                            blipSell = false
                        end)
                    else
                        ESX.ShowNotification(_U('notenoughgold'))
                        blipSell = false
                    end
                end, 'jewels')
            end
        end
    end
end)
