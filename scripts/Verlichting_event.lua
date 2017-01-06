return {
	active = true,  

	on = {
		'Achterdeur',
		'Buitensensor',
		'Slapen',
		'Daglicht',
		'Iemand thuis'
	},

	execute = function(domoticz)

		Buitenlamp = domoticz.devices['Buitenlamp 1']
		Slapen = domoticz.devices['Slapen']
		Achterdeur = domoticz.devices['Achterdeur']
		Buitensensor = domoticz.devices['Buitensensor']
		local Achter = domoticz.devices['Lamp achter']
		local Tussen = domoticz.devices['Lamp tussen']
		local Keuken = domoticz.devices ['Lamp keuken']
		local Zit = domoticz.devices ['Lamp zithoek']
		local Lux = tonumber(domoticz.devices['Daglicht'].state)
		local Thuis = domoticz.devices['Iemand thuis']
		local Simulatie = domoticz.devices['Simulatie']
				
		print ("Achterdeur"..Achterdeur.state)
		print ("Buitensensor"..Buitensensor.state)
		print ("Slapen"..Slapen.state)
		print ("Thuis"..Thuis.state)
		
		--Binnenverlichting op lichtsterkte
		print ("Lux "..Lux)
		
		--Zorgen dat lux altijd tussen 0 (verlichting brandt 50) en 50 (verlichting brandt 0) is
		if Lux > 50 then Lux = 50 end
		
		if Slapen.state == 'Off' and (Thuis.state == 'On' or Simulatie.state == 'On') then
			
			if Lux < 10 then domoticz.devices['Buitenlamp 1'].switchOn() end
			domoticz.devices['Lamp achter'].switchOn()
			domoticz.devices['Lamp achter'].dimTo(50-Lux)
			domoticz.devices['Lamp tussen'].switchOn()
			domoticz.devices['Lamp tussen'].dimTo(50-Lux)
			domoticz.devices['Lamp keuken'].switchOn()
			domoticz.devices['Lamp keuken'].dimTo(50-Lux)
			domoticz.devices['Lamp zithoek'].switchOn()
			domoticz.devices['Lamp zithoek'].dimTo(50-Lux)
			domoticz.notify('Donker - Verlichting aan#Donker - Verlichting aan#-2')
			print ("Donker - Binnenverlichting aan")	
		
		--Buitenlamp schakelen op beweging
		
		elseif ((Achterdeur.state == 'Open' or Buitensensor.state == 'On') and (Buitenlamp.state == 'Off')) then
			
			if (domoticz.time.isNightTime) then
				domoticz.devices['Buitenlamp 1'].switchOn('FOR 2')
				domoticz.notify('Beweging tuin nacht - Buitenlamp aan#Beweging tuin nacht - Buitenlamp aan#-2')
				print ("Beweging tuin nacht - Buitenlamp aan")
			elseif (domoticz.time.isDayTime) then
				domoticz.notify('Beweging tuin overdag#Beweging tuin overdag#-2')
				print ("Beweging tuin overdag")
			end
		
		--Verlichting uit als weg, slapen of licht
			
		elseif (Lux >= 10 or Slapen.state == 'On' or Thuis.state == 'Off') and (Buitenlamp.state == 'On' or Achter.state == 'On' or Tussen.state == 'On' or Zit.state == 'On' or Keuken.state == 'On') then
			domoticz.devices['Buitenlamp 1'].switchOff()
			domoticz.devices['Lamp achter'].switchOff()
			domoticz.devices['Lamp tussen'].switchOff()
			domoticz.devices['Lamp zithoek'].switchOff()
			domoticz.devices['Lamp keuken'].switchOff()
			domoticz.notify('Slapen - Verlichting uit#Slapen - Verlichting uit#-2')
			print ("Slapen - Verlichting uit")
		end
		
	end
}