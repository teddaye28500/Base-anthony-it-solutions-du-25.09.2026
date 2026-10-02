--- /id

ESX = exports["es_extended"]:getSharedObject()



local id = GetPlayerServerId(PlayerId())



RegisterCommand("id", function() 

    ESX.ShowNotification('Votre ID est le : ~r~'..id)

end)