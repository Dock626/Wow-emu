extends Node

@onready var SpellHandler = $"../.."
const AOE_COLLISION = preload("res://Resources/Spell_logic/aoe_collision.tscn")

func aoe():
	var aoe_position = SpellHandler.Player.current_spell.cast_position
	var aoe_radius = SpellHandler.Player.current_spell.cast_radius
	var aoe = AOE_COLLISION.instantiate()
	var main = Global.get_main()
	aoe.position = aoe_position
	aoe.collision_radius = aoe_radius
	var mesh = aoe.get_node("MeshInstance3D").mesh
	mesh.top_radius = aoe_radius
	main.add_child(aoe)
