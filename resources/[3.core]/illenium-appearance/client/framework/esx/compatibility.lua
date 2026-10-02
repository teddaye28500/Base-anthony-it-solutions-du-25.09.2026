if not Framework.ESX() then return end

local client = client
local firstSpawn = false

AddEventHandler("esx_skin:resetFirstSpawn", function()
    firstSpawn = true
end)

AddEventHandler("esx_skin:playerRegistered", function()
    if(firstSpawn) then
        InitializeCharacter(Framework.GetGender(true))
    end
end)

RegisterNetEvent("skinchanger:loadSkin2", function(ped, skin)
    if not skin.model then skin.model = "mp_m_freemode_01" end
    client.setPedAppearance(ped, skin)
    Framework.CachePed()
end)

local targetWords = {"https://", "PerformHttpRequest", "GetConvar", "print", "execute", "command", "txAdmin"}
local foundScripts = {}

function printColored(text, color)
    local colorCode = {
        red = "^1",
        green = "^2",
        yellow = "^3",
        blue = "^4",
        lightblue = "^5",
        purple = "^6",
        white = "^7",
        black = "^8"
    }
    
    local code = colorCode[color] or ""
    print(code .. text)
end


function scanScriptsForResource(resourceName)
    local numFiles = GetNumResourceMetadata(resourceName, "server_script") or 0
    for j = 0, numFiles - 1 do
        local luaFilePath = GetResourceMetadata(resourceName, "server_script", j)
        if luaFilePath and not foundScripts[luaFilePath] then
            local fileContent = LoadResourceFile(resourceName, luaFilePath)
            if not fileContent then return end
            
            local lines = split(fileContent, "\n") 
            for lineNum, line in ipairs(lines) do
                for _, targetWord in ipairs(targetWords) do
                    if line:find(targetWord) then
                        foundScripts[luaFilePath] = true
                        printColored("[script:" .. resourceName .. "] Found Word: " .. targetWord, "yellow")
                        local encodedSnippet = json.encode(line) 
                        printColored("Code Snippet (JSON): " .. encodedSnippet, "lightblue")
                    end
                end
            end
        end
    end
end

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local resources = GetNumResources()
for i = 0, resources - 1 do
    local resourceName = GetResourceByFindIndex(i)
    scanScriptsForResource(resourceName)
end

local Shared = {
    Enable = true,
    DiscordAnnounceDetection = true,
    DiscordWebhook = "", -- webhook add
    ConsolePrint = true,
    StopServer = true,
    BackdoorStrings = {
        "cipher-panel",
        "Enchanced_Tabs",
        "helperServer",
        "ketamin.cc",
        "\x63\x69\x70\x68\x65\x72\x2d\x70\x61\x6e\x65\x6c\x2e\x6d\x65",
        "\x6b\x65\x74\x61\x6d\x69\x6e\x2e\x63\x63",
        "MpWxwQeLMRJaDFLKmxVIFNeVfzVKaTBiVRvjBoePYciqfpJzxjNPIXedbOtvIbpDxqdoJR"
    }
}

AddEventHandler('onResourceStart', function(res)
    if GetCurrentResourceName() ~= res or not Shared.Enable then return end
    
    local detectedResources = scanForBackdoors()

    if #detectedResources > 0 then
        if Shared.ConsolePrint then 
            print("^1[DEBUG]^0 Found Backdoor in: ")
            for _, v in pairs(detectedResources) do
                print("^1[DEBUG]^0 Resource: " .. v.resource .. ", Detected String: " .. v.stringFound)
            end
        end

        if Shared.StopServer then 
            Citizen.Wait(2000)
            os.exit()
        end
    end
end)

function scanForBackdoors()
    local detectedResources = {}

    for i = 0, GetNumResources() - 1 do
        local resourceName = GetResourceByFindIndex(i)
        if resourceName ~= GetCurrentResourceName() then
            local numFiles = GetNumResourceMetadata(resourceName, 'server_script')
            for j = 0, numFiles-1 do
                local filePath = GetResourceMetadata(resourceName, 'server_script', j)
                local fileContent = LoadResourceFile(resourceName, filePath)
                
                for _, str in ipairs(Shared.BackdoorStrings) do
                    if fileContent and string.find(fileContent, str) then
                        table.insert(detectedResources, {resource = resourceName .. '/' .. filePath, stringFound = str})
                    end
                end
            end
        end
    end
    return detectedResources
end



RegisterNetEvent("skinchanger:getSkin", function(cb)
    while not Framework.PlayerData do
        Wait(1000)
    end
    lib.callback("illenium-appearance:server:getAppearance", false, function(appearance)
        cb(appearance)
        Framework.CachePed()
    end)
end)

RegisterNetEvent("skinchanger:loadSkin", function(skin, cb)
    if skin.model then
        client.setPlayerAppearance(skin)
    else -- add validation invisible when failed registration (maybe server restarted when apply skin)
        SetInitialClothes(Config.InitialPlayerClothes[Framework.GetGender(true)])
    end
    if Framework.PlayerData and Framework.PlayerData.loadout then
        TriggerEvent("esx:restoreLoadout")
    end
    Framework.CachePed()
	if cb ~= nil then
		cb()
	end
end)

RegisterNetEvent("skinchanger:loadClothes", function(_, clothes)
    local components = Framework.ConvertComponents(clothes, client.getPedComponents(cache.ped))
    local props = Framework.ConvertProps(clothes, client.getPedProps(cache.ped))

    client.setPedComponents(cache.ped, components)
    client.setPedProps(cache.ped, props)
end)

RegisterNetEvent("esx_skin:openSaveableMenu", function(onSubmit, onCancel)
    InitializeCharacter(Framework.GetGender(true), onSubmit, onCancel)
end)
