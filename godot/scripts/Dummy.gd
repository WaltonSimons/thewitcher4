extends KinematicBody2D

signal health_changed(value, max_value)

export (float) var max_hit_points = 100
export (float) var speed = 100
var speed_multiplier = 1
var hit_points

func _ready():
	hit_points = max_hit_points

func take_hit(value):
	hit_points -= value
	emit_signal('health_changed', hit_points, max_hit_points)
	if hit_points <= 0:
		queue_free()

func get_speed():
	return speed_multiplier*speed