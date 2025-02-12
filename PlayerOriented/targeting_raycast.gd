extends RayCast3D
@onready var Player = $"../../../../.."
@onready var camera = $".."  # Assumes the camera is the parent node

func _input(event):
	if Input.is_action_just_released("select"):
		select_target()

func select_target():
	target_position = (camera.project_local_ray_normal(get_viewport().get_mouse_position()) * 1000)
	force_raycast_update()

	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("Targetable"):
			set_selected_target(collider)
		'else:
			set_selected_target(null) '

func set_selected_target(target):
	if is_instance_valid(Player.current_target):
		Player.current_target.is_targeted = false
	Player.current_target = target
	target.is_targeted = true
