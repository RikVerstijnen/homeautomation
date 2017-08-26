 return {
    active = true,
    on = {
        devices = {
            'Mode'
        }
    },
    execute = function(domoticz,switch)
        if (switch.state == 'On') then
            domoticz.log('Mode On')
			domoticz.devices('Lights').switchSelector(10) --Auto
			domoticz.devices('VerwarmingOmhoog').SwitchOn()
			domoticz.devices('S_TV').SwitchOn()
			domoticz.devices('S_DVD speler').SwitchOn()
			domoticz.devices('S_Interactieve TV').SwitchOn()
			domoticz.devices('S_Wasmachine').SwitchOn()
			domoticz.devices('S_Droger').SwitchOn()
        elseif (switch.state == 'Auto') then
            domoticz.log('Mode Auto')		
			if (domoticz.devices('Iemand thuis').state == 'On') then
				domoticz.devices('Lights').switchSelector(10) --Auto
				domoticz.devices('VerwarmingOmhoog').SwitchOn()
			end
			--Devices on; even when not at home
			domoticz.devices('S_TV').SwitchOn()
			domoticz.devices('S_DVD speler').SwitchOn()
			domoticz.devices('S_Interactieve TV').SwitchOn()
			domoticz.devices('S_Wasmachine').SwitchOn()
			domoticz.devices('S_Droger').SwitchOn()
		elseif (switch.state == 'Off') then
            domoticz.log('Mode Off')
			domoticz.devices('Lights').switchSelector(0) --Off
			domoticz.devices('VerwarmingOmhoog').SwitchOff()
			domoticz.devices('S_TV').SwitchOff()
			domoticz.devices('S_DVD speler').SwitchOff()
			domoticz.devices('S_Interactieve TV').SwitchOff()
			domoticz.devices('S_Wasmachine').SwitchOff()
			domoticz.devices('S_Droger').SwitchOff()
			domoticz.devices('Sproeier achter').SwitchOff()
			end
    end
}