extends Area3D
@onready var Players = get_tree().get_nodes_in_group("Players")
@onready var parent = self.get_parent()
signal inrange



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Players"):
			#inrange.emit
			parent.SPEED = 0

func attack():
	
