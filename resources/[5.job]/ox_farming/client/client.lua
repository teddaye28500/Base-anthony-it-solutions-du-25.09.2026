local ESX = exports["es_extended"]:getSharedObject()

--------------------------------- Target ---------------------------------

local Target = exports.ox_target


--------------------------------- Notifications ---------------------------------

RegisterNetEvent('esx-farming:client:notify')
AddEventHandler('esx-farming:client:notify', function(title, description, position, typeM)
    lib.notify({
        title = title,
        description = description,
        position = position,
        type = typeM
    })
end)


--------------------------------- Progresbarr ---------------------------------

RegisterNetEvent('esx-farmming:client:progressbar')
AddEventHandler('esx-farmming:client:progressbar', function(duration, position, label, useWhileDead, canCancel, move, car, dict, clip)
    lib.progressCircle({
        duration = duration,
        position = position,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        disable = {
            move = move,
            car = car,
        },
        anim = {
            dict =  dict,
            clip = clip
        },
    })
end)

--------------------------------- Progresbarr Vente et Processus ---------------------------------

RegisterNetEvent('esx-farmming:client:progressbarSellPros')
AddEventHandler('esx-farmming:client:progressbarSellPros', function(duration, position, label, useWhileDead, canCancel, move, car, dict, clip, model, pos, rot)
    lib.progressCircle({
        duration = duration,
        position = position,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        disable = {
            move = move,
            car = car,
        },
        anim = {
            dict =  dict,
            clip = clip
        },
        prop = {
            model = model,
            pos = pos,
            rot = rot
        },
    })
end)

--------------------------------- Peds ---------------------------------

Citizen.CreateThread(function()
    for k, v in pairs(Config.PedLocation) do
    local modelHash = GetHashKey(v.model)
    RequestModel(modelHash) 
    while ( not HasModelLoaded(modelHash) ) do
        Wait(1)
    end
    local ped = CreatePed(1, modelHash, v.coords, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true) 
    TaskStartScenarioInPlace(ped, v.scenario, -1, true) 
    FreezeEntityPosition(ped, true)
    end
end)

if Config.UseBlips then
    Citizen.CreateThread(function()

      -------- Blips --------

        for k, v in pairs(Config.Allblips) do
            local AllBlip = AddBlipForCoord(v.coords)
            SetBlipSprite(AllBlip, v.SetBlipSprite)
            SetBlipDisplay(AllBlip, v.SetBlipDisplay)
            SetBlipScale(AllBlip, v.SetBlipScale)
            SetBlipColour(AllBlip, v.SetBlipColour)
            SetBlipAsShortRange(AllBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.BlipName)
            EndTextCommandSetBlipName(AllBlip)
        end

        -------- Tomates --------

        for _, v in pairs(Config.TomatoFields) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z),
                size = v.size,
                rotation = v.heading,
                debugPoly = drawZones,
                options = {
                    {
                    name = 'Ramasser Tomates',
                    event = "esx-farming:client:StartfarmTomato",
                    icon = "fa fa-sign-language",
                    label = Config.Label["PickTomato"],
                    }
                } 
            })
        end

        -------- Mangues --------

        for _, v in pairs(Config.MangoFields) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z),
                size = v.size,
                rotation = v.heading,
                debugPoly = drawZones,
                options = {
                    {
                    name = 'Ramasser Mangues',
                    event = "esx-farming:client:StartfarmMango",
                    icon = "fa fa-sign-language",
                    label = Config.Label["PickMango"],
                    }
                } 
            })
        end

        -------- Oranges --------

        for _, v in pairs(Config.OrangeFields) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z),
                size = v.size,
                rotation = v.heading,
                debugPoly = drawZones,
                options = {
                    {
                    name = 'Ramasser Oranges',
                    event = "esx-farming:client:StartfarmOrange",
                    icon = "fa fa-sign-language",
                    label = Config.Label["PickOrange"],
                    }
                } 
            })
        end

        -------- Pommes --------

        for _, v in pairs(Config.AppleFields) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z),
                size = v.size,
                rotation = v.heading,
                debugPoly = drawZones,
                options = {
                    {
                    name = 'Ramasser Pommes',
                    event = "esx-farming:client:StartfarmApple",
                    icon = "fa fa-sign-language",
                    label = Config.Label["PickApple"],
                    }
                } 
            })
        end

        -------- Goyaves --------

        for _, v in pairs(Config.GauvaFields) do
            exports.ox_target:addBoxZone({
                coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z),
                size = v.size,
                rotation = v.heading,
                debugPoly = drawZones,
                options = {
                    {
                    name = 'Ramasser Goyaves',
                    event = "esx-farming:client:StartfarmGauva",
                    icon = "fa fa-sign-language",
                    label = Config.Label["PickGauva"],
                    }
                } 
            })
        end

        exports.ox_target:addBoxZone({
            coords = vec3(2310.5981, 4885.0073, 42.0),
            size = vec3(.5, .5, 2),
            rotation = 325,
            debug = false,
            options = {
                {
                    name = 'Vendre Fruits',
                    event = 'esx-farming:client:SellFood',
                    icon = "fa-solid fa-money-bill-wave",
                    label = Config.Label["Food"],
                },
                {
                    name = 'Traitements Tomates',
                    event = 'esx-farming:client:FooodProcess',
                    icon = 'fa-solid fa-chalkboard-user',
                    label = Config.Label["ProcessFood"],
                },

            }
        })

        exports.ox_target:addBoxZone({
            coords = vec3(84.04, 190.71, 105.26),
            size = vec3(.5, .5, 2),
            rotation = 340,
            debug = false,
            options = {
                {
                    name = 'Vendre Produits',
                    event = 'esx-farming:client:SellProduct',
                    icon = "fa-solid fa-money-bill-wave",
                    label = Config.Label["SellProduct"],
                },
            }
        })
    end)
end

----------------------------------- Menu Vendre ---------------------------------

 RegisterNetEvent('esx-farming:client:SellFood')
 AddEventHandler('esx-farming:client:SellFood', function(src)
     lib.registerContext({
         id = 'sell_food',
         title = 'Vendres Produits',
         options = {
            {
                 icon = "fa-regular fa-money-bill-1",
                 title = 'Vendres Tomates',
                 description = 'Tomates',
                 image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335353066594365/tomato.png",
                 args = 1,
                 event = 'esx-farming:client:Sell',
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendres Mangues',
                description = 'Mangues',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335400642584626/mango.png",
                args = 2,
                event = 'esx-farming:client:Sell',
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendres Oranges',
                description = 'Oranges',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335401762471967/orange.png",
                args = 3,
                event = 'esx-farming:client:Sell',
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendres Pommes',
                description = 'Pommes',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335352148037732/apple.png",
                args = 4,
                event = 'esx-farming:client:Sell',
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendres Goyaves',
                description = 'Goyaves',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335883750903808/gauva.png",
                args = 5,
                event = 'esx-farming:client:Sell',
            },  
         },
     })
     lib.showContext('sell_food')
 end)


------------------------------------- Menu Cuisine -----------------------------------

 RegisterNetEvent('esx-farming:client:FooodProcess')
 AddEventHandler('esx-farming:client:FooodProcess', function(src)
     lib.registerContext({
         id = 'proccess_food',
         title = 'Traitements Des Fruits',
         options = {
             {
                 icon = "fa-solid fa-clipboard",
                 title = 'Traitements Tomates',
                 description = 'Tomates',
                 image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335353066594365/tomato.png",
                 event = 'esx-farming:client:TomatoProces',
             },  
             {
                icon = "fa-solid fa-clipboard",
                title = 'Traitements Mangues',
                description = 'Mangues',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335400642584626/mango.png",
                event = 'esx-farming:client:MangoProces',
            },  
            {
                icon = "fa-solid fa-clipboard",
                title = 'Traitements Oranges',
                description = 'Oranges',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335401762471967/orange.png",
                event = 'esx-farming:client:OrangeProces',
            },  
            {
                icon = "fa-solid fa-clipboard",
                title = 'Traitements Pommes',
                description = 'Pommes',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335352148037732/apple.png",
                event = 'esx-farming:client:AppleProces',
            },
            {
                icon = "fa-solid fa-clipboard",
                title = 'Traitements Goyaves',
                description = 'Goyaves',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335883750903808/gauva.png",
                event = 'esx-farming:client:GauvaProces',
            },
         }
     })
     lib.showContext('proccess_food')
 end)

 ----------------------------------- Tomates -----------------------------------

 RegisterNetEvent('esx-farming:client:TomatoProces')
 AddEventHandler('esx-farming:client:TomatoProces', function(src)
     lib.registerContext({
         id = 'proccess_tomato',
         title = 'Traitements Tomates',
         options = {
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Ketchup',
                description = 'Ketchup',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335353364385832/tomato_ketchup.png",
                args = 1,
                event = "esx-farming:client:StartTomatoProduct",
                metadata = {
                    {label = 'Tomato', value = 5},
                },
             },  
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Purée de tomate',
                description = 'Purée de tomate',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335351757971477/tomato_paste.png",
                args = 2,
                event = "esx-farming:client:StartTomatoProduct",
                metadata = {
                    {label = 'Tomato', value = 10},
                },
             },  
             {
                 title = '< Back',
                 event = "esx-farming:client:FooodProcess",
             }
         },
     })
     lib.showContext('proccess_tomato')
end)

----------------------------------- Mangues -----------------------------------

RegisterNetEvent('esx-farming:client:MangoProces')
AddEventHandler('esx-farming:client:MangoProces', function(src)
     lib.registerContext({
         id = 'proccess_mango',
         title = 'Traitements Mangues',
         options = {
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Jus De Mangues',
                description = 'Jus De Mangues',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335400986513489/mangojuice.png",
                args = 1,
                event = "esx-farming:client:StartMangoProduct",
                metadata = {
                    {label = 'Mango', value = 10},
                },
             },  
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Alcool De Mangues',
                description = 'Alcool De Mangues',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335401380782080/mangowine.png",
                args = 2,
                event = "esx-farming:client:StartMangoProduct",
                metadata = {
                    {label = 'Mango', value = 25},
                },
             },  
             {
                 title = '< Back',
                 event = "esx-farming:client:FooodProcess",
             }
         },
     })
     lib.showContext('proccess_mango')
end)

----------------------------------- Oranges -----------------------------------

RegisterNetEvent('esx-farming:client:OrangeProces')
AddEventHandler('esx-farming:client:OrangeProces', function(src)
     lib.registerContext({
         id = 'proccess_orange',
         title = 'Traitements Oranges',
         options = {
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Jus D Oranges',
                description = 'Jus D Oranges',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335402118979664/orangejuice.png",
                args = 1,
                event = "esx-farming:client:StartOrangeProduct",
                metadata = {
                    {label = 'Orange', value = 10},
                },
             },  
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Alcool D Oranges',
                description = 'Alcool D Oranges',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335403230478468/orangewine.png",
                args = 2,
                event = "esx-farming:client:StartOrangeProduct",
                metadata = {
                    {label = 'Orange', value = 25},
                },
             },  
             {
                 title = '< Back',
                 event = "esx-farming:client:FooodProcess",
             }
         },
     })
     lib.showContext('proccess_orange')
end)

----------------------------------- Pommes -----------------------------------

RegisterNetEvent('esx-farming:client:AppleProces')
AddEventHandler('esx-farming:client:AppleProces', function(src)
     lib.registerContext({
         id = 'proccess_apple',
         title = 'Traitements Pommes',
         options = {
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Jus de Pommes',
                description = 'Jus de Pommes',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335352420671631/applejuice.png",
                args = 1,
                event = "esx-farming:client:StartAppleProduct",
                metadata = {
                    {label = 'Apple', value = 10},
                },
             },  
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Cidres',
                description = 'Cidres',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335352739434496/applewine.png",
                args = 2,
                event = "esx-farming:client:StartAppleProduct",
                metadata = {
                    {label = 'Apple', value = 25},
                },
             },  
             {
                 title = '< Back',
                 event = "esx-farming:client:FooodProcess",
             }
         },
     })
     lib.showContext('proccess_apple')
end)

----------------------------------- Goyaves -----------------------------------

RegisterNetEvent('esx-farming:client:GauvaProces')
AddEventHandler('esx-farming:client:GauvaProces', function(src)
     lib.registerContext({
         id = 'proccess_gauva',
         title = 'Traitements Goyaves',
         options = {
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Jus De Goyaves',
                description = 'Jus De Goyaves',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335399954714794/guavajuice.png",
                args = 1,
                event = "esx-farming:client:StartGauvaProduct",
                metadata = {
                    {label = 'Gauva', value = 10},
                },
             },  
             {
                icon = "fa-solid fa-cubes-stacked",
                title = 'Fabriquer Alcool De Goyaves',
                description = 'Alcool De Goyaves',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335400315437106/guavawine.png",
                args = 2,
                event = "esx-farming:client:StartGauvaProduct",
                metadata = {
                    {label = 'Gauva', value = 25},
                },
             },  
             {
                 title = '< Back',
                 event = "esx-farming:client:FooodProcess",
             }
         },
     })
     lib.showContext('proccess_gauva')
end)

----------------------------------- Menu Vendre Produits -----------------------------------

 RegisterNetEvent('esx-farming:client:SellProduct')
 AddEventHandler('esx-farming:client:SellProduct', function(src)
     lib.registerContext({
         id = 'sell_product',
         title = 'Vendre Produits',
         options = {
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre un produit à base de tomates',
                description = 'Produit à base de tomates',
                event = "esx-farming:client:SellTomatoProduct",
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre un produit à base de Mangues',
                description = 'Produit à base de Mangues',
                event = "esx-farming:client:SellMangoProduct",
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre un produit à base d Orange',
                description = 'Produit à base d Orange',
                event = "esx-farming:client:SellOrangeProduct",
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre un produit à base de Pommes',
                description = 'Produit à base de Pommes',
                event = "esx-farming:client:SellAppleProduct",
            },  
            {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre un produit à base de Goyaves',
                description = 'Produit à base de Goyaves',
                event = "esx-farming:client:SellGauvaProduct",
            },  
         },
     })
     lib.showContext('sell_product')
 end)

----------------------------------- Menu Vendre Produit Base de Tomates -----------------------------------

 RegisterNetEvent('esx-farming:client:SellTomatoProduct')
 AddEventHandler('esx-farming:client:SellTomatoProduct', function(src)
     lib.registerContext({
         id = 'sell_product_tomato',
         title = 'Vendre un produit à base de tomates',
         options = {
             {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre Ketchup',
                description = 'Ketchup',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335353364385832/tomato_ketchup.png",
                args = 1,
                event = "esx-farming:client:StartSellTomatoProduct",
             },  
             {
                icon = "fa-regular fa-money-bill-1",
                title = 'Vendre Purée de Tomate',
                description = 'Purée de Tomate',
                image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335351757971477/tomato_paste.png",
                args = 2,
                event = "esx-farming:client:StartSellTomatoProduct",
             },  
             {
                title = '< Back',
                event = "esx-farming:client:SellProduct",
            }
         },
     })
     lib.showContext('sell_product_tomato')
 end)

----------------------------------- Menu Vendre Produit Mangues -----------------------------------

RegisterNetEvent('esx-farming:client:SellMangoProduct')
AddEventHandler('esx-farming:client:SellMangoProduct', function(src)
    lib.registerContext({
        id = 'sell_product_mango',
        title = 'Vendre un produit à base de Mangues',
        options = {
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre jus de mangues',
               description = 'Jus de mangues',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335400986513489/mangojuice.png",
               args = 1,
               event = "esx-farming:client:StartSellMangoProduct",
            },  
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Alcool de Mangues',
               description = 'Alcool de Mangues',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335401380782080/mangowine.png",
               args = 2,
               event = "esx-farming:client:StartSellMangoProduct",
            },  
            {
               title = '< Back',
               event = "esx-farming:client:SellProduct",
           }
        },
    })
    lib.showContext('sell_product_mango')
end)

----------------------------------- Menu Vendre Produit Oranges -----------------------------------

RegisterNetEvent('esx-farming:client:SellOrangeProduct')
AddEventHandler('esx-farming:client:SellOrangeProduct', function(src)
    lib.registerContext({
        id = 'sell_product_orange',
        title = 'Vendre un produit à base d Orange',
        options = {
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Jus D Orange',
               description = 'Jus D Orange',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335402118979664/orangejuice.png",
               args = 1,
               event = "esx-farming:client:StartSellOrangeProduct",
            },  
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Alcool D Orange',
               description = 'Alcool D Orange',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335403230478468/orangewine.png",
               args = 2,
               event = "esx-farming:client:StartSellOrangeProduct",
            },  
            {
               title = '< Back',
               event = "esx-farming:client:SellProduct",
           }
        },
    })
    lib.showContext('sell_product_orange')
end)

----------------------------------- Menu Vendre Produit pommes -----------------------------------

RegisterNetEvent('esx-farming:client:SellAppleProduct')
AddEventHandler('esx-farming:client:SellAppleProduct', function(src)
    lib.registerContext({
        id = 'sell_product_apple',
        title = 'Vendre un produit à base de Pommes',
        options = {
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Jus De Pommes',
               description = 'Jus De Pommes',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335352420671631/applejuice.png",
               args = 1,
               event = "esx-farming:client:StartSellAppleProduct",
            },  
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Cidres',
               description = 'Cidres',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335352739434496/applewine.png",
               args = 2,
               event = "esx-farming:client:StartSellAppleProduct",
            },  
            {
               title = '< Back',
               event = "esx-farming:client:SellProduct",
           }
        },
    })
    lib.showContext('sell_product_apple')
end)

----------------------------------- Menu Vendre Produit Goyaves -----------------------------------

RegisterNetEvent('esx-farming:client:SellGauvaProduct')
AddEventHandler('esx-farming:client:SellGauvaProduct', function(src)
    lib.registerContext({
        id = 'sell_product_gauva',
        title = 'Vendre un produit à base de Goyaves',
        options = {
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Jus de Goyaves',
               description = 'Jus de Goyaves',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335399954714794/guavajuice.png",
               args = 1,
               event = "esx-farming:client:StartSellGauvaProduct",
            },  
            {
               icon = "fa-regular fa-money-bill-1",
               title = 'Vendre Alcool de Goyaves',
               description = 'Alcool de Goyaves',
               image = "https://cdn.discordapp.com/attachments/1090026904326783039/1107335400315437106/guavawine.png",
               args = 2,
               event = "esx-farming:client:StartSellGauvaProduct",
            },  
            {
               title = '< Back',
               event = "esx-farming:client:SellProduct",
           }
        },
    })
    lib.showContext('sell_product_gauva')
end)


----------------------------------- Commencer à cueillir des tomates -----------------------------------

RegisterNetEvent('esx-farming:client:StartfarmTomato')
AddEventHandler('esx-farming:client:StartfarmTomato', function(args)
    TriggerEvent('esx-farmming:client:progressbar', 3000, 'bottom', Config.Label["PickTomato"], false, true, true, true, 'missmechanic', 'work_base')
    Wait(3000)
    TriggerServerEvent('esx-farming:server:TomatoRewards', src)
end)

----------------------------------- Vendre -----------------------------------

RegisterNetEvent('esx-farming:client:Sell')
AddEventHandler('esx-farming:client:Sell', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:SellInfoTomato', function(Tomato)
            if Tomato then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 3000, 'bottom', Config.Label["SellTomato"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(3000)
                TriggerServerEvent('esx-farming:server:TomatoSellRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Dont Have Tomato', 'Tomato', 'center-right', 'error')
            end
        end)
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:SellInfoMango', function(Mango)
            if Mango then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 3000, 'bottom', Config.Label["SellMango"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(3000)
                TriggerServerEvent('esx-farming:server:MangoSellRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Dont Have Mango', 'Mango', 'center-right', 'error')
            end
        end)
    elseif args == 3 then
        ESX.TriggerServerCallback('esx-farming:server:SellInfoOrange', function(Orange)
            if Orange then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 3000, 'bottom', Config.Label["SellOrange"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(3000)
                TriggerServerEvent('esx-farming:server:OrangeSellRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Dont Have Orange', 'Orange', 'center-right', 'error')
            end
        end)
    elseif args == 4 then
        ESX.TriggerServerCallback('esx-farming:server:SellInfoApple', function(Apple)
            if Apple then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 3000, 'bottom', Config.Label["SellApple"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(3000)
                TriggerServerEvent('esx-farming:server:AppleSellRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Dont Have Apple', 'Apple', 'center-right', 'error')
            end
        end)
    elseif args == 5 then
        ESX.TriggerServerCallback('esx-farming:server:SellInfoGauva', function(Guava)
            if Guava then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 3000, 'bottom', Config.Label["SellApple"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(3000)
                TriggerServerEvent('esx-farming:server:GauvaSellRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Dont Have Gauva', 'Guava', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Traitements Tomates -----------------------------------

RegisterNetEvent('esx-farming:client:StartTomatoProduct')
AddEventHandler('esx-farming:client:StartTomatoProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:TomatoKetchupInfo', function(Tomato)
            if Tomato then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeTomatoKetchup"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:TomatoKetchupRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Tomato 5', 'Tomato Ketchup', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:TomatoPasteInfo', function(Tomato)
            if Tomato then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeTomatoPaste"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:TomatoPasteRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Tomato 10', 'Tomato Paste', 'center-right', 'error')
            end
        end)
    end
end)


----------------------------------- Traitements Mangues -----------------------------------

RegisterNetEvent('esx-farming:client:StartMangoProduct')
AddEventHandler('esx-farming:client:StartMangoProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:MangoJuiceInfo', function(Mango)
            if Mango then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeMangoJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:MangoJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Mango 10', 'Mango Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:MangoWineInfo', function(Mango)
            if Mango then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeMangoWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:MangoWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Mango 25', 'Mango Wine', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Traitements Oranges -----------------------------------

RegisterNetEvent('esx-farming:client:StartOrangeProduct')
AddEventHandler('esx-farming:client:StartOrangeProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:OrangeJuiceInfo', function(Orange)
            if Orange then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeOrangeJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:OrangeJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Orange 10', 'Orange Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:OrangeWineInfo', function(Orange)
            if Orange then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeOrangeWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:OrangeWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Orange 25', 'Orange Wine', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Traitements Pommes -----------------------------------

RegisterNetEvent('esx-farming:client:StartAppleProduct')
AddEventHandler('esx-farming:client:StartAppleProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:AppleJuiceInfo', function(Apple)
            if Apple then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeAppleJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:AppleJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Apple 10', 'Apple Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:AppleWineInfo', function(Apple)
            if Apple then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeAppleWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:AppleWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Apple 25', 'Apple Wine', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Traitements Goyaves -----------------------------------

RegisterNetEvent('esx-farming:client:StartGauvaProduct')
AddEventHandler('esx-farming:client:StartGauvaProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:GauvaJuiceInfo', function(Gauva)
            if Gauva then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeGauvaJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:GauvaJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Gauva 10', 'Gauva Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:GauvaWineInfo', function(Gauva)
            if Gauva then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["MakeGauvaWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:GauvaWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'Need Gauva 25', 'Gauva Wine', 'center-right', 'error')
            end
        end)
    end
end)



----------------------------------- Vendre Tomates -----------------------------------

RegisterNetEvent('esx-farming:client:StartSellTomatoProduct')
AddEventHandler('esx-farming:client:StartSellTomatoProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:TomatoKetchupInfoSell', function(TomatoKetchup)
            if TomatoKetchup then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellTomatoKetchup"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellTomatoKetchupRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Tomato Ketchup', 'Tomato Ketchup', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:TomatoPasteInfoSell', function(TomatoPaste)
            if TomatoPaste then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellTomatoPatse"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellTomatoPatseRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Tomato Paste', 'Tomato Paste', 'center-right', 'error')
            end
        end)
      
    end
end)

----------------------------------- Vendre Mangues -----------------------------------

RegisterNetEvent('esx-farming:client:StartSellMangoProduct')
AddEventHandler('esx-farming:client:StartSellMangoProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:MangoJuiceInfoSell', function(MangoJuice)
            if MangoJuice then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellMangoJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellMangoJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Mango Juice', 'Mango Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:MangoWineInfoSell', function(MangoWine)
            if MangoWine then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellMangoWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellMangoWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Mango Wine', 'Mango Wine', 'center-right', 'error')
            end
        end)
    end
end)


----------------------------------- Vendre Oranges -----------------------------------

RegisterNetEvent('esx-farming:client:StartSellOrangeProduct')
AddEventHandler('esx-farming:client:StartSellOrangeProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:OrangeJuiceInfoSell', function(OrangeJuice)
            if OrangeJuice then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellOrangeJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellOrangeJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Orange Juice', 'Orange Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:OrangeWineInfoSell', function(OrangeWine)
            if OrangeWine then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellOrangeWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellOrangeWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Orange Wine', 'Orange Wine', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Vendre Pommes -----------------------------------

RegisterNetEvent('esx-farming:client:StartSellAppleProduct')
AddEventHandler('esx-farming:client:StartSellAppleProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:AppleJuiceInfoSell', function(AppleJuice)
            if AppleJuice then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellAppleJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellAppleJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Apple Juice', 'Apple Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:AppleWineInfoSell', function(AppleWine)
            if AppleWine then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellAppleWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellAppleWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Apple Wine', 'Apple Wine', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Vendre Goyaves -----------------------------------

RegisterNetEvent('esx-farming:client:StartSellGauvaProduct')
AddEventHandler('esx-farming:client:StartSellGauvaProduct', function(args)
    if args == 1 then
        ESX.TriggerServerCallback('esx-farming:server:GauvaJuiceInfoSell', function(GauvaJuice)
            if GauvaJuice then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellGauvaJuice"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellGauvaJuiceRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Gauva Juice', 'Gauva Juice', 'center-right', 'error')
            end
        end)   
    elseif args == 2 then
        ESX.TriggerServerCallback('esx-farming:server:GauvaWineInfoSell', function(GauvaWine)
            if GauvaWine then
                TriggerEvent('esx-farmming:client:progressbarSellPros', 2000, 'bottom', Config.Label["SellGauvaWine"], false, true, true, true, 'missfam4', 'base', 'p_amb_clipboard_01', vec3(0.00, 0.00, 0.00), vec3(0.0, 0.0, -1.5))
                Wait(2000)
                TriggerServerEvent('esx-farming:server:SellGauvaWineRewards', src)
            else
                TriggerEvent('esx-farming:client:notify', 'No Gauva Wine', 'Gauva Wine', 'center-right', 'error')
            end
        end)
    end
end)

----------------------------------- Recuperer Mangues -----------------------------------

RegisterNetEvent('esx-farming:client:StartfarmMango')
AddEventHandler('esx-farming:client:StartfarmMango', function(args)
    TriggerEvent('esx-farmming:client:progressbar', 3000, 'bottom', Config.Label["PickMango"], false, true, true, true, 'amb@prop_human_movie_bulb@base', 'base')
    Wait(3000)
    TriggerServerEvent('esx-farming:server:MangoRewards', src)
end)


----------------------------------- Recuperer Oranges -----------------------------------

RegisterNetEvent('esx-farming:client:StartfarmOrange')
AddEventHandler('esx-farming:client:StartfarmOrange', function(args)
    TriggerEvent('esx-farmming:client:progressbar', 3000, 'bottom', Config.Label["PickOrange"], false, true, true, true, 'amb@prop_human_movie_bulb@base', 'base')
    Wait(3000)
    TriggerServerEvent('esx-farming:server:OrangeRewards', src)
end)

----------------------------------- Recuperer Pommes -----------------------------------

RegisterNetEvent('esx-farming:client:StartfarmApple')
AddEventHandler('esx-farming:client:StartfarmApple', function(args)
    TriggerEvent('esx-farmming:client:progressbar', 3000, 'bottom', Config.Label["PickApple"], false, true, true, true, 'amb@prop_human_movie_bulb@base', 'base')
    Wait(3000)
    TriggerServerEvent('esx-farming:server:AppleRewards', src)
end)

----------------------------------- Recuperer Goyaves -----------------------------------

RegisterNetEvent('esx-farming:client:StartfarmGauva')
AddEventHandler('esx-farming:client:StartfarmGauva', function(args)
    TriggerEvent('esx-farmming:client:progressbar', 3000, 'bottom', Config.Label["PickGauva"], false, true, true, true, 'amb@prop_human_movie_bulb@base', 'base')
    Wait(3000)
    TriggerServerEvent('esx-farming:server:GauvaRewards', src)
end)

------------------------------------------------------------------------------
--------------------------------- By Le Djo ----------------------------------
------------------------------------------------------------------------------

