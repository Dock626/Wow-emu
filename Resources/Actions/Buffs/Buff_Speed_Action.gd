extends Buff

class_name Speed_buff

var original_speed : float
var buffed_speed : float
var buff_amount : float
var type : buff_type

func _init(buff_amount: float, expire: float) -> void:
	'if user != null:
		self.buff.connect(user._on_actions_received)
	if caster != null:
		self.buff.connect(caster._on_actions_received)'
	self.expire = expire
	self.buff_amount = buff_amount
	if buff_amount < 1:
		type = buff_type.debuff
	else:
		type = buff_type.buff

func apply_buff(user):
	var Use_Buff = Speed_buff.new(buff_amount, expire)
	Use_Buff.buffed_speed
	Use_Buff.use(user)

func use(user):
	buffed_speed = (original_speed * buff_amount) - original_speed
	user.SPEED += buffed_speed
	print(self)
	print(user)
	user.buffs.append(self)
	_timer_start(user)

func _on_timer_timeout():
	timer_parent.buffs.erase(self)
	timer_parent.get_node(str(_timer_name)).queue_free()
	timer_parent.SPEED -= buffed_speed

func dispel():
	user.SPEED -= buffed_speed
	for buffs in user.buffs:
		if buffs == self:
			user.buffs.erase(buffs)
	user.get_node(str(_timer_name)).queue_free()



	'self._buff_id = Global.generate_spell_id()
	self.user = user
	var speed_buffed = user.SPEED * speed_bonus
	buff_amount = speed_buffed - user.SPEED
	original_speed = user.SPEED
	user.SPEED = original_speed + buff_amount
	user.buffs_set.get_or_add("speed_buff", type)'
