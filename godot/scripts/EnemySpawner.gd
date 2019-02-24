extends Node

const TIME_BETWEEN_SPAWNS = 1
export(Vector2) var spawn_point

export (PackedScene) var enemy0
export (PackedScene) var enemy1
export (PackedScene) var enemy2
export (PackedScene) var enemy_path_follower

var waves = [
	[0,0,0,0,0],
	[0,0,0,1,1],
	[1,1,1,1,1]
]

var current_wave = 0
var enemy_i = 0

var enemy_path = null

func _ready():
	#send_wave(0)
	pass

func send_wave(i, path):
	enemy_i = 0
	enemy_path = path
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

	enemy.transform.origin = spawn_point
	var path_follower = enemy_path_follower.instance()
	path_follower.add_child(enemy)
	path_follower.unit = enemy
	enemy.position = Vector2(0, 0)
	enemy_path.add_child(path_follower)

func _on_Timer_timeout():
	var wave = waves[current_wave]
	var enemy = wave[enemy_i]
	
	if enemy_i < len(wave) - 1:
		$Timer.wait_time = TIME_BETWEEN_SPAWNS
		$Timer.start()
		enemy_i += 1
	
	spawn_enemy(enemy)
