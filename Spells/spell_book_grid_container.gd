extends GridContainer
const SpellBookButton = preload("res://Spells/spellbook_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(SpellList)
	'for i in range(1, 9):
		var spellbook_button = SpellBookButton.instantiate()
		spellbook_button.button_id = i
		spellbook_button.spell = SpellList.return_spell("Firebolt")
		self.add_child(spellbook_button)'
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
