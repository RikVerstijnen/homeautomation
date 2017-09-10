return {
    active = true,
    on = {
        devices = {
        'Rik is thuis',
		'Sabine is thuis'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Rik = domoticz.devices('Rik is thuis').state
		Sabine = domoticz.devices('Sabine is thuis').state
		
		--Extra
		Iemand = domoticz.devices('Iemand thuis').state
		
		--Iemand thuis
		if (Rik == 'On' or Sabine == 'On') and Iemand == 'Off' then
			domoticz.log("Iemand thuis")
			domoticz.notify('Aanwezigheid','Iemand thuis',domoticz.PRIORITY_LOWEST)
			domoticz.devices('Iemand thuis').switchOn()
		end
				
		--Niemand thuis
		if (Rik == 'Off' and Sabine == 'Off') and Iemand == 'On' then
			domoticz.log("Niemand thuis")
			domoticz.notify('Aanwezigheid','Niemand thuis',domoticz.PRIORITY_LOWEST)
			domoticz.devices('Iemand thuis').switchOff()
		end
		
    end
}