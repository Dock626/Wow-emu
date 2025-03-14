extends CharacterBody3D
signal targeted(value)

@export var selected = false
@export var SPEED : float = 8
@export var stop_distance: float = 2.5  # Distance to stop near the player
@export var Target : Node
@export var attacking = false
@export var Health := 100
@onready var _Health_bar = $SubViewport/HealthBar
@onready var _Health_bar_mesh = $HealthBar
@onready var box = $Selected
@onready var portrait = $Control/Portrait2D
@onready var Players = get_tree().get_nodes_in_group("Players")
@onready var targeting: MeshInstance3D = $Targeting


#@onready var Agro_range = $Area3D
#@onready var Agro_table : Array

const Attack = preload("res://addons/Attack_area.tscn")
var aoe_targeting : bool
var Looking_around : bool
var _check_players : int
var buffs := []
var is_targeted : bool = false
func initialize(set_position) -> void:
	self.global_transform.origin = set_position
func _ready():
	add_to_group("Mobs")
	#var stuffik = get_node("Area_stuff")
	#stuffik.in_range.connect(self._on_attack_area_in_range)
	
func _process(delta: float) -> void:
	die()
	_Health_bar.value = Health
	if is_targeted:
		targeting.transparency = 0.2
	else:
		targeting.transparency = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	Target = check_closest()
	Players = get_tree().get_nodes_in_group("Players")
	if is_on_floor() and is_instance_valid(Target):
		
		var direction = (Target.global_transform.origin - global_transform.origin).normalized()
		
		# Calculate the distance to the player
		var distance = global_transform.origin.distance_to(Target.global_transform.origin)
		
		# Move towards the player if further than the stop distance
		if attacking == true:
			velocity = Vector3.ZERO
		elif distance > stop_distance:
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
	move_and_slide()
	
func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	if event.is_action_released("select"): #and Looking_around == false:
		for i in get_tree().get_nodes_in_group("Mobs"):
			i.selected = false
		selected = true
		targeted.emit(self)

func die() -> void:
	if Health <= 0:
		Global.score += 1
		remove_from_group("Mobs")
		queue_free()

func check_closest(): # maybe move to mob logic or some other component
	var list_of_players = []
	if Players.size() > 0:
		# Calculate the direction to the player
		
		for player in Players:
			var check_distance = global_transform.origin.distance_to(player.global_transform.origin)
			list_of_players.append([player, check_distance])

		list_of_players.sort()
		return list_of_players[0][0]

func _on_actions_received(actions: Array) -> void:
	for action in actions:
		action.use(self)
func _mouse_enter() -> void:
	if is_targeted == true:
		return
	targeting.transparency = 0.6
func _mouse_exit() -> void:
	if is_targeted == true:
		return
	targeting.transparency = 1
