extends Button

func _process(delta: float) -> void:
	print()
func _can_drop_data(position, data):
	
	return typeof(data) == TYPE_DICTIONARY and data.has("icon")

func _drop_data(position, data):
	if typeof(data) == TYPE_DICTIONARY:
		# Access the data fields
		var picture = data.get("icon", null)
		var action_id = data.get("id")
		self.icon = picture
	
	# Set the preview to follow the mouse
		
