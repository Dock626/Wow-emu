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
	if check_if_already_applied(user):
		return
	var Use_Buff = Attribute_buff.new(attribute, buff_amount, expire)
	Use_Buff.user = user
	Use_Buff.name = self.name #for some mysterious reason the name is erased
	Use_Buff.apply_buff(user)
	user.buffs.append(Use_Buff)

func apply_buff(user):
	var user_attribute = user.get(attribute)
	var var_original = user_attribute
	user_attribute += (user_attribute * buff_amount) - user_attribute
	user.set(attribute, user_attribute)
	buff_amount = user_attribute - var_original
	_timer_start(user)

func dispel():
	var user_attribute = user.get(attribute)
	user_attribute -= buff_amount
	user.set(attribute, user_attribute)
	for buffs in user.buffs:
		if buffs == self:
			user.buffs.erase(buffs)
	user.get_node(str(_timer_name)).queue_free()
