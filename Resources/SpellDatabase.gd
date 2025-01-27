extends Node
var Spell_id : int = 0

const HealAction = preload("res://Resources/Actions/HealAction.gd")
const DamageAction = preload("res://Resources/Actions/DamageAction.gd")
const BuffSpeedAction = preload("res://Resources/Actions/Buffs/Buff_Speed_Action.gd")
const DispelAction = preload("res://Resources/Actions/DispelAction.gd")
const AoeProperties = preload("res://Resources/Actions/aoe_properties.gd")
var Spell_List : Array [SpellResource] = [
	SpellResource.new("Flash Heal",             #name
	"A quick flash of light that cures wounds", #description
	"Instant", #type
	15, 	   #energy
	2,  	   #charge
	true,	   #GCD
	preload("res://Resources/icons/fajerbol.png"), #icon
	[
		HealAction.new(20),
		BuffSpeedAction.new(1.5, 5)
	],
	0
	),
	
	SpellResource.new("Firebolt",
	"A quick bolt of fire",
	"Projectile", #type
	15,
	2,
	true,	   #GCD
	preload("res://Resources/icons/fajerbol.png"),
	[
		DamageAction.new(10),
		DispelAction.new()
	],
	0
	),
	
	SpellResource.new("Dispel",
	"Remove a positive effect from enemy",
	"Instant",
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
	"AoE",
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
]

func get_spell(spell_name: String) -> SpellResource:
	for spell in Spell_List:
		if spell.name == spell_name:
			return spell
	return null
