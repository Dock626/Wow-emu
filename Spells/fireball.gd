extends RigidBody3D
signal hit(value : int)



@export var speed = 20
@export var spawnPos : Vector3
@export var target : Node

var dir : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	position = spawnPos + Vector3(0, 1, 0)
	if is_instance_valid(target):
		self.hit.connect(target._on_fireball_hit)
	print(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(target):
		var height = target.get_node("CollisionShape3D")
		var target_height = Vector3(0, height.shape.size.y / 2, 0) 
		var to_target = (target.global_transform.origin + target_height - global_transform.origin).normalized()
		global_transform.origin += to_target * speed * delta
		var distance_to_target = global_transform.origin.distance_to(target.global_transform.origin + target_height)
		if distance_to_target < 0.1:  # Adjust the threshold as needed
			hit.emit(60)
			queue_free()  # Remove the missile
	else:
		queue_free()
func _physics_process(delta: float) -> void:
	pass
