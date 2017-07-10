return {
	active = false,  

	on = {
		'Mode',
	},

	execute = function(domoticz)

		Mode = domoticz.devices['Mode'].state

		print ("Mode"..Mode)
		
		-- Bij opstaan: rolluiken open
				
		-- Bij slapen gaan: rolluiken dicht
			
	end
}