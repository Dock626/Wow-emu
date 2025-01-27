extends BaseSpellAction
const BuffSpeed = preload("res://Resources/Actions/Buffs/Buff_instance/Buff_speed.gd")
@export var speed_bonus = 2
@export var type = "buff"
@export var expire = 5


func _init(speed_bonus: float, expire: float) -> void:
	
	self.speed_bonus = speed_bonus
	self.expire = expire
	if speed_bonus < 1:
		type = "debuff"

func use(user):
	var Buff = BuffSpeed.new(user,user.unbuffed_SPEED,speed_bonus,Global.generate_spell_id(), self.expire)
	Buff.use(user)
	
	
	
	'self._buff_id = Global.generate_spell_id()
	self.user = user
	var speed_buffed = user.SPEED * speed_bonus
	buff_amount = speed_buffed - user.SPEED
	original_speed = user.SPEED
	user.SPEED = original_speed + buff_amount
	user.buffs_set.get_or_add("speed_buff", type)'
