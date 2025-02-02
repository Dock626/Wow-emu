extends Node
@onready var Player = $"../.."
var was_targeted := 0
var in_sight : Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event):
	if not is_multiplayer_authority():
		return

	if Input.is_action_just_pressed("select") and event is not InputEventMouseMotion:
		Player.Looking_around.emit(false)
		was_targeted = 0

	if Input.is_action_just_released("Tab_target"):
		#was_targeted
		in_sight = []
		for i in get_tree().get_nodes_in_group("Mobs"):
			i.selected = false
			var check_distance = Player.global_transform.origin.distance_to(i.global_transform.origin)
			if check_distance < 300:
				in_sight.append([i, check_distance])
				in_sight.sort()

		if was_targeted >= in_sight.size():
			was_targeted = 0

		if in_sight[was_targeted][0] == Player.current_target:
			was_targeted += 1

		if was_targeted >= in_sight.size():
			was_targeted = 0

		if in_sight.size() > 0:
			var yea = in_sight[was_targeted][0]
			if yea == Player.current_target and in_sight.size() != 1:
				yea = in_sight[was_targeted + 1][0]
			yea.selected = true
			Player.current_target = yea
		was_targeted += 1

	if Input.is_action_just_pressed("Spellbook"):
		if not Player._spellbook.visible:
			Player._spellbook.show()
		else:
			Player._spellbook.hide()
