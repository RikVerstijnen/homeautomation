 return {
    active = true,
    on = {
        devices = {
        'Rik is thuis',
		'Sabine is thuis',
		'Beweging',
		'Achterdeur',
		'Buitensensor',
		'Auto thuis',
		'VoordeurOpen'
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
		if Iemand == 'Off' and (Rik == 'On' or Sabine == 'On' or Beweging == 'On' or Achterdeur.state == 'Open' or Buitensensor.state == 'On' or Auto == 'On' or VoordeurOpen == 'On') then
			domoticz.log("Iemand thuis")
			domoticz.devices('Iemand thuis').switchOn()
			if (domoticz.devices('Mode').state == 'Auto') then
				domoticz.devices('Lights').switchSelector(10) --Auto
				domoticz.devices('Heating').SwitchOn()
			end
			--ToDo: Alarm when mode = Off
			--domoticz.notify('Alarm!','Beweging terwijl mode Off is',domoticz.PRIORITY_EMERGENCY)
		elseif Iemand == 'On' and (Rik == 'Off' and Sabine == 'Off' and Beweging == 'Off' and Auto == 'Off') then
			domoticz.log("Niemand thuis")
			domoticz.devices('Iemand thuis').switchOff()
			if (domoticz.devices('Mode').state == 'Auto') then
				domoticz.devices('Lights').switchSelector(0) --Off
				domoticz.devices('Heating').SwitchOff()
			end
		end
    end
}