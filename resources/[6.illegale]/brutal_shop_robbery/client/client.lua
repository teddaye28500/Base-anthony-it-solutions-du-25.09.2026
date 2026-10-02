CurrentIndex = nil
InRobbery = false
InProcess = false
DisableControlsValue = false
AlertPlace = nil
IndexToSell = nil
CurrentSafe = nil
InDrilling = false
SendWelconeNotify = true
TotalReceivedMoney = 0
CurrentSecond = 0
CashRegisters = {}
shopPeds = {}
safeObjects = {}
safeIndexs = {}
ReceivedItems = {}
SafeDetails = {}

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        for i = 1, #Config.ShopRobberys do
            ClearArea(GetEntityCoords(shopPeds[i]), 10.0)
            DeletePed(shopPeds[i])
        end
        for i = 1, #Config.ShopRobberys do
            for ii = 1, #safeIndexs do
                DeleteEntity(safeObjects[i][ii])
            end
        end
        if DoesEntityExist(moneyprop) then
            DeleteEntity(moneyprop)
        end
    end
end)

Citizen.CreateThread(function()
    for i = 1, #Config.ShopRobberys do
        local pedConfig = Config.ShopRobberys[i].NPC
        loadModel(pedConfig.model)
        shopPeds[i] = CreatePed(4, GetHashKey(pedConfig.model), pedConfig.coords, false, false)
        SetEntityHeading(shopPeds[i], pedConfig.coords[4])
        SetBlockingOfNonTemporaryEvents(shopPeds[i], true)
        FreezeEntityPosition(shopPeds[i], true)
        SetEntityInvincible(shopPeds[i], true)
        SetEntityCollision(shopPeds[i], false, false)

        if Config.RobberyBlips.Use then
            blip = AddBlipForCoord(pedConfig.coords)
            SetBlipSprite(blip, Config.RobberyBlips.sprite)
            SetBlipScale(blip, Config.RobberyBlips.size)
            SetBlipColour(blip, Config.RobberyBlips.color)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.RobberyBlips.label)
            EndTextCommandSetBlipName(blip)
            SetBlipAsShortRange(blip, true)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(10)
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local sleep = 1000

        for i = 1, #Config.ShopRobberys do
            local dist = #(pedCoords - GetEntityCoords(shopPeds[i]))
            if dist <= 6.0 then
                if SendWelconeNotify and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('WEAPON_UNARMED') and Config.NotifyToRobbery then
                    SendWelconeNotify = false
                    SendNotify(17)
                    Citizen.CreateThread(function()
                        Citizen.Wait(1000*60*30)
                        SendWelconeNotify = true
                    end)
                end

                sleep = 1
                if IsPedShooting(ped) and CurrentIndex == nil then
                    StartRobbery(i, Config.ShopRobberys[i].NPC.coords)
                    Wait(5000)
                end
                if IsPedDeadOrDying(shopPeds[i]) then
                    TriggerServerEvent('brutal_shop_robbery:server:sync', 'NPC SYNC', i)
                    Wait(5000)
                end                                                                                                                                                                           
            end
        end
        Citizen.Wait(sleep)
    end
end)

function StartRobbery(index, coords)

    for i = 1, #Config.ShopRobberys[index].CashRegisters do
        table.insert(CashRegisters, true)
    end

    TSCB('brutal_shop_robbery:server:PossibleRobbery', function(possible)
        if possible then
            Citizen.CreateThread(function()
                while InRobbery or CurrentSecond < Config.ShopRobberys[index].SecondsRemaining do
                    Citizen.Wait(1000)
                    CurrentSecond += 1
                end
            end)
            InRobbery = true
            SendNotify(3)
            loadModel('p_v_43_safe_s')
            for k,v in pairs(Config.ShopRobberys[index].SafeCoords) do
                if safeObjects[index] == nil then
                    safeObjects[index] = {}
                    SafeDetails[index] = {}
                end
                safeObjects[index][k] = CreateObject(GetHashKey('p_v_43_safe_s'), v[1], v[2], v[3], 1, 1, 0)
                SetEntityHeading(safeObjects[index][k], v[4])
                FreezeEntityPosition(safeObjects[index][k], true)
                SafeDetails[index][k] = {broke = false, grab = false}
            end
            TriggerServerEvent('brutal_shop_robbery:server:sync', 'START ROBBERY', index)
            TriggerServerEvent('brutal_shop_robbery:server:PoliceAlert', coords, index)

            Citizen.CreateThread(function()
                while InRobbery do
                    Citizen.Wait(1)
                    local ped = PlayerPedId()
                    local pedCoords = GetEntityCoords(ped)
                    
                    for i = 1, #Config.ShopRobberys[index].CashRegisters do
                        local dist = #(pedCoords - vector3(Config.ShopRobberys[index].CashRegisters[i].coords[1], Config.ShopRobberys[index].CashRegisters[i].coords[2], Config.ShopRobberys[index].CashRegisters[i].coords[3]))
                        if dist < 0.2 and InProcess == false and CashRegisters[i] then
                            HelpNotify(Config.HelpNotify[1][1])

                            if IsControlJustReleased(0, Config.HelpNotify[1][2]) then
                                if CashRegisters[i] then
                                    if NoCarryWeapon() then
                                        StartGrabMoney(i)
                                    end
                                end
                            end

                        end
                    end

                    for k,v in pairs(Config.ShopRobberys[index].SafeCoords) do
                        local dist = #(pedCoords - vector3(Config.ShopRobberys[index].SafeCoords[k][1], Config.ShopRobberys[index].SafeCoords[k][2], Config.ShopRobberys[index].SafeCoords[k][3]))
                        if dist < 1.5 and InProcess == false then
                            HelpNotify(Config.HelpNotify[2][1])

                            if IsControlJustReleased(0, Config.HelpNotify[2][2]) then
                                if SafeDetails[index][k].broke == false then
                                    if SafeDetails[index][k].grab == false then
                                        if CurrentSecond >= Config.ShopRobberys[index].SecondsRemaining then
                                            if NoCarryWeapon() then
                                                TSCB('brutal_shop_robbery:server:getItem', function(HasItem)
                                                    if HasItem then
                                                        CurrentSafe = k
                                                        StartDrilling()
                                                    else
                                                        notification(Config.Notify[9][1], Config.Notify[9][2]..' '..Config.DrillItem.label, Config.Notify[9][3], Config.Notify[9][4])
                                                    end
                                                end, Config.DrillItem.item)
                                            end
                                        else
                                            local NeedWaitTime = Config.ShopRobberys[index].SecondsRemaining-CurrentSecond
                                            notification(Config.Notify[16][1], Config.Notify[16][2]..' '..NeedWaitTime..' '..Config.SecondForm, Config.Notify[16][3], Config.Notify[16][4])
                                        end
                                    else
                                        SendNotify(6)
                                    end
                                else
                                    SendNotify(5)
                                end
                            end
                        end
                    end
                end
            end)

            Citizen.CreateThread(function()
                while InRobbery do
                    Citizen.Wait(10000)
                    local ShopPlace = Config.ShopRobberys[CurrentIndex].NPC.coords
                    if PlayerDied() or (#(GetEntityCoords(PlayerPedId()) - vector3(ShopPlace[1], ShopPlace[2], ShopPlace[3])) > Config.MaxDistance) then
                        local Rewards = {
                            {stat = Config.SuccessRobbery.totalPayOut, value = "~r~"..TotalReceivedMoney.." ~g~"..Config.MoneyForm},
                        }
                        for k,v in pairs(ReceivedItems) do
                            table.insert(Rewards, {stat = v.label, value = '~r~'..v.count..'~g~x'})
                        end
                        if TotalReceivedMoney ~= 0 or #Rewards > 1 then
                            if Config.SuccessRobbery.Use then
                                HeistNotify(Config.SuccessRobbery, Rewards, 5, true)
                            end
                            if Config.ItemsSellToBoss.use then
                                Citizen.CreateThread(function()
                                    Citizen.Wait(8000)
                                    SellItems(CurrentIndex)
                                end)
                            end
                        else
                            if Config.FailedRobbery.Use then
                                HeistNotify(Config.FailedRobbery, nil, 5, true)
                            end
                        end

                        if InDrilling then
                            InDrilling = false
                            local player = GetPlayerPed(-1)
                            StopParticleFxLooped(effect, 0)
                            ClearPedTasksImmediately(player)
                            StopSound(drillSound)
                            ReleaseSoundId(drillSound)
                            DeleteObject(attachedDrill)
                            DeleteEntity(attachedDrill)
                            StopGameplayCamShaking(true)
                            ClearPedTasksImmediately(PlayerPedId())
                            FreezeEntityPosition(player, false)
                            DetachEntity(player)
                        end

                        TriggerServerEvent('brutal_shop_robbery:server:sync', 'RESET ROBBERY', CurrentIndex)
                        break
                    end
                end
            end)

        end
    end)
end

RegisterNetEvent('brutal_shop_robbery:client:sync')
AddEventHandler('brutal_shop_robbery:client:sync', function(type, index, amount)
    if type == 'START ROBBERY' then
        CurrentIndex = index
        local chance = math.random(1, 100)
        if chance > Config.NpcAttack.chance then
            TaskHandsUp(shopPeds[index], -1, -1, -1, 1)
            PlayPedAmbientSpeechWithVoiceNative(shopPeds[index], "SHOP_SCARED", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
            SetEntityInvincible(shopPeds[index], false)
        else
            local ped = PlayerPedId()
            SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
            AddRelationshipGroup('GuardPeds')
            SetPedRelationshipGroupHash(shopPeds[index], GetHashKey("GuardPeds"))
            GiveWeaponToPed(shopPeds[index], GetHashKey(Config.NpcAttack.weapon), 999, 1, 1)
            SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	        SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	        SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
            SetBlockingOfNonTemporaryEvents(shopPeds[index], false)
            SetEntityInvincible(shopPeds[index], false)
            SetEntityCollision(shopPeds[index], true, true)
            FreezeEntityPosition(shopPeds[index], false)
        end
    elseif type == 'RESET ROBBERY' then
        local pedConfig = Config.ShopRobberys[index].NPC
        loadModel(pedConfig.model)
        for i = 1, #safeIndexs do
            DeleteEntity(safeObjects[index][i])
        end
        DeletePed(shopPeds[index])
        shopPeds[index] = CreatePed(4, GetHashKey(pedConfig.model), pedConfig.coords, false, false)
        SetEntityHeading(shopPeds[index], pedConfig.coords[4])
        SetBlockingOfNonTemporaryEvents(shopPeds[index], true)
        FreezeEntityPosition(shopPeds[index], true)
        SetEntityInvincible(shopPeds[index], true)
        SetEntityCollision(shopPeds[index], false, false)
        ClearArea(pedConfig.coords, 10.0)

        if AlertPlace ~= nil then
            RemoveBlip(AlertPlace)
            notification(Config.Notify[15][1], Config.Notify[15][2]..' '..Config.ShopRobberys[index].ShopName, Config.Notify[15][3], Config.Notify[15][4])
            AlertPlace = nil
        end

        InRobbery = false
        InProcess = false
        IndexToSell = CurrentIndex
        CurrentIndex = nil
        TotalReceivedMoney = 0
        SafeDetails = {} 
        CurrentSafe = nil 
        safeIndexs = {}
        safeObjects = {}
        CashRegisters = {}
    elseif type == 'RECEIVED MONEY' then
        notification(Config.Notify[10][1], Config.Notify[10][2]..' '..amount..' '..Config.MoneyForm, Config.Notify[10][3], Config.Notify[10][4])
        TotalReceivedMoney += amount
    elseif type == 'NPC SYNC' then
        SetEntityHealth(shopPeds[index], 0)
    elseif type == 'RECEIVED ITEMS' then
        ReceivedItems = amount
    end
end)

RegisterNetEvent('brutal_shop_robbery:client:PoliceAlert')
AddEventHandler('brutal_shop_robbery:client:PoliceAlert', function(coords, index)
    PoliceAlertNotify(coords, Config.ShopRobberys[index].ShopName)

    AlertPlace = AddBlipForCoord(coords[1], coords[2], coords[3])
    SetBlipSprite(AlertPlace, Config.PoliceAlertBlip.sprite)
    SetBlipScale(AlertPlace, Config.PoliceAlertBlip.size)
    SetBlipColour(AlertPlace, Config.PoliceAlertBlip.color)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.PoliceAlertBlip.label)
    EndTextCommandSetBlipName(AlertPlace)
end)


-----------------------------------------------------------
-----------------------| drilling |------------------------
-----------------------------------------------------------

function StartDrilling()
    local ped = PlayerPedId()
    local player = GetPlayerPed(-1)
    local animDict = "anim@heists@fleeca_bank@drilling"
    local animLib = "drill_straight_idle"

    DisableControls()
    InProcess = true
    InDrilling = true
    FreezeEntityPosition(player, true)
    SetEntityHeading(PlayerPedId(), GetEntityHeading(safeObjects[CurrentIndex][CurrentSafe]))
    loadAnimDict(animDict)
    TaskPlayAnim(player, animDict , animLib ,8.0, -8.0, -1, 1, 0, false, false, false )
    AttachEntityToEntity(player, safeObjects[CurrentIndex][CurrentSafe], 0, -0.12, -1.170, 0.20, 0.0, 0.0, 0.0, true, true, true, true, 1, true)

    local drillProp = GetHashKey('hei_prop_heist_drill')
    local boneIndex = GetPedBoneIndex(player, 28422)

    RequestModel(drillProp)
    while not HasModelLoaded(drillProp) do
        Citizen.Wait(100)
    end

    attachedDrill = CreateObject(drillProp, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedDrill, player, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                            
    SetEntityAsMissionEntity(attachedDrill, true, true)

    RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
    drillSound = GetSoundId()
    Citizen.Wait(100)
    PlaySoundFromEntity(drillSound, "Drill", attachedDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
    Citizen.Wait(100)	

    ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)

    local particleDictionary = "scr_fbi5a"
	local particleName = "scr_bio_cutter_flame"

	RequestNamedPtfxAsset(particleDictionary)
	while not HasNamedPtfxAssetLoaded(particleDictionary) do
		Citizen.Wait(0)
	end

	SetPtfxAssetNextCall(particleDictionary)
	effect = StartParticleFxLoopedOnEntity(particleName, attachedDrill, -0.01, -0.65, 0.00, -0, -0, 20, 2.0, 0, 0, 0)
	Citizen.Wait(100)
    
    Drilling.Start(function(status)
        StopParticleFxLooped(effect, 0)
        ClearPedTasksImmediately(player)
        StopSound(drillSound)
        ReleaseSoundId(drillSound)
        DeleteObject(attachedDrill)
        DeleteEntity(attachedDrill)
        StopGameplayCamShaking(true)
        ClearPedTasksImmediately(PlayerPedId())
        FreezeEntityPosition(player, false)
        DetachEntity(player)
        Citizen.Wait(1000)

        if status then
            SafeDetails[CurrentIndex][CurrentSafe].broke = true
            if InRobbery then
                GrabCashAnim()
            end
        else
            SafeDetails[CurrentIndex][CurrentSafe].broke = true
            SendNotify(4)
        end

        DisableControlsValue = false
        InProcess = false
        InDrilling = false
    end)
end

function GrabCashAnim()
	local player = GetPlayerPed(-1)
    local ped = PlayerPedId()
    local pedCo, pedRot = GetEntityCoords(ped), GetEntityRotation(ped)
	local animDict = "anim@heists@ornate_bank@grab_cash"
	local animName = "grab"
    loadAnimDict("mini@safe_cracking")
    NetworkRegisterEntityAsNetworked(safeObjects[CurrentIndex][CurrentSafe])
    TakeControl(safeObjects[CurrentIndex][CurrentSafe])
    local sceneRot = GetEntityRotation(safeObjects[CurrentIndex][CurrentSafe]) + vector3(0.0, 0.0, 90.0)
    local scenePos = GetEntityCoords(safeObjects[CurrentIndex][CurrentSafe]) - GetAnimInitialOffsetPosition("mini@safe_cracking", "door_open_succeed_stand_safe", 0.0, 0.0, 0.0, sceneRot, 0, 2)
    
    scene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.0)
    NetworkAddPedToSynchronisedScene(ped, scene, "mini@safe_cracking", 'door_open_succeed_stand', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(safeObjects[CurrentIndex][CurrentSafe], scene, "mini@safe_cracking", 'door_open_succeed_stand_safe', 8.0, 8.0, 137)
    NetworkStartSynchronisedScene(scene)
    loadModel('prop_cash_case_02')
    moneybag = CreateObject(GetHashKey('prop_cash_case_02'), GetOffsetFromEntityInWorldCoords(safeObjects[CurrentIndex][CurrentSafe], 0.0, 0.0, 0.1), true, false)
    SetEntityHeading(moneybag, GetEntityHeading(safeObjects[CurrentIndex][CurrentSafe]))
    Citizen.Wait(2200)
    PlayEntityAnim(safeObjects[CurrentIndex][CurrentSafe], "DOOR_OPEN_SUCCEED_STAND_SAFE", "mini@safe_cracking", 8.0, false, true, 0, 0.96, 262144)

    loadAnimDict(animDict)
	local targetPosition, targetRotation = (GetOffsetFromEntityInWorldCoords(safeObjects[CurrentIndex][CurrentSafe], 0, 0, 0)), GetEntityRotation(safeObjects[CurrentIndex][CurrentSafe])
    local animPos = GetAnimInitialOffsetPosition(animDict, animName, targetPosition, targetRotation, 0, 2)
    local netScene = NetworkCreateSynchronisedScene(targetPosition.x-0.2, targetPosition.y+0.1, targetPosition.z-0.3, targetRotation.x+180, targetRotation.y-180, targetRotation.z+2.91, 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, netScene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)

    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
    bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(GetAnimDuration(animDict, animName) * 150)
	NetworkStopSynchronisedScene(netScene)
    DeleteObject(moneybag)
    DeleteObject(bag)
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)

    TriggerServerEvent('brutal_shop_robbery:server:AddMoney', 'SAFE', CurrentIndex)
    TriggerServerEvent('brutal_shop_robbery:server:AddItem', 'SAFE', CurrentIndex)
end

function TakeControl(ent)
    if DoesEntityExist(ent) then
        local timer = GetGameTimer() + 7500
        while not NetworkHasControlOfEntity(ent) do
            Wait(50)
            NetworkRequestControlOfEntity(ent)
            NetworkRegisterEntityAsNetworked(ent)
            if timer < GetGameTimer() or not DoesEntityExist(ent) then 
                return false 
            end
        end
        return true
    end
    return false
end

-----------------------------------------------------------
---------------------| cash register |---------------------
-----------------------------------------------------------

function StartGrabMoney(cash_index)
    local ped = PlayerPedId()
    local player = GetPlayerPed(-1)
    local pedCo = GetEntityCoords(ped)
    local animDict = "oddjobs@shop_robbery@rob_till"
    local animLib = "loop"

    local cashregister = GetClosestObjectOfType(pedCo, 5.0, GetHashKey('prop_till_01'), 0, 0, 0)
    if cashregister ~= 0 then
        if HasObjectBeenBroken(cashregister) then
            CashRegisters[cash_index] = false
            InProcess = true
            FreezeEntityPosition(player, true)
            SetEntityHeading(PlayerPedId(), GetEntityHeading(cashregister))
            loadAnimDict(animDict)
            TaskPlayAnim(player, animDict , animLib ,8.0, -8.0, -1, 1, 0, false, false, false)
            SpinnerFunction(Config.GrabMoney, 10000)
            Citizen.Wait(10000)
            TriggerServerEvent('brutal_shop_robbery:server:AddMoney', 'CASH REGISTER', CurrentIndex)
            ClearPedTasksImmediately(player)
            ClearPedTasksImmediately(ped)
            FreezeEntityPosition(player, false)
            InProcess = false
        else
            SendNotify(7)
        end
    end
end

-----------------------------------------------------------
-----------------------| sell items |----------------------
-----------------------------------------------------------

function SellItems(index)
    Selling = true
    SendNotify(14)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000*60*Config.ItemsSellToBoss.availableTime)
            if Selling then
                SendNotify(11)
                FinishSell()
            end
        end
    end)

    loadModel(Config.ItemsSellToBoss.model)
    Boss = CreatePed(4, GetHashKey(Config.ItemsSellToBoss.model), Config.ItemsSellToBoss.coords, false, false)
    SetEntityHeading(Boss, Config.ItemsSellToBoss.coords[4])
    SetBlockingOfNonTemporaryEvents(Boss, true)
    FreezeEntityPosition(Boss, true)
    SetEntityInvincible(Boss, true)
    SetEntityCollision(Boss, true, true)

    if Config.ItemsSellToBoss.blip.use then
        bossBlip = AddBlipForCoord(Config.ItemsSellToBoss.coords)
        SetBlipSprite(bossBlip, Config.ItemsSellToBoss.blip.sprite)
        SetBlipScale(bossBlip, Config.ItemsSellToBoss.blip.size)
        SetBlipColour(bossBlip, Config.ItemsSellToBoss.blip.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.ItemsSellToBoss.blip.label)
        EndTextCommandSetBlipName(bossBlip)
        SetBlipAsShortRange(bossBlip, true)

        SetBlipRoute(bossBlip, true)
        SetBlipRouteColour(bossBlip, Config.ItemsSellToBoss.blip.color)
    end

    Citizen.CreateThread(function()
        while Selling do
            local sleep = 2000
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dist = #(pedCoords - vector3(Config.ItemsSellToBoss.coords[1], Config.ItemsSellToBoss.coords[2], Config.ItemsSellToBoss.coords[3]))

            if dist < 1.7 then
                sleep = 1
                HelpNotify(Config.HelpNotify[3][1])

                if IsControlJustReleased(0, Config.HelpNotify[3][2]) then
                    loadAnimDict("mp_common") 
                    TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake1_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
                    Citizen.Wait(2000)
                    ClearPedTasks(GetPlayerPed(-1))

                    TriggerServerEvent('brutal_shop_robbery:server:SellItems', IndexToSell)
                    FinishSell()
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function FinishSell()
    Selling = false
    IndexToSell = nil
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

function HelpNotify(text)
    AddTextEntry('HelpNotification', text)
    BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false)
end

function DisableControls()
    DisableControlsValue = true
    Citizen.CreateThread(function()
        while DisableControlsValue do 
            for k,v in pairs(Config.DisableControls) do
                DisableControlAction(0,v,true)
            end
            Citizen.Wait(0)
        end
    end)
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

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do        
        Citizen.Wait(1)
    end
end

function SpinnerFunction(text, time)
    showBusySpinnerNoScaleform(text)

    Citizen.CreateThread(function()
        Citizen.Wait(time)
        BusyspinnerOff()
    end)
end

function showBusySpinnerNoScaleform(text)
    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandBusyspinnerOn(1)
end