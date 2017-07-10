return {
	active = false,  

	on = {
		'Achterdeur',
		'Buitensensor',
		'Beweging'
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
		
		if (Achterdeur.state == 'Open' or Buitensensor.state == 'On' or Beweging.state == 'On') and Mode.state == 'Off' and Orientatie.state == 'Off' and domoticz.time.isNightTime then
			
			--Lampen even aan
				domoticz.devices['Buitenlamp 1'].switchOn('FOR 2')
				domoticz.devices['Lamp achter'].switchOn('FOR 2')
				domoticz.devices['Lamp achter'].dimTo(10)
				domoticz.devices['Lamp tussen'].switchOn('FOR 2')
				domoticz.devices['Lamp tussen'].dimTo(10)
				domoticz.devices['Lamp keuken'].switchOn('FOR 2')
				domoticz.devices['Lamp keuken'].dimTo(10)
				domoticz.devices['Lamp zithoek'].switchOn('FOR 2')
				domoticz.devices['Lamp zithoek'].dimTo(10)
				print ("Beweging nacht - Verlichting aan")
				domoticz.notify('Beweging nacht','Beweging nacht - Verlichting aan',domoticz.PRIORITY_HIGH)
		end
		
	end
}