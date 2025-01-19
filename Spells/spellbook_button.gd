extends Button

var spell : SpellResource = SpellDatabase.get_spell("Firebolt")


func _ready() -> void:
	self.icon = spell.icon
	self.tooltip_text = spell.description
	

func _get_drag_data(position):
	var drag_data = spell
	var preview = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)  # Optional: Visual representation of drag
	return drag_data
