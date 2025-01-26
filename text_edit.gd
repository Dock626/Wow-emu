extends TextEdit
@onready var timer = $Timer
var score : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
func _process(delta: float) -> void:
	self.text = str(score)
func _on_timer_timeout() -> void:
	score +=1
