extends TextureButton

signal turret_bought(turret_type, turret_icon)
export (PackedScene) var turret_prefab

func _ready():
	get_child(0).texture = turret_prefab.instance().get_child(1).texture

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("turret_bought", turret_prefab, get_child(0).texture)