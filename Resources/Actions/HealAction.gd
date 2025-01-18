extends BaseSpellAction

@export var heal = 20


func _init(heal : int) -> void:
	self.heal = heal

func use(user):
	user.Health += heal
