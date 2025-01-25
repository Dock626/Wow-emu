extends BaseSpellAction

@export var speed_bonus = 2
@export var type = "buff"
@export var expire = 5
var original_speed
var user
var buff_amount



func _init(speed_bonus: float, expire: float) -> void:
	self.speed_bonus = speed_bonus
	self.expire = expire
	if speed_bonus < 1:
		type = "debuff"
	
	
func use(user):
	self.user = user
	var speed_buffed = user.SPEED * speed_bonus
	buff_amount = speed_buffed - user.SPEED
	original_speed = user.SPEED
	user.SPEED = original_speed + buff_amount
	user.buffs.append(self)
	timer_start(user)


func effect(user):
	return


func timer_start(user):
	print("Speed added")
	var timer = Timer.new()
	timer.name = str(self)
	timer.wait_time = expire
	timer.one_shot = true
	timer.timeout.connect(self._on_timer_timeout)
	user.add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	print("Speed removed")
	user.SPEED -= buff_amount
	user.buffs.erase(self)
	user.get_node(str(self)).queue_free()
