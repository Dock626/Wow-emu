extends Node
@onready var Player = get_parent()
var fireball = preload("res://Spells/fireball.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action_1") and Player.current_target != null:
			use_skill()
			

func use_skill():
	if !Player.Casting:
		Player.Casting_started.emit
		Player.Casting = true
		Player.SpellCasting.start()
		Player.Cast_target = Player.current_target

func _on_cast_timer_timeout() -> void:
	if Player.Casting == false:
		return
	if is_instance_valid(Player.Cast_target):
		var Casted = fireball.instantiate()
		Casted.spawnPos = Player.global_transform.origin
		Casted.target = Player.Cast_target
		Player.get_parent().add_child(Casted)
		_sync_cast_fireball.rpc(Casted.spawnPos, Player.Cast_target.get_path())
	Player.Casting = false
	
@rpc("any_peer", "call_remote", "unreliable")
func _sync_cast_fireball(spawn_pos, id) -> void:
	# Recreate the fireball on clients for synchronization
	var Casted = fireball.instantiate()
	Casted.spawnPos = spawn_pos
	Casted.target = get_node(id)
	Player.get_parent().add_child(Casted)
