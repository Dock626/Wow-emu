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
	
func is_user_friendly(user):
	var is_player = false
	for player in Global.get_players():
		if user == player:
			is_player = true
	if is_player:
		return true
