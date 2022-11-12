extends Node

var tile_size = Vector2(30, 30)
var grid_origin = Vector2(10, 10)

var grid_map = {}

func to_grid_position(pos: Vector2)-> Vector2:
	return ((pos - grid_origin)/ tile_size).floor()

func to_global_position(pos: Vector2) -> Vector2:
	return pos * tile_size + grid_origin

func is_grid_position_occupied(pos: Vector2) -> bool:
	return grid_map.has(pos)

func snap_to_grid_position(pos: Vector2) -> Vector2:
	return to_global_position(to_grid_position(pos))

func add_to_grid(tower: Node2D, grid_position: Vector2) -> void:
	grid_map[grid_position] = tower
	tower.global_position = to_global_position(grid_position)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
