extends Node
signal held(value)
var time_pressed
@onready var winner = $wina
func _ready():
	pass
func _process(delta):
	'win()
	print(winner)'
	pass
func win():
	var mobs_size = get_tree().get_nodes_in_group("Mobs")
	if mobs_size.size() == 0 and winner:
		winner.visible = true
