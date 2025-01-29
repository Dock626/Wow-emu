extends BaseSpellAction

class_name Buff

enum buff_type{
	debuff = 0,
	buff = 1
}

signal buff(value)
var user : Node
var caster : Node
var expire : float
var _timer_name : String
var timer_parent

func _init(value, expire:float) -> void:
	if user != null:
		self.buff.connect(user._on_actions_received)
	pass
func apply_buff(user):
	pass
func use(user):
	pass
func _timer_start(user):
	print(user)
	var timer = Timer.new()
	timer.name = str(Global.generate_spell_id())
	_timer_name = timer.name
	timer.wait_time = expire
	timer.one_shot = true
	timer.timeout.connect(self._on_timer_timeout)
	timer_parent = user
	user.add_child(timer)
	timer.start()

func _on_timer_timeout():
	timer_parent.buffs.erase(self)
	timer_parent.get_node(str(_timer_name)).queue_free()

func dispel():
	pass
