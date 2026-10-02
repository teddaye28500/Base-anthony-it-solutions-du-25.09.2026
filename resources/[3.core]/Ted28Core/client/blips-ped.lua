------blips-----------

local blips = {
   {title="~g~∑ Football~g~ ∑", colour=68, id=518, x = 785.23, y = -247.50, z = 66.11},
   {title="~g~∑ Fight salle~g~ ∑", colour=15 , id=311, x = -258.11, y = -2024.39, z = 30.14},
   {title="~g~∑ Fight plage~g~ ∑", colour=15 , id=311, x = -1276.85, y = -1538.44, z = 4.31},
   {title="Location vehicule", colour=8 , id=225, x = 218.85, y = -858.10, z = 30.25},
   {title="Location vehicule", colour=8 , id=225, x = 4493.92, y = -4518.55, z = 4.41},
   {title="Location vehicule", colour=8 , id=225, x = 1930.18, y = 3721.64, z = 32.81},
   {title="Location vehicule", colour=8 , id=225, x = 121.64, y = 6624.94, z = 31.95},
   {title="panwshop", colour=7 , id=728, x = 178.90, y = -1318.46, z = 29.34},   
   -- Example {title="", colour=, id=, x=, y=, z=},                                                                  
   --Tu peut en ajouter autant que tu veut en copiant la ligne au dessus ! 

     
  }                                        
  Citizen.CreateThread(function()           
  
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.5)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
  end)  

 ---ped fix 
  
--[[Citizen.CreateThread(function()
  local hash = GetHashKey("mp_m_execpa_01")
  local pedpos = vector3(173.38356018066, -1319.2825927734, 28.363613128662) -- Position du Ped
  
  while not HasModelLoaded(hash) do
  RequestModel(hash)
  Wait(20)
  end
  
  ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_execpa_01", pedpos.x, pedpos.y, pedpos.z, 286.92, false, true) --Emplacement du PEDS
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetEntityInvincible(ped, true)
  FreezeEntityPosition(ped, true)
  end)  

----glacier fête foraine

Citizen.CreateThread(function()
  local hash = GetHashKey("mp_m_execpa_01")
  local pedpos = vector3(-1609.5479736328, -1062.6168212891, 12.456047058105) -- Position du Ped
  
  while not HasModelLoaded(hash) do
  RequestModel(hash)
  Wait(20)
  end
  
  ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_execpa_01", pedpos.x, pedpos.y, pedpos.z, 34.91, false, true) --Emplacement du PEDS
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetEntityInvincible(ped, true)
  FreezeEntityPosition(ped, true)
  end)]] 
