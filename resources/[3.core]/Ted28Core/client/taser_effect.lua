--- TASER EFFECT

local time = 4000 

local isStunt = false

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)

        

        if IsPedBeingStunned(GetPlayerPed(-1)) then

            SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)   

        end

        

        if IsPedBeingStunned(GetPlayerPed(-1)) and not isStunt then

            isStunt = true

            SetTimecycleModifier("REDMIST_blend")

            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)

        elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isStunt then

            isStunt = false

            Wait(5000)

            SetTimecycleModifier("hud_def_desat_Trevor")        

            Wait(10000) 

            SetTimecycleModifier("")

            SetTransitionTimecycleModifier("")

            StopGameplayCamShaking()

        end

    end

end)



local knockedOut = false

local wait = 15

local count = 60



Citizen.CreateThread(function()

    while true do

        Wait(1)

        local myPed = GetPlayerPed(-1)

        if IsPedInMeleeCombat(myPed) then

            if GetEntityHealth(myPed) < 115 then

                SetPlayerInvincible(PlayerId(), true)

                SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)

                exports.iNotificationV2:UINotification({

                    title = "United Los Santos", 

                    text = "Vous êtes KO",

                    color = "100, 255, 0", 

                    showTime = 8,

                    type = 1

                })      

                wait = 15

                knockedOut = true

                SetEntityHealth(myPed, 116)

            end

        end

        if knockedOut == true then

            SetPlayerInvincible(PlayerId(), true)

            DisablePlayerFiring(PlayerId(), true)

            SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)

            ResetPedRagdollTimer(myPed)

            

            if wait >= 0 then

                count = count - 1

                if count == 0 then

                    count = 60

                    wait = wait - 1

                    SetEntityHealth(myPed, GetEntityHealth(myPed)+4)

                end

            else

                SetPlayerInvincible(PlayerId(), false)

                knockedOut = false

            end

        end

    end

end)



function ShowNotification(text)

    SetNotificationTextEntry("STRING")

    AddTextComponentString(text)

    DrawNotification(false, false)

end