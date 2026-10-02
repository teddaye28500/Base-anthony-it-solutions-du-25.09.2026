InRobbery = false
CurrentIndex = nil
ReceivedItems = {}
lootable = false
Bagcount = 5
EnemySpawnRadius = 5

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        DeletePed(NPC)

        DeleteEntity(Truck)
        DeleteEntity(Truck_NPC1)
        DeleteEntity(Truck_NPC2)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local sleep = 2000

        local dist = #(pedCoords - vector3(Config.BossCoords[1], Config.BossCoords[2], Config.BossCoords[3]))
        if dist <= 1.0 then
            sleep = 1
            HelpNotify(Config.HelpNotify[1][1])

            if IsControlJustReleased(0, Config.HelpNotify[1][2]) then
                SetEntityHeading(ped, Config.BossCoords[4])
                loadAnimDict('timetable@jimmy@doorknock@')
                TaskPlayAnim(ped, 'timetable@jimmy@doorknock@', 'knockdoor_idle', 8.0, -8.0, -1, 2, 0, false, false, false)
                Citizen.Wait(2500)
                ClearPedTasks(ped)

                loadModel(Config.BossModel)
                NPC = CreatePed(1, Config.BossModel, Config.BossCoords[1], Config.BossCoords[2], Config.BossCoords[3]-1, Config.BossCoords[4]-180, true, true)
                SetBlockingOfNonTemporaryEvents(NPC, true)
                SetPedDiesWhenInjured(NPC, false)
                SetPedCanPlayAmbientAnims(NPC, true)
                SetPedCanRagdollFromPlayerImpact(NPC, false)
                SetEntityInvincible(NPC, true)
                FreezeEntityPosition(NPC, true)

                TSCB('brutal_truck_robbery:server:PossibleRobbery', function(possible)
                    if possible then
                        InRobbery = true
                        TriggerServerEvent('brutal_truck_robbery:server:sync', 'START ROBBERY')
                        SendInsText(1)

                        Citizen.CreateThread(function()
                            while InRobbery do
                                if PlayerDied() then
                                    if Config.FailedRobbery.Use then
                                        HeistNotify(Config.FailedRobbery, nil, 5, true)
                                    end
                                    finishRobbery()
                                end
                                Citizen.Wait(1000*10)
                            end
                        end)

                        GetInfos()
                    end
                end)

                Citizen.Wait(5000)
                DeletePed(NPC)
            end                                                                                                                                                                     
        end
        Citizen.Wait(sleep)
    end
end)

function GetInfos() 
    loadModel(Config.EnemiesModel)
    AddRelationshipGroup('InfoTheft')
    AgressiveNPC = {}
    AgressiveNPC_Blip = {}
    local Coords = Config.EnemiesCoords
    for i = 1, Config.EnemyCount do
        local Randomplaceing = math.random(EnemySpawnRadius*(-1), EnemySpawnRadius) 
        AgressiveNPC[i] = CreatePed(30, Config.EnemiesModel, Coords[1]+Randomplaceing, Coords[2]+Randomplaceing, Coords[3], Coords[4], true, true)
        SetPedArmour(AgressiveNPC[i], 60)
        SetPedAsEnemy(AgressiveNPC[i], true)
        SetPedRelationshipGroupHash(AgressiveNPC[i], 'InfoTheft')
        GiveWeaponToPed(AgressiveNPC[i], GetHashKey('WEAPON_PISTOL'), 250, false, true)
        SetPedDropsWeaponsWhenDead(AgressiveNPC[i], false) 
        TaskCombatPed(AgressiveNPC[i], GetPlayerPed(-1))
        SetPedAccuracy(AgressiveNPC[i], 50)
        SetPedDropsWeaponsWhenDead(AgressiveNPC[i], false)

        AgressiveNPC_Blip[i] = AddBlipForEntity(AgressiveNPC[i])
        SetBlipSprite(AgressiveNPC_Blip[i], Config.EnemyBlip['sprite'])
        SetBlipScale(AgressiveNPC_Blip[i], Config.EnemyBlip['size'])
        SetBlipColour(AgressiveNPC_Blip[i], Config.EnemyBlip['colour'])
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.EnemyBlip['label'])
        EndTextCommandSetBlipName(AgressiveNPC_Blip[i])
    end
    SetBlipRoute(AgressiveNPC_Blip[1], true)
    
    CheckDead()

    while InRobbery do
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(Config.EnemiesCoords[1], Config.EnemiesCoords[2], Config.EnemiesCoords[3]))
        if distance < 50 then
            SetBlipRoute(AgressiveNPC_Blip[1], false)

            InfoObject = CreateObject(GetHashKey('prop_paper_box_05'), Coords[1], Coords[2], Coords[3]-1, Coords[4], true, true, true)
            InfoObject_Blip = AddBlipForEntity(InfoObject)
            SetBlipSprite(InfoObject_Blip, Config.CollectableBlip['sprite'])
            SetBlipScale(InfoObject_Blip, Config.CollectableBlip['size'])
            SetBlipColour(InfoObject_Blip, Config.CollectableBlip['colour'])
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.CollectableBlip['label'])
            EndTextCommandSetBlipName(InfoObject_Blip)
            SetBlipRoute(InfoObject_Blip, true)
            break
        end
        Citizen.Wait(1)
    end
    
    while InRobbery do
        local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(InfoObject))
        if dist <= 2.0 then
            HelpNotify(Config.HelpNotify[5][1])
            if IsControlJustReleased(0, Config.HelpNotify[5][2]) then
                if NoCarryWeapon() then
                    RequestAnimDict('anim@move_m@trash')
                    while not HasAnimDictLoaded('anim@move_m@trash') do
                        Citizen.Wait(50)
                    end
                    TaskPlayAnim(PlayerPedId(), 'anim@move_m@trash', "pickup", 3.0, -8, -1, 63, 0, 0, 0, 0)
                    Citizen.Wait(1000)
                    DeleteObject(InfoObject)
                    Citizen.Wait(1000)
                    ClearPedTasks(PlayerPedId())
                    break
                end
            end
        end
        Citizen.Wait(1)
    end
    if InRobbery then
        SendInsText(3)
        StartTruckRobbery()
        Citizen.Wait(30000)
        for i = 1, Config.EnemyCount do
            RemoveBlip(AgressiveNPC_Blip[i])
            DeletePed(AgressiveNPC[i])
        end
    end
end

function CheckDead()
    for i = 1, Config.EnemyCount do
        Citizen.CreateThread(function()
            while InRobbery do
                Citizen.Wait(2000) 
                if IsEntityDead(AgressiveNPC[i]) then
                    RemoveBlip(AgressiveNPC_Blip[i])
                    Citizen.Wait(3000)
                    DeletePed(AgressiveNPC[i])
                    break
                end
            end
        end)  
    end 
end

function StartTruckRobbery()
    CurrentIndex = math.random(1, #Config.Trucks)
    local Index = Config.Trucks[CurrentIndex]

    loadModel('stockade')
    Truck = CreateVehicle(GetHashKey('stockade'), Index.truckSpawn, true, false)
    SetEntityAsMissionEntity(Truck, false, false)

    loadModel('s_m_m_prisguard_01')
    Truck_NPC1 = CreatePed(5, GetHashKey('s_m_m_prisguard_01'), Index.truckSpawn, true, true)
    SetEntityAsMissionEntity(Truck_NPC1, false, false)
    SetPedFleeAttributes(Truck_NPC1, 0, 0)
    SetPedCombatAttributes(Truck_NPC1, 46, 1)
    SetPedCombatAbility(Truck_NPC1, 100)
    SetPedCombatMovement(Truck_NPC1, 2)
    SetPedCombatRange(Truck_NPC1, 2)
    SetPedKeepTask(Truck_NPC1, true)
    GiveWeaponToPed(Truck_NPC1, GetHashKey('WEAPON_PISTOL'), 250, false, true)
    SetPedDropsWeaponsWhenDead(Truck_NPC1, false) 
    SetPedAsCop(Truck_NPC1, true)
    Citizen.Wait(400)
    SetPedIntoVehicle(Truck_NPC1, Truck, -1)

    Truck_NPC2 = CreatePed(5, GetHashKey('s_m_m_prisguard_01'), Index.truckSpawn, true, true)
    SetEntityAsMissionEntity(Truck_NPC2, false, false)
    SetPedFleeAttributes(Truck_NPC2, 0, 0)
    SetPedCombatAttributes(Truck_NPC2, 46, 1)
    SetPedCombatAbility(Truck_NPC2, 100)
    SetPedCombatMovement(Truck_NPC2, 2)
    SetPedCombatRange(Truck_NPC2, 2)
    SetPedKeepTask(Truck_NPC2, true)
    GiveWeaponToPed(Truck_NPC2, GetHashKey('WEAPON_PISTOL'), 250, false, true)
    SetPedDropsWeaponsWhenDead(Truck_NPC2, false) 
    SetPedAsCop(Truck_NPC2, true)
    Citizen.Wait(400) 
    SetPedIntoVehicle(Truck_NPC2, Truck, 0)

    Truck_Blip = AddBlipForEntity(Truck)
    SetBlipSprite(Truck_Blip, Config.TruckBlip.sprite)
    SetBlipScale(Truck_Blip, Config.TruckBlip.size)
    SetBlipColour(Truck_Blip, Config.TruckBlip.color)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.TruckBlip.label)
    EndTextCommandSetBlipName(Truck_Blip)

    TaskVehicleDriveToCoordLongrange(Truck_NPC1, Truck, Index.destination, 15.0, 263043, 2.0)
    
    Citizen.CreateThread(function()
        while InRobbery do
            local npc1_dist = #(GetEntityCoords(Truck) - GetEntityCoords(Truck_NPC1))
            local npc2_dist = #(GetEntityCoords(Truck) - GetEntityCoords(Truck_NPC2))
            if GetEntityHealth(Truck_NPC1) == 0 and GetEntityHealth(Truck_NPC2) == 0 or npc1_dist > 10 or npc2_dist > 10 then
                SendInsText(2)
                TriggerServerEvent('brutal_truck_robbery:server:PoliceAlert', GetEntityCoords(Truck))
                TruckLoot()
                break
            end

            local dist = #(GetEntityCoords(Truck_NPC1) - Index.destination)
            if dist < 5 then
                SendNotify(7)
                finishRobbery()
            end

            Citizen.Wait(5000)
        end
    end)
end

function TruckLoot()
    Citizen.CreateThread(function()
        while InRobbery do
            TruckCoordsOffset = GetOffsetFromEntityInWorldCoords(Truck, 0.0, -4.25, 0)
            local dist = #(GetEntityCoords(PlayerPedId()) - vector3(TruckCoordsOffset))
            if lootable == false then
                if dist <= 1.0 then
                    HelpNotify(Config.HelpNotify[2][1])

                    if IsControlJustReleased(0, Config.HelpNotify[2][2]) then
                        PlaceC4()
                    end
                end
            else
                if dist <= 1.0 then
                    HelpNotify(Config.HelpNotify[3][1])
    
                    if IsControlJustReleased(0, Config.HelpNotify[3][2]) then
                        if LootoutTruck() then
                                local Rewards = {}
                                for k,v in pairs(ReceivedItems) do
                                    table.insert(Rewards, {stat = v.label, value = '~r~'..v.count..'~g~x'})
                                end
                                if #Rewards > 0 then
                                    Citizen.Wait(10000)
                                    if Config.SuccessRobbery.Use then
                                        HeistNotify(Config.SuccessRobbery, Rewards, 5, true)
                                    end
                                    Citizen.CreateThread(function()
                                        Citizen.Wait(8000)
                                        finishRobbery()
                                        if Config.ItemsSellToBoss.use then
                                            SellItems()
                                        end
                                    end)
                                end
                            break
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end

function PlaceC4()
    if IsVehicleStopped(Truck) then
        if NoCarryWeapon() then
            placebags()
            RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
            while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
                Citizen.Wait(50)
            end
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z + 0.2, true, true, true)
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.06, 0.0, 0.06, 90.0,
                0.0, 0.0, true, true, false, true, 1, true)
            FreezeEntityPosition(PlayerPedId(), true)
            TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8,
                -1, 63, 0, 0, 0, 0)
            Citizen.Wait(5500)
            ClearPedTasks(PlayerPedId())
            DetachEntity(prop)
            AttachEntityToEntity(prop, Truck, GetEntityBoneIndexByName(Truck, 'door_pside_r'), -0.7, 0.0,
                0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            FreezeEntityPosition(PlayerPedId(), false)
            Citizen.Wait(1000*5)
            local transCoords = GetEntityCoords(Truck)
            SetVehicleDoorBroken(Truck, 2, false)
            SetVehicleDoorBroken(Truck, 3, false)
            AddExplosion(transCoords.x, transCoords.y, transCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
            ApplyForceToEntity(Truck, 0, transCoords.x, transCoords.y, transCoords.z, 0.0, 0.0, 0.0, 1, false,true, true, true, true)
            lootable = true
            DeleteEntity(prop)
            Citizen.CreateThread(function()
                Citizen.Wait(8000)
                FreezeEntityPosition(Truck, true)
            end)
        end
    else
        SendNotify(8)
    end
end

function placebags()
    BagID = 1
    Bags = {}
    local transCoords = GetEntityCoords(Truck)

    for i=1, Bagcount do
        local RandomPlaceing = math.random(-5, 5)
        Bags[i] = CreateObject(GetHashKey('prop_money_bag_01'), transCoords.x, transCoords.y, transCoords.z, true, true, true)
        AttachEntityToEntity(Bags[i], Truck, GetEntityBoneIndexByName(Truck, 'chassis_dummy'), RandomPlaceing/10 , -3.5+(i*0.3),
        0.45, RandomPlaceing+0.0,  RandomPlaceing*2+0.0, RandomPlaceing*15+0.0, true, false, false, true, 1, true)
    end
end

function LootoutTruck()
    if NoCarryWeapon() then
        RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
        while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
            Citizen.Wait(50)
        end
        local PedCoords = GetEntityCoords(PlayerPedId())
        SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 2)
        Citizen.Wait(10)
        local bag = CreateObject(GetHashKey('prop_cs_heist_bag_02'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
        AttachEntityToEntity(bag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0,
            false, false, false, false, 2, true)
        TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false,
            false)
        FreezeEntityPosition(PlayerPedId(), true)
        local RunTime = (Bagcount - BagID + 1)* 1000
        local _time = GetGameTimer()
        HandBag = CreateObject(GetHashKey('prop_money_bag_01'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
        AttachEntityToEntity(HandBag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.06, 0.0, 0.06, 90.0,
            0.0, 0.0, true, true, false, true, 1, true)
        SetEntityVisible(HandBag, false, false)
        StopLoot = false
        while GetGameTimer() - _time < RunTime and StopLoot == false do
            Citizen.Wait(1)
            if IsControlPressed(0, Config.HelpNotify[4][2]) then
                StopLoot = true
            end
            HelpNotify(Config.HelpNotify[4][1])
            if HasAnimEventFired(PlayerPedId(), GetHashKey("CASH_APPEAR")) then
                if not IsEntityVisible(HandBag) then
                    SetEntityVisible(HandBag, true, false)
                    DeleteObject(Bags[BagID])
                    TriggerServerEvent('brutal_truck_robbery:server:AddItem')
                end
            end
            if HasAnimEventFired(PlayerPedId(), GetHashKey("RELEASE_CASH_DESTROY")) then
                if IsEntityVisible(HandBag) then
                    SetEntityVisible(HandBag, false, false)
                    BagID += 1
                end
            end
        end
        DeleteObject(HandBag)

        DeleteEntity(bag)
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        SetPedComponentVariation(PlayerPedId(), 5, Config.BagNumber, 0, 2)
        Citizen.Wait(2500)
        if Bagcount - BagID <= 0 then
            return true
        else
            return false
        end
    end
end

function finishRobbery()
    TriggerServerEvent('brutal_truck_robbery:server:sync', 'RESET ROBBERY')
end

RegisterNetEvent('brutal_truck_robbery:client:sync')
AddEventHandler('brutal_truck_robbery:client:sync', function(type, data)
    if type == 'RECEIVED ITEMS' then
        table.insert(ReceivedItems, data)
    elseif type == 'RESET ROBBERY' then
        InRobbery = false
        CurrentIndex = nil
        lootable = false
    
        DeleteEntity(Truck)
        DeleteEntity(Truck_NPC1)
        DeleteEntity(Truck_NPC2)
        DeleteEntity(InfoObject)
        RemoveBlip(Truck_Blip)
        RemoveBlip(AlertPlace)
        RemoveBlip(InfoObject_Blip)
        for i = 1, Config.EnemyCount do
            if AgressiveNPC_Blip[i] ~= nil then
                RemoveBlip(AgressiveNPC_Blip[i])
                DeletePed(AgressiveNPC[i])
            end
        end

    end
end)

-----------------------------------------------------------
-----------------------| sell items |----------------------
-----------------------------------------------------------

function SellItems()
    Selling = true
    SendInsText(4)

    Citizen.CreateThread(function()
        while Selling do
            Citizen.Wait(1000*60*Config.ItemsSellToBoss.availableTime)
            if Selling then
                FinishSell()
            end
        end
    end)

    loadModel(Config.ItemsSellToBoss.model)
    Boss = CreatePed(4, GetHashKey(Config.ItemsSellToBoss.model), Config.ItemsSellToBoss.coords[1], Config.ItemsSellToBoss.coords[2], Config.ItemsSellToBoss.coords[3], false, false)
    SetEntityHeading(Boss, Config.ItemsSellToBoss.coords[4])
    SetBlockingOfNonTemporaryEvents(Boss, true)
    FreezeEntityPosition(Boss, true)
    SetEntityInvincible(Boss, true)
    SetEntityCollision(Boss, true, true)

    if Config.ItemsSellToBoss.blip.use then
        bossBlip = AddBlipForEntity(Boss)
        SetBlipSprite(bossBlip, Config.ItemsSellToBoss.blip.sprite)
        SetBlipScale(bossBlip, Config.ItemsSellToBoss.blip.size)
        SetBlipColour(bossBlip, Config.ItemsSellToBoss.blip.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.ItemsSellToBoss.blip.label)
        EndTextCommandSetBlipName(bossBlip)
        SetBlipAsShortRange(bossBlip, true)
        SetBlipRoute(bossBlip, true)
    end

    Citizen.CreateThread(function()
        while Selling do
            local sleep = 2000
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dist = #(pedCoords - vector3(Config.ItemsSellToBoss.coords[1], Config.ItemsSellToBoss.coords[2], Config.ItemsSellToBoss.coords[3]))

            if dist < 1.7 then
                sleep = 1
                HelpNotify(Config.HelpNotify[6][1])

                if IsControlJustReleased(0, Config.HelpNotify[6][2]) then
                    if NoCarryWeapon() then
                        loadAnimDict("mp_common") 
                        TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake1_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
                        Citizen.Wait(2000)
                        ClearPedTasks(GetPlayerPed(-1))

                        TriggerServerEvent('brutal_truck_robbery:server:SellItems')
                        FinishSell()
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function FinishSell()
    Selling = false
    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 2)
    RemoveBlip(bossBlip)
    
    Citizen.CreateThread(function()
        Citizen.Wait(1000*10)
        DeleteEntity(Boss)
    end)
end

-----------------------------------------------------------
-----------------------| functions |-----------------------
-----------------------------------------------------------

function SendNotify(Number)
    notification(Config.Notify[Number][1], Config.Notify[Number][2], Config.Notify[Number][3], Config.Notify[Number][4])
end

function SendInsText(Num)
    SendNUIMessage({action = "open", text = Config.InstructionTexts[Num]})
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do        
        Citizen.Wait(1)
    end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function HelpNotify(text)
    AddTextEntry('HelpNotification', text)
    BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false)
end

-----------------------------------------------------------
-----------------| NOT RENAME THE SCRIPT |-----------------
-----------------------------------------------------------

Citizen.CreateThread(function()
    Citizen.Wait(1000*30)
	if GetCurrentResourceName() ~= 'brutal_truck_robbery' then
		while true do
			Citizen.Wait(1)
			print("Please don't rename the script! Please rename it back to 'brutal_truck_robbery'")
		end
	end
end)