extends Node
var Spell_id : int = 0

const HealAction = preload("res://Resources/Actions/HealAction.gd")
const DamageAction = preload("res://Resources/Actions/DamageAction.gd")
const BuffSpeedAction = preload("res://Resources/Actions/Buffs/Buff_Speed_Action.gd")
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
		.set_name("FlameStrike")
		.set_description("Quick wave of flames")
		.set_energy_cost(15)
		.set_cast_time(0)
		.is_GCD(true)
		.set_icon(preload("res://Resources/icons/fajerbol.png"))
		.set_type(SpellResource.cast_type.AoE)
		.add_action(DamageAction.new(20))
		.set_radius(3)
		.get_spell())
	

func get_spell(spell_name: String) -> SpellResource:
	for spell in Spell_List:
		if spell.name == spell_name:
			return spell
	return null
'[
	SpellResource.new("Flash Heal",             #name
	"A quick flash of light that cures wounds", #description
	SpellResource.cast_type.Instant, #type
	15, 	   #energy
	2,  	   #cast_time
	true,	   #is_GCD
	preload("res://Resources/icons/fajerbol.png"), #icon
	[
		HealAction.new(20),
		BuffSpeedAction.new(1.5, 5)
	],
	0
	),
	
	SpellResource.new("Firebolt",
	"A quick bolt of fire",
	SpellResource.cast_type.Projectile, #type
	15,
	2,
	true,	   #is_GCD
	preload("res://Resources/icons/fajerbol.png"),
	[
		DamageAction.new(10),
		DispelAction.new()
	],
	0
	),
	
	SpellResource.new("Dispel",
	"Remove a positive effect from enemy",
	SpellResource.cast_type.Instant,
	15,
	2,
	true,
	preload("res://Resources/icons/fajerbol.png"),
	[
		DispelAction.new()
	],
	0
	),
	
	SpellResource.new("Flamestrike",
	"Unleash a wave of flames",
	SpellResource.cast_type.AoE,
	15,
	2,
	true,
	preload("res://Resources/icons/fajerbol.png"),
	[
		DamageAction.new(20),
		#AoeProperties.new(5)
	],
	3
	)
]'
