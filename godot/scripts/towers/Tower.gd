extends Node2D

export (int) var shoot_range
export (float) var shoot_delay = 1
export (float) var turn_speed = 10

func _ready():
	set_shoot_range(shoot_range)
	$ShootTimer.wait_time = shoot_delay

func set_shoot_range(value):
	$Weapon/RayCast2D.cast_to.y = value
	$RangeArea/CollisionShape2D.get_shape().radius = value

func _process(delta):
	turn_towards_nearest_enemy()

func turn_towards_nearest_enemy():
	var bodies = $RangeArea.get_overlapping_bodies()
	var closest_distance = 0
	var closest = null
	for body in bodies:
		var distance = global_position.distance_to(body.global_position)
		if closest == null:
			closest = body
			closest_distance = distance
		elif distance < closest_distance:
			closest = body
			closest_distance = distance
	if closest:
		$Weapon.rotation = (global_position.angle_to_point(closest.global_position))
		$Weapon.rotation_degrees -= 90

func _on_ShootTimer_timeout():
	$Weapon.shoot(shoot_range)
