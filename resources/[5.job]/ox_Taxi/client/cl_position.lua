CreateThread(function()
    for i = 1, #Config.TaxiPatron do
        exports.qtarget:AddBoxZone(i .. "_taxipatron_menu", Config.TaxiPatron[i].coords, 1.0, 1.0, {
            name = i .. "_taxipatron_menu",
            heading = Config.TaxiPatron[i].heading,
            debugPoly = false,
            minZ = Config.TaxiPatron[i].coords.z - 1.5,
            maxZ = Config.TaxiPatron[i].coords.z + 1.5
        }, {
            options = {
                {
                    event = 'menupatrontaxi',
                    icon = Config.TaxiPatron[i].icon,
                    label = Config.TaxiPatron[i].labeltarget,
                    job = "taxi",
                }
            },
            distance = 1.5
        })
    end
end) 

CreateThread(function()
    for i = 1, #Config.TaxiCoffre do
        exports.qtarget:AddBoxZone(i .. "_taxicoffre_menu", Config.TaxiCoffre[i].coords, 1.0, 1.0, {
            name = i .. "_taxicoffre_menu",
            heading = Config.TaxiCoffre[i].heading,
            debugPoly = false,
            minZ = Config.TaxiCoffre[i].coords.z - 1.5,
            maxZ = Config.TaxiCoffre[i].coords.z + 1.5
        }, {
            options = {
                {
                    event = 'coffretaxi',
                    icon = Config.TaxiCoffre[i].icon,
                    label = Config.TaxiCoffre[i].labeltarget,
                    job = "taxi",
                }
            },
            distance = 1.5
        })
    end
end) 

CreateThread(function()
    for i = 1, #Config.TaxiVetement do
        exports.qtarget:AddBoxZone(i .. "_taxivetement_menu", Config.TaxiVetement[i].coords, 1.0, 1.0, {
            name = i .. "_taxivetement_menu",
            heading = Config.TaxiVetement[i].heading,
            debugPoly = false,
            minZ = Config.TaxiVetement[i].coords.z - 1.5,
            maxZ = Config.TaxiVetement[i].coords.z + 1.5
        }, {
            options = {
                {
                    event = 'taxivetement',
                    icon = Config.TaxiVetement[i].icon,
                    label = Config.TaxiVetement[i].labeltarget,
                    job = "taxi",
                }
            },
            distance = 1.5
        })
    end
end) 

CreateThread(function()
    for i = 1, #Config.TaxiGarage do
        exports.qtarget:AddBoxZone(i .. "_taxigarage_menu", Config.TaxiGarage[i].coords, 1.0, 1.0, {
            name = i .. "_taxigarage_menu",
            heading = Config.TaxiGarage[i].heading,
            debugPoly = false,
            minZ = Config.TaxiGarage[i].coords.z - 1.5,
            maxZ = Config.TaxiGarage[i].coords.z + 1.5
        }, {
            options = {
                {
                    event = 'taxi:opentaxigarage',
                    icon = Config.TaxiGarage[i].icon,
                    label = Config.TaxiGarage[i].labeltarget,
                    job = "taxi",
                }
            },
            distance = 1.5
        })
    end
end) 