extends Node

signal actions(value)

const aoe_indicator = preload("res://UI_Spells/UI_Player/aoe.tscn")

@onready var projectile: Node = $Spell_types/Projectile
@onready var instant: Node = $Spell_types/Instant
@onready var aoe: Node = $Spell_types/AoE
@onready var is_GCD = $Global_cd
@onready var Player = get_parent()
@onready var _spell_timer = $CastTimer

var _casting := false
var Spells := [SpellDatabase.get_spell("Firebolt")]



func _on_player_casting_started(spell: SpellResource) -> void:
	if spell == null or _casting:
		return
	elif !is_GCD.is_stopped() and spell.is_GCD == false:
		return
	Player.Cast_target = Player.current_target
	Player.current_spell = spell
	if spell.cast_time == 0:
		_on_cast_timer_timeout()
	else:
		_casting = true
		_spell_timer.set_wait_time(spell.cast_time)
		_spell_timer.start()

func _on_cast_timer_timeout() -> void:
	if Player.current_spell.type == SpellResource.cast_type.Projectile:
		projectile._projectile_scene_init()
	elif Player.current_spell.type == SpellResource.cast_type.Instant:
		instant._instant()
	elif Player.current_spell.type == SpellResource.cast_type.AoE:
		aoe.aoe()
	_casting = false

func progress() -> float:
	return (1 - _spell_timer.time_left / _spell_timer.wait_time) * 100

#adding spells for the player
func return_spell(spell_name):
	for spell in Spells:
		if spell.name == spell_name:
			return spell
	return null


func add_spell(Spell):
	Spells.append(Spell)
