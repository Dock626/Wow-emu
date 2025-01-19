extends Node
signal Action_pressed(value)
func _ready() -> void:
	self.Action_pressed.connect(get_parent()._on_input_action)
func _input(event: InputEvent) -> void:
	for i in range(1 ,10):
		if Input.is_action_just_pressed("Action_%d" % i):
			Action_pressed.emit(i)
