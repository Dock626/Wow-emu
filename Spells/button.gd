extends Button


func _get_drag_data(position):
	var drag_data = {
		"icon": icon,
		"id": 1
	}
	var preview = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)  # Optional: Visual representation of drag
	return drag_data
	
