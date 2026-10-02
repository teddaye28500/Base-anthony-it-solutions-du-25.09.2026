Main = {}
picked = 0


ESX.RegisterServerCallback('bbv-atmaddmoney', function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if not Player then return end
    if picked > 3 then return end -- anti exploit
    picked = picked + 1
    Player.addMoney(Config.Settings.Reward)
end)

ESX.RegisterServerCallback('bbv-atm:cooldown', function(source, cb)
    if not cooldown then 
        cb(false)
    else
        cb(true)
    end
    Main:Cooldown()
end)

function Main:Cooldown()
    if cooldown then return end 
    cooldown = true
    Wait(Config.Settings.Cooldown * 60000)
    cooldown = false
    picked = 0
end