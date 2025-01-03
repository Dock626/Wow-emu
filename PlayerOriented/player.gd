#<source object>.<signal>.connect(<target_object>.<name of function on the target object>)
#self.select_pressed.connect(self._on_player_select_pressed)
extends CharacterBody3D
signal Casting_started
signal select_pressed
signal Looking_around

enum ANIMATIONS {JUMP_UP, JUMP_DOWN, STRAFE, WALK}


@export var SPEED = 11
@export var Fly_manouver = 0.1
@export var fall_acceleration = 75
@export var JUMP_VELOCITY = 6
@export var current_animation := ANIMATIONS.WALK
@export var sensitivity = 0.4
@export var health = 100

@onready var Mobs = get_tree().get_nodes_in_group("Mobs")
@onready var Looking_from = $CameraBase/CameraRot
@onready var animation_tree = $AnimationTree
@onready var SpellCasting = $CastTimer
@onready var UI = $UI
@onready var health_bar = $UI/ProgressBar
var rotated = Vector3()
var is_jumping = false
var target_velocity = Vector3.ZERO
var current_target : Node
var Casting = false
var Cast_target
var fireball = preload("res://Spells/fireball.tscn")
var has_slowed_down := false
var was_targeted : int
var in_sight = []

func _ready():
	pass
	
func _process(_delta):
	die()
	if Casting:
		var Castbar = UI.get_node("CastBar")
		Castbar.visible = true
		Castbar.value = (1 - SpellCasting.time_left / SpellCasting.wait_time) * 100
	else:
		UI.get_node("CastBar").visible = false
	health_bar.value = health
func _physics_process(delta):
	if velocity.z != 0 or velocity.x != 0 and is_on_floor():
		animation_tree["parameters/state/transition_request"] = "move"
		animation_tree["parameters/move/blend_position"] = 1
	else:
		animation_tree["parameters/state/transition_request"] = "move"
		animation_tree["parameters/move/blend_position"] = -1
	if Input.is_action_just_released("select"):
		select_pressed.emit()
	# Add the gravity.

	if not is_on_floor():
		velocity += get_gravity() * delta
		
		# Handle changing direction midair.
		var input_dir := Input.get_vector("move_right", "move_left", "move_back", "move_forward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and not has_slowed_down:
			if velocity.x != 0 and sign(direction.x) != sign(velocity.x):
				velocity.x *= 0.5
				has_slowed_down = true  # Prevent further midair slowing.
			if velocity.z != 0 and sign(direction.z) != sign(velocity.z):
				velocity.z *= 0.5
				has_slowed_down = true
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		current_animation = ANIMATIONS.JUMP_UP
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		has_slowed_down = false
		var input_dir := Input.get_vector("move_right", "move_left", "move_back", "move_forward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and Input.is_action_pressed("move_back"):
			velocity.x = direction.x * SPEED / 2
			velocity.z = direction.z * SPEED / 2
		elif direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	if velocity != Vector3(0, 0, 0):
		Casting = false #breaking Casting spells
	move_and_slide()
	
func animate(anim: int, delta:=0.0):

	if anim == ANIMATIONS.JUMP_UP:
		animation_tree["parameters/state/transition_request"] = "jump_up"

	elif anim == ANIMATIONS.JUMP_DOWN:
		animation_tree["parameters/state/transition_request"] = "jump_down"

	elif anim == ANIMATIONS.STRAFE:
		animation_tree["parameters/state/transition_request"] = "strafe"

	#elif anim == ANIMATIONS.WALK:
		# Change state to walk.
#		animation_tree["parameters/state/transition_request"] = "walk"

#func apply_input(delta: float):
	

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		Looking_around.emit(true)
		if Looking_from.rotation.x <= 1:
			Looking_from.rotate_x(deg_to_rad(event.relative.y * sensitivity))
		else:
			Looking_from.rotation.x = 1

	if Input.is_action_just_pressed("select") and event is not InputEventMouseMotion:
		Looking_around.emit(false)
		was_targeted = 0
		
	if Input.is_action_pressed("zoom_in") and Looking_from.position.z != 4.5:
		Looking_from.position.y -= 0.25
		Looking_from.position.z += 0.5
	if Input.is_action_pressed("zoom_out") and Looking_from.position.z != -2.5:
		Looking_from.position.y += 0.25
		Looking_from.position.z -= 0.5
		#var result = lerp(start, end, weight)
	if Input.is_action_just_pressed("Action_1") and current_target != null:
		if !Casting:
			Casting_started.emit
			Casting = true
			SpellCasting.start()
			Cast_target = current_target
		$UI/GridContainer/Button.button_pressed = true
		
		'var Casted = fireball.instantiate()
		Casted.spawnPos = position
		Casted.target = current_target
		get_parent().add_child(Casted)'
	
	if Input.is_action_just_released("Tab_target"):
		#was_targeted
		in_sight = []
		for i in get_tree().get_nodes_in_group("Mobs"):
			i.selected =false
			var check_distance = global_transform.origin.distance_to(i.global_transform.origin)
			if check_distance < 300:
				in_sight.append([i, check_distance])
				in_sight.sort()
		if was_targeted >= in_sight.size():
			was_targeted = 0
		if in_sight.size() > 0:
			var yea = in_sight[was_targeted][0]
			yea.selected = true
			current_target = yea
		was_targeted +=1
		
	
func die():
	if health <= 0:
		$Pivot.rotation.x = 90
		SPEED = 0
		Casting = true
func _on_targeted(value: Variant) -> void:
	current_target = value

func _on_cast_timer_timeout() -> void:
	if Casting == false:
		return
	var Casted = fireball.instantiate()
	Casted.spawnPos = position
	Casted.target = Cast_target
	get_parent().add_child(Casted)
	Casting = false
