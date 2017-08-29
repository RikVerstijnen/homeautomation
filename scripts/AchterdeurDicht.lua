 return {
    active = true,
    on = {
        devices = {
		'AchterdeurDicht'
        }
    },
    execute = function(domoticz,switch)
		domoticz.devices('Achterdeur').close()
    end
}