extends Node
signal Action_pressed(value)
func _ready() -> void:
	self.Action_pressed.connect(get_parent()._on_input_action)
func _input(event: InputEvent) -> void:
	for i in range(1 ,10):
		if Input.is_action_just_pressed("Action_%d" % i):
			Action_pressed.emit(i)
'func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action_1") and Player.current_target != null:
		use_skill()
		print(SpellDatabase.get_spell("Firebolt"))
	if Input.is_action_just_pressed("Action_2"):
		if !Player.get_node("AoE"):
			var aoe = aoe_indicator.instantiate()
			Player.add_child(aoe)
		else:
			Player.get_node("AoE").queue_free()'
