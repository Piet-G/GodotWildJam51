extends Node

var tile_size = Vector2(40, 40)
var grid_origin = Vector2(0, 0)

var grid_map = {}
var enemy_info = {}
var illegal_spaces = {}

func to_grid_position(pos: Vector2)-> Vector2:
	return ((pos - grid_origin)/ tile_size).floor()

func to_global_position(pos: Vector2) -> Vector2:
	return pos * tile_size + grid_origin

func is_grid_position_occupied(pos: Vector2) -> bool:
	return grid_map.has(pos) or illegal_spaces.has(pos)

func snap_to_grid_position(pos: Vector2) -> Vector2:
	return to_global_position(to_grid_position(pos))

func add_to_grid(tower: Node2D, grid_position: Vector2) -> void:
	grid_map[grid_position] = tower
	tower.global_position = to_global_position(grid_position)
	
	if(tower.has_method("added_to_grid")):
		tower.added_to_grid()

func add_illegal_space(pos):
	illegal_spaces[pos] = true

func get_positions_available_to_enemy():
	var array = []
	for pos in enemy_info.keys():
		if(not is_grid_position_occupied(pos)):
			array.append(pos)
	
	return array

func get_weights_total(weight_name):
	var total = 0
	for pos in get_positions_available_to_enemy():
		total += enemy_info[pos][weight_name]
	
	return total

func get_buildings_of_type(type, is_enemy):
	var buildings = []
	for pos in grid_map.keys():
		if(grid_map[pos].type == type):
			buildings.append(grid_map[pos])
	
	return buildings

func get_position_with_weight(weight_name, value):
	var total = 0
	for pos in get_positions_available_to_enemy():
		total += enemy_info[pos][weight_name]
		if(total >= value):
			return pos
	
	return get_positions_available_to_enemy()[0]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
