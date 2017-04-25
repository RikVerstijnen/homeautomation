return {
	active = true,  

	on = {
		'Mode',
	},

	execute = function(domoticz)
						
		if (devicechanged['Mode'] == 'Off') then

		-- Als slapen, dan apparaten uit
		domoticz.devices['Mediaspeler'].SwitchOff()
		domoticz.devices['TV'].SwitchOff()
		domoticz.devices['DVD speler'].SwitchOff()
		domoticz.devices['Interactieve TV'].SwitchOff()
		domoticz.devices['Wasmachine'].SwitchOff()
		domoticz.devices['Droger'].SwitchOff()
		domoticz.devices['Sproeier achter'].SwitchOff()
		
		elseif (devicechanged['Mode'] == 'On' or devicechanged['Mode'] == 'Auto') then
		
		-- Als wakker, dan apparaten aan
		domoticz.devices['Mediaspeler'].SwitchOn()
		domoticz.devices['TV'].SwitchOn()
		domoticz.devices['DVD speler'].SwitchOn()
		domoticz.devices['Interactieve TV'].SwitchOn()
		domoticz.devices['Wasmachine'].SwitchOn()
		domoticz.devices['Droger'].SwitchOn()
		
		end
		
	end
}