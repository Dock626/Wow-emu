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

func proc_check(proc_name: String) -> SpellBuilder:
	_sr.proc_check = proc_name
	return self
	
func add_action(action: BaseSpellAction) -> SpellBuilder:
	action.set_spell(self)
	action.name = _sr.name
	_sr.add_action(action)
	return self

#AoE properties

func set_radius(cast_radius: float = 1) -> SpellBuilder:
	_sr.cast_radius = cast_radius
	return self

func set_effect_time(effect_time: float = 0): # for example, how long will a slow trap last on map
	_sr.effect_time = effect_time
	return self
func set_tick_rate(tick_rate: float = 2):
	_sr.tick_rate = tick_rate
	return self

func get_spell() -> SpellResource:
	if _sr.type == SpellResource.cast_type.AoE and _sr.cast_radius == 0:
		print_debug("aoe spell " + _sr.name + " has radius of 0")
	return _sr
