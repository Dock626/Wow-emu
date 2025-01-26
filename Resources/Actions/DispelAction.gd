extends BaseSpellAction

func _init() -> void:
	pass

func use(user):
	for buff in user.buffs:
		buff.dispel()
	print(user.buffs)
