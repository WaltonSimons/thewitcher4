extends Control

const PANEL_HEIGHT = 100

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	$TopPanel.rect_size = Vector2(screen_size.x, PANEL_HEIGHT)
	
	var button_size = Vector2(PANEL_HEIGHT - 20, PANEL_HEIGHT - 20)
	var icon_pos = Vector2(10, 10)
	
	$TopPanel/TurretButton.rect_size = button_size
	$TopPanel/TurretButton/TurretIcon.rect_size = button_size
	$TopPanel/TurretButton/TurretIcon.rect_position = icon_pos
	
	$TopPanel/TurretButton2.rect_size = button_size
	$TopPanel/TurretButton2/TurretIcon2.rect_size = button_size
	$TopPanel/TurretButton2/TurretIcon2.rect_position = icon_pos

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
