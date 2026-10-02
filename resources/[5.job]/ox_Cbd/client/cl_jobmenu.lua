local enService = true -- Variable pour suivre l'état du service
local group = GetPlayerGroup(player)

-- Fonction pour vérifier si le joueur est en service
function EstEnService()
    return enService
end

lib.registerContext({
    id = 'cbdjob',
    title = 'Cbd',
    options = {
        {
            title = 'Prendre son service',
            event = 'CbdServiceON'
        },
        {
            title = 'Prendre sa fin de service',
            event = 'CbdServiceOFF'
        },
    }
})

lib.registerContext({
    id = 'patroncbdmenu',
    title = 'Cbd',
    options = {
        {
            title = 'Gestion de l\'entreprise',
            event = 'nsx:ActionsPatron'
        },
     
    }
})



RegisterCommand("cbd", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cbd' and not ESX.PlayerData.dead and ESX.PlayerData.job.grade == 4 then
         lib.showContext("patroncbdmenu")
    end
end)
    
RegisterKeyMapping("cbd", "Cbd | Actions Patron", "keyboard", "F6")

RegisterNetEvent('nsx:ServiceMenu')
AddEventHandler('nsx:ServiceMenu', function()
    lib.showContext("cbdjob")
end)

exports.qtarget:AddBoxZone("Service", vector3(187.46716308594, -243.37300109863, 54.070526123047), 2.4, 1, {
    name = "Service",       
    heading = 228,
    debugPoly = false,
    minZ = 2.98,
    maxZ = 5.98,
}, {
    options = {
        {
            event = "nsx:ServiceMenu",
            label = "Prendre s ont service ",
            job = "cbd",
        },
    },
    distance = 2.5
})

RegisterNetEvent('CbdServiceON')
AddEventHandler('CbdServiceON', function()
            enService = true
            lib.notify({
                title = 'Cbd',
                description = 'Prise de service',
                position = 'top',
                style = {
                    backgroundColor = '#021726',
                    color = '#3DB3FF',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'circle-check',
                iconColor = '#3DB3FF'
            })
    end)

RegisterNetEvent('CbdServiceOFF')
AddEventHandler('CbdServiceOFF', function()
    enService = false
    local randomNumber = math.random()
    if randomNumber <= 0.6 then
        lib.notify({
            title = 'Cbd',
            description = 'Fin de service, vous avez le droit à un repos bien mérité !',
            position = 'top',
            style = {
                backgroundColor = '#021726',
                color = '#3DB3FF',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'circle-check',
            iconColor = '#3DB3FF'
        })
    else
        lib.notify({
            title = 'Cbd',
            description = 'Fin de service, vous avez déjà fait mieux mais vous avez quand même le droit à un repos bien mérité !',
            position = 'top',
            style = {
                backgroundColor = '#021726',
                color = '#3DB3FF',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'circle-check',
            iconColor = '#3DB3FF'
        })
    end
end)