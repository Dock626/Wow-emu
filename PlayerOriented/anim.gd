extends Sprite2D
@onready var test = $AnimationPlayer

func _ready() -> void:
	test.play("fade_in_out")
