extends MeshInstance3D



var default = self.mesh.top_radius

func radius(delta):
	self.mesh.top_radius += delta
	self.mesh.bottom_radius += delta
	
func reset():
	self.mesh.top_radius = default
	self.mesh.bottom_radius = default
