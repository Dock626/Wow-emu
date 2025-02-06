extends Node

const HealAction = preload("res://Resources/Actions/HealAction.gd")
const DamageAction = preload("res://Resources/Actions/DamageAction.gd")
const DispelAction = preload("res://Resources/Actions/DispelAction.gd")
const BuffAction = preload("res://Resources/Actions/Buffs/Buff_actions/Buff_percent_Action.gd")
const BuffProc = preload("res://Resources/Actions/Buffs/Buff_actions/Buff_proc.gd")


var Spell_List: Array[SpellResource] = []

func _ready():
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Firebolt")
		.set_description("BIGGGG FIREBOLT")
		.set_energy_cost(15)
		.set_cast_time(1.5)
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
		.set_cast_time(3)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/fajerbol.png"))
		.set_type(SpellResource.cast_type.AoE)
		.add_action(DamageAction.new(20))
		.set_radius(3)
		.set_effect_time(5)
		#.set_tick_rate(1)
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
		.add_action(BuffAction.new("SPEED", 1.5, 2))
		.add_action(DamageAction.new(10))
		.add_action(BuffProc.new("Quick_Firebolt", 10))
		.get_spell())

func get_spell(spell_name: String) -> SpellResource:
	for spell in Spell_List:
		if spell.name == spell_name:
			return spell
	return null
