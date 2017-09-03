 return {
    active = true,
    on = {
        devices = {
		'AchterdeurOpen'
        }
    },
    execute = function(domoticz,switch)
		domoticz.devices('Achterdeur').open()
    end
}