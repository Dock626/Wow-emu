extends Resource

class_name SpellResource 

enum spellclass {
	MAGE = 1,
	WARRIOR = 2
}

@export var spellClass: spellclass = 1
@export var spellIcon: CompressedTexture2D

var actions: Array[BaseSpellAction] = []
var name : String
var description: String
var energy : int
var cast_time : float
var icon

func _init(name: String, description: String, energy: int, charge: float, icon, actions: Array[BaseSpellAction]) -> void:
	self.actions.append_array(actions)
	self.name = name
	self.description = description
	self.energy = energy
	self.cast_time = charge
	self.icon = icon
