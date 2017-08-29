return {
    active = true,
    on = {
        devices = {
        'Rik is thuis',
		'Sabine is thuis',
		'Beweging',
		'AchterdeurOpen',
		'Buitensensor',
		'VoordeurOpen'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Rik = domoticz.devices('Rik is thuis').state
		Sabine = domoticz.devices('Sabine is thuis').state
		Beweging = domoticz.devices('Beweging').state
		Achterdeur = domoticz.devices('AchterdeurOpen').state
		Voordeur = domoticz.devices('VoordeurOpen').state
		Buiten = domoticz.devices('Buitensensor').state
		
		--Extra
		Iemand = domoticz.devices('Iemand thuis').state
		Lux = tonumber(domoticz.devices('Daglicht').state)
		Sproeier = domoticz.devices('Sproeier achter').state
		
		--Iemand Binnen
		if (Rik == 'On' or Sabine == 'On' or Beweging == 'On' or Achterdeur == 'On' or Voordeur == 'On') then
			if Iemand == 'Off' then
				domoticz.log("Iemand thuis")
				domoticz.devices('Iemand thuis').switchOn()
			end
			if (domoticz.devices('Mode').state == 'Auto') then
				domoticz.devices('Lights').switchSelector(10) --Auto
				domoticz.devices('VerwarmingOmhoog').switchOn()
			end
			--ToDo: Alarm when mode = Off
			--domoticz.notify('Alarm!','Beweging terwijl mode Off is',domoticz.PRIORITY_EMERGENCY)
		end
		
		--Iemand Buiten
		if (Achterdeur == 'On' or Buiten == 'On') then
			if Iemand == 'Off' then
				domoticz.log("Iemand thuis")
				domoticz.devices('Iemand thuis').switchOn()
			end
			if (domoticz.devices('Mode').state == 'Auto') then
				if Lux > 40 then Lux = 40 end
        		if Lux < 12 then domoticz.devices('Buitenlamp 1').switchOn() end	
			end
			if Sproeier == 'On' then
				domoticz.log("Iemand in de tuin; sproeier uit")
				domoticz.devices('Sproeier achter').switchOff()
			end 
			--ToDo: Alarm when mode = Off
			--domoticz.notify('Alarm!','Beweging terwijl mode Off is',domoticz.PRIORITY_EMERGENCY)
		end
		
		--Niemand thuis
		if Iemand == 'On' and (Rik == 'Off' and Sabine == 'Off' and Beweging == 'Off' and Auto == 'Off') then
			domoticz.log("Niemand thuis")
			domoticz.devices('Iemand thuis').switchOff()
			if (domoticz.devices('Mode').state == 'Auto') then
				domoticz.devices('Lights').switchSelector(0) --Off
				domoticz.devices('VerwarmingOmhoog').switchOff()
			end
		end
		
    end
}