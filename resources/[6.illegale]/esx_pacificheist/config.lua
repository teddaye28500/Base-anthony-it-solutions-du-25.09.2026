Config = {}

Config.useOxInventory = true
Config.useXsound = true           --This allow to play an alarm sound during the heist, you need to install this dependency https://github.com/Xogy/xsound

Config.moneyPerRack = {
    min = 2000,
    max = 3000
}

Config.DataCrackDifficult = 4   --beetween 1 and 5 (int)
Config.PoliceAlert = true
Config.MinCops = 0

Config.Account = "black_money"     -- or "money" 

Config.Zones = {
    StartHeist = vector3(257.10, 220.30, 106.28),
    StartHeistPed = vector4(256.8342590332, 219.48565673828, 106.28632354736, 345.43933105469), --256.86135864258, 219.50064086914, 106.28645324707, 336.60028076172
    SecondDoor = vector3(260.85903930664, 221.95330810547, 106.28355407715),
    SecondDoorPed = vector4(261.12591552734, 222.08288574219, 106.28337860107, 245.02288818359),
    ThirdDoor = vector3(253.51321411133, 221.41751098633, 101.68338775635),
    ThirdDoorPed = vector4(253.5708770752, 221.44815063477, 101.6833114624, 161.27717590332),
    Vault = vector3(253.37843322754, 228.20303344727, 101.68320465088),
    VaultPed = vector4(253.4764251709, 227.91691589355, 101.6833190918, 69.78360748291)
}

Config.Language = "fr"

Config.Locales = {
    ["fr"] = {
        ["click_request"] = "Appuyer sur ~INPUT_CONTEXT~ pour braquer la ~r~Pacfic Standard",
        ["cant_rob_now"] = "~r~Vous ne pouvez pas braquer cette banque maintenant!",
        ["no_thermal_charge"] = "~r~Vous n'avez pas de charge thermique!",
        ["no_card"] = "~r~Vous n'avez pas de PC de pirate!",
        ["thermal_request"] = "Appuyer sur ~INPUT_CONTEXT~ pour poser une ~r~charge thermique",
        ["vault_request"] = "Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le ~r~coffre fort",
        ["heist_in_progress"] = "~r~Un braquage est déjà en cours!",
        ["police_alert"] = "Un braquage est en cours, approcher avec précaution : [ ~y~Pacific Standard Bank~s~, Vinewood Boulevard ]"
    }
}