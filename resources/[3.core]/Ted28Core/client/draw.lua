-- S'assurer que le script client se lance bien
--print("[client.lua] Le script est chargé correctement.")

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        for _, v in pairs(Config.ClothingStores) do
            local distance = #(coords - v)

            -- Affiche les markers si le joueur est à moins de 20 mètres
            if distance < 20.0 then
                DrawMarker(
                    1,               -- type de marker (cylindre vertical)
                    v.x, v.y, v.z - 1.0, -- position (ajusté vers le sol)
                    0.0, 0.0, 0.0,   -- direction
                    0.0, 0.0, 0.0,   -- rotation
                    1.5, 1.5, 1.0,   -- taille (x, y, z)
                    255, 0, 255, 200,  -- violet (rouge + bleu), avec une opacité de 200
                    false, true, 2, false, nil, nil, false
                )
            end
        end
    end
end)
