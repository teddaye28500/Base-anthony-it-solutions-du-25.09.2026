-- Example Client Side Commands - Delete them

--[[
	TriggerEvent('brutal_notify:SendAlert', 'Title', 'Message', Time, 'type')
]]--

if Config.ExampleNotifys then
	RegisterCommand('success', function()
		TriggerEvent('brutal_notify:SendAlert', 'SUCCESS', 'This is an example notify!', 5000, 'success')
	end)

	RegisterCommand('info', function()
		TriggerEvent('brutal_notify:SendAlert', 'INFO', 'This is an example notify!', 5000, 'info')
	end)

	RegisterCommand('error', function()
		TriggerEvent('brutal_notify:SendAlert', 'ERROR', 'This is an example notify!', 5000, 'error')
	end)

	RegisterCommand('warning', function()
	    TriggerEvent('brutal_notify:SendAlert', 'WARNING', 'This is an example notify!', 5000, 'warning')
	end)
end

