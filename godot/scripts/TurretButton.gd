extends TextureButton

signal turret_bought(turret_type, turret_icon)
export (PackedScene) var turret_prefab

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("turret_bought", turret_prefab, $TurretIcon.texture)