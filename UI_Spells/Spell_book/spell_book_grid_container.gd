extends GridContainer
const SPELLBOOK_BUTTON = preload("res://UI_Spells/Spell_book/spellbook_button.tscn")
#@onready var SpellList = Global.get_SpellHandler()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(SpellList)
	for i in range(1, 9):
		var spellbook_button = SPELLBOOK_BUTTON.instantiate()
		spellbook_button.button_id = i
		if i == 1:
			spellbook_button.spell = SpellDatabase.get_spell("Firebolt")
		if i == 2:
			spellbook_button.spell = SpellDatabase.get_spell("Flash Heal")
		#spellbook_button.spell = SpellList.return_spell("Firebolt")
		self.add_child(spellbook_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
