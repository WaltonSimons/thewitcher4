extends PathFollow2D

var unit

func _process(delta):
	if unit:
		self.set_offset(self.get_offset() + unit.get_speed()*delta)
	else:
		queue_free()