Citizen.CreateThread(function()
	
	local bool = false
	local helmet = -1
	local helmetTexture = -1
	local time = 1000
		
	while true do
				
		local ped = PlayerPedId()
		
		if GetVehiclePedIsUsing(ped) ~= 0 then
						
			if not GetIsTaskActive(ped, 160) and bool == false then				
				bool = true
				
				if not (helmet == -1) then
					ClearPedProp(ped, 0)
					SetPedPropIndex(ped, 0, helmet, helmetTexture, true)
				end
			end
		else
			if bool == true then
				bool = false
			end
					
			helmet = GetPedPropIndex(ped, 0)
			helmetTexture = GetPedPropTextureIndex(ped, 0) 
		end
		
		
		Citizen.Wait(time)
	end
end)
