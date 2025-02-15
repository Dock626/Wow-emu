extends Node

signal actions(value)

const aoe_indicator = preload("res://UI_Spells/UI_Player/aoe_indicator.tscn")

@onready var projectile: Node = $Spell_types/Projectile
@onready var no_projectile: Node = $Spell_types/no_projectile
@onready var aoe: Node = $Spell_types/AoE
@onready var Global_cd = $Global_cd
@onready var Player = get_parent()
@onready var _spell_timer = $CastTimer
@onready var cooldowns: Node = $Cooldowns

var _casting : bool = false
var Spells := [SpellDatabase.get_spell("Firebolt")]

func _on_player_casting_started(spell: SpellResource) -> void:
	if spell == null or _casting:
		return
	elif !Global_cd.is_stopped() and spell.is_GCD == true:
		return
	elif spell.CD > 0:
		for cooldown in cooldowns.get_children():
			if spell.name == cooldown.CD_name:
				return
	for buff in Player.buffs:
		if buff is proc_buff and buff.proc_name == spell.proc_check:
			spell.apply_proc()
			if buff.is_erased_on_use:
				Player.buffs.erase(buff)
	_casting = true
	Player.Cast_target = Player.current_target
	Player.current_spell = spell
	if spell.cast_time == 0:
		_on_cast_timer_timeout()
	else:
		_spell_timer.set_wait_time(spell.cast_time)
		_spell_timer.start()
	if Player.current_spell.is_GCD:
		Global_cd.start()

func _on_cast_timer_timeout() -> void:
	if _casting == false:
		return
	var cooldown_timer = Cooldown.new()
	cooldown_timer.on_ready(Player.current_spell)
	$Cooldowns.add_child(cooldown_timer)
	cooldown_timer.start()
	use_procs()
	if Player.current_spell.type == SpellResource.cast_type.Projectile:
		projectile._projectile_scene_init()
	elif Player.current_spell.type == SpellResource.cast_type.Instant:
		no_projectile.no_projectile()
	elif Player.current_spell.type == SpellResource.cast_type.AoE:
		aoe.aoe()
	_casting = false

func use_procs():
	var procs : Array = []
	for action in Player.current_spell.actions:
		if action is proc_buff:
			procs.append(action)
			Player.current_spell.actions.erase(action)
	Player._on_actions_received(procs)

func progress() -> float:
	return (1 - _spell_timer.time_left / _spell_timer.wait_time) * 100

func progress_gcd() -> float:
	return (1 - Global_cd.time_left / Global_cd.wait_time) * 100

#adding spells for the player
func return_spell(spell_name):
	for spell in Spells:
		if spell.name == spell_name:
			return spell.duplicate_spell()
	return null

func add_spell(Spell):
	Spells.append(Spell)
