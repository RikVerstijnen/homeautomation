return {
    active = true,
    on = {
        devices = {
		'Beweging',
		'AchterdeurOpen',
		'Buitensensor',
		'VoordeurOpen'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Beweging = domoticz.devices('Beweging').state
		Achterdeur = domoticz.devices('AchterdeurOpen').state
		Voordeur = domoticz.devices('VoordeurOpen').state
		Buiten = domoticz.devices('Buitensensor').state
		
		--Extra
		Iemand = domoticz.devices('Iemand thuis').state
		Lux = tonumber(domoticz.devices('Daglicht').state)
		Sproeier = domoticz.devices('Sproeier achter').state
		Mode = domoticz.devices('Mode').state
		
		--Variabelen
		local Delay = 2
		local ModeDelay = domoticz.devices('Mode').lastUpdate.minutesAgo > Delay
		local IemandDelay = domoticz.devices('Iemand thuis').lastUpdate.minutesAgo > Delay
		
		--Iemand Binnen
		if (Beweging == 'On' or Achterdeur == 'On' or Voordeur == 'On') then
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
				if Lux > 40 then Lux = 40 end
        		if Lux < 12 then domoticz.devices('Buitenlamp 1').switchOn() end	
			end
			--Sproeier aan: zet maar uit
			if Sproeier == 'On' then
				domoticz.log("Iemand in de tuin; sproeier uit")
				domoticz.devices('Sproeier achter').switchOff()
			end 
		end
				
    end
}