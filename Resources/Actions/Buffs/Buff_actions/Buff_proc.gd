extends Buff

class_name proc_buff

var original_speed: float
var buff_amount: float
var type: buff_type = 2
var attribute: String
var proc_name: String
var chance: int
func _init(chance: int, proc_name: String, expire: float) -> void:
	self.expire = expire
	self.proc_name = proc_name
	self.chance = chance

func use(user):
	if check_if_already_applied(user):
		return
	var rng = RandomNumberGenerator.new()
	var randi = rng.randi_range(0, 1000)
	if randi > chance:
		return
	var Use_Buff = proc_buff.new(chance, proc_name, expire)
	Use_Buff.user = user
	Use_Buff.apply_buff(user)
	user.buffs.append(Use_Buff)

func apply_buff(user):
	_timer_start(user)

func dispel():
	for buffs in user.buffs:
		if buffs == self:
			user.buffs.erase(buffs)
	user.get_node(str(_timer_name)).queue_free()

func _to_string() -> String:
	return proc_name
