extends Camera3D

# Called when the node enters the scene tree for the first time.
@onready var player = $"../../../.."
@onready var shootray = Vector3(0,0,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shootray = shoot_ray()
	if shootray.has("position"):
		var hit_position = shootray["position"]
		player.mouse_position.z = hit_position.z
		player.mouse_position.x = hit_position.x

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot_ray() # mouse tracking
		

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	return raycast_result
