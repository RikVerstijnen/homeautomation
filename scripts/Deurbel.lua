 return {
    active = true,
    on = {
        devices = {
            'Beldrukker'
        }
    },
    execute = function(domoticz,switch)
		domoticz.devices('Deurbel').switchOn()
		domoticz.log("Deurbel gaat")
		domoticz.notify('Deurbel','Deurbel gaat',domoticz.PRIORITY_HIGH)
    end
}