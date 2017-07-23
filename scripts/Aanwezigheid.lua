 return {
    active = true,
    on = {
        devices = {
        'Rik is thuis',
		'Sabine is thuis',
		'Beweging',
		'Achterdeur',
		'Buitensensor',
		'Auto thuis'
        }
    },
    execute = function(domoticz,switch)
		Rik = domoticz.devices('Rik is thuis').state
		Sabine = domoticz.devices('Sabine is thuis').state
		Beweging = domoticz.devices('Beweging').state
		Iemand = domoticz.devices('Iemand thuis').state
		Achterdeur = domoticz.devices('Achterdeur').state
		Buiten = domoticz.devices('Buitensensor').state
		Auto = domoticz.devices('Auto thuis').state
		if Iemand == 'Off' and (Rik == 'On' or Sabine == 'On' or Beweging == 'On' or Achterdeur.state == 'Open' or Buitensensor.state == 'On' or Auto == 'On') then
			domoticz.log("Iemand thuis")
			domoticz.devices('Iemand thuis').switchOn()
			if (domoticz.devices('Mode').state == 'Auto') then
				domoticz.devices('Lights').switchSelector(10) --Auto
				--ToDo: Heating up
			end
			--ToDo: Alarm when mode = Off
		elseif Iemand == 'On' and (Rik == 'Off' and Sabine == 'Off' and Beweging == 'Off' and Auto == 'Off') then
			domoticz.log("Niemand thuis")
			domoticz.devices('Iemand thuis').switchOff()
			if (domoticz.devices('Mode').state == 'Auto') then
				domoticz.devices('Lights').switchSelector(0) --Off
				--ToDo: Heating down
			end
		end
    end
}