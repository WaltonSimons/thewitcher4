extends Node2D

export (int) var shoot_range
export (PackedScene) var ray_scene
export (Color) var projectile_color
export (float) var damage_per_shot
export (float) var shoot_delay = 1

func _ready():
	set_shoot_range(shoot_range)
	$ShootTimer.wait_time = shoot_delay

func set_shoot_range(value):
	$Weapon/RayCast2D.cast_to.y = value

func _process(delta):
	$Weapon.look_at(get_global_mouse_position())
	$Weapon.rotation_degrees += 90
	if Input.is_action_just_pressed('left_click'):
		shoot_at_position(get_global_mouse_position())

func shoot_at_position(position):
	var dist = $Weapon/ProjectileOrigin.global_position.distance_to(position)
	draw_shoot(dist/2)

func draw_shoot(length):
	var ray = ray_scene.instance()
	ray.vanish_time = 0.1
	ray.ray_color = projectile_color
	get_parent().add_child(ray)
	ray.position = $Weapon/ProjectileOrigin.global_position
	ray.rotation = $Weapon.rotation
	ray.scale = Vector2(0.3, length)

func _on_ShootTimer_timeout():
	shoot_at_position(get_global_mouse_position())
