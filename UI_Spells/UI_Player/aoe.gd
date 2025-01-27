extends Area3D
signal spell_passer(value)
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var player = get_parent()
var spell : SpellResource

func _ready() -> void:
	self.spell_passer.connect(player._spell_handler._on_player_casting_started)
	self.mesh_instance_3d.mesh.top_radius = spell.cast_radius
func _physics_process(delta: float) -> void:
	global_transform.origin = player.mouse_position
	
func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		spell.cast_position = global_transform.origin
		spell_passer.emit(spell)
		self.queue_free()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		self.queue_free()
