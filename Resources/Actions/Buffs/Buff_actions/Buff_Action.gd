extends Buff

class_name Attribute_buff

var original_speed: float
var buff_amount: float
var type: buff_type = buff_type.buff
var attribute: String
func _init(attribute, buff_amount: float, expire: float) -> void:
	self.expire = expire
	self.buff_amount = buff_amount
	self.attribute = attribute
	if buff_amount == 1:
		print_debug(attribute, " buff is set to 1, are you sure it's correct?")
	elif buff_amount < 1:
		type = buff_type.debuff
		
func use(user):
	var Use_Buff = Attribute_buff.new(attribute, buff_amount, expire)
	Use_Buff.user = user
	Use_Buff.apply_buff(user)
	user.buffs.append(Use_Buff)

func apply_buff(user):
	#user.get(attribute) += user.get(attribute) * buff_amount - user.get(attribute)
	var user_attribute = user._get(attribute)
	_timer_start(user)

func dispel():
	user.SPEED -= user.unbuffed_SPEED * buff_amount - user.unbuffed_SPEED
	for buffs in user.buffs:
		if buffs == self:
			user.buffs.erase(buffs)
	user.get_node(str(_timer_name)).queue_free()
