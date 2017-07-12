 return {
    active = true,
    on = {
        devices = {
            'Daglicht'
        }
    },
    execute = function(domoticz
	)
        if (domoticz.devices('Lights').state == 'Auto') then
			domoticz.log('Adjust light intensity')
			Lux = tonumber(domoticz.devices('Daglicht').state)
			if Lux > 50 then Lux = 50 end
			if Lux < 12 then 
				domoticz.devices('Buitenlamp 1').switchOn() 
			else
				domoticz.devices('Buitenlamp 1').switchOff()
			end
			domoticz.devices('Lamp achter').dimTo(50-Lux)
			domoticz.devices('Lamp achter').switchOn()
			domoticz.devices('Lamp tussen').dimTo(50-Lux)
			domoticz.devices('Lamp tussen').switchOn()
			domoticz.devices('Lamp keuken').dimTo(50-Lux)
			domoticz.devices('Lamp keuken').switchOn()
			domoticz.devices('Lamp zithoek').dimTo(50-Lux)
			domoticz.devices('Lamp zithoek').switchOn()
			domoticz.devices('Schemerlampen').dimTo(60-Lux)
		end
    end
}