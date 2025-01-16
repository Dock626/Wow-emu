extends GridContainer
const ACTION_BUTTON = preload("res://action_button.tscn")
var action_buttons = self.get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1, 6):
		self.add_child(ACTION_BUTTON.instantiate(i))
