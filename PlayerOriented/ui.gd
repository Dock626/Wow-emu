extends Control
signal action_used(button_number : int)
@onready var buttons = $GridContainer.get_children()
func _ready():
	pass

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action_1"):
		action_used.emit(1)
func _button_pressed():
	print(self)

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
