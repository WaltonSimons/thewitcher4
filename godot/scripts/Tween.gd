extends Tween


func _ready():
	print(get_parent())
	var target = get_parent().position
	target.x += 400
	interpolate_property(get_parent(), 'position', get_parent().position, target, 10, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	start()