--------------------------------------------------------------------------
-------------------------------| WEBHOOK |--------------------------------
--------------------------------------------------------------------------

BotName = 'Brutal Shop Robbery'

function DiscordWebhook(TYPE, MESSAGE)
    local information = {
        {
            ["color"] = Config.Webhooks.Colors[TYPE],
            ["author"] = {
                ["icon_url"] = 'https://i.ibb.co/By9TPLK/bs-2.png',
                ["name"] = BotName..' - Logs',
            },
            ["title"] = '**'.. Config.Webhooks.Locale[TYPE] ..'**',
            ["description"] = MESSAGE,
            ["fields"] = {
                {
                    ["name"] = Config.Webhooks.Locale['Time'],
                    ["value"] = os.date('%d/%m/%Y - %X')
                }
            },
            ["footer"] = {
                ["text"] = 'Brutal Scripts - Made by Keres & Dév',
                ["icon_url"] = 'https://i.ibb.co/By9TPLK/bs-2.png'
            }
        }
    }
    PerformHttpRequest(GetWebhook(), function(err, text, headers) end, 'POST', json.encode({avatar_url = IconURL, username = BotName, embeds = information}), { ['Content-Type'] = 'application/json' })
end