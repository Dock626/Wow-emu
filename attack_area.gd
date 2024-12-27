extends Area3D
@onready var Players = get_tree().get_nodes_in_group("Players")
@onready var parent = self.get_parent()
@onready var Attack_timer = $Timer
var attacking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.transparency = 1

func _process(delta: float) -> void:
	'var bodies = get_overlapping_bodies()
	if attacking == false:
		for body in bodies:
			if body.is_in_group("Players"):
				attack()
				attacking = true'
	
	
	if parent.attacking == true:
		$MeshInstance3D.transparency = (Attack_timer.time_left / Attack_timer.wait_time)


func attack():
	parent.SPEED = 0
	parent.attacking = true
	Attack_timer.start()

func _on_timer_timeout() -> void:
	parent.SPEED = 8
	$MeshInstance3D.transparency = 1
	parent.attacking = false
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Players"):
			body.queue_free()
	queue_free()
