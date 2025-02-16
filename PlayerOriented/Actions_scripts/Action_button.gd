extends Button

signal Action_pressed(value)
const COLOR_RECT = preload("res://color_rect.tscn")
@onready var Player = $"../..".get_parent()
var Spell : SpellResource = SpellDatabase.get_spell("FireBolt")
var spell_name : String
var button_id : int
@onready var glow_effect = $ColorRect
func _ready():
	self.Action_pressed.connect(Player._on_Action_pressed)
	Player.Action_bar.append([button_id, Spell])
	self.text = str(button_id)
	if Spell:
		self.icon = Spell.icon
		self.tooltip_text = Spell.description
		Spell.caster = Player
	
func _process(delta: float) -> void:
	if Spell and Spell.is_procced(Player, self):
		glow_effect.visible = true
	else: 
		glow_effect.visible = false

func _physics_process(delta: float) -> void:
	if Spell and Spell.CD > 0:
		var cooldown_active = false  # Track if we found an active cooldown
	
		for cooldown in Player._spell_handler.cooldowns.get_children():
			if cooldown.CD_name == Spell.name:
				cooldown_active = true  # Mark cooldown as active
				self.modulate = Color(1, 1, 1, 0.5)  # Make button semi-transparent
				self.text = str(round(cooldown.time_left))  # Show cooldown time
				break  # Stop checking once we find it
	
		if not cooldown_active:  # If no cooldowns were found, reset button
			self.modulate = Color(1, 1, 1, 1)  # Restore normal visibility
			self.text = str(button_id)  # Reset button text

	else:
		self.modulate = Color(1, 1, 1, 1)  # Ensure full opacity
		self.text = str(button_id)  # Restore default text
func _can_drop_data(position, data):
	return data is SpellResource

func _drop_data(position, data):
	if data is SpellResource:
		_update(data)
		
func reset():
	self.text = str(button_id)
	self.modulate = Color(1, 1, 1, 1)
func _update(spell) -> void:
	Player.Action_bar.erase([button_id, Spell])
	self.tooltip_text = spell.description
	icon = spell.icon
	self.Spell = spell
	Player.Action_bar.append([button_id, Spell])

func _get_drag_data(position):
	var drag_data = Spell
	var preview = TextureRect.new()
	preview.texture = icon
	set_drag_preview(preview)
	self.icon = null
	Spell = null
	return drag_data

func _pressed() -> void:
	Action_pressed.emit(Spell)
	
