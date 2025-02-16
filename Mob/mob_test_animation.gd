extends AnimationPlayer

@onready var mob = $"../../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if mob.velocity != Vector3(0,0,0):
		self.play("Walking_A")
	else:
		var anim_name = "2H_Melee_Attack_Chop"
		var anim_player = self

		# Get the original animation length
		var anim = anim_player.get_animation(anim_name)
		var anim_length = anim.length  # Duration in seconds

		# Calculate speed scale to make it play over 3 seconds
		var speed_scale = anim_length / 3.0

		# Set the playback speed
		anim_player.set_speed_scale(speed_scale)
		anim_player.play(anim_name)
		
