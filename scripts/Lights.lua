 return {
    active = true,
    on = {
        devices = {
            'Lights'
        }
    },
    execute = function(domoticz,switch)
        if (switch.state == 'Full') then
            domoticz.log('Lights Full')
			domoticz.devices('Buitenlamp 1').switchOn()
			domoticz.devices('Lamp achter').dimTo(100)			
			domoticz.devices('Lamp achter').switchOn()
			domoticz.devices('Lamp tussen').dimTo(100)
			domoticz.devices('Lamp tussen').switchOn()
			domoticz.devices('Lamp keuken').dimTo(100)
			domoticz.devices('Lamp keuken').switchOn()
			domoticz.devices('Lamp zithoek').dimTo(100)
			domoticz.devices('Lamp zithoek').switchOn()
			domoticz.devices('Schemerlampen').dimTo(100)
        elseif (switch.state == 'Auto') then
            domoticz.log('Lights Auto')
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
		elseif (switch.state == 'Off') then
            domoticz.log('Lights Off')
			domoticz.devices('Buitenlamp 1').switchOff()
			domoticz.devices('Lamp achter').switchOff()
			domoticz.devices('Lamp tussen').switchOff()
			domoticz.devices('Lamp keuken').switchOff()
			domoticz.devices('Lamp zithoek').switchOff()
			domoticz.devices('Schemerlampen').dimTo(0)
        end
    end
}