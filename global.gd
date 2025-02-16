extends Node


@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEnter
const Spelldb = preload("res://Resources/SpellDatabase.gd")
const Player = preload("res://PlayerOriented/player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()
var spawn_this_many_mobs = 1
var score = 0 
@onready var Players = get_tree().get_nodes_in_group("Players")
@onready var Mobs = get_tree().get_nodes_in_group("Mobs")
@onready var Spell_database : SpellDatabase = $Spell_database
@export var Spell_id : int = 0
@export var mob_scene: PackedScene
func _ready():
	pass
func _process(delta):
	pass

func _on_host_button_pressed():
	main_menu.hide()
	#hud.show()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	#multiplayer.peer_disconnected.connect(remove_player)
	
	add_player(multiplayer.get_unique_id())
	$Button.show()
	#upnp_setup()


func _on_join_button_pressed():
	main_menu.hide()
	#hud.show()
	
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer
# Replace with function body.

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	player.add_to_group("Players")

func get_main():
	return self
func get_players():
	var players = []
	for player in get_tree().get_nodes_in_group("Players"):
		players.append(player)
	return players
func generate_spell_id():
	Spell_id += 1
	return Spell_id


func _on_mob_timer_timeout() -> void:
	if mob_scene == null:
		print("Error: mob_scene is not assigned!")
		return
	
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	if get_tree().get_node_count_in_group("Mobs") > 15:
		return

	for i in range(spawn_this_many_mobs):
		print("Spawning mob:", i)

		var mob = mob_scene.instantiate()
		if mob == null:
			print("Error: mob instantiation failed!")
			continue

		# Assign a new random spawn position
		mob_spawn_location.progress_ratio = randf()  # Random point along the path
		var spawn_position = mob_spawn_location.position

		# Add a small random offset to prevent stacking
		var random_offset = Vector3(randf_range(-100, 100), 0, randf_range(-100, 100))
		mob.position = spawn_position + random_offset

		add_child(mob)


func _on_increment_mobs_timeout() -> void:
	if spawn_this_many_mobs == 5:
		return
	spawn_this_many_mobs += 1
	


func _on_button_pressed() -> void:
	_on_mob_timer_timeout()
	$MobTimer.start()
	$Increment_mobs.start()
	$Button.hide()
