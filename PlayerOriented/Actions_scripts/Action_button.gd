extends Button

signal Action_pressed(value)

@onready var UI = $"../..".get_parent()
var Spell : SpellResource = SpellDatabase.get_spell("FireBolt")
var spell_name : String
var button_id : int

func _ready():
	self.Action_pressed.connect(UI._on_Action_pressed)
	UI.Spell_list.append([button_id, Spell])
func _can_drop_data(position, data):
	return data is SpellResource

func _drop_data(position, data):
	if data is SpellResource:
		_update(data)
		
	
func _update(spell) -> void:
	UI.Spell_list.erase([button_id, Spell])
	
	icon = spell.icon
	self.Spell = spell
	
	UI.Spell_list.append([button_id, Spell])
func _get_drag_data(position):
	var drag_data = Spell
	var preview = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)
	self.icon = null
	Spell = null
	return drag_data

func _pressed() -> void:
	Action_pressed.emit(Spell)
	
