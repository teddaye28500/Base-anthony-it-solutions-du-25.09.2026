RegisterNetEvent('nsx:lavage', function()
    lib.registerContext({
        id = 'lavage',
        title = Config.Title.Lavage,
        options = {
            {
                title = Config.Title.Main,
                event = 'washing:hands'
            },
            {
                title = Config.Title.Sponge,
                event = 'washing:sponge',
                description = Config.description.LavageSponge
            }
        }
    })

    lib.showContext('lavage')
end)

RegisterNetEvent('nsx:cuisson', function()
    lib.registerContext({
        id = 'cuisson',
        title = Config.Title.Cuisson,
        options = {
            {
                title = Config.Title.Burger,
                event = 'cuisson:burger',
                description = Config.description.CuissonBurger
            },
            {
                title = Config.Title.Menuburger,
                event = 'cuisson:menuburger',
                description = Config.description.CuissonMenuburger
            },
            {
                title = Config.Title.Sandwitch,
                event = 'cuisson:sandwitch',
                description = Config.description.CuissonSandwitch
            },
        }
    })

    lib.showContext('cuisson')
end)


RegisterNetEvent('nsx:friteuse', function()
    lib.registerContext({
        id = 'friteuse',
        title = Config.Title.Friteuse,
        options = {
            {
                title = Config.Title.Frites,
                event = 'friteuse:frites',
                description = Config.description.FriteuseFrites
            },
            {
                title = Config.Title.Poutine,
                event = 'friteuse:poutine',
                description = Config.description.FriteusePoutine
            },
            {
                title = Config.Title.Croquette,
                event = 'friteuse:croquette',
                description = Config.description.FriteuseCroquette
            },
        }
    })

    lib.showContext('friteuse')
end)

RegisterNetEvent('nsx:boisson', function()
    lib.registerContext({
        id = 'boisson',
        title = Config.Title.Boisson,
        options = {
            {
                title = Config.Title.Jus,
                event = 'nsx:jusorange',
                description = Config.description.BoissonJus
            },
            {
                title = Config.Title.Liqueur,
                event = 'nsx:liqueur',
                description = Config.description.BoissonLiqueur
            },
            {
                title = Config.Title.Coca,
                event = 'nsx:coca',
                description = Config.description.BoissonCoca
            },
            {
                title = Config.Title.Pepper,
                event = 'nsx:pepper',
                description = Config.description.BoissonPepper
            },
        }
    })

    lib.showContext('boisson')
end)

RegisterNetEvent('nsx:toilet', function()
    lib.registerContext({
        id = 'toilet',
        title = Config.Title.Toilet,
        options = {
            {
                title = Config.Title.Pee,
                event = 'pee',
            },
        }
    })

    lib.showContext('toilet')
end)

RegisterNetEvent('nsx:toiletfille', function()
    lib.registerContext({
        id = 'toilet2',
        title = Config.Title.Toilet,
        options = {
            {
                title = Config.Title.Pee,
                event = 'peefille',
            },
        }
    })

    lib.showContext('toilet2')
end)

RegisterNetEvent('nsx:washingface', function()
    lib.registerContext({
        id = 'washingface',
        title = Config.Title.WashingFace,
        options = {
            {
                title = Config.Title.Face,
                event = 'washing:face',
            },
            {
                title = Config.Title.WashingHands,
                event = 'washing:hands2',
            }
        }
    })

    lib.showContext('washingface')
end)

RegisterNetEvent('nsx:garage', function()
    lib.registerContext({
        id = 'garage',
        title = Config.Title.Garage, 
        options = {
            {
                title = Config.Title.GarageVeh,
                event = 'nsx:garage',
            },
        }
    })

    lib.showContext('garage')
end)

RegisterNetEvent('nsx:legume', function()
    lib.registerContext({
        id = 'legume',
        title = Config.Title.Legumes, 
        options = {
            {
                title = Config.Title.Salade,
                description = Config.description.DSalade,
                event = 'cutting:salade',
            },
            {
                title = Config.Title.Poulet,
                description = Config.description.DPoulet,
                event = 'cutting:poulet',
            },
            {
                title = Config.Title.Boulette,
                description = Config.description.DBoulette,
                event = 'cutting:boulette',
            },
        }
    })

    lib.showContext('legume')
end)

RegisterNetEvent('nsx:offlinestore', function()
    lib.registerContext({
        id = 'offlinestore',
        title = Config.Title.Offline,
        options = {
            {
                title = Config.Title.Burger,
                event = 'offline:burger',
                description = Config.description.OBurger
            },
            {
                title = Config.Title.Clubsandwich,
                event = 'offline:clubsandwitch',
                description = Config.description.Clubsandwich
            },
            {
                title = Config.Title.OPoutine,
                event = 'offline:poutine',
                description = Config.description.OPoutine
            },
            {
                title = Config.Title.OFrites,
                event = 'offline:frites',
                description = Config.description.OFrites
            },
            {
                title = Config.Title.OCroquette,
                event = 'offline:croquette',
                description = Config.description.OCroquette
            },
            {
                title = Config.Title.OLiqueur,
                event = 'offline:liqueur',
                description = Config.description.OLiqueur
            },
            {
                title = Config.Title.OJusorange,
                event = 'offline:jusorange',
                description = Config.description.OJusorange
            },
            {
                title = Config.Title.OPepper,
                event = 'offline:pepper',
                description = Config.description.OPepper
            },
        }
    })

    lib.showContext('offlinestore')
end)

--  client ACHAT 

exports.qtarget:AddBoxZone("BurgershotAchat", vector3(Config.achatburgershot.x, Config.achatburgershot.y, Config.achatburgershot.z), 1.0 , 1.5, {
	name="BurgershotAchat",
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "nsx:achatburgershot",
				icon = "fa-solid fa-cart-shopping",
				label = "Achat Burgershot",
				job = "burgershot",
			},
		},
	distance = 2.5
})

  RegisterNetEvent('nsx:achatburgershot')
AddEventHandler('nsx:achatburgershot', function()
    lib.showContext('boissonburgershot')
end)

lib.registerContext({
    id = 'boissonburgershot',
    title = 'Shop Burget Shot',
    options = {
      {
      title = 'Sauce',
      description = 'prix : '   .. Config.prix.sauce .. '$' ,
      icon = 'fa-solid fa-cart-plus',
      event = 'add:sauce'
      },
      {
        title = 'Fromage',
        description = 'prix : '   .. Config.prix.fromage .. '$' , 
        icon = 'fa-solid fa-cart-plus',
         event = 'add:fromage'
            },
      {
        title = 'Poulet',
        description = 'prix : '   .. Config.prix.poulet .. '$' ,
        icon = 'fa-solid fa-cart-plus',
         event = 'add:poulet'
            },
      {
        title = 'Boulette',
        description = 'prix : '   .. Config.prix.boulette .. '$' ,
        icon = 'fa-solid fa-cart-plus',
        event = 'add:boulette'
        },
        {
          title = 'Ketchup',
          description = 'prix : '   .. Config.prix.ketchup .. '$' ,
          icon = 'fa-solid fa-cart-plus',
          event = 'add:ketchup'
          },
          {
            title = 'Bacon',
            description = 'prix : '   .. Config.prix.bacon .. '$' ,
            icon = 'fa-solid fa-cart-plus',
            event = 'add:bacon'
            },
            {
              title = 'Beurre',
              description = 'prix : '   .. Config.prix.beurre .. '$' ,
              icon = 'fa-solid fa-cart-plus',
              event = 'add:beurre'
              },
              {
                title = 'Patate',
                description = 'prix : '   .. Config.prix.patate .. '$' ,
                icon = 'fa-solid fa-cart-plus',
                event = 'add:patate'
                },
                {
                  title = 'glaces',
                  description = 'prix : '   .. Config.prix.glaces .. '$' ,
                  icon = 'fa-solid fa-cart-plus',
                  event = 'add:glaces'
                  },
                  {
                    title = 'Sponge',
                    description = 'prix : '   .. Config.prix.sponge .. '$' ,
                    icon = 'fa-solid fa-cart-plus',
                    event = 'add:sponge'
                    },
        {
        title = 'Salade',
        description = 'prix : '   .. Config.prix.salade .. '$' ,
        icon = 'fa-solid fa-cart-plus',
         event = 'add:salade'
            },
    }
  })

  RegisterNetEvent('add:sauce')
  AddEventHandler('add:sauce', function()
    TriggerServerEvent('add:sauceserveur')
  end)

  RegisterNetEvent('add:fromage')
  AddEventHandler('add:fromage', function()
    TriggerServerEvent('add:fromageserveur')
  end)

  RegisterNetEvent('add:poulet')
  AddEventHandler('add:poulet', function()
    TriggerServerEvent('add:pouletserveur')
  end)

  RegisterNetEvent('add:boulette')
  AddEventHandler('add:boulette', function()
    TriggerServerEvent('add:bouletteserveur')
  end)

  RegisterNetEvent('add:salade')
  AddEventHandler('add:salade', function()
    TriggerServerEvent('add:saladeserveur')
  end)

  RegisterNetEvent('add:ketchup')
  AddEventHandler('add:ketchup', function()
    TriggerServerEvent('add:ketchupserveur')
  end)

  RegisterNetEvent('add:bacon')
  AddEventHandler('add:bacon', function()
    TriggerServerEvent('add:baconserveur')
  end)

  RegisterNetEvent('add:beurre')
  AddEventHandler('add:beurre', function()
    TriggerServerEvent('add:beurreserveur')
  end)

  RegisterNetEvent('add:patate')
  AddEventHandler('add:patate', function()
    TriggerServerEvent('add:patateserveur')
  end)

  RegisterNetEvent('add:glaces')
  AddEventHandler('add:glaces', function()
    TriggerServerEvent('add:glacesserveur')
  end)

  RegisterNetEvent('add:sponge')
  AddEventHandler('add:sponge', function()
    TriggerServerEvent('add:spongeserveur')
  end)