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
	
	if Spell:
		self.icon = Spell.icon
		Spell.caster = Player
	
func _process(delta: float) -> void:
	if Spell and Spell.is_procced(Player, self):
		glow_effect.visible = true
	else: 
		glow_effect.visible = false
		
func _can_drop_data(position, data):
	return data is SpellResource

func _drop_data(position, data):
	if data is SpellResource:
		_update(data)
		
	
func _update(spell) -> void:
	Player.Action_bar.erase([button_id, Spell])
	icon = spell.icon
	self.Spell = spell
	Spell.caster = Player
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
	
