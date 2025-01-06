extends CharacterBody3D
signal targeted(value)

@export var selected = false
@export var SPEED = 8
@export var stop_distance: float = 2.5  # Distance to stop near the player
@export var Target : Node
@export var attacking = false

@onready var box = $Selected
@onready var portrait = $Control/Portrait2D
@onready var Players = get_tree().get_nodes_in_group("Players")
@onready var Health = $Control/HealthBar

#@onready var Agro_range = $Area3D
#@onready var Agro_table : Array

@onready var Attack = preload("res://Attack_area.tscn")


var Looking_around : bool
var mouse_on = false
var check_players : int

func _ready():
	add_to_group("Mobs")
	
	
	
	#var stuffik = get_node("Area_stuff")
	#stuffik.in_range.connect(self._on_attack_area_in_range)
	
func _process(delta: float) -> void:
	die()
	set_selected(selected)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	Target = check_closest()
	Players = get_tree().get_nodes_in_group("Players")
	print(Players)
	if is_on_floor() and is_instance_valid(Target):
		
		var direction = (Target.global_transform.origin - global_transform.origin).normalized()
		
		# Calculate the distance to the player
		var distance = global_transform.origin.distance_to(Target.global_transform.origin)
		
		# Move towards the player if further than the stop distance
		if distance > stop_distance:
			velocity = direction * SPEED
		else:
			velocity = Vector3.ZERO
		look_at(Target.global_transform.origin, Vector3.UP)
	if is_instance_valid(Target):
		var in_range
		in_range = global_transform.origin.distance_to(Target.global_transform.origin)
		if in_range <= 3.5 and attacking == false:
			attacking = true
			var Area_stuff = Attack.instantiate()
			add_child(Area_stuff)
			Area_stuff.attack()
	if mouse_on and not selected:
		box.transparency = 0.75
	elif selected:
		box.transparency = 0.25
	else:
		box.transparency = 1
	move_and_slide()
	
func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	if event.is_action_released("select") and Looking_around == false:
		selected = not selected
		targeted.emit(self)
func _mouse_enter() -> void:
	mouse_on = true
func _mouse_exit() -> void:
	mouse_on = false


func set_selected(value):
	portrait.visible = value
	Health.visible = value
func die() -> void:
	if Health.value <= 0:
		remove_from_group("Mobs")
		queue_free()
func check_closest():
	var list_of_players = []
	if Players.size() > 0:
		# Calculate the direction to the player
		
		for player in Players:
			var check_distance = global_transform.origin.distance_to(player.global_transform.origin)
			list_of_players.append([player, check_distance])

		list_of_players.sort()
		return list_of_players[0][0]


#signals
func _on_player_select_pressed() -> void:
	if mouse_on == false and Looking_around == false:
		selected = false
func _on_player_looking_around(value) -> void:
	Looking_around = value
func _on_fireball_hit(value) -> void:
	Health.value -= value
