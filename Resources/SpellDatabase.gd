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
		.set_name("Scortch")
		.set_description("Quick flame burst, castable while moving")
		.set_energy_cost(15)
		.set_cast_time(1.5)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/scortch.png"))
		.set_type(SpellResource.cast_type.Instant)
		.add_action(DamageAction.new(10))
		.add_action(BuffProc.new(250, "Quick_Firebolt", 10))
		.is_castable_while_walking()
		.get_spell())
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Firebolt")
		.set_description("A bolt of fire")
		.set_energy_cost(25)
		.set_cast_time(2)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/fajerbol.png"))
		.set_type(SpellResource.cast_type.Projectile)
		.add_action(DamageAction.new(25))
		.add_action(BuffProc.new(200, "Quick_Firebolt", 10))
		.proc_check("Quick_Firebolt")
		.get_spell())
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Flame Strike")
		.set_description("A wave of flames")
		.set_energy_cost(15)
		.set_cast_time(3)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/Flame_Strike.webp"))
		.set_type(SpellResource.cast_type.AoE)
		.add_action(DamageAction.new(15))
		.set_radius(5)
		.set_effect_time(5)
		.proc_check("Quick_Firebolt")
		#.set_tick_rate(1)
		.get_spell())
	Spell_List.append(SpellBuilder.new()
		.create()
		.set_name("Haste")
		.set_description("Speedy speed")
		.set_energy_cost(15)
		.set_cast_time(0)
		.is_GCD(false)
		.set_icon(preload("res://Resources/icons/haste.png"))
		.set_type(SpellResource.cast_type.Instant)
		.add_action(BuffAction.new("SPEED", 1.5, 4))
		.is_castable_while_walking()
		.get_spell())

func get_spell(spell_name: String) -> SpellResource:
	for spell in Spell_List:
		if spell.name == spell_name:
			var spell_return = spell.duplicate_spell()
			return spell_return
	return null

func get_spell_by_id(id) -> SpellResource:
	for i in range(0, Spell_List.size()):
		if i == id:
			return Spell_List[i]
	return null
