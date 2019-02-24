extends Sprite

var damage

func emit(size):
	var time = 1
	var final_color = modulate
	final_color.a = 0
	$Tween.interpolate_property(self, 'modulate', modulate, final_color, time, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.interpolate_property(self, 'scale', Vector2(0, 0), Vector2(size, size), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_callback(self, time, 'queue_free')
	$Tween.start()


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	print(body)
	body.speed_multiplier = 0.5
	body.take_hit(damage)
