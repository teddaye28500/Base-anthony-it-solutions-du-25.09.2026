--############################
--############ Boss ##########
--############################

TriggerEvent('esx_society:registerSociety', 'police', 'police', 'society_police', 'society_police', 'society_police', {type = 'public'})

--##############################
--############ Coffre ##########
--##############################

local StashPolice = {
    id = 'StashPolice',
    label = Config.Title.Stash,
    slots = 55,
    weight = 20000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(StashPolice.id, StashPolice.label, StashPolice.slots, StashPolice.weight, StashPolice.owner)
    end
end)