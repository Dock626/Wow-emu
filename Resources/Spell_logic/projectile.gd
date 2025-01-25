extends RigidBody3D
signal actions(Array)



@export var speed = 20
@export var spawnPos : Vector3

var target
var dir : float
var Spell : SpellResource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = spawnPos + Vector3(0, 1, 0)
	if is_instance_valid(target):
		self.actions.connect(target._on_actions_received)

func _physics_process(delta: float) -> void:
	if !is_instance_valid(target):
		queue_free()
		return
	
	
	var height = target.get_node("CollisionShape3D")
	var target_height = Vector3(0, height.shape.size.y / 2, 0) 
	var to_target = (target.global_transform.origin + target_height - global_transform.origin).normalized()
	global_transform.origin += to_target * speed * delta
	var distance_to_target = global_transform.origin.distance_to(target.global_transform.origin + target_height)
	if distance_to_target < 1:  # Adjust the threshold as needed
		actions.emit(Spell.actions)
		queue_free()  # Remove the missile
		
		
