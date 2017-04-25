return {
	active = true,  

	on = {
		'Iemand thuis',
		'Mode'
	},

	execute = function(domoticz)
		
		Iemand = domoticz.devices['Iemand thuis'].state
		Mode = domoticz.devices['Mode'].state
		Verwarming = domoticz.devices['Stat Woonkamer'].state
		
		print ("Iemand thuis: "..Iemand)
		print ("Mode: "..Mode)
		print ("Verwarming: "..Verwarming)
		
		if (Iemand == 'On' and Mode == 'Auto') or Mode == 'On' then
			print ("Verwarming aan")
			domoticz.devices['Stat Woonkamer'].updateTemperature(19)
		elseif (Iemand == 'Off' and Mode == 'Auto')  or Mode == 'Off' then
			print ("Verwarming uit")
			domoticz.devices['Stat Woonkamer'].updateTemperature(15)
		end
		
	end
}