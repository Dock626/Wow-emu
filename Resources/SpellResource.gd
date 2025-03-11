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
var name: String = ""
var description: String = ""
var type: cast_type = cast_type.Instant
var energy_cost: int = 0
var cast_time: float = 0
var is_GCD: bool = true
var icon
var default_icon = preload("res://Resources/icons/fajerbol.png")
var proc_check: String
var cast_only_while_standing: bool = true
var CD: float
# AoE properties
var cast_position: Vector3
var cast_radius: float = 0
var effect_time: float
var tick_rate: float

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
	var new_spell = SpellResource.new()

	# Copy primitive values
	new_spell.name = self.name
	new_spell.description = self.description
	new_spell.type = self.type
	new_spell.energy_cost = self.energy_cost
	new_spell.cast_time = self.cast_time
	new_spell.is_GCD = self.is_GCD
	new_spell.icon = self.icon
	new_spell.cast_radius = self.cast_radius
	new_spell.spellClass = self.spellClass
	new_spell.spellIcon = self.spellIcon
	new_spell.cast_position = self.cast_position
	new_spell.effect_time = self.effect_time
	new_spell.tick_rate = self.tick_rate
	new_spell.proc_check = self.proc_check
	new_spell.cast_only_while_standing = self.cast_only_while_standing
	new_spell.CD = self.CD

	# Duplicate actions
	for action in self.actions:
		var duplicated_action = action.duplicate_action()
		duplicated_action.spell = new_spell
		duplicated_action.name = new_spell.name
		new_spell.actions.append(duplicated_action)

	# Duplicate procs
	for proc in self.procs:
		new_spell.procs.append(proc.duplicate())

	return new_spell
