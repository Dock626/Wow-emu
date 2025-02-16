extends AnimationPlayer
@onready var player = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.active = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player._spell_handler._casting:
		self.play("Spellcast_Long")
	elif player.velocity.y != 0:
		self.play("Jump_Idle")
	elif player.velocity != Vector3(0,0,0):
		self.play("Walking_A")
	else:
		self.play("Idle")
	
