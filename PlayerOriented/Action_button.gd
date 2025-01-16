extends Button

signal Action_pressed(value)

var test = "Action_1"

var skill_name = "Firebolt"

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed(test):
		Action_pressed.emit("Firebolt")
		

func _can_drop_data(position, data):
	
	return typeof(data) == TYPE_DICTIONARY and data.has("icon")

func _drop_data(position, data):
	if typeof(data) == TYPE_DICTIONARY:
		# Access the data fields
		var picture = data.get("icon", null)
		var action_id = data.get("name")
		self.icon = picture
	
