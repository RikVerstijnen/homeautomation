 return {
    active = true,
    on = {
        devices = {
            'Lights',
			'Daglicht 2'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Lights = domoticz.devices('Lights').state
		Daglicht = domoticz.devices('Daglicht 2').state
		
		local Lux = tonumber(Daglicht)
		local Factor
		
		if Lux > 50 then 
			Factor = 50
		else
			Factor = Lux
		end
		
		if (Lights == 'Full') then
            domoticz.log('Lights Full')
			--Set Milight to white
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=230&switchcmd=Set%20Level&level=' .. tostring(100))
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=230')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=231&switchcmd=Set%20Level&level=' .. tostring(100))
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=231')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=232&switchcmd=Set%20Level&level=' .. tostring(100))
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=232')
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=233&switchcmd=Set%20Level&level=' .. tostring(100))
			domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=233')
			domoticz.devices('Schemerlampen').dimTo(100)
        elseif (Lights == 'Auto') then
            domoticz.log('Lights Auto')
			if Factor < 12 then 
				domoticz.log('Dark; switch on lights outside')
				domoticz.devices('Buitenlamp 1').switchOn() 
			else
				domoticz.log('Light; switch off lights outside')
				domoticz.devices('Buitenlamp 1').switchOff()
			end
			if Factor == 50 then
				domoticz.log('Light; switch off lights inside')
				domoticz.devices('Buitenlamp 1').switchOff()
				domoticz.devices('Lamp achter').switchOff()
				domoticz.devices('Lamp tussen').switchOff()
				domoticz.devices('Lamp keuken').switchOff()
				domoticz.devices('Lamp zithoek').switchOff()
				domoticz.devices('Schemerlampen').dimTo(0)
			else
				domoticz.log('Adjust light intensity; Factor = '..Factor)
				--Set Milight to white
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=230&switchcmd=Set%20Level&level=' .. tostring(50-Factor))
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=230')
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=231&switchcmd=Set%20Level&level=' .. tostring(50-Factor))
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=231')
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=232&switchcmd=Set%20Level&level=' .. tostring(50-Factor))
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=232')
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=233&switchcmd=Set%20Level&level=' .. tostring(50-Factor))
				domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=233')
				domoticz.devices('Lamp zithoek').switchOn()
				domoticz.devices('Schemerlampen').dimTo(60-Factor) --Between 10 and 60
			end
		elseif (Lights == 'Off') then
            domoticz.log('Lights Off')
			domoticz.devices('Buitenlamp 1').switchOff()
			domoticz.devices('Lamp achter').switchOff()
			domoticz.devices('Lamp achter').dimTo(0)
			domoticz.devices('Lamp tussen').switchOff()
			domoticz.devices('Lamp tussen').dimTo(0)
			domoticz.devices('Lamp keuken').switchOff()
			domoticz.devices('Lamp keuken').dimTo(0)
			domoticz.devices('Lamp zithoek').switchOff()
			domoticz.devices('Lamp zithoek').dimTo(0)
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