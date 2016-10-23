return {
	active = true,  

	on = {
		'Rik is thuis',
		'Sabine is thuis',
		'Beweging',
	},

	execute = function(domoticz)

		Rik = domoticz.devices['Rik is thuis'].state
		Sabine = domoticz.devices['Sabine is thuis'].state
		Beweging = domoticz.devices['Beweging'].state

		print ("Rik thuis: "..Rik)
		print ("Sabine thuis: "..Sabine)
		print ("Beweging: "..Beweging)
		
		--Iemand thuis
		if Iemand == 'Off' and (Rik == 'On' or Sabine == 'On' or Beweging == 'On') then
			print ("Iemand thuis")
			domoticz.notify('Iemand thuis#-2')
			domoticz.devices['Iemand thuis'].switchOn()
		elseif Iemand == 'On' and (Rik == 'Off' and Sabine == 'Off' and Beweging == 'Off') then
			print ("Niemand thuis")
			domoticz.notify('Niemand thuis#-2')
			domoticz.devices['Iemand thuis'].switchOff()
		end
		
	end
}