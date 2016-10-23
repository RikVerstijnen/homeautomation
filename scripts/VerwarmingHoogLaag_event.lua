return {
	active = true,  

	on = {
		'Iemand thuis',
		'Slapen'
	},

	execute = function(domoticz)
		
		Iemand = domoticz.devices['Iemand thuis'].state
		Slapen = domoticz.devices['Slapen'].state
		Verwarming = domoticz.devices['Stat Woonkamer'].state
		
		print ("Iemand thuis: "..Iemand)
		print ("Slapen: "..Slapen)
		print ("Verwarming: "..Verwarming)
		
		--Verwarming
		if Iemand == 'On' and Slapen == 'Off' then
			print ("Verwarming aan")
			domoticz.notify('Verwarming aan#-2')
			domoticz.devices['Stat Woonkamer'].updateTemperature(19)
		elseif Iemand == 'Off' or Slapen == 'On' then
			print ("Verwarming uit")
			domoticz.notify('Verwarming uit#-2')
			domoticz.devices['Stat Woonkamer'].updateTemperature(15)
		end
		
	end
}