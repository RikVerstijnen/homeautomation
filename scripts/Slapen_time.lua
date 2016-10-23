return {
	active = true,
	on = {
		['timer'] = {
			'at 22:30'
		}
	},
	execute = function(domoticz)

		local Slapen = domoticz.devices['Slapen']
		local Thuis = domoticz.devices['Iemand thuis']
		
		--Weg: Simuleer slapen rond 23u
		if Thuis.state == 'Off' then 
			domoticz.devices['Slapen'].switchOn().within_min(30)
			print ("Niet thuis - Slapen simulatie")
		end
		
	end
}