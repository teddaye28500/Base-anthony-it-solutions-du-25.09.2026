lib.registerContext({
    id = 'tabacactions',
    title = 'Tabac Actions',
    onExit = function()
        print('Action made by ledjo')
    end,
    options = {
        {
            title = 'Annonces',
            icon = 'fa fa-fire',
            menu = 'annonce_menu',
        },
        {
            title = 'Demande Point Farm',
            icon = 'fa fa-fire',
            menu = 'pointfarm_menu',
        },
        {
            title = 'Facture',
            icon = 'fa fa-fire',
            event = 'ledjo_tabac:sendbill'
        },
    },
    {
        id = 'annonce_menu',
        title = 'Annonces',
        menu = 'tabacactions',
        options = {
            ['Ouvert'] = {event = 'annonceO', icon = 'fa fa-check-circle'},
            ['Fermer'] = {event = 'annonceF', icon = 'fa fa-times-circle'}
        }
    },
    {
        id = 'pointfarm_menu',
        title = 'Point Farm',
        menu = 'tabacactions',
        options = {
            ['Recolte'] = {event = 'blips2', icon = 'fa fa-fire'},
            ['Traitement'] = {event = 'blips3', icon = 'fa fa-fire'}
        }
    }
})

RegisterCommand('tabac', function()
    if ESX.PlayerData.job.name == 'tabac' then
        lib.showContext('tabacactions')
    else 
        ESX.ShowNotification('Vous n\'êtes pas tabac')
    end
end)