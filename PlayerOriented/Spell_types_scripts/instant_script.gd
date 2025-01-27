extends Node

@onready var SpellHandler = $"../.."

func _instant():
	SpellHandler.actions.connect(SpellHandler.Player.Cast_target._on_actions_received)
	SpellHandler.actions.emit(SpellHandler.Player.current_spell.actions)
