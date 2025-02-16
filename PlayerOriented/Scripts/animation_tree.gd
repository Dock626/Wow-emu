extends AnimationTree

@onready var parent = self.get_parent()
var anim_state = get("parameters/move/blend_position")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
