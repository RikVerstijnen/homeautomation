return {
	active = true,  

	on = {
		'Stat Woonkamer',
		'Woonkamer'
	},

	execute = function(domoticz)

		Setpoint = tonumber(domoticz.devices['Stat Woonkamer'].state)
		Temp = tonumber(domoticz.devices['Woonkamer'].temperature)
		Ketel = domoticz.devices['Ketel']

		print ("Setpoint")
		print (Setpoint)
		print ("Temp")
		print (Temp)
		
		if Temp < Setpoint and Ketel.state == 'Off' then
			print ("Temperatuur te laag; stoken")
			--domoticz.notify('Temperatuur te laag; stoken#-2')
			Ketel.switchOn()
		elseif Temp >= Setpoint and Ketel.state == 'On' then
			print ("Temperatuur goed; stoppen met stoken")
			--domoticz.notify('Temperatuur goed; stoppen met stoken#-2')
			Ketel.switchOff()
		end
		
	end
}