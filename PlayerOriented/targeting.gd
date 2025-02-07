extends MeshInstance3D

@onready var Parent = get_parent()

var Targeted : bool = false

func _ready() -> void:
	transparency = 1
