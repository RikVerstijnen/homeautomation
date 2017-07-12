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
			--ToDo: Heating up
        elseif (switch.state == 'Auto') then
            domoticz.log('Mode Auto')
		elseif (switch.state == 'Off') then
            domoticz.log('Mode Off')
			domoticz.devices('Lights').switchSelector(0) --Off
			--ToDo: Heating down
			--ToDo: Irrigation off
        end
    end
}