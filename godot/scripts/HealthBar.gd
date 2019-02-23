extends Sprite

func _on_health_changed(value, max_value):
	var target_scale = $GreenBar.scale
	target_scale.x = value/max_value
	$Tween.interpolate_property($GreenBar, 'scale', $GreenBar.scale, target_scale, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func _process(delta):
	global_rotation = 0
	global_position = get_parent().global_position + Vector2(0, -25)