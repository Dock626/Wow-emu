extends MeshInstance3D

var camera_pos
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	print(camera_pos)
	if camera_pos != null:
		look_at(camera_pos, Vector3.UP, true)
		position = get_parent().global_transform.origin + Vector3(0,3,0)
	update_camera_pos.rpc(camera_pos, self.rotation)
@rpc("call_local")
func update_camera_pos(new_pos: Vector3, rotate):
	camera_pos = new_pos
	rotation = rotate
