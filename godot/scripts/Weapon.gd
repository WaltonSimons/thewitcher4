extends Sprite

export (float) var damage_per_shot
export (PackedScene) var ray_scene
export (Color) var projectile_color

func shoot(shoot_range):
	var dist = shoot_range
	if $RayCast2D.is_colliding():
		var col = $RayCast2D.get_collider()
		if col:
			col.take_hit(damage_per_shot)
			dist = $ProjectileOrigin.global_position.distance_to(col.global_position)
	draw_shoot(dist/2)

func draw_shoot(length):
	var ray = ray_scene.instance()
	ray.vanish_time = 0.1
	ray.ray_color = projectile_color
	get_parent().get_parent().add_child(ray)
	ray.position = $ProjectileOrigin.global_position
	ray.rotation = rotation
	ray.scale = Vector2(0.3, length)