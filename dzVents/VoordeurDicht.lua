 return {
    active = true,
    on = {
        devices = {
		'VoordeurDicht'
        }
    },
    execute = function(domoticz,switch)
		domoticz.devices('Voordeur').close()
    end
}