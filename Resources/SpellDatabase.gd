extends Node


const HealAction = preload("res://Resources/Actions/HealAction.gd")
const DamageAction = preload("res://Resources/Actions/DamageAction.gd")

var Spell_List : Array [SpellResource] = [
	SpellResource.new("Flash Heal",             #name
	"A quick flash of light that cures wounds", #description
	15, #energy
	2,  #charge
	[
		HealAction.new()
	]),
	SpellResource.new("Firebolt",
	"A quick bolt of fire",
	15,
	2,
	[
		DamageAction.new()
	])
]

func get_spell(spell_name: String) -> SpellResource:
	for spell in Spell_List:
		if spell.name == spell_name:
			return spell
	return null
