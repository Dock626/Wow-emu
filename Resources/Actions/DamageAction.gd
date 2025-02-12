extends BaseSpellAction

@export var damage = 25


func _init(damage : int) -> void:
	self.damage = damage

func use(user):
	user.Health -= damage
	
