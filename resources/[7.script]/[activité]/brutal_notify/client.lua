function StartNotify(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
        message = message,
        time = time,
		type = type,
	})
end

RegisterNetEvent('brutal_notify:SendAlert')
AddEventHandler('brutal_notify:SendAlert', function(title, message, time, type)
	StartNotify(title, message, time, type)
end)

exports("SendAlert", StartNotify)

function MoveNotify()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'open2',
		title = "Move",
        message = "Move Where You Want",
	})
end

function ResetNotify()
	SendNUIMessage({
		action = 'reset',
	})
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterCommand(Config.NotifyEdit.Command, function()
	MoveNotify()
end)

RegisterCommand(Config.NotifyReset, function()
	ResetNotify()
end)