extends Buff

class_name Attribute_buff_on_hit

var original_speed: float
var buff_amount: float
var type: buff_type = buff_type.buff
var attribute: String

func _init(attribute, buff_amount: int, expire: float) -> void:
	self.expire = expire
	self.buff_amount = buff_amount
	self.attribute = attribute
	if buff_amount == 0:
		print_debug(attribute, " buff is set to 0, are you sure it's correct?")
	elif buff_amount < 0:
		type = buff_type.debuff

func use(user):
	var Use_Buff = Attribute_buff_on_hit.new(attribute, buff_amount, expire)
	Use_Buff.user = caster
	Use_Buff.apply_buff(caster)
	user.buffs.append(Use_Buff)

func apply_buff(user):
	var user_attribute = user.get(attribute)
	user_attribute += buff_amount
	user.set(attribute, user_attribute)
	_timer_start(user)


func dispel():
	var user_attribute = user.get(attribute)
	user_attribute -= buff_amount
	user.set(attribute, user_attribute)
	for buffs in user.buffs:
		if buffs == self:
			user.buffs.erase(buffs)
	user.get_node(str(_timer_name)).queue_free()
