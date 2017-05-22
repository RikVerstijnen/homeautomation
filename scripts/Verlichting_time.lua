return {
    active = false, 
    on = {
    	['timer'] = {'Every minute'}
    },
    execute = function(domoticz)	
	
		local Buitenlamp = domoticz.devices['Buitenlamp 1']
		local Achter = domoticz.devices['Lamp achter']
		local Tussen = domoticz.devices['Lamp tussen']
		local Keuken = domoticz.devices ['Lamp keuken']
		local Zit = domoticz.devices ['Lamp zithoek']
		local Thuis = domoticz.devices['Iemand thuis']
		Mode = domoticz.devices['Mode']
		
		--Slapen of licht: Verlichting uit
		
		if (Mode.state == 'Off') and (Buitenlamp.state == 'On' or Achter.state == 'On' or Tussen.state == 'On' or Keuken.state == 'On' or Zit.state == 'On') then
		
			domoticz.devices['Buitenlamp 1'].switchOff()
			domoticz.devices['Lamp achter'].switchOff()
			domoticz.devices['Lamp tussen'].switchOff()
			domoticz.devices['Lamp keuken'].switchOff()
			domoticz.devices['Lamp zithoek'].switchOff()
			print ("Slapen - Verlichting uit")	
		
		end
		
	end
}