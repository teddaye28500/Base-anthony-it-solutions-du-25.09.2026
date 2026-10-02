-- RAGDOLL

  local ragdoll = false
  local shownHelp = false
  
  
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
          if IsControlJustPressed(2, 82) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
              ragdoll = not ragdoll
              if not ragdoll then
                  shownHelp = false
              end
          end
          if IsPedBeingStunned(GetPlayerPed(-1)) then
              ragdoll = true
          end
  
        
          -- Don't ragdoll if player is dead
          if IsPlayerDead(PlayerId()) and ragdoll == true then
              ragdoll = false
              shownHelp = false
          end
          if ragdoll == true and not shownHelp then
  
              --TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.01, 'tombe', 1.0)
  
              lib.showTextUI('Se relever [ ; ]', {
                  position = "top-center",
                  icon = 'heart-pulse',
                  style = {
                      borderRadius = 50,
                      backgroundColor = '#007BD0',
                      color = 'white'
                  }
              })
  
  
  
              shownHelp = true
  
  
              Wait(1200)
              
  
          Wait(4000)
  
          lib.hideTextUI()
  
  
          end
      end
  end)
  
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
          if ragdoll then
              SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
          end
      end
  end)
  
  RegisterNetEvent('epic_ragdoll:toggle')
  AddEventHandler('epic_ragdoll:toggle', function()
      ragdoll = not ragdoll
      if not ragdoll then
          shownHelp = false
      end
  end)
  
  RegisterNetEvent('epic_ragdoll:set')
  AddEventHandler('epic_ragdoll:set', function(value)
      ragdoll = value
      if not ragdoll then
          shownHelp = false
      end
  end)