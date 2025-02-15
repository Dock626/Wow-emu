extends Timer

class_name Cooldown

var CD_name: String

func on_ready(spell) -> void:
	self.wait_time = spell.CD
	self.CD_name = spell.name
	connect("timeout", Callable(self, "_on_timeout"))
	
func _on_timeout() -> void:
	queue_free()
