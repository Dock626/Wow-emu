extends Node
@onready var Player = $"../.."
var tab_target_index := 0
var in_sight : Array

func _input(event):
	if not is_multiplayer_authority():
		return

	if Input.is_action_just_pressed("select"):
		tab_target_index = 0

	if Input.is_action_just_pressed("Spellbook"):
		if not Player._spellbook.visible:
			Player._spellbook.show()
		else:
			Player._spellbook.hide()
	if Input.is_key_pressed(KEY_ESCAPE):
		if is_instance_valid(Player.current_target):
				Player.current_target.is_targeted = false
		Player.current_target = null
	if Input.is_action_just_released("Tab_target"):
		in_sight = []
		for i in get_tree().get_nodes_in_group("Mobs"):
			i.selected = false
			var check_distance = Player.global_transform.origin.distance_to(i.global_transform.origin)
			if check_distance < 300:
				in_sight.append([i, check_distance])
				in_sight.sort()
		
		if in_sight == []:
			return
		if tab_target_index >= in_sight.size():
			tab_target_index = 0

		if in_sight[tab_target_index][0] == Player.current_target:
			tab_target_index += 1

		if tab_target_index >= in_sight.size():
			tab_target_index = 0

		if in_sight.size() > 0:
			var target = in_sight[tab_target_index][0]
			if target == Player.current_target and in_sight.size() != 1:
				target = in_sight[tab_target_index + 1][0]
			if is_instance_valid(Player.current_target):
				Player.current_target.is_targeted = false
			target.is_targeted = true
			Player.current_target = target
		tab_target_index += 1
