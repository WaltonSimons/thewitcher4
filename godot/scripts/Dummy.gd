extends KinematicBody2D

export (float) var hit_points = 100

func take_hit(value):
	hit_points -= value
	if hit_points <= 0:
		queue_free()
