-- TOMBER QUAND ON SE FAIT TOUCHER DANS LA JAMBE

local LEG_BONES = {
    [11816] = true,  -- Pelvis
    [58271] = true,  -- SKEL_L_Thigh
    [63931] = true,  -- SKEL_L_Calf
    [14201] = true,  -- SKEL_L_Foot
    [2108]  = true,  -- SKEL_L_Toe0
    [65245] = true,  -- IK_L_Foot
    [57717] = true,  -- PH_L_Foot
    [46078] = true,  -- MH_L_Knee

    [51826] = true,  -- SKEL_R_Thigh
    [36864] = true,  -- SKEL_R_Calf
    [52301] = true,  -- SKEL_R_Foot
    [20781] = true,  -- SKEL_R_Toe0
    [35502] = true,  -- IK_R_Foot
    [24806] = true,  -- PH_R_Foot
    [16335] = true,  -- MH_R_Knee

    [23639] = true,  -- RB_L_ThighRoll
    [6442]  = true,  -- RB_R_ThighRoll
}

local lastFall = 0
local cooldown = 2000 -- 2 secondes pour éviter de tomber en boucle

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)

        local ped = PlayerPedId()

        if HasEntityBeenDamagedByAnyPed(ped) then
            local _, bone = GetPedLastDamageBone(ped)

            if bone and LEG_BONES[bone] then
                local now = GetGameTimer()

                if now - lastFall > cooldown then
                    lastFall = now
                    makePedFall(ped)
                end
            end

            ClearEntityLastDamageEntity(ped)
        end
    end
end)

function makePedFall(ped)
    -- Animation de chute
    RequestAnimDict("missfam4")
    while not HasAnimDictLoaded("missfam4") do
        Citizen.Wait(10)
    end

    TaskPlayAnim(ped, "missfam4", "base", 8.0, -8.0, 1500, 0, 0, false, false, false)
    SetPedToRagdoll(ped, 2000, 2000, 0, false, false, false)
end