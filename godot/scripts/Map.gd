extends Node2D

const TILE_SIZE = 64

export(NodePath) var terrain_type
export(String, FILE, ".map") var map_layout
var map_layout_file = File.new()

onready var map_tiles = []
onready var tile_templ = load("res://scenes/Tile.tscn")

func map_tile_to_sprite(tile, terrain_type):
	if tile == 'O':
		return get_node(terrain_type).basic1

func _ready():	
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
			
func create_map_tex():	
	for row in len(self.map_tiles):
		for tile in len(self.map_tiles[row]):
			var tile_inst = tile_templ.instance()
			tile_inst.texture = self.map_tiles[row][tile]
			$Tiles.add_child(tile_inst)
			tile_inst.transform.origin = Vector2(row * TILE_SIZE, tile * TILE_SIZE)
	