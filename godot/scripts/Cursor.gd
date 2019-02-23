extends Sprite

var tile_size = 64

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var mouse = get_global_mouse_position()
	mouse.x = int(mouse.x/tile_size) * tile_size + tile_size/2
	mouse.y = int(mouse.y/tile_size) * tile_size + tile_size/2
	
	self.global_position = mouse
