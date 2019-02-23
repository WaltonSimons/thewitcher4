extends AnimatedSprite

var vanish_time = 0.2
var radius
var damage

func _ready():
	$Area2D/CollisionShape2D.get_shape().radius = 30

func deal_damage():
	for body in $Area2D.get_overlapping_bodies():
		body.take_hit(damage)

func explode():
	play()
	var factor = radius/31
	scale = Vector2(factor, factor)
	var final_color = modulate
	final_color.a = 0
	$Tween.interpolate_property(self, 'modulate', modulate, final_color, vanish_time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_callback(self, vanish_time, 'queue_free')
	$Tween.interpolate_callback(self, 0.1, 'deal_damage')
	$Tween.start()
	