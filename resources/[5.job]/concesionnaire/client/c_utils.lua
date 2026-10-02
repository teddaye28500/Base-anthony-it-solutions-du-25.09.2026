Oliann = {}

function Oliann.PlayAnim(dict, anim, wait)
    Oliann.LoadAnimDict(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(wait)
    ClearPedSecondaryTask(PlayerPedId()) 
end

function Oliann.LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end