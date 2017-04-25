return {
	active = true,
	on = {
		['timer'] = {
			'at 08:00'
		}
	},
	execute = function(domoticz)

		local Slapen = domoticz.devices['Slapen']
		local Simulatie = domoticz.devices['Simulatie']
		
		print ("Slapen: "..Slapen)
		print ("Simulatie: "..Simulatie)
				
		if Simulatie.state == 'On' then 
			domoticz.devices['Mode'].switchOff().within_min(30)
			print ("Niet thuis - Wakker simulatie")
		end
				
	end
}