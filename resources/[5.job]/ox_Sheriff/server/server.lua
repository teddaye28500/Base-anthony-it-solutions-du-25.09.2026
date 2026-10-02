--############################
--############ Boss ##########
--############################

TriggerEvent('esx_society:registerSociety', 'sheriff', 'sheriff', 'society_sheriff', 'society_sheriff', 'society_sheriff', {type = 'public'})

--##############################
--############ Coffre ##########
--##############################

local StashSheriff = {
    id = 'StashSheriff',
    label = Config.Title.Stash,
    slots = 55,
    weight = 20000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(StashSheriff.id, StashSheriff.label, StashSheriff.slots, StashSheriff.weight, StashSheriff.owner)
    end
end)