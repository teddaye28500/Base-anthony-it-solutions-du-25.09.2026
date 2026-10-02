Language = Config.Language
PlantStage = 1
HeistInProgress = false
VaultOpen = false

RegisterNetEvent("esx_pacificheist:receiveHeistInfos", function(status)
    HeistInProgress = status
end)

RegisterNetEvent("esx_pacificheist:receiveChargeInfos", function(stage)
    PlantStage = stage
    if stage == 2 then
        SecondDoor()
    elseif stage == 3 then
        ThirdDoor()
    end
end)

RegisterNetEvent("esx_pacificheist:receiveVaultInfos", function(status)
    VaultOpen = status
end)

function SecondDoor()
    CreateThread(function()
        local ms = 1000
        local coords = Config.Zones.SecondDoor
        while PlantStage == 2 do
            ms = 1000
            if #(GetEntityCoords(PlayerPedId()) - coords) < 1.3 then
                ms = 0
                ESX.ShowHelpNotification(Config.Locales[Language]['thermal_request'])
                if IsControlJustPressed(0, 51) then
                    local canDo = true
                    if Config.useOxInventory then
                        if exports.ox_inventory:GetItemCount("thermal_charge", {}) < 1 then --thermal_charge
                            ESX.ShowNotification(Config.Locales[Language]['no_thermal_charge'])
                            canDo = false
                        end
                    else
                        local inventory = ESX.GetPlayerData().inventory
                        local count = 0
                        for i=1, #inventory, 1 do
                            if inventory[i].name == 'thermal_charge' then --thermal_charge
                            count = inventory[i].count
                            end
                        end
                        if count < 1 then
                            ESX.ShowNotification(Config.Locales[Language]['no_thermal_charge'])
                            canDo = false
                        end
                    end
                    if canDo then
                        ThermalCharge()
                    end
                end
            end
            Wait(ms)
        end
        TriggerServerEvent("esx_pacificheist:startAlarm")
    end)
end

function ThirdDoor()
    CreateThread(function()
        local ms = 1000
        local coords = Config.Zones.ThirdDoor
        while PlantStage == 3 do
            ms = 1000
            if #(GetEntityCoords(PlayerPedId()) - coords) < 1.3 then
                ms = 0
                ESX.ShowHelpNotification(Config.Locales[Language]['thermal_request'])
                if IsControlJustPressed(0, 51) then
                    local canDo = true
                    if Config.useOxInventory then
                        if exports.ox_inventory:GetItemCount("thermal_charge", {}) < 1 then --thermal_charge
                            ESX.ShowNotification(Config.Locales[Language]['no_thermal_charge'])
                            canDo = false
                        end
                    else
                        local inventory = ESX.GetPlayerData().inventory
                        local count = 0
                        for i=1, #inventory, 1 do
                            if inventory[i].name == 'thermal_charge' then --thermal_charge
                            count = inventory[i].count
                            end
                        end
                        if count < 1 then
                            ESX.ShowNotification(Config.Locales[Language]['no_thermal_charge'])
                            canDo = false
                        end
                    end
                    if canDo then
                        ThermalCharge()
                    end
                end
            end
            Wait(ms)
        end
    end)
end

function OpenVault()
    local ped = PlayerPedId()
    local x, y, z, w = table.unpack(Config.Zones.VaultPed)
    CreateThread(function()

        Wait(1000)

        local obj = GetClosestObjectOfType(x, y, z, 30.0, GetHashKey("v_ilev_bk_vaultdoor"), false, false, false)
        local count = 0
        repeat
            FreezeEntityPosition(obj, false)
            SetEntityHeading(obj, GetEntityHeading(obj)-0.08)
            FreezeEntityPosition(obj, true)
            count = count+1
            Wait(10)
        until count == 1800
    end)
end

function ThermalCharge()
    TriggerServerEvent("esx_pacificheist:removeItem", 'thermal_charge')
    local ped = PlayerPedId()
    local x, y, z, w = table.unpack(Config.Zones.StartHeistPed)
    local doorCoords = vector3(257.39, 221.20, 106.29)
    local oldModel = "hei_v_ilev_bk_gate_pris"
    local newModel = "hei_v_ilev_bk_gate_molten"

    if PlantStage == 2 then
        addRot = 170
        x, y, z, w = table.unpack(Config.Zones.SecondDoorPed)
        doorCoords = vector3(261.56878662109, 222.49368286133, 106.28356170654)
        oldModel = "hei_v_ilev_bk_gate2_pris"
        newModel = "hei_v_ilev_bk_gate2_molten"
    end
    if PlantStage == 3 then
        addRot = 0.0
        x, y, z, w = table.unpack(Config.Zones.ThirdDoorPed)
        doorCoords = vector3(252.985, 221.70, 101.72)
        oldModel = "hei_v_ilev_bk_safegate_pris"
        newModel = "hei_v_ilev_bk_safegate_molten"
    end
    print(PlantStage)
    TriggerServerEvent("esx_pacificheist:sendChargeInfos", PlantStage + 1)
    CreateThread(function()
        RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
        while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
            Wait(50)
        end
        SetEntityCoords(ped, x, y, z - 1.0)

        SetEntityHeading(ped, w)

        local pedCoords = GetEntityCoords(ped)

        local thermalCharge = CreateObject(GetHashKey("hei_prop_heist_thermite"), pedCoords.x, pedCoords.y, pedCoords.z + 0.2,  true,  true, true)

        SetEntityCollision(thermalCharge, false, true)
        AttachEntityToEntity(thermalCharge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)

        TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge',  8.0, 8.0, -1, 0, 1, 0, 0, 0)

        Wait(4000)

        DetachEntity(thermalCharge, true, true)
        FreezeEntityPosition(thermalCharge, true)

        Wait(200)
        RequestNamedPtfxAsset("scr_ornate_heist")
        while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
            Wait(1)
        end
        SetPtfxAssetNextCall("scr_ornate_heist")
        local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", doorCoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

        TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
        TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
        Wait(10000)
        DeleteObject(thermalCharge)
        Wait(2000)
        TriggerServerEvent("esx_pacificheist:changeDoorModel", doorCoords, oldModel, newModel, false)
        Wait(1000)
        StopParticleFxLooped(effect, 0)

        local obj = ESX.Game.GetClosestObject(doorCoords, {[GetHashKey(newModel)] = true})
        FreezeEntityPosition(obj, false)

        Wait(3000)
    end)
end

function StartHeist()
    PlantStage = 1
    if Config.useOxInventory then
        if exports.ox_inventory:GetItemCount("thermal_charge", {}) < 1 then --thermal_charge
            ESX.ShowNotification(Config.Locales[Language]['no_thermal_charge'])
            return
        end
    else
        local inventory = ESX.GetPlayerData().inventory
        local count = 0
        for i=1, #inventory, 1 do
            if inventory[i].name == 'thermal_charge' then --thermal_charge
            count = inventory[i].count
            end
        end
        if count < 1 then
            ESX.ShowNotification(Config.Locales[Language]['no_thermal_charge'])
            return
        end
    end
    TriggerServerEvent("esx_pacificheist:sendHeistInfos", true)
    ThermalCharge()
    RequestModel("hei_prop_hei_cash_trolly_01")
    Citizen.Wait(100)
    Trolley1 = CreateObject(269934519, 257.44, 215.07, 100.68, true, 0, 0)
    Trolley2 = CreateObject(269934519, 262.34, 213.28, 100.68, true, 0, 0)
    Trolley3 = CreateObject(269934519, 263.45, 216.05, 100.68, true, 0, 0)
    local heading = GetEntityHeading(Trolley3)

    SetEntityHeading(Trolley3, heading + 150)
end

CreateThread(function()
    local ms = 1000
    local coords = Config.Zones.StartHeist
    while true do
        ms = 1000
        if #(GetEntityCoords(PlayerPedId()) - coords) < 1.3  and not HeistInProgress then
            ms = 0
            ESX.ShowHelpNotification(Config.Locales[Language]['click_request'])
            if IsControlJustPressed(0, 51) then
                ESX.TriggerServerCallback("esx_pacificheist:canRob", function(cb)
                    if cb == true then
                        StartHeist()
                    else
                        print("cb false")
                        ESX.ShowHelpNotification(Config.Locales[Language]['cant_rob_now'])
                    end 
                end)
            end
        end
        Wait(ms)
    end
end)

CreateThread(function()
    local ms = 1000
    local coords = Config.Zones.Vault
    while true do
        ms = 1000
        if #(GetEntityCoords(PlayerPedId()) - coords) < 1.3 and HeistInProgress and not VaultOpen then
            ms = 0
            ESX.ShowHelpNotification(Config.Locales[Language]['vault_request'])
            if IsControlJustPressed(0, 51) and HeistInProgress and not VaultOpen then
                local canDo = true
                if Config.useOxInventory then
                    if exports.ox_inventory:GetItemCount("hacker_laptop", {}) < 1 then --security_card
                        ESX.ShowNotification(Config.Locales[Language]['no_card'])
                        canDo = false
                    end
                else
                    local inventory = ESX.GetPlayerData().inventory
                    local count = 0
                    for i=1, #inventory, 1 do
                        if inventory[i].name == 'hacker_laptop' then --security_card
                        count = inventory[i].count
                        end
                    end
                    if count < 1 then
                        ESX.ShowHelpNotification(Config.Locales[Language]['no_card'])
                        canDo = false
                    end
                end
                if canDo then
                    local animDict = "anim@heists@ornate_bank@hack"

                    RequestAnimDict(animDict)
                    RequestModel("hei_prop_hst_laptop")
                    RequestModel("hei_p_m_bag_var22_arm_s")
                    RequestModel("hei_prop_heist_card_hack_02")
                
                    while not HasAnimDictLoaded(animDict)
                        or not HasModelLoaded("hei_prop_hst_laptop")
                        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
                        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
                        Citizen.Wait(100)
                    end
                    local ped = PlayerPedId()
                    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
                    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", 253.34, 228.25, 101.39, 253.34, 228.25, 101.39, 0, 2) -- Animasyon kordinatları, buradan lokasyonu değiştirin // These are fixed locations so if you want to change animation location change here
                    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", 253.34, 228.25, 101.39, 253.34, 228.25, 101.39, 0, 2)
                    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 253.34, 228.25, 101.39, 253.34, 228.25, 101.39, 0, 2)
                    FreezeEntityPosition(ped, true)
                    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
                    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
                    SetEntityVisible(bag, false)
                    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
                    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
                    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
                    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)
                    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)

                    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)    --by utkuali

                    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

                    SetEntityHeading(ped, 63.60) -- Animasyon düzgün oturması için yön // for proper animation direction

                    NetworkStartSynchronisedScene(netScene)
                    Wait(4500) -- Burayı deneyerek daha iyi hale getirebilirsiniz // You can try editing this to make transitions perfect
                    NetworkStopSynchronisedScene(netScene)

                    NetworkStartSynchronisedScene(netScene2)

                    TriggerEvent("datacrack:start", Config.DataCrackDifficult, function(output)
                        if output == true then
                            TriggerServerEvent("esx_pacificheist:sendVaultInfos", true)
                            OpenVault()
                        end
                    end)
                    NetworkStopSynchronisedScene(netScene2)

                    NetworkStartSynchronisedScene(netScene3)
                    Wait(3000)
                    NetworkStopSynchronisedScene(netScene3)

                    DeleteObject(bag)
                    DeleteObject(laptop)
                    DeleteObject(card)
                    FreezeEntityPosition(ped, false)
                end
            end
        end
        Wait(ms)
    end
end)

RegisterNetEvent("esx_pacificheist:changeDoorModelClient", function(coords, oldModel, newModel, fix)
    if fix == true then
        CreateModelSwap(coords.x, coords.y, coords.z, 5, GetHashKey(newModel), GetHashKey(oldModel), 1)
    else
        CreateModelSwap(coords.x, coords.y, coords.z, 5, GetHashKey(oldModel), GetHashKey(newModel), 1)
    end
end)

