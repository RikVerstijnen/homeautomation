 return {
    active = true,
    on = {
        devices = {
		'VoordeurOpen',
		'VoordeurDicht'
        }
    },
    execute = function(domoticz,switch)
		if VoordeurOpen.state == 'On' then
			domoticz.changedDevices('Voordeur').Open()
			domoticz.log('Voordeur open')
		elseif VoordeurDicht.state == 'On' then
			domoticz.changedDevices('Voordeur').Close()
			domoticz.log('Voordeur dicht')
		end
    end
}