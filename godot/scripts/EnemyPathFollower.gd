extends PathFollow2D

var unit

func _process(delta):
	var unit_ref = weakref(unit)
	if unit_ref.get_ref():
		self.set_offset(self.get_offset() + unit.get_speed()*delta)
	else:
		queue_free()