return {
    active = true,
    on = {
        devices = {
		'Beweging',
		'AchterdeurOpen',
		'Buitensensor',
		'VoordeurOpen',
		'Beweging speelkamer'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Beweging = domoticz.devices('Beweging').state
		Achterdeur = domoticz.devices('AchterdeurOpen').state
		Voordeur = domoticz.devices('VoordeurOpen').state
		Buiten = domoticz.devices('Buitensensor').state
		Speelkamer = domoticz.devices('Beweging speelkamer').state
		
		--Extra
		Iemand = domoticz.devices('Iemand thuis').state
		Lux = tonumber(domoticz.devices('Daglicht').state)
		Sproeier = domoticz.devices('Sproeier achter').state
		Mode = domoticz.devices('Mode').state
		LampSpeelkamer = domoticz.devices('Speelkamer').state
		
		--Variabelen
		ModeDelay = domoticz.devices('Mode').lastUpdate.minutesAgo > domoticz.variables('AlarmDelay').value
		IemandDelay = domoticz.devices('Iemand thuis').lastUpdate.minutesAgo > domoticz.variables('AlarmDelay').value
		InsideThreshold = domoticz.variables('LuxThesholdInside').value
		OutsideThreshold = domoticz.variables('LuxThesholdOutside').value
		
		--Iemand Binnen
		if (Beweging == 'On' or Achterdeur == 'On' or Voordeur == 'On' or Speelkamer == 'On') then
			--Thuis en donker
			if (Iemand == 'On' and Mode == 'Auto' and Speelkamer == 'On' and Lux < InsideThreshold) then
				domoticz.devices('Speelkamer').switchOn().forMin(1)
			end			
			--Niet thuis
			if (Iemand == 'Off' and IemandDelay == true) then
				domoticz.notify('Alarm!','Beweging binnen terwijl weg',domoticz.PRIORITY_HIGH)	
			end
			--Thuis en mode uit
			if (Iemand == 'On' and Mode == 'Off' and IemandDelay == true and ModeDealy == true) then
				domoticz.notify('Alarm!','Beweging binnen terwijl slapen',domoticz.PRIORITY_HIGH)	
			end
		end
		
		--Iemand Buiten
		if (Achterdeur == 'On' or Buiten == 'On') then
			--Niet thuis of mode uit
			if (Iemand == 'Off' and IemandDelay == true) then
				domoticz.notify('Alarm!','Beweging buiten terwijl weg',domoticz.PRIORITY_HIGH)	
			end
			--Thuis en mode uit
			if (Iemand == 'On' and Mode == 'Off' and IemandDelay == true and ModeDealy == true) then
				domoticz.notify('Alarm!','Beweging buiten terwijl slapen',domoticz.PRIORITY_HIGH)	
			end
			--Bij schemer buitenlamp aan
			if (domoticz.devices('Mode').state == 'Auto') then
        		if Lux < OutsideThreshold then domoticz.devices('Buitenlamp 1').switchOn() end	
			end
			--Sproeier aan: zet maar uit
			if Sproeier == 'On' then
				domoticz.log("Iemand in de tuin; sproeier uit")
				domoticz.devices('Sproeier achter').switchOff()
			end 
		end
				
    end
}