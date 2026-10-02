

CreateThread(function()
    for i=1, #Config.Lavage do
        exports.qtarget:AddBoxZone(i.."_lavage_menu", Config.Lavage[i].coords, 1.0, 1.0, {
            name=i.."_lavage_menu",
            heading=Config.Lavage[i].heading,
            debugPoly=false,
            minZ=Config.Lavage[i].coords.z-1.5,
            maxZ=Config.Lavage[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:lavage',
                    icon = Config.Lavage[i].icon,
                    label = Config.Lavage[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Cuisson do
        exports.qtarget:AddBoxZone(i.."_cuisson_menu", Config.Cuisson[i].coords, 1.0, 1.0, {
            name=i.."_cuisson_menu",
            heading=Config.Cuisson[i].heading,
            debugPoly=false,
            minZ=Config.Cuisson[i].coords.z-1.5,
            maxZ=Config.Cuisson[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:cuisson',
                    icon = Config.Cuisson[i].icon,
                    label = Config.Cuisson[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Friteuse do
        exports.qtarget:AddBoxZone(i.."_friteuse_menu", Config.Friteuse[i].coords, 1.0, 1.0, {
            name=i.."_friteuse_menu",
            heading=Config.Friteuse[i].heading,
            debugPoly=false,
            minZ=Config.Friteuse[i].coords.z-1.5,
            maxZ=Config.Friteuse[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:friteuse',
                    icon = Config.Friteuse[i].icon,
                    label = Config.Friteuse[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Boisson do
        exports.qtarget:AddBoxZone(i.."_boisson_menu", Config.Boisson[i].coords, 1.0, 1.0, {
            name=i.."_boisson_menu",
            heading=Config.Boisson[i].heading,
            debugPoly=false,
            minZ=Config.Boisson[i].coords.z-1.5,
            maxZ=Config.Boisson[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:boisson',
                    icon = Config.Boisson[i].icon,
                    label = Config.Boisson[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable2 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable2[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable2[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable2[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable2[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable3 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable3[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable3[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable3[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable3[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable4 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable4[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable4[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable4[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable4[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable5 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable5[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable5[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable5[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable5[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable6 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable6[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable6[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable6[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable6[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable7 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable7[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable7[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable7[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable7[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable8 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable8[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable8[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable8[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable8[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable9 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable9[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable9[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable9[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable9[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable10 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable10[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable10[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable10[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable10[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.WashingTable11 do
        exports.qtarget:AddBoxZone(i.."_washingtable_menu", Tablecoords.WashingTable11[i].coords, 1.0, 1.0, {
            name=i.."_washingtable_menu",
            heading=Tablecoords.WashingTable11[i].heading,
            debugPoly=false,
            minZ=Tablecoords.WashingTable11[i].coords.z-1.5,
            maxZ=Tablecoords.WashingTable11[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:table',
                    icon = Config.WashingTable[i].icon,
                    label = Config.WashingTable[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Plancher do
        exports.qtarget:AddBoxZone(i.."_washingfloor_menu", Tablecoords.Plancher[i].coords, 1.0, 1.0, {
            name=i.."_washingfloor_menu",
            heading=Tablecoords.Plancher[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Plancher[i].coords.z-1.5,
            maxZ=Tablecoords.Plancher[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:floor',
                    icon = Config.Plancher[i].icon,
                    label = Config.Plancher[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Plancher2 do
        exports.qtarget:AddBoxZone(i.."_washingfloor_menu", Tablecoords.Plancher2[i].coords, 1.0, 1.0, {
            name=i.."_washingfloor_menu",
            heading=Tablecoords.Plancher2[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Plancher2[i].coords.z-1.5,
            maxZ=Tablecoords.Plancher2[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'washing:floor',
                    icon = Config.Plancher[i].icon,
                    label = Config.Plancher[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Toilet do
        exports.qtarget:AddBoxZone(i.."_toilet_menu", Tablecoords.Toilet[i].coords, 1.0, 1.0, {
            name=i.."_toilet_menu",
            heading=Tablecoords.Toilet[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Toilet[i].coords.z-1.5,
            maxZ=Tablecoords.Toilet[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:toilet',
                    icon = Config.Toilet[i].icon,
                    label = Config.Toilet[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Toiletfille do
        exports.qtarget:AddBoxZone(i.."_toilet_menu", Tablecoords.Toiletfille[i].coords, 1.0, 1.0, {
            name=i.."_toilet_menu",
            heading=Tablecoords.Toiletfille[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Toiletfille[i].coords.z-1.5,
            maxZ=Tablecoords.Toiletfille[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:toiletfille',
                    icon = Config.Toilet[i].icon,
                    label = Config.Toilet[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Washingface do
        exports.qtarget:AddBoxZone(i.."_toilet_menu", Tablecoords.Washingface[i].coords, 1.0, 1.0, {
            name=i.."_toilet_menu",
            heading=Tablecoords.Washingface[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Washingface[i].coords.z-1.5,
            maxZ=Tablecoords.Washingface[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:washingface',
                    icon = Config.Washingface[i].icon,
                    label = Config.Washingface[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Washingface2 do
        exports.qtarget:AddBoxZone(i.."_toilet_menu", Tablecoords.Washingface2[i].coords, 1.0, 1.0, {
            name=i.."_toilet_menu",
            heading=Tablecoords.Washingface2[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Washingface2[i].coords.z-1.5,
            maxZ=Tablecoords.Washingface2[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:washingface',
                    icon = Config.Washingface[i].icon,
                    label = Config.Washingface[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Trash do
        exports.qtarget:AddBoxZone(i.."_trash_menu", Tablecoords.Trash[i].coords, 1.0, 1.0, {
            name=i.."_trash_menu",
            heading=Tablecoords.Trash[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Trash[i].coords.z-1.5,
            maxZ=Tablecoords.Trash[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:trash',
                    icon = Config.Trash[i].icon,
                    label = Config.Trash[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Trash2 do
        exports.qtarget:AddBoxZone(i.."_trash_menu", Tablecoords.Trash2[i].coords, 1.0, 1.0, {
            name=i.."_trash_menu",
            heading=Tablecoords.Trash2[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Trash2[i].coords.z-1.5,
            maxZ=Tablecoords.Trash2[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:trash',
                    icon = Config.Trash[i].icon,
                    label = Config.Trash[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Garage do
        exports.qtarget:AddBoxZone(i.."_garage_menu", Config.Garage[i].coords, 1.0, 1.0, {
            name=i.."_garage_menu",
            heading=Config.Garage[i].heading,
            debugPoly=false,
            minZ=Config.Garage[i].coords.z-1.5,
            maxZ=Config.Garage[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'burgershot:openburgershotgarage',
                    icon = Config.Garage[i].icon,
                    label = Config.Garage[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Legumes do
        exports.qtarget:AddBoxZone(i.."_cuisson_menu", Config.Legumes[i].coords, 1.0, 1.0, {
            name=i.."_cuisson_menu",
            heading=Config.Legumes[i].heading,
            debugPoly=false,
            minZ=Config.Legumes[i].coords.z-1.5,
            maxZ=Config.Legumes[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:legume',
                    icon = Config.Legumes[i].icon,
                    label = Config.Legumes[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Bossmenu do
        exports.qtarget:AddBoxZone(i.."_boisson_menu", Config.Bossmenu[i].coords, 1.0, 1.0, {
            name=i.."_boisson_menu",
            heading=Config.Bossmenu[i].heading,
            debugPoly=false,
            minZ=Config.Bossmenu[i].coords.z-1.5,
            maxZ=Config.Bossmenu[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:bossmenu',
                    icon = Config.Bossmenu[i].icon,
                    label = Config.Bossmenu[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.StashBurgershot do
        exports.qtarget:AddBoxZone(i.."_stash_menu", Config.StashBurgershot[i].coords, 1.0, 1.0, {
            name=i.."_stash_menu",
            heading=Config.StashBurgershot[i].heading,
            debugPoly=false,
            minZ=Config.StashBurgershot[i].coords.z-1.5,
            maxZ=Config.StashBurgershot[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:stash',
                    icon = Config.StashBurgershot[i].icon,
                    label = Config.StashBurgershot[i].labeltarget,
                    job = "burgershot",
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Commands do
        exports.qtarget:AddBoxZone(i.."_commands_menu", Config.Commands[i].coords, 1.0, 1.0, {
            name=i.."_commands_menu",
            heading=Config.Commands[i].heading,
            debugPoly=false,
            minZ=Config.Commands[i].coords.z-1.5,
            maxZ=Config.Commands[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:commands',
                    icon = Config.Commands[i].icon,
                    label = Config.Commands[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Commands2 do
        exports.qtarget:AddBoxZone(i.."_commands_menu", Tablecoords.Commands2[i].coords, 1.0, 1.0, {
            name=i.."_commands_menu",
            heading=Tablecoords.Commands2[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Commands2[i].coords.z-1.5,
            maxZ=Tablecoords.Commands2[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:commands2',
                    icon = Config.Commands[i].icon,
                    label = Config.Commands[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Commands3 do
        exports.qtarget:AddBoxZone(i.."_commands_menu", Tablecoords.Commands3[i].coords, 1.0, 1.0, {
            name=i.."_commands_menu",
            heading=Tablecoords.Commands3[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Commands3[i].coords.z-1.5,
            maxZ=Tablecoords.Commands3[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:commands3',
                    icon = Config.Commands[i].icon,
                    label = Config.Commands[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Commands4 do
        exports.qtarget:AddBoxZone(i.."_commands_menu", Tablecoords.Commands4[i].coords, 1.0, 1.0, {
            name=i.."_commands_menu",
            heading=Tablecoords.Commands4[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Commands4[i].coords.z-1.5,
            maxZ=Tablecoords.Commands4[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'nsx:commands4',
                    icon = Config.Commands[i].icon,
                    label = Config.Commands[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Config.Billing do
        exports.qtarget:AddBoxZone(i.."_billing_menu", Config.Billing[i].coords, 1.0, 1.0, {
            name=i.."_billing_menu",
            heading=Config.Billing[i].heading,
            debugPoly=false,
            minZ=Config.Billing[i].coords.z-1.5,
            maxZ=Config.Billing[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'burgershot:sendbill',
                    icon = Config.Billing[i].icon,
                    job = 'burgershot',
                    label = Config.Billing[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Billing2 do
        exports.qtarget:AddBoxZone(i.."_billing_menu", Tablecoords.Billing2[i].coords, 1.0, 1.0, {
            name=i.."_billing_menu",
            heading=Tablecoords.Billing2[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Billing2[i].coords.z-1.5,
            maxZ=Tablecoords.Billing2[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'burgershot:sendbill',
                    icon = Config.Billing[i].icon,
                    job = 'burgershot',
                    label = Config.Billing[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Billing3 do
        exports.qtarget:AddBoxZone(i.."_billing_menu", Tablecoords.Billing3[i].coords, 1.0, 1.0, {
            name=i.."_billing_menu",
            heading=Tablecoords.Billing3[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Billing3[i].coords.z-1.5,
            maxZ=Tablecoords.Billing3[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'burgershot:sendbill',
                    icon = Config.Billing[i].icon,
                    job = 'burgershot',
                    label = Config.Billing[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i=1, #Tablecoords.Billing4 do
        exports.qtarget:AddBoxZone(i.."_billing_menu", Tablecoords.Billing4[i].coords, 1.0, 1.0, {
            name=i.."_billing_menu",
            heading=Tablecoords.Billing4[i].heading,
            debugPoly=false,
            minZ=Tablecoords.Billing4[i].coords.z-1.5,
            maxZ=Tablecoords.Billing4[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'burgershot:sendbill',
                    icon = Config.Billing[i].icon,
                    job = 'burgershot',
                    label = Config.Billing[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for i = 1, #Config.OfflineStore do
        exports.qtarget:AddBoxZone(i .. "_offlinestore_menu", Config.OfflineStore[i].coords, 1.0, 1.0, {
            name = i .. "_offlinestore_menu",
            heading = Config.OfflineStore[i].heading,
            debugPoly = false,
            minZ = Config.OfflineStore[i].coords.z - 1.5,
            maxZ = Config.OfflineStore[i].coords.z + 1.5
        }, {
            options = {
                {
                    event = 'nsx:offlinestore',
                    icon = Config.OfflineStore[i].icon,
                    label = Config.OfflineStore[i].labeltarget,
                }
            },
            distance = 1.5
        })
    end
end)