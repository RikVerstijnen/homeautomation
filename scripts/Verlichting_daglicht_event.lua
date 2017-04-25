return {
	active = true,  

	on = {
		'Mode',
		'Daglicht',
		'Iemand thuis'
	},

	execute = function(domoticz)

		Buitenlamp = domoticz.devices['Buitenlamp 1']
		Mode = domoticz.devices['Mode']
		Buitensensor = domoticz.devices['Buitensensor']
		Achter = domoticz.devices['Lamp achter']
		Tussen = domoticz.devices['Lamp tussen']
		Keuken = domoticz.devices ['Lamp keuken']
		Zit = domoticz.devices ['Lamp zithoek']
		Lux = tonumber(domoticz.devices['Daglicht'].state)
		Thuis = domoticz.devices['Iemand thuis']
		Orientatie = domoticz.devices['Orientatie']
				
		print ("Buitensensor "..Buitensensor.state)
		print ("Mode "..Mode.state)
		print ("Thuis "..Thuis.state)
		print ("Orientatie "..Orientatie.state)
		
		--Zorgen dat orientatie niet altijd aan blijft staan
		if (Mode.state == 'Off' and Mode.attributeChanged('state')) then domoticz.devices['Orientatie'].switchOff() end
		
		--Binnenverlichting op lichtsterkte
		print ("Lux "..Lux)
		
		--Zorgen dat lux altijd tussen 0 (verlichting brandt 50) en 50 (verlichting brandt 0) is
		if Lux > 50 then Lux = 50 end
		
		if (Mode.state == 'On') or (Mode.state == 'Auto' and Thuis.state == 'On') then
			
			if Lux < 12 then 
				domoticz.devices['Buitenlamp 1'].switchOn() 
			else
				domoticz.devices['Buitenlamp 1'].switchOff()
			end
			domoticz.devices['Lamp achter'].switchOn()
			domoticz.devices['Lamp achter'].dimTo(50-Lux)
			domoticz.devices['Lamp achter'].update(hue,274) -- Test
			domoticz.devices['Lamp tussen'].switchOn()
			domoticz.devices['Lamp tussen'].dimTo(50-Lux)
			domoticz.devices['Lamp keuken'].switchOn()
			domoticz.devices['Lamp keuken'].dimTo(50-Lux)
			domoticz.devices['Lamp zithoek'].switchOn()
			domoticz.devices['Lamp zithoek'].dimTo(50-Lux)
			domoticz.devices['Schemerlampen'].dimTo(60-Lux)
			domoticz.notify('Donker - Verlichting aan#Donker - Verlichting aan#-2')
			print ("Donker - Binnenverlichting aan")	
		
		--Verlichting uit als weg, uit of licht
			
		elseif (Orientatie.state == 'Off' and (Lux >= 12 or Mode.state == 'Off' or (Mode.state == 'Auto' and Thuis.state == 'Off')))
		and (Buitenlamp.state == 'On' or Achter.state == 'On' or Tussen.state == 'On' or Zit.state == 'On' or Keuken.state == 'On') then
			domoticz.devices['Buitenlamp 1'].switchOff()
			domoticz.devices['Lamp achter'].switchOff()
			domoticz.devices['Lamp tussen'].switchOff()
			domoticz.devices['Lamp zithoek'].switchOff()
			domoticz.devices['Lamp keuken'].switchOff()
			domoticz.devices['Schemerlampen'].dimTo(0)
			domoticz.notify('Slapen - Verlichting uit#Slapen - Verlichting uit#-2')
			print ("Slapen - Verlichting uit")		

		end
		
	end
}