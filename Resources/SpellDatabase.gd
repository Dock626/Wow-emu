extends Node

const HealAction = preload("res://Resources/Actions/HealAction.gd")
const DamageAction = preload("res://Resources/Actions/DamageAction.gd")
const BuffSpeedAction = preload("res://Resources/Actions/Buffs/Buff_actions/Buff_Speed_Action.gd")
const DispelAction = preload("res://Resources/Actions/DispelAction.gd")
const AoeProperties = preload("res://Resources/Actions/aoe_properties.gd")

var Spell_List : Array [SpellResource] = []

func _ready():
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Firebolt")
		.set_description("BIGGGG FIREBOLT")
		.set_energy_cost(15)
		.set_cast_time(2)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/fajerbol.png"))
		.set_type(SpellResource.cast_type.Projectile)
		.add_action(DamageAction.new(20))
		.get_spell())
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Flame Strike")
		.set_description("Quick wave of flames")
		.set_energy_cost(15)
		.set_cast_time(0)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/fajerbol.png"))
		.set_type(SpellResource.cast_type.AoE)
		.add_action(DamageAction.new(20))
		.set_radius(3)
		.get_spell())
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Haste")
		.set_description("Speedy speed")
		.set_energy_cost(15)
		.set_cast_time(0)
		.is_GCD(false)
		.set_icon(preload("res://Resources/icons/fajerbol.png"))
		.set_type(SpellResource.cast_type.Instant)
		.add_action(BuffSpeedAction.new(1.5, 2))
		.get_spell())

func get_spell(spell_name: String) -> SpellResource:
	for spell in Spell_List:
		if spell.name == spell_name:
			return spell
	return null
