RegisterNetEvent('washing:hands')
AddEventHandler('washing:hands', function()
    if not isWashed then
        dict = "missheist_agency3aig_23"
        clip = "urinal_sink_loop"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.LavageMain.Duration, Config.Progress_bar.LavageMain.Label)
        StopAnimTask(cache.ped, dict, clip, 1.0)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
        FreezeEntityPosition(cache.ped, false)
        Notification("success", "", locale("lavage"))
        isWashed = true
    else
        Notification("error", "", locale("dejalavage"))
    end
end)

RegisterNetEvent('washing:hands2')
AddEventHandler('washing:hands2', function()
    dict = "missheist_agency3aig_23"
    clip = "urinal_sink_loop"
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
    FreezeEntityPosition(cache.ped, true)
    ProgressBar(Config.Progress_bar.LavageMain.Duration, Config.Progress_bar.LavageMain.Label)
    StopAnimTask(cache.ped, dict, clip, 1.0)
    ClearPedTasks(cache.ped)
    DeleteEntity(prop)
    FreezeEntityPosition(cache.ped, false)
end)

RegisterNetEvent('washing:sponge')
AddEventHandler('washing:sponge', function()
    ESX.TriggerServerCallback('ledjo:getItemAmount', function(quantity)
        if quantity >= 1 then
            dict = "missheist_agency3aig_23"
            clip = "urinal_sink_loop"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            local hash = `prop_sponge_01`
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Wait(100)
                RequestModel(hash)
            end
            local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
            AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true,
                true, false, false, 1, true)
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(Config.Progress_bar.LavageSponge.Duration, Config.Progress_bar.LavageSponge.Label)
            StopAnimTask(cache.ped, dict, clip, 1.0)
            FreezeEntityPosition(cache.ped, false)
            ClearPedTasks(cache.ped)
            DeleteEntity(prop)
            Notification("success", "", locale("lavage"))
            TriggerServerEvent('ledjo:remove', 'item', 1, 'spongedirty')
            TriggerServerEvent('ledjo:add', 'item', 1, 'sponge')
        else
            Notification("error", "", locale("epongesale"))
        end
    end, 'spongedirty')
end)

RegisterNetEvent('cuisson:burger')
AddEventHandler('cuisson:burger', function()
    if isWashed then
        dict = "amb@prop_human_bbq@male@idle_a"
        clip = "idle_b"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        local hash = `prop_fish_slice_01`
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, false, 1, true)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.CuissonBurger.Duration, Config.Progress_bar.CuissonBurger.Label)
        TriggerServerEvent('checkItemBurgershot', 'burger')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('cuisson:menuburger')
AddEventHandler('cuisson:menuburger', function()
    if isWashed then
        dict = "amb@prop_human_bbq@male@idle_a"
        clip = "idle_b"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        local hash = `prop_fish_slice_01`
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, false, 1, true)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.CuissonMenuburger.Duration, Config.Progress_bar.CuissonMenuburger.Label)
        TriggerServerEvent('checkItemBurgershot', 'menuburger')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('cuisson:sandwitch')
AddEventHandler('cuisson:sandwitch', function()
    if isWashed then
        dict = "amb@prop_human_bbq@male@idle_a"
        clip = "idle_b"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        local hash = `prop_fish_slice_01`
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, false, 1, true)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.CuissonClubsandwitch.Duration, Config.Progress_bar.CuissonClubsandwitch.Label)
        TriggerServerEvent('checkItemBurgershot', 'clubsandwitch')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('friteuse:frites')
AddEventHandler('friteuse:frites', function()
    if isWashed then
        dict = "amb@prop_human_bbq@male@idle_a"
        clip = "idle_b"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        local hash = `prop_fish_slice_01`
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, false, 1, true)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.FriteuseFrites.Duration, Config.Progress_bar.FriteuseFrites.Label)
        TriggerServerEvent('checkItemBurgershot', 'frites')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('friteuse:poutine')
AddEventHandler('friteuse:poutine', function()
    if isWashed then
        dict = "amb@prop_human_bbq@male@idle_a"
        clip = "idle_b"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        local hash = `prop_fish_slice_01`
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, false, 1, true)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.FriteusePoutine.Duration, Config.Progress_bar.FriteusePoutine.Label)
        TriggerServerEvent('checkItemBurgershot', 'poutine')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('friteuse:croquette')
AddEventHandler('friteuse:croquette', function()
    if isWashed then
        dict = "amb@prop_human_bbq@male@idle_a"
        clip = "idle_b"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        local hash = `prop_fish_slice_01`
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
            false, false, 1, true)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.FriteuseCroquette.Duration, Config.Progress_bar.FriteuseCroquette.Label)
        TriggerServerEvent('checkItemBurgershot', 'croquette')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('washing:table')
AddEventHandler('washing:table', function()
    ESX.TriggerServerCallback('ledjo:getItemAmount', function(quantity)
        if quantity >= 1 then
            dict = "timetable@floyd@clean_kitchen@base"
            clip = "base"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            local hash = `prop_sponge_01`
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Wait(100)
                RequestModel(hash)
            end
            local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
            AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, -0.04, 0.0, 0.0, 0.0, true,
                true, false, false, 1, true)
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(Config.Progress_bar.WashingTable.Duration, Config.Progress_bar.WashingTable.Label)
            StopAnimTask(cache.ped, dict, clip, 1.0)
            FreezeEntityPosition(cache.ped, false)
            ClearPedTasks(cache.ped)
            DeleteEntity(prop)
            Notification("success", "", locale("washingtable"))
            TriggerServerEvent('ledjo:remove', 'item', 1, 'sponge')
            TriggerServerEvent('ledjo:add', 'item', 1, 'spongedirty')
        else
            Notification("error", "", locale("neededitem"))
        end
    end, 'sponge')
end)

RegisterNetEvent('pee')
AddEventHandler('pee', function()
    dict = "misscarsteal2peeing"
    clip = "peeing_loop"
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
    FreezeEntityPosition(cache.ped, true)
    ProgressBar(Config.Progress_bar.Peeing.Duration, Config.Progress_bar.Peeing.Label)
    StopAnimTask(cache.ped, dict, clip, 1.0)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasks(cache.ped)
    DeleteEntity(prop)
    Notification("success", "", locale("peeing"))
end)

RegisterNetEvent('peefille')
AddEventHandler('peefille', function()
    FreezeEntityPosition(PlayerPedId(), true)
    ExecuteCommand('e sitchair3')
    ProgressBar(Config.Progress_bar.Peeing.Duration, Config.Progress_bar.Peeing.Label)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(PlayerPedId())
    Notification("success", "", locale("peeing"))
end)

RegisterNetEvent('washing:floor')
AddEventHandler('washing:floor', function()
    dict = "move_mop"
    clip = "idle_scrub_small_player"
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
    local hash = `prop_cs_mop_s`
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(100)
        RequestModel(hash)
    end
    local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true,
        false, false, 1, true)
    FreezeEntityPosition(cache.ped, true)
    ProgressBar(Config.Progress_bar.Washingfloor.Duration, Config.Progress_bar.Washingfloor.Label)
    StopAnimTask(cache.ped, dict, clip, 1.0)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasks(cache.ped)
    DeleteEntity(prop)
    Notification("success", "", locale("lavageplancher"))
end)

RegisterNetEvent('washing:face')
AddEventHandler('washing:face', function()
    dict = "switch@michael@wash_face"
    clip = "loop_michael"
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
    FreezeEntityPosition(cache.ped, true)
    ProgressBar(Config.Progress_bar.Washingface.Duration, Config.Progress_bar.Washingface.Label)
    StopAnimTask(cache.ped, dict, clip, 1.0)
    FreezeEntityPosition(cache.ped, false)
    ClearPedTasks(cache.ped)
    DeleteEntity(prop)
    Notification("success", "", locale("washingface"))
end)

RegisterNetEvent('cutting:salade')
AddEventHandler('cutting:salade', function()
    ESX.TriggerServerCallback('ledjo:getItemAmount', function(quantity)
        if quantity >= 1 then
            dict = "mini@repair"
            clip = "fixing_a_ped"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(Config.Progress_bar.Cutting.Duration, Config.Progress_bar.Cutting.Label)
            StopAnimTask(cache.ped, dict, clip, 1.0)
            FreezeEntityPosition(cache.ped, false)
            ClearPedTasks(cache.ped)
            DeleteEntity(prop)
            TriggerServerEvent('ledjo:remove', 'item', 1, 'salade')
            TriggerServerEvent('ledjo:add', 'item', 1, 'saladecouper')
            Notification("success", "", locale("cutting"))
        else
            Notification("error", "", locale("neededitem"))
        end
    end, 'salade')
end)

RegisterNetEvent('cutting:poulet')
AddEventHandler('cutting:poulet', function()
    ESX.TriggerServerCallback('ledjo:getItemAmount', function(quantity)
        if quantity >= 1 then
            dict = "mini@repair"
            clip = "fixing_a_ped"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(Config.Progress_bar.Cutting.Duration, Config.Progress_bar.Cutting.Label)
            StopAnimTask(cache.ped, dict, clip, 1.0)
            FreezeEntityPosition(cache.ped, false)
            ClearPedTasks(cache.ped)
            DeleteEntity(prop)
            TriggerServerEvent('ledjo:remove', 'item', 1, 'poulet')
            TriggerServerEvent('ledjo:add', 'item', 2, 'pouletcouper')
            Notification("success", "", locale("cuttingchicken"))
        else
            Notification("error", "", locale("neededitem"))
        end
    end, 'poulet')
end)

RegisterNetEvent('cutting:boulette')
AddEventHandler('cutting:boulette', function()
    ESX.TriggerServerCallback('ledjo:getItemAmount', function(quantity)
        if quantity >= 1 then
            dict = "mini@repair"
            clip = "fixing_a_ped"
            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Wait(0) end
            TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
            FreezeEntityPosition(cache.ped, true)
            ProgressBar(Config.Progress_bar.Cutting.Duration, Config.Progress_bar.Cutting.Label)
            StopAnimTask(cache.ped, dict, clip, 1.0)
            FreezeEntityPosition(cache.ped, false)
            ClearPedTasks(cache.ped)
            DeleteEntity(prop)
            TriggerServerEvent('ledjo:remove', 'item', 1, 'steakhacher')
            TriggerServerEvent('ledjo:add', 'item', 2, 'boulette')
            Notification("success", "", locale("cuttingchicken"))
        else
            Notification("error", "", locale("neededitem"))
        end
    end, 'steakhacher')
end)

RegisterNetEvent('nsx:jusorange')
AddEventHandler('nsx:jusorange', function()
    if isWashed then
        dict = "mini@repair"
        clip = "fixing_a_ped"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.BoissonLoad.Duration, Config.Progress_bar.BoissonLoad.Label)
        TriggerServerEvent('checkItemBurgershot', 'jusorange')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('nsx:pepper')
AddEventHandler('nsx:pepper', function()
    if isWashed then
        dict = "mini@repair"
        clip = "fixing_a_ped"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.BoissonLoad.Duration, Config.Progress_bar.BoissonLoad.Label)
        TriggerServerEvent('checkItemBurgershot', 'pepper')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('nsx:liqueur')
AddEventHandler('nsx:liqueur', function()
    if isWashed then
        dict = "mini@repair"
        clip = "fixing_a_ped"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.BoissonLoad.Duration, Config.Progress_bar.BoissonLoad.Label)
        TriggerServerEvent('checkItemBurgershot', 'liqueur')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('nsx:coca')
AddEventHandler('nsx:coca', function()
    if isWashed then
        dict = "mini@repair"
        clip = "fixing_a_ped"
        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do Wait(0) end
        TaskPlayAnim(cache.ped, dict, clip, 3.0, 1.0, -1, 49, 0, false, false, false)
        FreezeEntityPosition(cache.ped, true)
        ProgressBar(Config.Progress_bar.BoissonLoad.Duration, Config.Progress_bar.BoissonLoad.Label)
        TriggerServerEvent('checkItemBurgershot', 'coca')
        StopAnimTask(cache.ped, dict, clip, 1.0)
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
    elseif not isWashed then
        Notification("error", "", locale("lavageavant"))
    end
end)

RegisterNetEvent('nsx:trash')
AddEventHandler('nsx:trash', function()
    exports.ox_inventory:openInventory('stash', { id = 'TrashCanBurgershot' })
end)

RegisterNetEvent('nsx:bossmenu')
AddEventHandler('nsx:bossmenu', function()
    TriggerEvent('esx_society:openBossMenu', 'burgershot', function(data)
    end, { wash = false })
end)

RegisterNetEvent('nsx:stash')
AddEventHandler('nsx:stash', function()
    exports.ox_inventory:openInventory('stash', { id = 'StashBurgershot' })
end)

RegisterNetEvent('nsx:commands')
AddEventHandler('nsx:commands', function()
    exports.ox_inventory:openInventory('stash', { id = 'CommandeBurgershot' })
end)

RegisterNetEvent('nsx:commands2')
AddEventHandler('nsx:commands2', function()
    exports.ox_inventory:openInventory('stash', { id = 'CommandeBurgershot2' })
end)

RegisterNetEvent('nsx:commands3')
AddEventHandler('nsx:commands3', function()
    exports.ox_inventory:openInventory('stash', { id = 'CommandeBurgershot3' })
end)

RegisterNetEvent('nsx:commands4')
AddEventHandler('nsx:commands4', function()
    exports.ox_inventory:openInventory('stash', { id = 'CommandeBurgershot4' })
end)
