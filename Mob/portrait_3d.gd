extends Camera3D
@export var target_node: NodePath
@onready var target = get_node_or_null(target_node)

func _process(delta: float) -> void:
	if is_instance_valid(target):
		# Focus on a point in front of the mob's head (adjust the offset)
		var face_position = target.global_transform.origin + target.global_transform.basis.y * 1.5
		look_at(face_position, Vector3.DOWN)
'var test
func _process(_delta):
	#test = $"../../Portrait3Dposition".global_position
	#$".".position = test
	pass	
'
