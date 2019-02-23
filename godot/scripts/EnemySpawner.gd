extends Node

const TIME_BETWEEN_SPAWNS = 5

export (PackedScene) var enemy0
export (PackedScene) var enemy1
export (PackedScene) var enemy2

var waves = [
	[0,0,0,0,0],
	[0,0,0,1,1],
	[1,1,1,1,1]
]

var current_wave = 0
var enemy_i = 0;

func _ready():
	send_wave(0)

func send_wave(i):
	var enemy_i = 0
	$Timer.one_shot = true
	$Timer.wait_time = TIME_BETWEEN_SPAWNS
	$Timer.start()
	
func spawn_enemy(i):
	var enemy
	if i == 0:
		enemy = enemy0.instance()
	elif i == 1:
		enemy = enemy1.instance()
	elif i == 2:
		enemy = enemy2.instance()

func _on_Timer_timeout():
	var wave = waves[current_wave]
	var enemy = wave[enemy_i]
	
	if enemy_i < len(wave):
		$Timer.wait_time = TIME_BETWEEN_SPAWNS
		$Timer.start()
		enemy_i += 1
	
	spawn_enemy(enemy)
