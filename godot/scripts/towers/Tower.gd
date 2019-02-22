extends Node2D

export (int) var shoot_range

func _ready():
	set_shoot_range(shoot_range)

func set_shoot_range(value):
	$Weapon/RayCast2D.cast_to.y = value

