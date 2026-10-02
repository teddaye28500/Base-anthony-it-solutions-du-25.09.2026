---DESACTIVER LES BRUITS AMBIANT | EXEMPLE : BRUIT DE TIR AMMUNATION, SCANNER POLICE....

Citizen.CreateThread(function()
    StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
    SetAudioFlag("PoliceScannerDisabled", true)
end)