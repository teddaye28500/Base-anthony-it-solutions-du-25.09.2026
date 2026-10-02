--ESX = nil
--------- KO SYSTEM ---------

local knockedOut = false
local wait = 50
local count = 60

CreateThread(function()
	while true do
		Wait(1.0)
		if IsPedInMeleeCombat(PlayerPedId()) then
			if GetEntityHealth(PlayerPedId()) < 120 then -- nombre de santé avant que tu tombe ko
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
				SetTimecycleModifier('damage')
				TriggerEvent('ui:toggle', false)
				TriggerEvent("esx_status:setDisplay", 0.0)
				wait = 50
				knockedOut = true
				SetEntityHealth(PlayerPedId(), 116)
			end
		end
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(PlayerPedId())
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())+4)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
				SetTimecycleModifier('')
				TriggerEvent("esx_status:setDisplay", 1.0)
				TriggerEvent('ui:toggle', true)
			end
		end
		 if knockedOut then
		 	CenterText("~r~Vous êtes K.O~s~", 1)
		 end
	end
end)
