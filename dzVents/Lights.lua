 return {
    active = true,
    on = {
        devices = {
            'Lights',
			'Daglicht'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Lights = domoticz.devices('Lights').state
		Daglicht = domoticz.devices('Daglicht').state
		
		local Lux = tonumber(domoticz.devices('Daglicht').state)
		if Lux > 40 then Lux = 40 end -- Lux between 0 and 50
		if (Lights == 'Full') then
            domoticz.log('Lights Full')
			--Set Milight to white
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=230')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=231')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=232')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=233')
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
        elseif (Lights == 'Auto') then
            domoticz.log('Lights Auto')
			if Lux < 12 then 
				domoticz.devices('Buitenlamp 1').switchOn() 
			else
				domoticz.devices('Buitenlamp 1').switchOff()
			end
			if Lux == 40 then
				domoticz.devices('Buitenlamp 1').switchOff()
				domoticz.devices('Lamp achter').switchOff()
				domoticz.devices('Lamp tussen').switchOff()
				domoticz.devices('Lamp keuken').switchOff()
				domoticz.devices('Lamp zithoek').switchOff()
				domoticz.devices('Schemerlampen').dimTo(0)
			else
				--Set Milight to white
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=230')
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=231')
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=232')
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=233')
				domoticz.devices('Lamp achter').dimTo(50-Lux) --Between 10 and 50
				domoticz.devices('Lamp achter').switchOn()
				domoticz.devices('Lamp tussen').dimTo(50-Lux) --Between 10 and 50
				domoticz.devices('Lamp tussen').switchOn()
				domoticz.devices('Lamp keuken').dimTo(60-Lux) --Between 20 and 60
				domoticz.devices('Lamp keuken').switchOn()
				domoticz.devices('Lamp zithoek').dimTo(50-Lux) --Between 10 and 50
				domoticz.devices('Lamp zithoek').switchOn()
				domoticz.devices('Schemerlampen').dimTo(60-Lux) --Between 20 and 60
			end
		elseif (Lights == 'Off') then
            domoticz.log('Lights Off')
			domoticz.devices('Buitenlamp 1').switchOff()
			domoticz.devices('Lamp achter').switchOff()
			domoticz.devices('Lamp tussen').switchOff()
			domoticz.devices('Lamp keuken').switchOff()
			domoticz.devices('Lamp zithoek').switchOff()
			domoticz.devices('Schemerlampen').dimTo(0)
		elseif (Lights == 'Disco') then
            domoticz.log('Disco!!')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=discomodenum5&idx=230')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=discomodenum5&idx=231')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=discomodenum5&idx=232')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=discomodenum5&idx=233')
			domoticz.devices('Lamp achter').dimTo(100)			
			domoticz.devices('Lamp achter').switchOn()
			domoticz.devices('Lamp tussen').dimTo(100)
			domoticz.devices('Lamp tussen').switchOn()
			domoticz.devices('Lamp keuken').dimTo(100)
			domoticz.devices('Lamp keuken').switchOn()
			domoticz.devices('Lamp zithoek').dimTo(100)
			domoticz.devices('Lamp zithoek').switchOn()
			domoticz.devices('Schemerlampen').switchOff()
        end
    end
}