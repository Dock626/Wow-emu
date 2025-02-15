extends Node

@onready var SpellHandler = get_parent().get_parent()

func no_projectile():
	if is_instance_valid(SpellHandler.Player.Cast_target):
		SpellHandler.Player.Cast_target._on_actions_received(SpellHandler.Player.current_spell.actions)
		
		var mesh_instance = MeshInstance3D.new()
		mesh_instance.mesh = SphereMesh.new()
		
		var material = StandardMaterial3D.new()
		material.albedo_color = Color(1, 0, 0, 1)
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mesh_instance.set_surface_override_material(0, material)
		
		mesh_instance.scale = Vector3(0.1, 0.1, 0.1)
		mesh_instance.global_transform.origin = SpellHandler.Player.Cast_target.global_transform.origin
		
		get_parent().add_child(mesh_instance)
		
		mesh_instance.set_script(load("res://PlayerOriented/instant_mesh.gd"))
		mesh_instance.target = SpellHandler.Player.Cast_target
		mesh_instance.call("_ready")
		mesh_instance.set_process(true)
		
