extends MeshInstance3D

var max_scale: float = 5.0  # Maximum scale the sphere will reach
var duration: float = 2.0   # Duration for full expansion
var elapsed_time: float = 0.0
var target
func _ready():
	# Create a red sphere mesh
	mesh = SphereMesh.new()
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(1, 0, 0, 1)  # Red color with full opacity
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	set_surface_override_material(0, material)
	
	scale = Vector3(0.1, 0.1, 0.1)  # Start small

func _process(delta):
	if is_instance_valid(target):
		self.global_transform.origin = target.global_transform.origin
	elapsed_time += delta
	var progress = elapsed_time / duration
	
	if progress < 1.0:
		# Expand the sphere
		var new_scale = lerp(Vector3(0.1, 0.1, 0.1), Vector3(max_scale, max_scale, max_scale), progress)
		scale = new_scale
		
		# Reduce opacity over time
		var material = get_surface_override_material(0)
		if material:
			material.albedo_color.a = lerp(1.0, 0.0, progress)
	else:
		queue_free()  # Remove the object when done
