extends Area3D

signal actions_emit(value: Array)

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
	else:
		timer.wait_time = 0.05
		timer.start()
func _physics_process(delta: float) -> void:
	bodies = get_overlapping_bodies()

func _on_timer_timeout() -> void:
	for body in bodies:
		if body.is_in_group("Mobs") or body.is_in_group("Players"):
			self.actions_emit.connect(body._on_actions_received)
			actions_emit.emit(actions)
	self.queue_free()
