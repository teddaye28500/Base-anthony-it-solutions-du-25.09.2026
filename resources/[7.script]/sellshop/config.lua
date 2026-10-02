Config = {}

Config.checkForUpdates = false -- Check for Updates?

Config.SellShops = {
    { 
        coords = vec3(175.78, -1316.31, 28.34), -- Coords of sell shop 
        heading = 150.60, -- Heading of ped in pawn shop
        ped = 'a_m_m_og_boss_01', -- Ped model name
        label = 'Pawnshop', -- Label at top of context menu/blip if enabled
        blip = {
            enabled = false, -- Enable blip?
            sprite = 365, -- https://docs.fivem.net/docs/game-references/blips/
            color = 50, -- https://docs.fivem.net/docs/game-references/blips/
            scale = 0.5 -- Scale/size of blip (0.75 default)
        },
        items = {
            { item = 'rolex', label = 'Rolex', price = 250, currency = 'money' }, -- Self explanatory I would hope
            { item = 'jewels', label = 'jewels', price = 230, currency = 'money' }, -- Self explanatory I would hope
            { item = 'bijoux', label = 'bijoux', price = 240, currency = 'money' }, -- Self explanatory I would hope
            { item = 'necklace', label = 'Collier', price = 140, currency = 'money' }, -- Self explanatory I would hope            
            { item = 'phone', label = 'Telephone', price = 100, currency = 'money' }, -- Self explanatory I would hope            
            { item = 'tv', label = 'Tv', price = 400, currency = 'money' }, -- Self explanatory I would hope
            { item = 'microwave', label = 'Micro-onde', price = 100, currency = 'money' }, -- Self explanatory I would hope
            { item = 'coffeemaker', label = 'Machine à café', price = 100, currency = 'money' }, -- Self explanatory I would hope
            { item = 'telescope', label = 'Télescope', price = 100, currency = 'money' }, -- Self explanatory I would hope            
            { item = 'diamond', label = 'Diamant', price = 270, currency = 'money' }, -- Self explanatory I would hope
            { item = 'gold', label = 'or', price = 260, currency = 'money' }, -- Self explanatory I would hope
            { item = 'fakemoney', label = 'Fausse monnaie', price = 50, currency = 'money' }, -- Self explanatory I would hope                                                                     
        }
    },
}