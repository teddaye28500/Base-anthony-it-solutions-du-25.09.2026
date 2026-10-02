---@diagnostic disable: duplicate-set-field, param-type-mismatch, missing-parameter, lowercase-global, undefined-global
Main = {}
registered = 0

local ox_target = exports.ox_target
local Inventory = exports.ox_inventory

local GetEntityCoords = GetEntityCoords
local GetClosestObjectOfType = GetClosestObjectOfType
local DoesEntityExist = DoesEntityExist
local SetEntityDrawOutlineColor = SetEntityDrawOutlineColor
local SetEntityDrawOutlineShader = SetEntityDrawOutlineShader
local StopAnimTask = StopAnimTask
local GetEntityForwardVector = GetEntityForwardVector
local RequestModel = RequestModel
local HasModelLoaded = HasModelLoaded
local AddExplosion = AddExplosion
local PlaySoundFrontend = PlaySoundFrontend

CreateThread(function()
    for k,v in pairs(Config.Settings.ATMs) do
        Main:Int(v)
    end
end)

function Main:Int(Model)
    ox_target:addModel(Model, {
    {
        event = 'bbv-robatm:rob',
        name = 'rob_atm',
        icon = "fas fa-money-bill",
        label = 'Poser la bombe',
        distance = 2.5
    }
})
end


RegisterNetEvent('bbv-robatm:rob',function()
    local ped = cache.ped
    local pedCoords = GetEntityCoords(ped)
    for k,v in pairs(Config.Settings.ATMs) do
        objectId = GetClosestObjectOfType(pedCoords, 2.0, joaat(Config.Settings.ATMs[k]), false)
        if DoesEntityExist(objectId) then
            SetEntityDrawOutlineColor(255, 1, 1, 255)
            SetEntityDrawOutlineShader(0)

            if lib.progressCircle({
                duration = 5000,
                label = "Pose de la bombe...",
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    comat = true,
                    mouse = false
                },
                anim = {
                    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    clip = 'machinic_loop_mechandplayer'
                },
            }) then  Main:Plant(objectId) else StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0) end
        end
    end
end)

function Main:Plant(ent)
    local hasitem = Inventory:Search('count', Config.Settings.BombItemName)
    if hasitem < 1 then
        Wrapper:Notify("Vous n\'avez pas de bombe.")
        return
    end
    if Main:Cooldown() then
        Wrapper:Notify("Deja braquer reviens plus tard.")
        return 
    end
   Wrapper:RemoveItem(Config.Settings.BombItemName, 1)
   Wrapper:Log('ATM ROBBERY')
   local entpos = GetEntityCoords(ent)
   local entf = GetEntityForwardVector(ent)
   local pos = vec4(entpos.x ,entpos.y ,entpos.z + 1, 90.0)
   local prop = 'prop_bomb_01'
   RequestModel(prop)
   while not HasModelLoaded(prop) do
     Wait(0)
   end
   Wrapper:CreateObject(ent,prop,pos,true,false)
   Wrapper:Notify("La bombe explosera dans 10 secondes.")
   Wait(10000)
   Wrapper:DeleteObject(objectId)
   AddExplosion(pos.x,pos.y,pos.z,2,15.0,true,false,false)
   local droppos = vec3(entpos.x - (entf.x - 0.1),entpos.y - (entf.y - 0.1) ,entpos.z)
   self:MoneyDrop(droppos)
end

function Main:MoneyDrop(pos)
    local pos1 = vec3(pos.x - 0.1,pos.y + 0.1,pos.z)
    local pos2 = vec3(pos.x - 0.0,pos.y + 0.0,pos.z)
    local pos3  = vec3(pos.x - 0.4,pos.y - 0.3,pos.z)
    local prop = 'prop_anim_cash_pile_01'
    RequestModel(prop)
    while not HasModelLoaded(prop) do
      Wait(0)
    end
    SetEntityDrawOutlineColor(1, 255, 1, 255)
    SetEntityDrawOutlineShader(0)
    Wrapper:CreateObject('id' .. 1,prop,pos1,true,false)
    Wrapper:CreateObject('id' .. 2,prop,pos2,true,false)
    Wrapper:CreateObject('id' .. 3,prop,pos3,true,false)
    Wrapper:Target('id' .. 1,'Ramasser',pos1,'bbv-atmrob:moneypickup:'..'id' .. 1)
    Wrapper:Target('id' .. 2,'Ramasser',pos2,'bbv-atmrob:moneypickup:'..'id' .. 2)
    Wrapper:Target('id' .. 3,'Ramasser',pos3,'bbv-atmrob:moneypickup:'..'id' .. 3)
    if registered < 3 then
        for i=1, 3 do
            RegisterNetEvent('bbv-atmrob:moneypickup:'..'id'..i, function()
                registered = registered + 1
                Wrapper:TargetRemove('id'..i)
                Wrapper:DeleteObject('id'..i)
                Wait(100)
                ESX.TriggerServerCallback('bbv-atmaddmoney', function(data) 
                    return
                end)
            end)
        end
    end
end

function Main:Cooldown()
    ESX.TriggerServerCallback('bbv-atm:cooldown', function(data) 
        _result = data
        return
    end)
    Wait(500)  -- TEMPS AVANT DE POUVOIR REFAIRE L'ATM
    return _result
end

RegisterNetEvent('bbv-atmrob:alarm',function()
    -- put your police dispatch export here
    for i=1, 30 do
        PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
        Wait(1000)
    end
end)