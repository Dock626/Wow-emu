extends Control

@onready var buttons = $GridContainer.get_children()
func _ready():
	for button in buttons:
		button.pressed.connect(self._button_pressed)
		

func _physics_process(delta: float) -> void:
	pass

func _button_pressed():
	print("Hello world!")
