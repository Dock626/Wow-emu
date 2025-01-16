class_name SpellBuilder

var _sr: SpellResource

func create() -> SpellBuilder:
	var new_sb := SpellBuilder.new()
	return new_sb

func _init():
	#_sr = SpellResource.new()
	pass
func set_description(description: String) -> SpellBuilder:
	_sr.description = description
	return self

func set_name(name: String) -> SpellBuilder:
	_sr.name = name
	return self

func add_action(action: BaseSpellAction) -> SpellBuilder:
	_sr.add_action(action)
	return self

func get_spell() -> SpellResource:
	return _sr
