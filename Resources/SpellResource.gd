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
var procs: Array[proc_buff] = []
var name: String
var description: String
var type: cast_type
var energy_cost: int
var cast_time: float = 0
var is_GCD: bool = true
var icon
var default_icon = preload("res://Resources/icons/fajerbol.png")
var proc_check: String
var cast_only_while_standing: bool = true

#AoE properties
var cast_position: Vector3
var cast_radius: float
var effect_time: float
var tick_rate: float

func _init(name: String = "", description: String = "", type: cast_type = 
			cast_type.Instant, energy: int = 0, cast_time: float = 0,
			is_GCD: bool = true, icon = self.default_icon,
			actions: Array[BaseSpellAction] = [], procs: Array[proc_buff] = [], 
			aoe_radius: float = 0) -> void:
	self.actions.append_array(actions)
	self.procs.append_array(procs)
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

func apply_proc():
	self.cast_time = 0

func is_procced(user, button):
	for buff in user.buffs:
		if buff is proc_buff and button.Spell.proc_check == buff.proc_name:
			return true
func duplicate_spell() -> SpellResource:
	# Create a new instance of SpellResource
	var new_spell = SpellResource.new(self.name, self.description, self.type, self.energy_cost, self.cast_time, self.is_GCD, self.icon, [], [], self.cast_radius)

	# Copy primitive values
	new_spell.spellClass = self.spellClass
	new_spell.spellIcon = self.spellIcon
	new_spell.cast_position = self.cast_position
	new_spell.effect_time = self.effect_time
	new_spell.tick_rate = self.tick_rate
	new_spell.proc_check = self.proc_check
	new_spell.cast_only_while_standing = self.cast_only_while_standing
	# Manually copy actions (ensure they support duplication)
	for action in self.actions:
		action.spell = new_spell
		new_spell.actions.append(action.duplicate_action())

	return new_spell
