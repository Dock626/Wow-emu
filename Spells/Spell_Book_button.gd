extends Button
@onready var name_display = $TextEdit
var spell : SpellResource = SpellDatabase.get_spell("Firebolt")
var button_id : int

func _ready() -> void:
	self.icon = spell.icon
	self.tooltip_text = spell.description
	get_child(0).text = spell.name # why the fuck does name_display.text not work?

func _get_drag_data(position):
	var drag_data = spell
	var preview = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)  # Optional: Visual representation of drag
	return drag_data
