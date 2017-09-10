 return {
    active = true,
    on = {
        devices = {
            'Lights',
			'Daglicht'
        }
    },
	data = {
        previousLux = { initial = 1000 }
    },
    execute = function(domoticz,switch)
			
		--Triggers
		Lights = domoticz.devices('Lights').state
		Daglicht = domoticz.devices('Daglicht').state
		
		local Lux = tonumber(Daglicht)
		local Factor
		
		if Daglicht == domoticz.data.previousLux then
		
			domoticz.log('Lux did not change; abort')
		
		else
				
			if Lux > 50 then 
				Factor = 50
			else
				Factor = Lux
			end
		
			if (Lights == 'Full') then
				domoticz.log('Lights Full')
				domoticz.notify('Lights','Lights full',domoticz.PRIORITY_LOWEST)
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
				if Factor < 12 and domoticz.devices('Buitenlamp 1').state == Off then 
					domoticz.log('Dark; switch on lights outside')
					domoticz.notify('Lights','Dark; switch on lights outside',domoticz.PRIORITY_LOWEST)
					domoticz.devices('Buitenlamp 1').switchOn() 
				elseif Factor >= 12 and domoticz.devices('Buitenlamp 1').state == On then 
					domoticz.log('Light; switch off lights outside')
					domoticz.notify('Lights','Light; switch off lights outside',domoticz.PRIORITY_LOWEST)
					domoticz.devices('Buitenlamp 1').switchOff()
				end
				if Factor == 50 and domoticz.devices('Schemerlampen').level > 0 then
					domoticz.log('Light; switch off lights inside')
					domoticz.notify('Lights','Light; switch off lights outside',domoticz.PRIORITY_LOWEST)
					domoticz.devices('Buitenlamp 1').switchOff()
					domoticz.devices('Lamp achter').switchOff()
					domoticz.devices('Lamp tussen').switchOff()
					domoticz.devices('Lamp keuken').switchOff()
					domoticz.devices('Lamp zithoek').switchOff()
					domoticz.devices('Schemerlampen').dimTo(0)
				elseif Factor > 50 and domoticz.devices('Schemerlampen').level == 0 then
					domoticz.log('Adjust light intensity; Factor = '..Factor)
					domoticz.notify('Lights','Adjust light intensity; Factor = '..Factor,domoticz.PRIORITY_LOWEST)
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
				domoticz.notify('Lights','Switch off lights',domoticz.PRIORITY_LOWEST)
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
				domoticz.notify('Lights','Turn on disco mode',domoticz.PRIORITY_LOWEST)
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
		
		-- store current value for next cycle
        domoticz.data.previousLux = Lux
		
	end
}