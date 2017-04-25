return {
	active = true,  

	on = {
		'Orientatie'
	},

	execute = function(domoticz)

		Buitenlamp = domoticz.devices['Buitenlamp 1']
		Achterdeur = domoticz.devices['Achterdeur']
		Buitensensor = domoticz.devices['Buitensensor']
		Orientatie = domoticz.devices['Orientatie']
		Beweging = domoticz.devices['Beweging']
		Mode = domoticz.devices['Mode']
		
		print ("Achterdeur "..Achterdeur.state)
		print ("Buitensensor "..Buitensensor.state)
		print ("Orientatie "..Orientatie.state)
		print ("Beweging "..Beweging.state)
		print ("Mode "..Mode.state)
						
		--Buitenlamp schakelen op beweging
		
		if Mode.state == 'Off' and Orientatie.state == 'On' then
		
			--Lampen aan
				domoticz.devices['Lamp achter'].switchOn()
				domoticz.devices['Lamp achter'].dimTo(50)
				domoticz.devices['Lamp tussen'].switchOn()
				domoticz.devices['Lamp tussen'].dimTo(50)
				domoticz.devices['Lamp keuken'].switchOn()
				domoticz.devices['Lamp keuken'].dimTo(50)
				domoticz.devices['Lamp zithoek'].switchOn()
				domoticz.devices['Lamp zithoek'].dimTo(50)
				print ("Orientatieverlichting aan")
		
		elseif Mode.state == 'Off' and Orientatie.state == 'Off' then
				
				--Lampen uit
				domoticz.devices['Lamp achter'].switchOff()
				domoticz.devices['Lamp achter'].dimTo(0)
				domoticz.devices['Lamp tussen'].switchOff()
				domoticz.devices['Lamp tussen'].dimTo(0)
				domoticz.devices['Lamp keuken'].switchOff()
				domoticz.devices['Lamp keuken'].dimTo(0)
				domoticz.devices['Lamp zithoek'].switchOff()
				domoticz.devices['Lamp zithoek'].dimTo(0)
				print ("Orientatieverlichting uit")
		
		end
		
	end
}