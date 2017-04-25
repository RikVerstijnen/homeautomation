class Dashing.Riklist extends Dashing.Widget
	@accessor 'items'
	constructor: ->
		super
		console.log("id = " + @id)
	
	addComposite: ->
		device_names = @get('devices')
		console.log("devices = " + device_names)
		widget = this

		Dashing.add_composite(@id, (id, devices) -> 
			data = 
				id: id
			room = id
			data["items"] = []
			for device_name in device_names.split(",")
					data["items"].push
						label: device_name
						value: devices[device_name]?.Data
			console.log(data)
			return data
		)
		#Dashing.update_composites(Dashing.lastEvents)
	ready: ->
		if 0
			if @get('unordered')
				$(@node).find('ol').remove()
			else
				$(@node).find('ul').remove()
      
      