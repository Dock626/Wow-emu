extends Node
@onready var Player = get_parent()
@onready var _spell_timer = $CastTimer
var fireball = preload("res://Spells/fireball.tscn")
var aoe_indicator = preload("res://Spells/aoe.tscn")
var _casting := false
var Spells := [SpellDatabase.get_spell("Firebolt")]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_casting_started(spell: SpellResource) -> void:
	if _casting or spell == null or Player.current_target == null:
		return
	_casting = true
	Player.Cast_target = Player.current_target
	Player.current_spell = spell
	_spell_timer.set_wait_time(spell.cast_time)
	_spell_timer.start()


func _on_cast_timer_timeout() -> void:
	if _casting == false or !is_instance_valid(Player.Cast_target):
		_casting = false
		return
	
	var Casted = fireball.instantiate()
	Casted.Spell = Player.current_spell
	Casted.spawnPos = Player.global_transform.origin
	Casted.target = Player.Cast_target
	Player.get_parent().add_child(Casted)
	#_sync_cast_fireball.rpc(Casted.spawnPos, Player.Cast_target.get_path())
	_casting = false


@rpc("any_peer", "call_remote", "unreliable")
func _sync_cast_fireball(spawn_pos, id) -> void:
	# Recreate the fireball on clients for synchronization
	var Casted = fireball.instantiate()
	Casted.spawnPos = spawn_pos
	Casted.target = get_node(id)
	Player.get_parent().add_child(Casted)


func progress() -> float:
	return (1 - _spell_timer.time_left / _spell_timer.wait_time) * 100

func return_spell(spell_name):
	for spell in Spells:
		if spell.name == spell_name:
			return spell
	return null
func add_spell(Spell):
	Spells.append(Spell)
