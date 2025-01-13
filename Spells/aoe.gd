extends Area3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var player = get_parent()
func _process(delta: float) -> void:
	global_transform.origin = player.mouse_position
