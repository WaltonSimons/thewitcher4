extends Node2D

export (int) var shoot_range
export (PackedScene) var ray_scene
export (Color) var projectile_color
export (float) var damage_per_shot
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
	#$Weapon.look_at(get_global_mouse_position())
	#$Weapon.rotation_degrees += 90
	if Input.is_action_just_pressed('left_click'):
		shoot_at_position(get_global_mouse_position())

func shoot_at_position(target_position):
	if $Weapon/RayCast2D.is_colliding():
		var col = $Weapon/RayCast2D.get_collider()
		if col:
			col.take_hit(damage_per_shot)
			target_position = col.global_position
	var dist = $Weapon/ProjectileOrigin.global_position.distance_to(target_position)
	dist = clamp(dist, 0, shoot_range)
	draw_shoot(dist/2)

func draw_shoot(length):
	var ray = ray_scene.instance()
	ray.vanish_time = 0.1
	ray.ray_color = projectile_color
	get_parent().add_child(ray)
	ray.position = $Weapon/ProjectileOrigin.global_position
	ray.rotation = $Weapon.rotation
	ray.scale = Vector2(0.3, length)

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
		$Weapon.rotation = (position.angle_to_point(closest.global_position))
		$Weapon.rotation_degrees -= 90

func _on_ShootTimer_timeout():
	shoot_at_position(get_global_mouse_position())
