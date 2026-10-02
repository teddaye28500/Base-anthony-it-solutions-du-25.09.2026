function HeistNotify(_initialText, _table, _waitTime, _playSound)
    showHeistBanner = true
    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end
    showHeist(_initialText, _table, _money, _xp)
    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(_waitTime) * 1000)
        showHeistBanner = false
    end)
end

function showHeist(ZinitialText, Ztable, Zmoney, Zxp)
    Citizen.CreateThread(function()
        function drawHeist(_initialText, _table, _money, _xp)
            local scaleform = Request('HEIST_CELEBRATION')
            local scaleform_bg = Request('HEIST_CELEBRATION_BG')
            local scaleform_fg = Request('HEIST_CELEBRATION_FG')

            local scaleform_list = {
                scaleform,
                scaleform_bg,
                scaleform_fg
            }

            for key, scaleform_handle in pairs(scaleform_list) do
                CallFunction(scaleform_handle, false, "CREATE_STAT_WALL", 1, "HUD_COLOUR_FREEMODE_DARK", 1)
                CallFunction(scaleform_handle, false, "ADD_BACKGROUND_TO_WALL", 1, 80, 1)
    
                --this should be used as it's own scaleform event.
                --CallFunction(scaleform_handle, false, "ADD_COMPLETE_MESSAGE_TO_WALL", 1, _initialText.missionTextLabel, _initialText.passFailTextLabel, _initialText.messageLabel, true, true, true)
    
                CallFunction(scaleform_handle, false, "ADD_MISSION_RESULT_TO_WALL", 1, _initialText.missionTextLabel, _initialText.passFailTextLabel, _initialText.messageLabel, true, true, true)
    
                if _table ~= nil then
                    if _table[1] ~= nil then
                        CallFunction(scaleform_handle, false, "CREATE_STAT_TABLE", 1, 10)
        
                        for i, k in pairs(_table) do
                            CallFunction(scaleform_handle, false, "ADD_STAT_TO_TABLE", 1, 10, _table[i].stat, _table[i].value, true, true, false, false, 0)
                        end
        
                        CallFunction(scaleform_handle, false, "ADD_STAT_TABLE_TO_WALL", 1, 10)
                    end
                end
    
                CallFunction(scaleform_handle, false, "SHOW_STAT_WALL", 1)
                CallFunction(scaleform_handle, false, "createSequence", 1, 1, 1)
            end

            return scaleform, scaleform_bg, scaleform_fg
        end
        local scale, scale_bg, scale_fg = drawHeist(ZinitialText, Ztable, Zmoney, Zxp)
        while showHeistBanner do
            Citizen.Wait(1)
            DrawScaleformMovieFullscreenMasked(scale_bg, scale_fg, 255, 255, 255, 50)
            DrawScaleformMovieFullscreen(scale, 255, 255, 255, 255)
        end
        StartScreenEffect("HeistCelebToast")
    end)
end
function Request(scaleform)
    local scaleform_handle = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform_handle) do
        Citizen.Wait(0)
    end
    return scaleform_handle
end

function CallFunction(scaleform, returndata, the_function, ...)
    BeginScaleformMovieMethod(scaleform, the_function)
    local args = {...}

    if args ~= nil then
        for i = 1,#args do
            local arg_type = type(args[i])

            if arg_type == "boolean" then
                ScaleformMovieMethodAddParamBool(args[i])
            elseif arg_type == "number" then
                if not string.find(args[i], '%.') then
                    ScaleformMovieMethodAddParamInt(args[i])
                else
                    ScaleformMovieMethodAddParamFloat(args[i])
                end
            elseif arg_type == "string" then
                ScaleformMovieMethodAddParamTextureNameString(args[i])
            end
        end

        if not returndata then
            EndScaleformMovieMethod()
        else
            return EndScaleformMovieMethodReturnValue()
        end
    end
end