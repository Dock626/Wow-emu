extends proc_buff

class_name proc_time

func _init(proc_name: String, expire: float) -> void:
	self.expire = expire
	self.proc_name = proc_name
	self.is_erased_on_use = false

func use(user):
	if check_if_already_applied(user):
		return
	var Use_Buff = proc_time.new(proc_name, expire)
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
