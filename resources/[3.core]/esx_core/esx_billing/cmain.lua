local isDead = false

function ShowBillsMenu()
	local options = {}
	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		if #bills > 0 then

			for k, v in ipairs(bills) do
				options[#options + 1] = {
					icon = "fas fa-scroll",
					iconColor = 'red',
					title = v.label,
					description = TranslateCap('invoices_item', ESX.Math.GroupDigits(v.amount)), billId = v.id,
					onSelect = function()
						ESX.TriggerServerCallback('esx_billing:payBill', function()
							ShowBillsMenu()
						end, v.id)
						lib.showContext("amountBill")
					end
				}
			end

			lib.registerContext({
				id = "amountBill",
				title = TranslateCap('invoices'),
				options = options,
			})
			lib.showContext("amountBill")
		else
			ESX.ShowNotification(TranslateCap('no_invoices'))
		end
	end)
end

RegisterCommand('showbills', function()
	if not isDead then
		ShowBillsMenu()
	end
end, false)

RegisterKeyMapping('showbills', TranslateCap('keymap_showbills'), 'keyboard', 'F7')

AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)


