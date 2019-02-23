extends Sprite

export (PackedScene) var rocket_scene

func shoot(shoot_range):
	var dist = shoot_range
	if $RayCast2D.is_colliding():
		var col = $RayCast2D.get_collider()
		if col:
			launch_rocket(col.position)

func launch_rocket(target):
	var rocket = rocket_scene.instance()
	get_parent().get_parent().add_child(rocket)
	rocket.global_position = global_position
	rocket.global_rotation = rotation
	rocket.distance = global_position.distance_to(target)
	rocket.set_tween(target)
