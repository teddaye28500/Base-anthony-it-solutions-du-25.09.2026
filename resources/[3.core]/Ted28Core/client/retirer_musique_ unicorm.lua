--retirer la musique dans unicorm

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_01_STAGE', false)
            SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM', false)
            SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM', false)
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        SetStaticEmitterEnabled('collision_9qv4ecm', false);
        Citizen.Wait(0)
    end
end)