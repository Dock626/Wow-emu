extends Node
signal Action_pressed(value)
func _ready() -> void:
	self.Action_pressed.connect(get_parent()._on_input_action)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action_1"):
		Action_pressed.emit(1)
	if Input.is_action_just_pressed("Action_2"):
		Action_pressed.emit(2)
