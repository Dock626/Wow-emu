extends GridContainer
const SPELLBOOK_BUTTON = preload("res://UI_Spells/Spell_book/spellbook_button.tscn")
#@onready var SpellList = Global.get_SpellHandler()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(1, 9):
		var spellbook_button = SPELLBOOK_BUTTON.instantiate()
		spellbook_button.button_id = i
		if i == 1:
			spellbook_button.spell = SpellDatabase.get_spell("Firebolt")
		elif i == 2:
			spellbook_button.spell = SpellDatabase.get_spell("Flame Strike")
		elif i == 3:
			spellbook_button.spell = SpellDatabase.get_spell("Haste")
		elif i == 4:
			spellbook_button.spell = SpellDatabase.get_spell("Combustion")
		elif i == 5:
			spellbook_button.spell = SpellDatabase.get_spell("Scortch")
		self.add_child(spellbook_button)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
