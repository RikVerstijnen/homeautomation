 return {
    active = true,
    on = {
        devices = {
		'VoordeurOpen'
        }
    },
    execute = function(domoticz,switch)
		domoticz.devices('Voordeur').open()
    end
}