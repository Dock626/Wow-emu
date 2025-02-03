extends Area3D

signal actions_emit(value: Array)

@onready var action_emitter: Timer = $action_emitter
@onready var timer: Timer = $Timer
@onready var collision_radius = $CollisionShape3D.shape.radius
@onready var mesh_radius = $MeshInstance3D.mesh.top_radius
var effect_time : float
var bodies
var actions : Array[BaseSpellAction] = []
var frame = 0
var initial_use :bool = false

func _ready() -> void:
	if effect_time > 0:
		timer.wait_time = effect_time
		timer.start()
		action_emitter.start()
	
func _physics_process(delta: float) -> void:
	bodies = get_overlapping_bodies()
	frame += 1
	if frame > 2 and !initial_use:
		use_once()
			
func use_once():
	bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Mobs") or body.is_in_group("Players"):
			self.actions_emit.connect(body._on_actions_received)
			actions_emit.emit(actions)
			self.actions_emit.disconnect(body._on_actions_received)
	if effect_time == 0:
		queue_free()
	initial_use = true

func _on_actions_emit_timeout() -> void:
	for body in bodies:
		if body.is_in_group("Mobs") or body.is_in_group("Players"):
			self.actions_emit.connect(body._on_actions_received)
			actions_emit.emit(actions)
			self.actions_emit.disconnect(body._on_actions_received)

func _on_timer_timeout() -> void:
	self.queue_free()
