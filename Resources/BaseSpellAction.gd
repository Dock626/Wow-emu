# BaseSpellAction
extends Resource

class_name BaseSpellAction
var name: String
var caster: Node
var spell
func use(player: Player_Base):
	pass
func set_spell(parent):
	self.spell = parent
func duplicate_action():
	return self
