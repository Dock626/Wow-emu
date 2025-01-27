extends Node

@onready var SpellHandler = $"../.."
const projectile_scene = preload("res://Resources/spell_scenes/projectile.tscn")

func _projectile_scene_init():
	if !is_instance_valid(SpellHandler.Player.Cast_target):
		return
	var Casted = projectile_scene.instantiate()
	Casted.Spell = SpellHandler.Player.current_spell
	Casted.spawnPos = SpellHandler.Player.global_transform.origin
	Casted.target = SpellHandler.Player.Cast_target
	SpellHandler.Player.get_parent().add_child(Casted)
	_sync_cast_projectile_scene.rpc(Casted.spawnPos, SpellHandler.Player.Cast_target.get_path())

@rpc("any_peer", "call_remote", "reliable")
func _sync_cast_projectile_scene(spawn_pos, id) -> void:
	# Recreate the projectile on clients for synchronization
	var Casted = projectile_scene.instantiate()
	Casted.spawnPos = spawn_pos
	Casted.target = get_node(id)
	SpellHandler.Player.get_parent().add_child(Casted)
