extends PathFollow2D

export (int) var speed = 100

func _process(delta):
	self.set_offset(self.get_offset() + speed*delta)