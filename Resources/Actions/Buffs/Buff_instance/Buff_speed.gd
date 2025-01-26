extends BaseSpellAction

signal buff(value)


var user : Node
var original_speed : float
var buff_amount :float
var _buff_id : int
var _timer_name : String
var expire : float
var buffed_speed : float
func _init(user : Node, original_speed : float, buff_amount : float, _buff_id : int, expire) -> void:
	self.user = user
	self.original_speed = original_speed
	self.buff_amount = buff_amount
	self._buff_id = _buff_id
	self.expire = expire
	self.buff.connect(user._on_actions_received)

func use(user):
	buffed_speed = (original_speed * buff_amount) - original_speed
	user.SPEED += buffed_speed
	user.buffs.append(self)
	_timer_start(user)


func _timer_start(user):
	print("Speed added")
	print(user.buffs, " speed: ", user.SPEED)
	var timer = Timer.new()
	timer.name = str(_buff_id)
	_timer_name = timer.name
	timer.wait_time = expire
	timer.one_shot = true
	timer.timeout.connect(self._on_timer_timeout)
	user.add_child(timer)
	timer.start()

func _on_timer_timeout():
	print("Speed removed")
	user.SPEED -= buffed_speed
	user.buffs.erase(self)
	print(user.SPEED)
	user.get_node(str(_timer_name)).queue_free()

func dispel():
	print("dispel")
	user.SPEED -= buffed_speed
	for buff in user.buffs:
		if buff == self:
			user.buffs.erase(buff)
	user.get_node(str(_timer_name)).queue_free()
