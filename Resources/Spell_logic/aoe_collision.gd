extends Area3D

@onready var timer: Timer = $Timer
@onready var collision_radius = $CollisionShape3D.shape.radius
@onready var mesh_radius = $MeshInstance3D.mesh.top_radius
var effect_time : float
var bodies
var actions : Array[BaseSpellAction] = []
func _ready() -> void:
	if effect_time > 0:
		timer.wait_time = effect_time
		timer.start()
		print("nop")
	print("yep")
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	self.queue_free()
