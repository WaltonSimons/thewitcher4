extends Sprite

var vanish_time = 0.2
var ray_color = Color(1, 1, 1)

func _ready():
	var final_color = ray_color
	final_color.a = 0
	$Tween.interpolate_property(self, 'modulate', ray_color, final_color, vanish_time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_callback(self, vanish_time, 'queue_free')
	$Tween.start()
	