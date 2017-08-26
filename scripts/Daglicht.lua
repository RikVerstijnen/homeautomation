 return {
    active = true,
    on = {
        devices = {
            'Daglicht'
        }
    },
    execute = function(domoticz)
		local Lux = tonumber(domoticz.devices('Daglicht').state)
		if Lux > 50 then Lux = 50 end
        if (domoticz.devices('Lights').state == 'Auto') then
			if Lux < 12 then 
				domoticz.devices('Buitenlamp 1').switchOn() 
			else
				domoticz.devices('Buitenlamp 1').switchOff()
			end
			if Lux == 50 then
				domoticz.log('Too light; switch off lights')
				domoticz.devices('Buitenlamp 1').switchOff()
				domoticz.devices('Lamp achter').switchOff()
				domoticz.devices('Lamp tussen').switchOff()
				domoticz.devices('Lamp keuken').switchOff()
				domoticz.devices('Lamp zithoek').switchOff()
				domoticz.devices('Schemerlampen').dimTo(0)
			else
				domoticz.log('Adjust light intensity')
				domoticz.devices('Lamp achter').dimTo(50-Lux)
				domoticz.devices('Lamp achter').switchOn()
				domoticz.devices('Lamp tussen').dimTo(50-Lux)
				domoticz.devices('Lamp tussen').switchOn()
				domoticz.devices('Lamp keuken').dimTo(60-Lux)
				domoticz.devices('Lamp keuken').switchOn()
				domoticz.devices('Lamp zithoek').dimTo(50-Lux)
				domoticz.devices('Lamp zithoek').switchOn()
				domoticz.devices('Schemerlampen').dimTo(60-Lux)
				domoticz.log('Adjust light intensity done')
			end
		end
    end
}