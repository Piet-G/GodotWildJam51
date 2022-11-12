extends Node

var tile_size = Vector2(30, 30)
var grid_origin = Vector2(0, 0)

func snap_to_grid_position(pos: Vector2) -> Vector2:
	return (pos / tile_size).floor() * tile_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
