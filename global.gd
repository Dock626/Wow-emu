extends Node
signal held(value)
var time_pressed
@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEnter

const Player = preload("res://PlayerOriented/player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()


@onready var winner = $wina


func _ready():
	pass
func _process(delta):
	pass


func win():
	var mobs_size = get_tree().get_nodes_in_group("Mobs")
	if mobs_size.size() == 0 and winner:
		winner.visible = true


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
	
	
	
	
