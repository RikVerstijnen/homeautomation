return {
	active = false,
	on = {
		['timer'] = {
			'at 08:00'
		}
	},
	execute = function(domoticz)

		local Slapen = domoticz.devices['Slapen']
		
		--Wakker rond 8u
		domoticz.devices['Slapen'].switchOff()
		print ("Het is 8u; wakker worden!")
				
	end
}