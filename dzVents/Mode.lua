 return {
    active = true,
    on = {
        devices = {
            'Mode',
			'Iemand thuis'
        }
    },
    execute = function(domoticz,switch)
		--Triggers
		Iemand = domoticz.devices('Iemand thuis').state
		Mode = domoticz.devices('Mode').state
	
        if (Mode == 'On') then
            domoticz.log('Mode On')
			domoticz.notify('Mode','Mode On',domoticz.PRIORITY_LOWEST)
			domoticz.devices('Lights').switchSelector(10) --Auto
			domoticz.devices('Heating').switchSelector(20) --Comfort
			--domoticz.devices('S_TV').switchOn()
			domoticz.devices('S_DVD speler').switchOn()
			domoticz.devices('S_Interactieve TV').switchOn()
			domoticz.devices('S_Wasmachine').switchOn()
			domoticz.devices('S_Droger').switchOn()
        elseif (Mode == 'Auto') then
            domoticz.log('Mode Auto')
			domoticz.notify('Mode','Mode Auto',domoticz.PRIORITY_LOWEST)			
			if (domoticz.devices('Iemand thuis').state == 'On') then
				domoticz.devices('Lights').switchSelector(10) --Auto
				domoticz.devices('Heating').switchSelector(20) --Comfort
			end
			--Devices on; even when not at home
			--domoticz.devices('S_TV').switchOn()
			domoticz.devices('S_DVD speler').switchOn()
			domoticz.devices('S_Interactieve TV').switchOn()
			domoticz.devices('S_Wasmachine').switchOn()
			domoticz.devices('S_Droger').switchOn()
		elseif (Mode == 'Off') then
            domoticz.log('Mode Off')
			domoticz.notify('Mode','Mode Off',domoticz.PRIORITY_LOWEST)
			domoticz.devices('Lights').switchSelector(0) --Off
			domoticz.devices('Heating').switchSelector(10) --Eco
			--domoticz.devices('S_TV').switchOff()
			domoticz.devices('S_DVD speler').switchOff()
			domoticz.devices('S_Interactieve TV').switchOff()
			domoticz.devices('S_Wasmachine').switchOff()
			domoticz.devices('S_Droger').switchOff()
			domoticz.devices('Sproeier achter').switchOff()
			end
    end
}