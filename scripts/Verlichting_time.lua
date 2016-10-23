return {
    active = true, 
    on = {
    	['timer'] = {'Every minute'}
    },
    execute = function(domoticz)	
	
		local Buitenlamp = domoticz.devices['Buitenlamp 1']
		local Achter = domoticz.devices['Lamp achter']
		local Tussen = domoticz.devices['Lamp tussen']
		local Slapen = domoticz.devices['Slapen']
		local Thuis = domoticz.devices['Iemand thuis']
		
		if (domoticz.time.isNightTime) and Slapen.state == 'Off' and (Buitenlamp.state == 'Off' or Achter.state == 'Off' or Tussen.state == 'Off') then
		
			domoticz.devices['Buitenlamp 1'].switchOn()
			domoticz.devices['Lamp achter'].switchOn()
			domoticz.devices['Lamp tussen'].switchOn()
			domoticz.notify('Donker - Verlichting aan#Donker - Verlichting aan#-2')
			print ("Donker - Verlichting aan")	
		
		--Slapen of licht: Verlichting uit
		
		elseif (Slapen.state == 'On' or domoticz.time.isDayTime) and (Buitenlamp.state == 'On' or Achter.state == 'On' or Tussen.state == 'On') then
		
			domoticz.devices['Buitenlamp 1'].switchOff()
			domoticz.devices['Lamp achter'].switchOff()
			domoticz.devices['Lamp tussen'].switchOff()
			domoticz.notify('Donker - Verlichting aan#Slapen - Verlichting uit#-2')
			print ("Slapen - Verlichting uit")	
		
		end
		
	end
}