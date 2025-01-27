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
var type : String
var energy : int
var cast_time : float
var GCD : bool
var icon

#AoE properties
var cast_position : Vector3
var cast_radius

func _init(name: String, description: String, type: String, energy: int, charge: float, GCD: bool, icon, actions: Array[BaseSpellAction]) -> void:
	self.actions.append_array(actions)
	self.name = name
	self.description = description
	self.type = type
	self.energy = energy
	self.cast_time = charge
	self.GCD = GCD
	self.icon = icon
