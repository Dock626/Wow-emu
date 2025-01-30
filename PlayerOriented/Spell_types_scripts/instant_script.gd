extends Node

@onready var SpellHandler = $"../.."

func _instant():
	if is_instance_valid(SpellHandler.Player.Cast_target):
		SpellHandler.actions.connect(SpellHandler.Player.Cast_target._on_actions_received)
	SpellHandler.actions.emit(SpellHandler.Player.current_spell.actions)
