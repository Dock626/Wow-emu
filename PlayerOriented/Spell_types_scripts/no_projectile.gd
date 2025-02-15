extends Node

@onready var SpellHandler = $"../.."

func no_projectile():
	if is_instance_valid(SpellHandler.Player.Cast_target):
		SpellHandler.Player.Cast_target._on_actions_received(SpellHandler.Player.current_spell.actions)
