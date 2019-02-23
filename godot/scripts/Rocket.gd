extends Sprite

export (float) var distance
export (float) var speed
export (PackedScene) var explosion_scene
export (float) var explosion_radius
export (float) var damage

func _ready():
	pass

func set_tween(target):
	var time = distance/speed
	$Tween.interpolate_property(self, 'global_position', global_position, target, time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_callback(self, time, 'explode')
	$Tween.start()

func explode():
	var explosion = explosion_scene.instance()
	explosion.vanish_time = 0.1
	explosion.global_position = global_position
	explosion.damage = damage
	explosion.radius = explosion_radius
	get_parent().add_child(explosion)
	explosion.explode()
	queue_free()