extends BaseSpellAction

class_name Buff

enum buff_type {
	debuff = 0,
	buff = 1,
	proc = 2
}

var user: Node
var expire: float
var _timer_name: String

func _init(attribute, value, expire: float) -> void:
	pass
func use(user):
	pass
func _timer_start(user):
	var timer = Timer.new()
	timer.name = str(Global.generate_spell_id())
	_timer_name = timer.name
	timer.wait_time = expire
	timer.one_shot = true
	timer.timeout.connect(self._on_timer_timeout)
	user.add_child(timer)
	timer.start()

func _on_timer_timeout():
	for buffs in user.buffs:
		if buffs == self:
			buffs.dispel()
			user.buffs.erase(buffs)

func check_if_already_applied(user):
	var user_buffs = user.buffs
	for buff in user_buffs:
		if self is proc_buff and buff is proc_buff:
			if self.proc_name == buff.proc_name:
				return true
		elif self.name == buff.name:
			return true

func dispel():
	pass
