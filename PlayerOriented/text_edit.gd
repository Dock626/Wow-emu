extends TextEdit

func _process(delta: float) -> void:
	self.text = ("score: " + str(Global.score))
