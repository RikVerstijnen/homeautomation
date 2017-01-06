return {
	active = true,
	on = {
		['timer'] = {
			'at 22:30'
		}
	},
	execute = function(domoticz)

		local Slapen = domoticz.devices['Slapen']
		local Simulatie = domoticz.devices['Simulatie']
		
		print ("Slapen: "..Slapen)
		print ("Simulatie: "..Simulatie)
		
		--Weg: Simuleer slapen rond 23u
		if Simulatie.state == 'On' then 
			domoticz.devices['Slapen'].switchOn().within_min(30)
			print ("Niet thuis - Slapen simulatie")
		end
		
	end
}