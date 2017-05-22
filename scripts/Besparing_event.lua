return {
	active = true,  

	on = {
		'Mode',
	},

	execute = function(domoticz)
						
		if (devicechanged['Mode'] == 'Off') then

		-- Als slapen, dan apparaten uit
		domoticz.devices['S_Mediaspeler'].SwitchOff()
		domoticz.devices['S_TV'].SwitchOff()
		domoticz.devices['S_DVD speler'].SwitchOff()
		domoticz.devices['S_Interactieve TV'].SwitchOff()
		domoticz.devices['S_Wasmachine'].SwitchOff()
		domoticz.devices['S_Droger'].SwitchOff()
		domoticz.devices['Sproeier achter'].SwitchOff()
		
		print ("Apparaten uit")
		
		elseif (devicechanged['Mode'] == 'On' or devicechanged['Mode'] == 'Auto') then
		
		-- Als wakker, dan apparaten aan
		domoticz.devices['S_Mediaspeler'].SwitchOn()
		domoticz.devices['S_TV'].SwitchOn()
		domoticz.devices['S_DVD speler'].SwitchOn()
		domoticz.devices['S_Interactieve TV'].SwitchOn()
		domoticz.devices['S_Wasmachine'].SwitchOn()
		domoticz.devices['S_Droger'].SwitchOn()
		
		print ("Apparaten aan")
		
		end
		
	end
}