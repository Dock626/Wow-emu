extends Area3D

signal actions_emit(value: Array)
@onready var action_emitter: Timer = $action_emitter
@onready var timer: Timer = $Timer
@onready var collision_radius = $CollisionShape3D.shape.radius
@onready var mesh_radius = $MeshInstance3D.mesh.top_radius

@onready var cylinder_1: MeshInstance3D = $cylinder1
@onready var cylinder_2: MeshInstance3D = $cylinder2
@onready var cylinder_3: MeshInstance3D = $cylinder3


var effect_time : float
var bodies
var actions : Array[BaseSpellAction] = []
var frame = 0
var initial_use :bool = false
var affect_players = false
var affect_mobs = true

func _ready() -> void:
	if effect_time > 0:
		timer.wait_time = effect_time
		timer.start()
		action_emitter.start()
		
func _physics_process(delta: float) -> void:
	cylinder_1.radius(delta/2.5)
	cylinder_2.radius(delta/1)
	cylinder_3.radius(delta/0.5)
	cylinder_1.transparency += delta/5
	cylinder_2.transparency += delta/5
	cylinder_3.transparency += delta/5
	bodies = get_overlapping_bodies()
	frame += 1
	if frame > 2 and !initial_use:
		use_once()
		
func use_once():
	bodies = get_overlapping_bodies()
	emit_actions()
	if effect_time == 0:
		queue_free()
	initial_use = true

func _on_actions_emit_timeout() -> void:
	emit_actions()
	
func emit_actions():
	if effect_time == 0:
		return
	for body in bodies:
		if body.is_in_group("Mobs"):
			self.actions_emit.connect(body._on_actions_received)
			actions_emit.emit(actions)
			self.actions_emit.disconnect(body._on_actions_received)

func _on_timer_timeout() -> void:
	cylinder_1.reset()
	cylinder_2.reset()
	cylinder_3.reset()
	self.queue_free()
