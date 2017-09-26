 return {
    active = true,
    on = {
        devices = {
            'Lights',
			'Daglicht',
			'Iemand thuis'
        }
    },
	data = {
        previousLux = { initial = 1000 }
    },
    execute = function(domoticz,switch)
			
		--Triggers
		Lights = domoticz.devices('Lights').state
		Daglicht = domoticz.devices('Daglicht').state
		
		--Extra
		local Lux = tonumber(Daglicht)
		local Factor
		local InsideThreshold = domoticz.variables('LuxThesholdInside').value
		local OutsideThreshold = domoticz.variables('LuxThesholdOutside').value
		
		if Daglicht == domoticz.data.previousLux then --or trigger != Lights/Daglicht!!
		
			domoticz.log('Lux did not change; abort')
		
		else
				
			if Lux > InsideThreshold then 
				Factor = InsideThreshold
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
				if Factor < OutsideThreshold and domoticz.devices('Buitenlamp 1').state == 'Off' then 
					domoticz.log('Dark; switch on lights outside')
					domoticz.notify('Lights','Dark; switch on lights outside',domoticz.PRIORITY_LOWEST)
					domoticz.devices('Buitenlamp 1').switchOn() 
				elseif Factor >= OutsideThreshold and domoticz.devices('Buitenlamp 1').state == 'On' then 
					domoticz.log('Light; switch off lights outside')
					domoticz.notify('Lights','Light; switch off lights outside',domoticz.PRIORITY_LOWEST)
					domoticz.devices('Buitenlamp 1').switchOff()
				end
				if Factor == InsideThreshold and domoticz.devices('Schemerlampen').level > 0 then
					domoticz.log('Light; switch off lights inside')
					domoticz.notify('Lights','Light; switch off lights outside',domoticz.PRIORITY_LOWEST)
					domoticz.devices('Buitenlamp 1').switchOff()
					domoticz.devices('Lamp achter').switchOff()
					domoticz.devices('Lamp tussen').switchOff()
					domoticz.devices('Lamp keuken').switchOff()
					domoticz.devices('Lamp zithoek').switchOff()
					domoticz.devices('Schemerlampen').dimTo(0)
				elseif Factor < InsideThreshold then
					--ToDo: Only adjust if last adjustment was longer than x minutes ago
					domoticz.log('Adjust light intensity; Factor = '..Factor)
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=230&switchcmd=Set%20Level&level=' .. tostring(InsideThreshold-Factor))
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=230')
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=231&switchcmd=Set%20Level&level=' .. tostring(InsideThreshold-Factor))
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=231')
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=232&switchcmd=Set%20Level&level=' .. tostring(InsideThreshold-Factor))
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=232')
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=switchlight&idx=233&switchcmd=Set%20Level&level=' .. tostring(InsideThreshold-Factor))
					domoticz.openURL('http://192.168.1.200:8080/json.htm?type=command&param=whitelight&idx=233')
					domoticz.devices('Lamp zithoek').switchOn()
					domoticz.devices('Schemerlampen').dimTo(InsideThreshold+10-Factor) --Between 10 and 60
				end
			elseif (Lights == 'Off' and domoticz.devices('Buitenlamp 1').state == 'On') then
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