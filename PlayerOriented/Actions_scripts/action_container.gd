extends GridContainer
const ACTION_BUTTON = preload("res://PlayerOriented/Actions_scripts/action_button.tscn")
var action_buttons = self.get_children()
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	for i in range(1, 9):
		var action_button = ACTION_BUTTON.instantiate()
		action_button.button_id = i
		action_button.text = str(i)
		if i == 1:
			action_button.Spell = SpellDatabase.get_spell("Scortch")
		elif i == 2:
			action_button.Spell = SpellDatabase.get_spell("Firebolt")
		elif i == 3:
			action_button.Spell = SpellDatabase.get_spell("Flame Strike")
		elif i == 4:
			action_button.Spell = SpellDatabase.get_spell("Haste")
		elif i == 5:
			action_button.Spell = SpellDatabase.get_spell("Combustion")
		self.add_child(action_button)
		
