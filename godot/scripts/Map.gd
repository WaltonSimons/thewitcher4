extends Node2D

const TILE_SIZE = 64

export(NodePath) var terrain_type
export(String, FILE, ".map") var map_layout
export(String, FILE, ".map") var map_path
var map_layout_file = File.new()
var map_path_file = File.new()

onready var cursor = load("res://scenes/Cursor.tscn").instance()

onready var map_tiles = []
onready var tile_templ = load("res://scenes/Tile.tscn")

func map_tile_to_sprite(tile, terrain_type):
	if tile == 'O':
		return get_node(terrain_type).basic1
	elif tile == '┌':
		return get_node(terrain_type).corner_upper_left
	elif tile == '┐':
		return get_node(terrain_type).corner_upper_right
	elif tile == '└':
		return get_node(terrain_type).corner_lower_left
	elif tile =='┘':
		return get_node(terrain_type).corner_lower_right
	elif tile == '-':
		return get_node(terrain_type).horizontal
	elif tile == '|':
		return get_node(terrain_type).vertical
	elif tile == '+':
		return get_node(terrain_type).crossroads
	elif tile == '┴':
		return get_node(terrain_type).splitN
	elif tile == '┬':
		return get_node(terrain_type).splitS
	elif tile == '┤':
		return get_node(terrain_type).splitW
	elif tile == '├':
		return get_node(terrain_type).splitE
							

func _ready():	
	add_child(cursor)
	
	$Tiles.transform.origin = Vector2(TILE_SIZE/2, TILE_SIZE/2)
	cursor.scale = Vector2(TILE_SIZE * 0.01, TILE_SIZE * 0.01)
	
	self.map_layout_file.open(map_layout, map_layout_file.READ)
	var content = self.map_layout_file.get_as_text()
	content = content.split('\n')
	for row in content:
		var map_row = []
		map_tiles.append(map_row)
		for tile in row:
			var sprite = map_tile_to_sprite(tile, self.terrain_type)
			map_row.append(sprite)
			
	self.create_map_tex()
	
	self.map_path_file.open(map_path, map_path_file.READ)
	var path_content = self.map_path_file.get_as_text()
	path_content = path_content.split('\n')
	self.create_enemies_path(path_content)
			
func create_map_tex():	
	for row in len(self.map_tiles):
		for tile in len(self.map_tiles[row]):
			var tile_inst = tile_templ.instance()
			tile_inst.texture = self.map_tiles[row][tile]
			$Tiles.add_child(tile_inst)
			tile_inst.transform.origin = Vector2(tile * TILE_SIZE, row * TILE_SIZE)
			
	
func find_path_start(layout):
	for row in len(layout):
		for tile in len(layout[row]):
			if layout[row][tile] == 'S':
				return Vector2(row, tile) 	
			
func create_path_node(layout, last_node):
	$EnemiesPath.curve.add_point(Vector2(last_node.y * TILE_SIZE, last_node.x * TILE_SIZE))
	
	var node_path = layout[last_node.x][last_node.y]
	var move_to = last_node

	if node_path == 'S' or node_path == 'v':
		move_to.x += 1
	elif node_path == '^':
		move_to.x -= 1
	elif node_path == '>':
		move_to.y += 1
	elif node_path == '<':
		move_to.y -= 1
		
	return move_to
			
func create_enemies_path(layout):
	var start = find_path_start(layout)
	
	var last_node = start
	while (layout[last_node.x][last_node.y] != 'B'):
		last_node = create_path_node(layout, last_node)
		
		