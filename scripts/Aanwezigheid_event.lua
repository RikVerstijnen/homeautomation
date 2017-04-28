return {
	active = true,  

	on = {
		'Rik is thuis',
		'Sabine is thuis',
		'Beweging',
		'Achterdeur',
		'Buitensensor'
	},

	execute = function(domoticz)

		Rik = domoticz.devices['Rik is thuis'].state
		Sabine = domoticz.devices['Sabine is thuis'].state
		Beweging = domoticz.devices['Beweging'].state
		Iemand = domoticz.devices['Iemand thuis'].state
		Achterdeur = domoticz.devices['Achterdeur'].state
		Buiten = domoticz.devices['Buitensensor'].state
		
		--Iemand thuis
		if Iemand == 'Off' and (Rik == 'On' or Sabine == 'On' or Beweging == 'On' or Achterdeur.state == 'Open' or Buitensensor.state == 'On') then
			print ("Iemand thuis")
			domoticz.devices['Iemand thuis'].switchOn()
		elseif Iemand == 'On' and (Rik == 'Off' and Sabine == 'Off' and Beweging == 'Off') then
			print ("Niemand thuis")
			domoticz.devices['Iemand thuis'].switchOff()
		end
		
	end
}