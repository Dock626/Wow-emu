#<source object>.<signal>.connect(<target_object>.<name of function on the target object>)
#self.select_pressed.connect(self._on_player_select_pressed)
extends CharacterBody3D

class_name Player_Base

signal Casting_started
signal select_pressed
signal Looking_around
signal action_pressed


@export var Fly_manouver = 0.1
@export var fall_acceleration = 75
@export var JUMP_VELOCITY = 6
@export var sensitivity = 0.4
@export var health = 100
@export var SPEED = 11

@onready var Looking_from = $CameraBase/Pivot
@onready var animation_tree = $AnimationTree
@onready var UI = $UI
@onready var health_bar = $UI/ProgressBar
@onready var camera = $CameraBase/Pivot/SpringArm3D/Camera3D
@onready var player_model = $PlayerModel
@onready var spellbook = $SpellBook
@onready var test = $AoE
@onready var spell_handler: Node = $SpellHandler


var current_spell : SpellResource
var rotated := Vector3()
var is_jumping := false
var target_velocity := Vector3.ZERO
var current_target: Node
var Cast_target
var has_slowed_down := false
var was_targeted: int
var in_sight = []
var mob = preload("res://mob.tscn")
var mouse_position := Vector3(0, 0, 0)
var selected := false
var mouse_on: bool
var Spell_list = []

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	

func _ready():
	if not is_multiplayer_authority():
		return
	camera.current = true
	$UI.show()
	self.add_to_group("Players")
	self.Casting_started.connect(spell_handler._on_player_casting_started)

func _unhandled_input(_event: InputEvent) -> void:
	if not is_multiplayer_authority():
		return


func _process(_delta):
	if not is_multiplayer_authority():
		return
	die()
	if spell_handler._casting:
		var Castbar = UI.get_node("CastBar")
		Castbar.visible = true
		Castbar.value = spell_handler.progress()
	else:
		UI.get_node("CastBar").hide()
	health_bar.value = health

func _physics_process(delta):
	if not is_multiplayer_authority():
		return
	if Input.is_action_just_released("select"):
		select_pressed.emit()
		var is_any_selected = false
		var mobs = get_tree().get_nodes_in_group("Mobs")
		for mob in mobs:
			if mob.selected == true:
				is_any_selected = true
		if is_any_selected == false:
			current_target = null
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
	# Get the input direction and handle the movement/deceleration.
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
	#if velocity != Vector3(0, 0, 0):
	#	casting = false  #breaking casting spells
	move_and_slide()


func _input(event):
	if not is_multiplayer_authority():
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		Looking_around.emit(true)
		if Looking_from.rotation.x <= 1:
			Looking_from.rotate_x(deg_to_rad(event.relative.y * sensitivity))
		else:
			Looking_from.rotation.x = 1
	'if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and event is InputEventMouseMotion:
		$CameraBase.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		Looking_around.emit(true)
		if Looking_from.rotation.x <= 1:
			Looking_from.rotate_x(deg_to_rad(event.relative.y * sensitivity))
		else:
			Looking_from.rotation.x = 1'

	if Input.is_action_just_pressed("select") and event is not InputEventMouseMotion:
		Looking_around.emit(false)
		was_targeted = 0

	if Input.is_action_pressed("zoom_in") and Looking_from.position.z != 3.5:
		Looking_from.position.y -= 0.25
		Looking_from.position.z += 0.5
	if Input.is_action_pressed("zoom_out") and Looking_from.position.z != -5.5:
		Looking_from.position.y += 0.25
		Looking_from.position.z -= 0.5
		#var result = lerp(start, end, weight)

	if Input.is_action_just_released("Tab_target"):
		#was_targeted
		in_sight = []
		for i in get_tree().get_nodes_in_group("Mobs"):
			i.selected = false
			var check_distance = global_transform.origin.distance_to(i.global_transform.origin)
			if check_distance < 300:
				in_sight.append([i, check_distance])
				in_sight.sort()

		if was_targeted >= in_sight.size():
			was_targeted = 0

		if in_sight[was_targeted][0] == current_target:
			was_targeted += 1

		if was_targeted >= in_sight.size():
			was_targeted = 0

		if in_sight.size() > 0:
			var yea = in_sight[was_targeted][0]
			if yea == current_target:
				yea = in_sight[was_targeted + 1][0]
			yea.selected = true
			current_target = yea
		was_targeted += 1

	if Input.is_action_just_pressed("Spellbook"):
		if not spellbook.visible:
			spellbook.show()
		else:
			spellbook.hide()


@rpc("call_local")
func get_damage(value):
	health.value -= value


func set_selecteD():
	if Input.is_action_just_released("select"):
		selected = !selected


func die():
	if health <= 0:
		$Pivot.rotation.x = 90
		SPEED = 0
		spell_handler._casting = true


func _on_targeted(value: Variant) -> void:
	current_target = value


func _mouse_enter() -> void:
	mouse_on = true
	$Selected.transparency = .5


func _mouse_exit() -> void:
	mouse_on = false
	$Selected.transparency = 1

func _on_Action_pressed(spell : SpellResource):
	Casting_started.emit(spell)
func _on_input_action(id : int):
	for spell in Spell_list:
		if spell[0] == id:
			Casting_started.emit(spell[1])
