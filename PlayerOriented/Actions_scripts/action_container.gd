extends GridContainer
const ACTION_BUTTON = preload("res://PlayerOriented/Actions_scripts/action_button.tscn")
var action_buttons = self.get_children()
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	for i in range(1, 9):
		var action_button = ACTION_BUTTON.instantiate()
		action_button.button_id = i
		action_button.text = str(i)
		self.add_child(action_button)
		
