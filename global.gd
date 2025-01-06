extends Node


@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEnter

const Player = preload("res://PlayerOriented/player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

@onready var Players = get_tree().get_nodes_in_group("Players")
@onready var Mobs = get_tree().get_nodes_in_group("Mobs")

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
	print(player.is_in_group("Players"))
	
	Mobs = get_tree().get_nodes_in_group("Mobs")
	for mob in Mobs:
		
		player.select_pressed.connect(mob._on_player_select_pressed)
		player.Looking_around.connect(mob._on_player_looking_around)
		mob.targeted.connect(player._on_targeted)
	
	
	
