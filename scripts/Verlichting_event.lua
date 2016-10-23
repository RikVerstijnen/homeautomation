return {
	active = true,  

	on = {
		'Achterdeur',
		'Buitensensor',
		'Slapen'
	},

	execute = function(domoticz)

		Buitenlamp = domoticz.devices['Buitenlamp 1']
		Slapen = domoticz.devices['Slapen']
		Achterdeur = domoticz.devices['Achterdeur']
		Buitensensor = domoticz.devices['Buitensensor']
		Tussen = domoticz.devices['Lamp tussen']
		Slapen = domoticz.devices['Slapen']
		
		print ("Achterdeur")
		print (Achterdeur.state)
		print ("Buitensensor")
		print (Buitensensor.state)
		print ("Slapen")
		print (Slapen.state)
		
		--Buitenlamp schakelen op beweging
		
		if ((Achterdeur.state == 'Open' or Buitensensor.state == 'On') and (Buitenlamp.state == 'Off')) then
			
			if (domoticz.time.isNightTime) then
				domoticz.devices['Buitenlamp 1'].switchOn('FOR 2')
				domoticz.notify('Beweging tuin nacht - Buitenlamp aan#Beweging tuin nacht - Buitenlamp aan#-2')
				print ("Beweging tuin nacht - Buitenlamp aan")
			elseif (domoticz.time.isDayTime) then
				domoticz.notify('Beweging tuin overdag#Beweging tuin overdag#-2')
				print ("Beweging tuin overdag")
			end
		
		--Verlichting uit als naar bed
			
		elseif (Slapen.state == 'On') and (Buitenlamp.state == 'On' or Achter.state == 'On' or Tussen.state == 'On') then
			domoticz.devices['Buitenlamp 1'].switchOff()
			domoticz.devices['Lamp achter'].switchOff()
			domoticz.devices['Lamp tussen'].switchOff()
			domoticz.notify('Slapen - Verlichting uit#Slapen - Verlichting uit#-2')
			print ("Slapen - Verlichting uit")
		end
		
	end
}