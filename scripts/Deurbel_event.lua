return {
	active = true,  

	on = {
		'Beldrukker'
	},

	execute = function(domoticz)

		domoticz.devices['Deurbel'].switchOn()
		print ("Deurbel gaat")
		domoticz.notify('Deurbel','Deurbel gaat',domoticz.PRIORITY_HIGH)
		
	end
}