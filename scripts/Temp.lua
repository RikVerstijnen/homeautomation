 return {
    active = true,
    on = {
        devices = {
        'TempWoonkamer',
		'Woonkamer-Stat',
		'VerwarmingOmhoog'
        }
    },
    execute = function(domoticz)
		Heating = domoticz.devices('VerwarmingOmhoog').state
		TmpWoonkamer = tonumber(domoticz.devices('TempWoonkamer').temperature)
		StatWoonkamer = tonumber(domoticz.devices('Woonkamer-Stat').state)
		if Heating == 'On' then
			if TmpWoonkamer < StatWoonkamer then
				domoticz.devices('Ketel').switchOn()
			else
				domoticz.devices('Ketel').switchOff()
			end
		elseif Heating == 'Off' then
			if TmpWoonkamer < 15 then
				domoticz.devices('Ketel').switchOn()
			else
				domoticz.devices('Ketel').switchOff()
			end
		end
    end
}