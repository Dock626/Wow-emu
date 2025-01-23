extends Button
@onready var name_display = $TextEdit
var spell : SpellResource = SpellDatabase.get_spell("FireBolt")
var button_id : int

func _ready() -> void:
	if spell:
		self.icon = spell.icon
		self.tooltip_text = spell.description
		name_display.text = spell.name
func _get_drag_data(position):
	var drag_data = spell
	var preview = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)  # Optional: Visual representation of drag
	return drag_data
