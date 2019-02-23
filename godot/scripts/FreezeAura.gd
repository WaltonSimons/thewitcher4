extends Sprite

export (float) var damage_per_shot
export (float) var slowdown_duration
export (float) var slowdown_multiplier
export (PackedScene) var aura_scene
export (Color) var projectile_color

func shoot(shoot_range):
	var aura = aura_scene.instance()
	aura.modulate = projectile_color
	get_parent().get_parent().add_child(aura)
	aura.global_position = $ProjectileOrigin.global_position
	aura.emit(2)
	