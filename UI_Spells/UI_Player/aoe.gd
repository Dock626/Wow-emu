extends Area3D
signal actions(value)
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var player = get_parent()
var spell : SpellResource
func _ready() -> void:
	self.actions.connect(player._on_actions_received)

func _physics_process(delta: float) -> void:
	global_transform.origin = player.mouse_position
	
func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		spell.cast_position = global_transform.origin
		actions.emit(spell)
		self.queue_free()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		self.queue_free()
