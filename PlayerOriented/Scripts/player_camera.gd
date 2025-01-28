extends Camera3D
# Called when the node enters the scene tree for the first time.
@onready var player = $"../../../.."
@onready var shootray = Vector3(0,0,0)
@onready var sensitivity = player.sensitivity
@onready var _Looking_from = $"../.."
@onready var CameraBase = $"../../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shootray = shoot_ray()
	if shootray.has("position"):
		var hit_position = shootray["position"]
		player.mouse_position = hit_position

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		player.Looking_around.emit(true)
		if _Looking_from.rotation.x <= 1:
			_Looking_from.rotate_x(deg_to_rad(event.relative.y * sensitivity))
		else:
			_Looking_from.rotation.x = 1
	'if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and event is InputEventMouseMotion:
		CameraBase.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		player.Looking_around.emit(true)
		if _Looking_from.rotation.x <= 1:
			_Looking_from.rotate_x(deg_to_rad(event.relative.y * sensitivity))
		else:
			_Looking_from.rotation.x = 1'
	if Input.is_action_pressed("zoom_in") and _Looking_from.position.z != 3.5:
		_Looking_from.position.y -= 0.25
		_Looking_from.position.z += 0.5
	if Input.is_action_pressed("zoom_out") and _Looking_from.position.z != -5.5:
		_Looking_from.position.y += 0.25
		_Looking_from.position.z -= 0.5
func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.collision_mask = 1
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	return raycast_result
