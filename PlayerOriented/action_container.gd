extends GridContainer
const ACTION_BUTTON = preload("res://action_button.tscn")
var action_buttons = self.get_children()
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	for i in range(1, 7):
		var action_button = ACTION_BUTTON.instantiate()
		action_button.button_id = i
		action_button.text = ''
		self.add_child(action_button)
		
