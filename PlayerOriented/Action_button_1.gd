extends Button

func _can_drop_data(position, data):
	
	return typeof(data) == TYPE_DICTIONARY and data.has("icon")

func _drop_data(position, data):
	if typeof(data) == TYPE_DICTIONARY:
		# Access the data fields
		var picture = data.get("icon", null)
		
		self.icon = picture
	
	# Set the preview to follow the mouse
		
