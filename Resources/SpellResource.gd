extends Resource

class_name SpellResource

enum spellclass {
	MAGE = 1,
	WARRIOR = 2
}
enum cast_type {
	Instant,
	Projectile,
	AoE
}

@export var spellClass: spellclass = 1
@export var spellIcon: CompressedTexture2D
var caster: Node
var actions: Array[BaseSpellAction] = []
var name: String
var description: String
var type: cast_type
var energy_cost: int
var cast_time: float = 0
var is_GCD: bool = true
var icon
var default_icon = preload("res://Resources/icons/fajerbol.png")
#AoE properties
var cast_position: Vector3
var cast_radius: float
var effect_time: float
var tick_rate: float
var proc_name: String
func _init(name: String = "", description: String = "", type: cast_type = cast_type.Instant, energy: int = 0, cast_time: float = 0,
			is_GCD: bool = true, icon = self.default_icon, actions: Array[BaseSpellAction] = [], aoe_radius: float = 0) -> void:
	self.actions.append_array(actions)
	self.name = name
	self.description = description
	self.type = type
	self.energy_cost = energy
	self.cast_time = cast_time
	self.is_GCD = is_GCD
	self.icon = icon
	self.cast_radius = aoe_radius
func add_action(action):
	self.actions.append(action)
