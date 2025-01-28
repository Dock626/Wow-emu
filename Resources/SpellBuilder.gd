class_name SpellBuilder

var _sr: SpellResource

func create() -> SpellBuilder:
	var new_sb := SpellBuilder.new()
	return new_sb

func _init():
	_sr = SpellResource.new()
	pass

func set_name(name: String) -> SpellBuilder:
	_sr.name = name
	return self

func set_description(description: String) -> SpellBuilder:
	_sr.description = description
	return self

func set_type(type: SpellResource.cast_type) -> SpellBuilder:
	_sr.type = type
	return self

func set_cast_time(cast_time: float = 0) -> SpellBuilder:
	_sr.cast_time = cast_time
	return self

func set_icon(icon) -> SpellBuilder:
	_sr.icon = icon
	return self

func set_energy_cost(energy_cost: int) -> SpellBuilder:
	_sr.energy_cost = energy_cost
	return self

func is_GCD(type: bool) -> SpellBuilder:
	_sr.is_GCD = type
	return self

func add_action(action: BaseSpellAction) -> SpellBuilder:
	_sr.add_action(action)
	return self

#AoE properties

func set_radius(cast_radius : float = 1) -> SpellBuilder:
	_sr.cast_radius = cast_radius
	return self

func get_spell() -> SpellResource:
	return _sr
