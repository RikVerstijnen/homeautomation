return {
    active = true,
    on = {
        devices = {
		'Beweging speelkamer'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
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
		--Thuis en donker
			if (Iemand == 'On' and Mode == 'Auto' and Speelkamer == 'On' and Lux < InsideThreshold) then
				domoticz.devices('Speelkamer').switchOn().forMin(1)
			end			
						
    end
}