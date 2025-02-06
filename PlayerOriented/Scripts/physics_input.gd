extends Node
@onready var Player = $"../.."
var has_slowed_down : bool = false

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
			return
	'if Input.is_action_just_released("select"):
		if Player.aoe_targeting:
			return
		var is_any_selected = false
		var mobs = get_tree().get_nodes_in_group("Mobs")
		for mob in mobs:
			if mob.selected == true:
				is_any_selected = true
		if is_any_selected == false:
			Player.current_target = null'
	# Add the gravity.

	if not Player.is_on_floor():
		Player.velocity += Player.get_gravity() * delta

		# Handle changing direction midair.
		var input_dir := Input.get_vector("move_right", "move_left", "move_back", "move_forward")
		var direction = (Player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and not has_slowed_down:
			if Player.velocity.x != 0 and sign(direction.x) != sign(Player.velocity.x):
				Player.velocity.x *= 0.5
				has_slowed_down = true  # Prevent further midair slowing.
			if Player.velocity.z != 0 and sign(direction.z) != sign(Player.velocity.z):
				Player.velocity.z *= 0.5
				has_slowed_down = true
	# Handle jump.
	if Input.is_action_just_pressed("jump") and Player.is_on_floor():
		Player.velocity.y = Player.JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	if Player.is_on_floor():
		has_slowed_down = false
		var input_dir := Input.get_vector("move_right", "move_left", "move_back", "move_forward")
		var direction = (Player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and Input.is_action_pressed("move_back"):
			Player.velocity.x = direction.x * Player.SPEED / 2
			Player.velocity.z = direction.z * Player.SPEED / 2
		elif direction:
			Player.velocity.x = direction.x * Player.SPEED
			Player.velocity.z = direction.z * Player.SPEED
		else:
			Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)
			Player.velocity.z = move_toward(Player.velocity.z, 0, Player.SPEED)
	#if velocity != Vector3(0, 0, 0):
	#	casting = false  #breaking casting spells
	Player.move_and_slide()

func get_camera_position():
	if not is_multiplayer_authority():
		return
	return Player.camera.global_transform.origin
