extends Node

@onready var SpellHandler = $"../.."
const AOE_COLLISION = preload("res://Resources/Spell_logic/aoe_collision.tscn")

func aoe():
	var aoe_position = SpellHandler.Player.current_spell.cast_position
	var aoe_radius = SpellHandler.Player.current_spell.cast_radius
	var duplicate_aoe = AOE_COLLISION.duplicate()
	var aoe = duplicate_aoe.instantiate()
	var main = Global.get_main()
	aoe.position = aoe_position
	var radius = aoe.get_node("CollisionShape3D").shape
	var mesh = aoe.get_node("MeshInstance3D").mesh
	aoe.effect_time = SpellHandler.Player.current_spell.effect_time
	aoe.actions = SpellHandler.Player.current_spell.actions
	
	mesh.top_radius = aoe_radius
	radius.radius = aoe_radius
	main.add_child(aoe)
