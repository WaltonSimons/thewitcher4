extends Path2D

onready var follow = $PathFollow2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	follow.transform.origin = Vector2(0, 0)

func _process(delta):
	follow.set_offset(follow.get_offset() + 100*delta)