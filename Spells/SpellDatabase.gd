extends Node

var spells = {
	"Fireball": {
		"description": "A blazing ball of fire.",
		"damage": 50,
		"mana_cost": 20,
		"cooldown": 5,
		"target_type": "enemy"
	},
	"Salve": {
		"description": "Restores health.",
		"heal": 30,
		"mana_cost": 15,
		"cooldown": 3,
		"target_type": "ally"
	}
}

func get_spell(name: String) -> Dictionary:
	return spells.get(name, null)
