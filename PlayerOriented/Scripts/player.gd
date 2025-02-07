extends CharacterBody3D

class_name Player_Base

signal Casting_started
signal action_pressed
const AOE = preload("res://UI_Spells/UI_Player/aoe_indicator.tscn")


@export var Fly_manouver = 0.1
@export var fall_acceleration = 75
@export var JUMP_VELOCITY = 6
@export var sensitivity = 0.4
@export var Health = 100
@export var SPEED : float = 11

@onready var targeting: MeshInstance3D = $Targeting
@onready var _animation_tree = $AnimationTree
@onready var UI = $UI
@onready var health_bar = $UI/HealthBar
@onready var _cast_bar = $UI/CastBar
@onready var _target_health_bar = $UI/TargetHealthBar
@onready var camera = $CameraBase/Pivot/SpringArm3D/Camera3D
@onready var _player_model = $PlayerModel
@onready var _spellbook = $SpellHandler/SpellBook
@onready var test = $AoE
@onready var _spell_handler: Node = $SpellHandler

var current_spell : SpellResource
var _is_jumping := false
var current_target: Node
var Cast_target
var mouse_position := Vector3(0, 0, 0)
var selected := false
var Action_bar = [] #spells on action bars
var buffs = []
var aoe_targeting : bool = false
var is_targeted : bool = false
func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority():
		return
	camera.current = true
	$UI.show()
	self.add_to_group("Players")
	self.Casting_started.connect(_spell_handler._on_player_casting_started)

func _unhandled_input(_event: InputEvent) -> void:
	if not is_multiplayer_authority():
		return

func _process(_delta):
	if not is_multiplayer_authority():
		return
	die()
	if _spell_handler._casting:
		_cast_bar.visible = true
		_cast_bar.value = _spell_handler.progress()
	else:
		_cast_bar.hide()
	health_bar.value = Health
	if is_instance_valid(current_target):
		_target_health_bar.show()
		_target_health_bar.value = current_target.Health
	else:
		_target_health_bar.hide()
	
	if is_targeted:
		targeting.transparency = 0.2
	else:
		targeting.transparency = 1

func die():
	if Health <= 0:
		$Pivot.rotation.x = 90
		SPEED = 0
		_spell_handler._casting = true

func _on_Action_pressed(spell : SpellResource):
	Casting_started.emit(spell)

func _on_actions_received(actions: Array) -> void:
	for action in actions:
		action.use(self)

func _on_input_action(id : int):
	for spell in Action_bar:
		if spell[0] == id:
			if spell[1] != null and spell[1].type == SpellResource.cast_type.AoE:
				var indicator = AOE.instantiate()
				indicator.spell = spell[1]
				add_child(indicator)
			else:
				Casting_started.emit(spell[1])

func get_id():
	return self.name

func _mouse_enter() -> void:
	if is_targeted == true:
		return
	targeting.transparency = 0.6
func _mouse_exit() -> void:
	if is_targeted == true:
		return
	targeting.transparency = 1
